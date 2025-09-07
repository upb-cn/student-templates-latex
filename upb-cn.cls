\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{upb-cn}[07.09.2025] 

\DeclareOption{thesis}{
    % For thesis
    \DeclareRobustCommand*{\thesisdegree}[1]{\gdef\@thesisdegree{#1}}
    \DeclareRobustCommand*{\secondreviewer}[1]{\gdef\@secondreviewer{#1}}
    \DeclareRobustCommand*{\supervisors}[1]{\gdef\@supervisors{#1}}
    \DeclareRobustCommand*{\submissiondate}[1]{\gdef\@submissiondate{#1}}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[a4paper,twoside]{report}

% Page setup
\RequirePackage[a4paper,
                left=1in,
                right=1in,   
                top=1.3in,    
                bottom=1.3in, 
                heightrounded]{geometry}

\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}

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


% Use biblatex
\RequirePackage[maxnames=999,minnames=999]{biblatex}
\@ifclasswith{upb-cn}{thesis}{
    \renewcommand{\bibsetup}{\thispagestyle{empty}\pagestyle{fancy}}
}{
    \defbibheading{bibliography}[References]{%
        \section*{#1}%
        \markboth{#1}{#1}%
    }
}

% Define colors
\RequirePackage{graphicx,xcolor}
\definecolor{upb}{RGB}{26,34,164}
\definecolor{cyan}{HTML}{0b7285}
\definecolor{teal}{HTML}{087f5b}
\definecolor{blue}{HTML}{1864ab}
\definecolor{orange}{HTML}{d9480f}
\definecolor{yellow}{HTML}{e67700}
\newcommand{\headlinecolor}{\color{upb}}

% Set hyperlink style
\RequirePackage{hyperref}
\urlstyle{tt}
\hypersetup{
    colorlinks=true,
    linkcolor=black,
    filecolor=black,
    citecolor=black,
    anchorcolor=upb, 
    menucolor=black,
    runcolor=black,
    urlcolor=upb
}

% Set header and footer
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
    \fancyfoot[LE,RO]{{\normalsize\thepage}}
}{
    \fancypagestyle{plain}{
        \fancyhf{} 
        \fancyfoot[R]{\normalsize\thepage/\pageref{LastPage}} 
        \renewcommand{\headrulewidth}{0pt} 
    }
    \thispagestyle{plain}
    \fancyhead[LE,LO]{\@lheader}
    \fancyhead[RE,RO]{\@rheader}
    \fancyfoot[RE,RO]{{\normalsize\thepage/\pageref{LastPage}}}
}

% Title style
\renewcommand{\maketitle}{%
    {\Large\sf\bfseries\headlinecolor\noindent\@title\bigskip\\%
    \color{black}\mdseries\normalsize\rmfamily\@author\bigskip}%
}

% Basic document format
\linespread{1.1}
\setlength{\parindent}{0pt}
\setlength{\baselineskip}{10pt}
\setlength{\parskip}{0.5\baselineskip plus 2pt minus 2pt}
\setlength{\bigskipamount}{\baselineskip}

% Remove page style when clearing
\def\cleardoublepage{
    \if@twoside
        \ifodd\c@page
        \else
            \thispagestyle{empty}\hbox{}\newpage
        \fi
    \fi
}

% Chapter style
\titleformat{\chapter}[display]
{\cleardoublepage\Huge\color{black}\scshape\thispagestyle{empty}} 
{
    \flushright%
    \begin{tikzpicture}%
        \draw[fill,color=upb] (0,0) rectangle (2cm, 2cm);% 
        \draw[color=white] (1cm,1cm) node {\thechapter};% 
    \end{tikzpicture}% 
} 
{0pt} 
{\huge\flushright\color{upb}} 
\titlespacing*{\chapter}{0pt}{0pt}{40pt}

% Section styles
\setcounter{secnumdepth}{3}
\renewcommand{\section}{% 
    \@startsection{section}{1}{0pt}{1ex plus 0ex minus 0ex}% 
    {1ex plus .2ex}{\sf\large\bfseries}% 
}
% Do not use chapter numbering if not in a thesis
\@ifclasswith{upb-cn}{thesis}{}{
    \renewcommand{\thesection}{\arabic{section}}
}

\renewcommand{\subsection}{% 
    \@startsection{subsection}{2}{0pt}{1ex plus 0ex minus 0ex}% 
    {1ex plus .2ex}{\sf\normalsize\bfseries}% 
}

\renewcommand{\subsubsection}{% 
    \@startsection{subsubsection}{3}{0pt}{1ex plus 0ex minus 0ex}% 
    {1ex plus .2ex}{\sf\small\bfseries}% 
}

% List style
\RequirePackage{enumitem}
\setlist[itemize,1]{nosep,label=\textbullet,left=1em}
\setlist[itemize,2]{nosep,label=-,left=1em}
\setlist[enumerate,1]{nosep,label=\arabic*.,left=1em}
\setlist[enumerate,2]{nosep,label=\alph*.,left=1em}

% Colored box
\RequirePackage{tcolorbox}
\newtcolorbox{notebox}[1][]{
  sharp corners, 
  colback=gray!5!white, 
  boxrule=0.5pt,
  #1
}

% Caption style
\RequirePackage[labelsep=colon,font=normal,labelfont=bf]{caption}

% Listings setup for multiple languages
\RequirePackage{listings}
\RequirePackage{upquote}
\RequirePackage{xcolor}

% Define code colors
\definecolor{codebg}{HTML}{f8f8f8} 

% Global defaults applied to all listings
\lstset{
    backgroundcolor=\color{codebg},
    basicstyle=\ttfamily\linespread{1}\selectfont,
    breaklines=true,
    columns=fullflexible,
    upquote=true,
    keepspaces=true,
    showstringspaces=false,
    keywordstyle=\color{orange},
    stringstyle=\color{blue},
    identifierstyle=\color{black},
    commentstyle=\color{gray}\itshape,
    escapeinside={(*@}{@*)}
}