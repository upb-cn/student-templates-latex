\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{upb-cn}[2026/07/21 Document class for UPB-CN templates]

% ---------------------------------------------------------------------------
% Class options
% ---------------------------------------------------------------------------
% Font: lmodern (default) or times; letters default to times
\newif\ifupbcn@times
\newif\ifupbcn@fontset
\newif\ifupbcn@fontsizeprovided
\DeclareOption{lmodern}{\upbcn@timesfalse\upbcn@fontsettrue}
\DeclareOption{times}{\upbcn@timestrue\upbcn@fontsettrue}

% Font size: default to 11pt unless explicitly set in \documentclass
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{report}\upbcn@fontsizeprovidedtrue}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}\upbcn@fontsizeprovidedtrue}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{report}\upbcn@fontsizeprovidedtrue}

% Document mode: plain document (default), thesis, or letter
\newif\ifupbcn@thesis
\newif\ifupbcn@letter
\DeclareOption{thesis}{\upbcn@thesistrue}
\DeclareOption{letter}{\upbcn@lettertrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\ifupbcn@letter
    \ifupbcn@thesis
        \ClassError{upb-cn}{The 'letter' and 'thesis' options cannot be combined}%
            {Remove one of these class options.}
    \fi
    \ifupbcn@fontset\else
        \upbcn@timestrue
    \fi
\fi

\ifupbcn@fontsizeprovided
    \LoadClass[a4paper,twoside]{report}
\else
    \LoadClass[a4paper,twoside,11pt]{report}
\fi
\raggedbottom

\ifupbcn@thesis
    % Creative Commons icons (\ccbyncndeu) for the thesis copyright page
    \RequirePackage{ccicons}
    % Thesis metadata, shown on the thesis title page
    \DeclareRobustCommand*{\thesisdegree}[1]{\gdef\@thesisdegree{#1}}
    \DeclareRobustCommand*{\secondreviewer}[1]{\gdef\@secondreviewer{#1}}
    \DeclareRobustCommand*{\supervisors}[1]{\gdef\@supervisors{#1}}
    \DeclareRobustCommand*{\submissiondate}[1]{\gdef\@submissiondate{#1}}
\fi

% ---------------------------------------------------------------------------
% Page geometry and fonts
% ---------------------------------------------------------------------------
\RequirePackage[a4paper,
                left=1in,
                right=1in,
                top=1.3in,
                bottom=1.3in,
                heightrounded]{geometry}

\RequirePackage[T1]{fontenc}
\ifupbcn@times
    \RequirePackage{times}
\else
    \RequirePackage{lmodern}
\fi

% ---------------------------------------------------------------------------
% Colors
% ---------------------------------------------------------------------------
\RequirePackage{graphicx,xcolor}
\RequirePackage{tikz}
\RequirePackage{titlesec}
\definecolor{upb}{RGB}{26,34,164}
\definecolor{cyan}{HTML}{0b7285}
\definecolor{teal}{HTML}{087f5b}
\definecolor{blue}{HTML}{1864ab}
\definecolor{orange}{HTML}{d9480f}
\definecolor{yellow}{HTML}{e67700}
\definecolor{codebg}{HTML}{f8f8f8}
\newcommand{\headlinecolor}{\color{upb}}

% ---------------------------------------------------------------------------
% Bibliography
% ---------------------------------------------------------------------------
\RequirePackage[maxnames=999,minnames=999]{biblatex}
\ifupbcn@thesis
    \renewcommand{\bibsetup}{\thispagestyle{empty}\pagestyle{fancy}}
\else
    \defbibheading{bibliography}[References]{%
        \section*{#1}%
        \markboth{#1}{#1}%
    }
\fi

% ---------------------------------------------------------------------------
% Hyperlinks
% ---------------------------------------------------------------------------
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

% ---------------------------------------------------------------------------
% Headers and footers
% ---------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\pagestyle{fancy}
\fancyhf{}

\DeclareRobustCommand*{\lheader}[1]{\gdef\@lheader{#1}}
\DeclareRobustCommand*{\rheader}[1]{\gdef\@rheader{#1}}
\gdef\@lheader{}
\gdef\@rheader{}

\ifupbcn@thesis
    \renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\thechapter.\ #1}}{}}
    \fancyhead[LE]{\leftmark}
    \fancyhead[RO]{\rightmark}
    \fancyfoot[LE,RO]{\normalsize\thepage}
\else
    \ifupbcn@letter
        \fancyfoot[L]{\footnotesize\textcolor{gray}{\textbf{Paderborn University}}}
        % Starred \pageref* suppresses the hyperref link, so the page total
        % inherits the gray footer color instead of linkcolor
        \fancyfoot[R]{\footnotesize\textcolor{gray}{Page \thepage\ of \pageref*{LastPage}}}
        \renewcommand{\headrulewidth}{0pt}
        \renewcommand{\footrulewidth}{0pt}
        \thispagestyle{empty}
    \else
        \fancypagestyle{plain}{
            \fancyhf{}
            \fancyfoot[R]{\normalsize\thepage/\pageref{LastPage}}
            \renewcommand{\headrulewidth}{0pt}
        }
        \thispagestyle{plain}
        \fancyhead[LE,LO]{\@lheader}
        \fancyhead[RE,RO]{\@rheader}
        \fancyfoot[RE,RO]{\normalsize\thepage/\pageref{LastPage}}
    \fi
\fi

% ---------------------------------------------------------------------------
% Letter mode: letterhead, sender block, and envelope fold marks
% ---------------------------------------------------------------------------
% Declared outside the letter block: \newif must always run so the conditional
% below is recognized when TeX skips this section in non-letter mode
\newif\ifupbcn@secretary

\ifupbcn@letter
    % Envelope fold marks at the left page edge
    \RequirePackage{eso-pic}
    \tikzset{
        fold/.style={line width=0.4pt,color=gray!50},
        folddash/.style={fold,dash pattern=on 1pt off 1pt}
    }
    \AddToShipoutPictureFG{%
        \AtPageLowerLeft{%
            \begin{tikzpicture}[overlay,remember picture]
                \draw[fold] (0,192mm) -- (8mm,192mm);
                \draw[folddash] (0,148.5mm) -- (4mm,148.5mm);
                \draw[fold] (0,87mm) -- (8mm,87mm);
            \end{tikzpicture}
        }
    }

    % Recipient address (unstarred so the argument may contain blank lines)
    \DeclareRobustCommand{\address}[1]{\gdef\@address{#1}}
    \gdef\@address{}

    % Use \showsecretary (before \makeletterhead) to include the secretary's
    % office block in the letterhead; it is hidden by default
    \newcommand{\showsecretary}{\upbcn@secretarytrue}

    % Sender identity shown in the letterhead sender block; the remaining
    % lines (department, group, secretary's office, street address) are fixed
    \DeclareRobustCommand*{\sendername}[1]{\gdef\@sendername{#1}}
    \DeclareRobustCommand*{\senderposition}[1]{\gdef\@senderposition{#1}}
    \DeclareRobustCommand*{\senderphone}[1]{\gdef\@senderphone{#1}}
    \DeclareRobustCommand*{\senderemail}[1]{\gdef\@senderemail{#1}}
    \gdef\@sendername{}
    \gdef\@senderposition{}
    \gdef\@senderphone{}
    \gdef\@senderemail{}

    \newcommand{\makeletterhead}{%
        \begin{figure}[t]
            \hspace{-12pt}
            \includegraphics[width=0.3\textwidth]{upb-logo.pdf}
        \end{figure}
        \begin{minipage}[t]{0.67\textwidth}
            {\footnotesize Paderborn University $\cdot$ Warburger Str.\ 100 $\cdot$ 33098 Paderborn $\cdot$ Germany}\\
            \\
            \@address
        \end{minipage}%
        \begin{minipage}[t]{0.33\textwidth}
            \raggedright\footnotesize
            Faculty of Computer Science, Electrical Engineering, and Mathematics \\
            Department of Computer Science \\[5pt]
            
            \@sendername \\
            \@senderposition \\
            T \@senderphone \\
            \@senderemail \\[5pt]

            \ifupbcn@secretary
                Secretary's Office \\
                Tanja Bürger \\
                T +49 5251 60-5376 \\
                tanja.buerger@uni-paderborn.de \\[5pt]

            \fi
            Pohlweg 51 \\
            33098 Paderborn, Germany

            \vspace{0.5cm}
            \flushright\today
            \flushleft
        \end{minipage}
        \vspace{1cm}
    }
\fi

% ---------------------------------------------------------------------------
% Title
% ---------------------------------------------------------------------------
% titling provides \thetitle, \theauthor, and \thedate, used e.g. on the
% thesis title and copyright pages; load it before \maketitle is redefined
\RequirePackage{titling}
\renewcommand{\maketitle}{%
    {%
    \sffamily\bfseries\headlinecolor\noindent
    \begingroup
        \LARGE
        \setlength{\baselineskip}{\baselineskip}%
        \parbox[t]{\textwidth}{\raggedright\@title}%
    \endgroup
    \par\bigskip
    \color{black}\mdseries\normalsize\rmfamily\@author\bigskip}%
}

% ---------------------------------------------------------------------------
% Paragraph and line spacing
% ---------------------------------------------------------------------------
\setlength{\parindent}{0pt}
\ifupbcn@letter
    % Letters keep the default leading and slightly wider paragraph gaps
    \setlength{\parskip}{6pt plus 2pt minus 2pt}
    \setlength{\bigskipamount}{12pt}
\else
    \linespread{1.1}
    \setlength{\parskip}{5pt plus 2pt minus 2pt}
    \setlength{\bigskipamount}{10pt}
\fi

% ---------------------------------------------------------------------------
% Sectioning
% ---------------------------------------------------------------------------
% Keep pages inserted by \cleardoublepage empty
\renewcommand{\cleardoublepage}{%
    \if@twoside
        \ifodd\c@page\else
            \thispagestyle{empty}\hbox{}\newpage
        \fi
    \fi
}

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

\setcounter{secnumdepth}{3}
\renewcommand{\section}{%
    \@startsection{section}{1}{0pt}{1ex plus 0ex minus 0ex}%
    {1ex plus .2ex}{\sffamily\Large\bfseries}%
}
% Sections are numbered without a chapter prefix outside a thesis
\ifupbcn@thesis\else
    \renewcommand{\thesection}{\arabic{section}}
\fi

\renewcommand{\subsection}{%
    \@startsection{subsection}{2}{0pt}{1ex plus 0ex minus 0ex}%
    {1ex plus .2ex}{\sffamily\normalsize\bfseries}%
}

\renewcommand{\subsubsection}{%
    \@startsection{subsubsection}{3}{0pt}{1ex plus 0ex minus 0ex}%
    {1ex plus .2ex}{\sffamily\small\bfseries}%
}

% ---------------------------------------------------------------------------
% Lists, boxes, captions, and tables
% ---------------------------------------------------------------------------
\RequirePackage{booktabs}

\RequirePackage{enumitem}
\setlist[itemize,1]{nosep,label=\textbullet,left=1em}
\setlist[itemize,2]{nosep,label=-,left=1em}
\setlist[enumerate,1]{nosep,label=\arabic*.,left=1em}
\setlist[enumerate,2]{nosep,label=\alph*.,left=1em}

% Checkboxes and marks
\RequirePackage{amssymb}
\RequirePackage{pifont}
\newcommand{\cmark}{\ding{51}}
\newcommand{\xmark}{\ding{55}}
\newcommand{\checkbox}{$\square$}
\newcommand{\done}{\rlap{$\square$}{\raisebox{2pt}{\large\hspace{2pt}\cmark}}%
\hspace{-3pt}}
\newcommand{\wontfix}{\rlap{$\square$}{\large\hspace{1pt}\xmark}}

\RequirePackage{tcolorbox}
\newtcolorbox{notebox}[1][]{
  sharp corners,
  colback=gray!5!white,
  boxrule=0.5pt,
  #1
}

\RequirePackage[labelsep=colon,font=normal,labelfont=bf]{caption}

% ---------------------------------------------------------------------------
% Code listings
% ---------------------------------------------------------------------------
\RequirePackage{listings}
\RequirePackage{upquote}

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
