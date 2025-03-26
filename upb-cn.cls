\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{upb-cn}[21.04.2023] 

\DeclareOption{thesis}{
    % for thesis
    \DeclareRobustCommand*{\thesisdegree}[1]{\gdef\@thesisdegree{#1}}
    \DeclareRobustCommand*{\secondreviewer}[1]{\gdef\@secondreviewer{#1}}
    \DeclareRobustCommand*{\supervisors}[1]{\gdef\@supervisors{#1}}
    \DeclareRobustCommand*{\submissiondate}[1]{\gdef\@submissiondate{#1}}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[a4paper,twoside]{report}

% page setup
\RequirePackage[left=1in,right=1in,top=0in,bottom=1in,includehead, headheight=1in]{geometry}
\setlength{\skip\footins}{16pt plus 5pt minus 2pt}

\RequirePackage{ifthen}
\RequirePackage{kvoptions}
\RequirePackage{xparse}
\RequirePackage{marginnote}
\RequirePackage{booktabs}
\RequirePackage{tikz}
\RequirePackage{titlesec}
\RequirePackage{titling}
\RequirePackage{ccicons}
\RequirePackage{transparent}

% set fonts
\RequirePackage{libertine}
\renewcommand\ttdefault{cmtt}
\renewcommand{\ttfamily}{\fontfamily{cmtt}\small\selectfont}
\RequirePackage{libertinust1math}
\RequirePackage[T1]{fontenc}

% use biblatex
\RequirePackage[maxnames=999,minnames=999]{biblatex}
\@ifclasswith{upb-cn}{thesis}{
    \renewcommand{\bibsetup}{\thispagestyle{empty}\pagestyle{fancy}}
}{
    \defbibheading{bibliography}[References]{%
        \section*{#1}%
        \markboth{#1}{#1}%
    }
}

% define colors
\RequirePackage{graphicx,xcolor}
\definecolor{UPBUltraBlue}{RGB}{26,34,164}
\definecolor{UPBArcticBlue}{RGB}{118,206,208}
\definecolor{UPBOceanBlue}{RGB}{81,165,197}
\definecolor{UPBSkyBlue}{RGB}{52,115,190}
\definecolor{UPBSapphireBlue}{RGB}{24,28,98}
\definecolor{UPBIrisViolet}{RGB}{126,63,168}
\definecolor{UPBFuchsiaRed}{RGB}{193,56,160}
\newcommand{\headlinecolor}{\color{UPBUltraBlue}}

% set hyperlink style
\RequirePackage{hyperref}
\urlstyle{tt}
\hypersetup{
    colorlinks=true,
    linkcolor=black,
    filecolor=black,
    citecolor=black,
    anchorcolor=black, 
    menucolor=black,
    runcolor=black,
    urlcolor=UPBUltraBlue
}

% set header and footer
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\pagestyle{fancy}
\fancyhf{}

\DeclareRobustCommand*{\lheader}[1]{\gdef\@lheader{#1}}
\DeclareRobustCommand*{\rheader}[1]{\gdef\@rheader{#1}}

\@ifclasswith{upb-cn}{thesis}{
    \renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\thechapter.\ #1}}{}}
    \fancyhead[LE]{\leftmark}
    \fancyhead[RO]{\rightmark}
    \fancyfoot[LE,RO]{{\sf\normalsize\thepage}}
}{

    % define new page style parameters for the first page
    \fancypagestyle{firstpage}{%
        \renewcommand{\headrulewidth}{0pt}%
        \fancyheadoffset[L]{36pt}%
        \fancyheadoffset[R]{36pt}%
    }
    \thispagestyle{firstpage} 

    % left header
    \fancyhead[LE,LO]{%
        \ifthenelse{\value{page}=1}{%
            \transparent{0.5}%
            \includegraphics[height=42pt]{../upb-logo}%
        }{\@lheader}
    }
    % right header
    \fancyhead[RE,RO]{%
        \ifthenelse{\value{page}=1}{%
            \transparent{0.5}%
            \includegraphics[height=30pt]{../upb-triangle}%
        }{\@rheader}
    }
    \fancyfoot[RE,RO]{{\sf\normalsize\thepage/\pageref{LastPage}}}
}

% title style
\newcommand{\makethetitle}{%
    {\headlinecolor\Large\sf\bfseries\noindent\@title \bigskip \\%
    \color{black}\large\bfseries\@author\bigskip}%
}

% basic document format
\linespread{1.1}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.5\baselineskip plus 2pt}

% remove page style when clearing
\def\cleardoublepage{
    \if@twoside
        \ifodd\c@page
        \else
            \thispagestyle{empty}\hbox{}\newpage
        \fi
    \fi
}

% chapter style
\titleformat{\chapter}[display]
{\cleardoublepage\normalfont\Huge\bfseries\color{black}\scshape\thispagestyle{empty}} 
{
    \flushright
    \begin{tikzpicture}
        \draw[fill,color=UPBUltraBlue] (0,0) rectangle (2cm, 2cm);
        \draw[color=white] (1cm,1cm) node {\thechapter};
    \end{tikzpicture}
} 
{0pt} 
{\huge\flushright\color{UPBUltraBlue}} 
\titlespacing*{\chapter}{0pt}{0pt}{40pt}

% section styles
\setcounter{secnumdepth}{3}
\renewcommand{\section}{%
    \@startsection{section}{1}{0pt}{1ex plus -1ex minus -.2ex}%
    {1ex plus .2ex}{\sf\large\bfseries\headlinecolor}%
}
% do not use chapter numbering if not in a thesis
\@ifclasswith{upb-cn}{thesis}{}{
    \renewcommand{\thesection}{\arabic{section}}
}

\renewcommand{\subsection}{%
    \@startsection{subsection}{2}{0pt}{1ex plus -1ex minus -.2ex}%
    {1ex plus .2ex}{\sf\normalsize\bfseries\color{black}}%
}

\renewcommand{\subsubsection}{%
    \@startsection{subsubsection}{3}{0pt}{1ex plus -1ex minus -.2ex}%
    {1ex plus .2ex}{\sf\small\bfseries\color{black}}%
}

% list style
\RequirePackage{enumitem}
\setlist[itemize,1]{nosep,label=\textbullet,left=1em}
\setlist[itemize,2]{nosep,label=-,left=1em}
\setlist[enumerate,1]{nosep,label=\arabic*.,left=1em}
\setlist[enumerate,2]{nosep,label=\alph*.,left=1em}

% colorbox
\RequirePackage{tcolorbox}
\newtcolorbox{notebox}[1][]{
  sharp corners, 
  colback=gray!5!white, 
  boxrule=0.5pt,
  #1
}

% caption style
\RequirePackage[labelsep=colon,font=normal,labelfont=bf]{caption}

% code blocks style
\RequirePackage{minted}
\RequirePackage{etoolbox}
\setminted{
    bgcolor=gray!5, 
    fontfamily=tt, 
    fontsize=\small,
    baselinestretch=1,
    curlyquotes=true,
    breaklines=true
}
\setmintedinline{
    bgcolor=gray!5, 
    fontfamily=tt, 
    fontsize=\small,
    baselinestretch=1,
    curlyquotes=true,
    breaklines=true
}
% \patchcmd{\minted@colorbg}{\medskip}{}{}{}
\patchcmd{\endminted@colorbg}{\medskip}{}{}{}

\renewcommand{\tt}[1]{\mintinline{text}{#1}}