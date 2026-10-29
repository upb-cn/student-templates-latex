\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{upb-cn}[2026/10/29 v1.0.0 Document class for UPB-CN templates]

% ---------------------------------------------------------------------------
% Class options
% ---------------------------------------------------------------------------
% Font: times (default), source, or lmodern
\newif\ifupbcn@source
\newif\ifupbcn@times
\newif\ifupbcn@fontsizeprovided
\upbcn@timestrue
\DeclareOption{source}{\upbcn@sourcetrue\upbcn@timesfalse}
\DeclareOption{times}{\upbcn@sourcefalse\upbcn@timestrue}
\DeclareOption{lmodern}{\upbcn@sourcefalse\upbcn@timesfalse}

% Font size: default to 11pt unless explicitly set in \documentclass
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{report}\upbcn@fontsizeprovidedtrue}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}\upbcn@fontsizeprovidedtrue}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{report}\upbcn@fontsizeprovidedtrue}

% Document mode: plain document (default), thesis, or letter
\newif\ifupbcn@thesis
\newif\ifupbcn@letter
\DeclareOption{thesis}{\upbcn@thesistrue}
\DeclareOption{letter}{\upbcn@lettertrue}

% Solutions in assignments and exams: shown (default) or hidden for the
% version handed out to students
\newif\ifupbcn@solutions
\upbcn@solutionstrue
\DeclareOption{solutions}{\upbcn@solutionstrue}
\DeclareOption{nosolutions}{\upbcn@solutionsfalse}

% Language: English (default) or German (ngerman)
\newif\ifupbcn@german
\DeclareOption{ngerman}{\upbcn@germantrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\ifupbcn@letter
    \ifupbcn@thesis
        \ClassError{upb-cn}{The 'letter' and 'thesis' options cannot be combined}%
            {Remove one of these class options.}
    \fi
\fi

\ifupbcn@fontsizeprovided
    \LoadClass[a4paper,twoside]{report}
\else
    \LoadClass[a4paper,twoside,11pt]{report}
\fi
\raggedbottom
% With \raggedbottom, footnotes would follow right after the text on short
% pages; keep them at the bottom of the page (loaded before hyperref)
\RequirePackage[bottom]{footmisc}

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

\RequirePackage[
  a4paper,
  margin=2cm,
  headheight=14pt,
  includeheadfoot
]{geometry}

\RequirePackage[T1]{fontenc}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\ifupbcn@source
    % Source Serif, Source Sans, and Source Code Pro for the text; math takes
    % its letters and digits from Source Serif (mathastext) and the remaining
    % symbols from newtxmath, whose weight matches Source Serif
    \RequirePackage{newtxmath}
    \RequirePackage{sourceserifpro}
    \RequirePackage{sourcesanspro}
    \RequirePackage{sourcecodepro}
    \RequirePackage[italic]{mathastext}
\else\ifupbcn@times
    \RequirePackage{newtxtext}
    \renewcommand{\ttdefault}{lmtt}
    \RequirePackage{newtxmath}
\else
    \RequirePackage{lmodern}
\fi\fi

% ---------------------------------------------------------------------------
% Language
% ---------------------------------------------------------------------------
% German sets the hyphenation, the date, and the bibliography strings via
% babel, and the fixed texts of the letterhead and the letter footer. A
% German logo (upb-logo-de.pdf) is used when it is present; otherwise the
% letterhead falls back to upb-logo.pdf
\ifupbcn@german
    \RequirePackage[ngerman]{babel}
    \RequirePackage{csquotes}
    \IfFileExists{upb-logo-de.pdf}%
        {\def\upbcn@logo{upb-logo-de.pdf}}%
        {\def\upbcn@logo{upb-logo.pdf}}%
    \def\upbcn@university{Universität Paderborn}
    \def\upbcn@returnaddress{Universität Paderborn $\cdot$ Warburger Str.\ 100 $\cdot$ 33098 Paderborn}
    \def\upbcn@faculty{Fakultät für Elektrotechnik, Informatik und Mathematik}
    \def\upbcn@department{Institut für Informatik}
    \def\upbcn@secretaryoffice{Sekretariat}
    \def\upbcn@city{33098 Paderborn}
    \def\upbcn@pageof#1#2{Seite #1 von #2}
\else
    \def\upbcn@logo{upb-logo.pdf}
    \def\upbcn@university{Paderborn University}
    \def\upbcn@returnaddress{Paderborn University $\cdot$ Warburger Str.\ 100 $\cdot$ 33098 Paderborn $\cdot$ Germany}
    \def\upbcn@faculty{Faculty of Computer Science, Electrical Engineering, and Mathematics}
    \def\upbcn@department{Department of Computer Science}
    \def\upbcn@secretaryoffice{Secretary's Office}
    \def\upbcn@city{33098 Paderborn, Germany}
    \def\upbcn@pageof#1#2{Page #1 of #2}
\fi

% ---------------------------------------------------------------------------
% Colors
% ---------------------------------------------------------------------------
\RequirePackage{graphicx,xcolor}
\RequirePackage{tikz}
\RequirePackage{titlesec}
% UPB blue is the only color the class defines; it is the accent for the
% title, links, and code keywords. Everything else is black or a gray
\definecolor{upb}{RGB}{26,34,164}
\newcommand{\headlinecolor}{\color{upb}}

% ---------------------------------------------------------------------------
% Bibliography
% ---------------------------------------------------------------------------
\RequirePackage[maxnames=999,minnames=999]{biblatex}
\ifupbcn@thesis
    \renewcommand{\bibsetup}{\thispagestyle{empty}\pagestyle{fancy}}
\else
    % \refname is "References" in English and "Literatur" in German
    \defbibheading{bibliography}[\refname]{%
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
% Headings such as \section{Task \hfill (10 points)} in exams
\pdfstringdefDisableCommands{\let\hfill\@empty}

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
        \fancyfoot[L]{\footnotesize\textcolor{gray}{\textbf{\upbcn@university}}}
        % Starred \pageref* suppresses the hyperref link, so the page total
        % inherits the gray footer color instead of linkcolor
        \fancyfoot[R]{\footnotesize\textcolor{gray}{\upbcn@pageof{\thepage}{\pageref*{LastPage}}}}
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
            \includegraphics[width=0.3\textwidth]{\upbcn@logo}
        \end{figure}
        \begin{minipage}[t]{0.67\textwidth}
            {\footnotesize\upbcn@returnaddress}\\
            \\
            \@address
        \end{minipage}%
        \begin{minipage}[t]{0.33\textwidth}
            \raggedright\footnotesize
            \upbcn@faculty \\
            \upbcn@department \\[5pt]
            
            \@sendername \\
            \@senderposition \\
            T \@senderphone \\
            \@senderemail \\[5pt]

            \ifupbcn@secretary
                \upbcn@secretaryoffice \\
                Tanja Bürger \\
                T +49 5251 60-5376 \\
                tanja.buerger@uni-paderborn.de \\[5pt]

            \fi
            Pohlweg 51 \\
            \upbcn@city

            \vspace{0.5cm}
            \flushright\today
            \flushleft
        \end{minipage}
        \vspace{1cm}
    }

    % Subject line, in bold sans-serif at the body size as usual for letters;
    % unstarred so the argument may be broken over two lines with \\
    \DeclareRobustCommand{\subject}[1]{%
        {\sffamily\normalsize\bfseries #1\par}%
        \vspace{0.8cm}%
    }
\fi

% ---------------------------------------------------------------------------
% Title
% ---------------------------------------------------------------------------
% titling provides \thetitle, \theauthor, and \thedate, used e.g. on the
% thesis title and copyright pages; load it before \maketitle is redefined
\RequirePackage{titling}
% The inline title is about twice the body size (\huge, 20.7pt at 11pt) and
% clearly above the section headings (\Large); the author line follows in
% \large, all in the sans-serif heading font
\renewcommand{\maketitle}{%
    \par
    \begingroup
        \raggedright\sffamily
        {\huge\bfseries\headlinecolor\@title\par}%
        \vspace{10pt}%
        {\large\@author\par}%
    \endgroup
    % Little space here: a following \section adds its own space above
    \vspace{6pt}%
}

% ---------------------------------------------------------------------------
% Cover page
% ---------------------------------------------------------------------------
% Optional cover page metadata, set like \title and \author:
%   \supertitle{...}    a line above the title (e.g., the type of document)
%   \subtitle{...}      a line below the title rule (e.g., the institution)
%   \coverdetails{...}  further details below the subtitle; unstarred so the
%                       details may span several paragraphs
%   \affiliation{...}   the author's position or affiliation, below the author
% The title may contain \\ to break it into lines. The date is shown below
% the affiliation only when \date is given explicitly
\DeclareRobustCommand{\supertitle}[1]{\gdef\@supertitle{#1}}
\DeclareRobustCommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\DeclareRobustCommand{\coverdetails}[1]{\gdef\@coverdetails{#1}}
\DeclareRobustCommand{\affiliation}[1]{\gdef\@affiliation{#1}}
\gdef\@supertitle{}
\gdef\@subtitle{}
\gdef\@coverdetails{}
\gdef\@affiliation{}
\newif\ifupbcn@coverdate
\let\upbcn@date\date
\renewcommand{\date}[1]{\upbcn@date{#1}\global\upbcn@coverdatetrue}

% \makecoverpage is used instead of \maketitle; it sets an unnumbered cover
% page with the title block in the middle, the author block at the bottom,
% and a grid motif built from the group logo in the upper right corner. The
% cover is numbered A internally so its hyperref anchor does not clash with
% the following page, where the arabic numbering (and the page total) starts
% at 1
\newcommand{\makecoverpage}{%
    \clearpage
    \pagenumbering{Alph}%
    \thispagestyle{empty}%
    \noindent
    \begin{tikzpicture}[overlay,remember picture]
        % The logo's squares have side 0.618 on a pitch of 1 (its own
        % proportions, here in cm). The grid is counted in columns (\c) and
        % rows (\r) from the top right corner of the page and fades out with
        % distance from it; the logo itself (a merged 2x2 square plus an L of
        % five squares) fills the 3x3 block at columns and rows 4--6
        \begin{scope}[shift={(current page.north east)}]
            \foreach \c in {0,...,10} {
                \foreach \r in {0,...,9} {
                    \pgfmathsetmacro{\op}{max(0, 1 - sqrt((\c+0.3)^2 + (\r+0.3)^2)/9.5)}
                    \pgfmathtruncatemacro{\inlogo}{(\c>=4)*(\c<=6)*(\r>=4)*(\r<=6)}
                    \ifnum\inlogo=0 \ifdim\op pt>0.02pt
                        \fill[black!20, fill opacity=\op]
                            ({0.2-\c-0.618}, {0.2-\r-0.618}) rectangle ++(0.618, 0.618);
                    \fi\fi
                }
            }
            \fill[black] (-6.418, -5.418) rectangle ++(1.618, 1.618);
            \foreach \c/\r in {4/4, 4/5, 4/6, 5/6, 6/6}
                \fill[black] ({0.2-\c-0.618}, {0.2-\r-0.618}) rectangle ++(0.618, 0.618);
        \end{scope}
        % Title block
        \node[anchor=north west, inner sep=0pt, text width=16cm, align=left]
            at ([xshift=2.5cm, yshift=-12.5cm]current page.north west) {%
            % align=left fixes the interword space to that of the font outside
            % the node; reset it so each line uses its own font's spacing.
            % Lines are set fully ragged right, so the interword spaces do
            % not stretch, and long titles break between words only
            \spaceskip\z@ \xspaceskip\z@ \rightskip\z@\@plus1fil
            \hyphenpenalty\@M \exhyphenpenalty\@M
            \ifx\@supertitle\@empty\else
                {\sffamily\large\@supertitle\par}%
                \vspace{12pt}%
            \fi
            {\sffamily\bfseries\fontsize{46}{50}\selectfont\@title\par}%
            \vspace{16pt}%
            {\rule{2.2cm}{2.5pt}\par}%
            \ifx\@subtitle\@empty\else
                \vspace{14pt}%
                {\sffamily\Large\@subtitle\par}%
            \fi
            \ifx\@coverdetails\@empty\else
                \vspace{4pt}%
                {\sffamily\@coverdetails\par}%
            \fi
        };
        % Author block
        \node[anchor=south west, inner sep=0pt, text width=16cm, align=left]
            at ([xshift=2.5cm, yshift=2.8cm]current page.south west) {%
            \spaceskip\z@ \xspaceskip\z@ \rightskip\z@\@plus1fil
            {\sffamily\Large\bfseries\@author\par}%
            \ifx\@affiliation\@empty\else
                \vspace{3pt}%
                {\sffamily\@affiliation\par}%
            \fi
            \ifupbcn@coverdate
                \vspace{3pt}%
                {\sffamily\@date\par}%
            \fi
        };
    \end{tikzpicture}%
    \clearpage
    \pagenumbering{arabic}%
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
{\cleardoublepage\Huge\color{black}\sffamily\bfseries\thispagestyle{empty}}
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

% Headings step down from \Large (14.4pt at 11pt) over \large to the body
% size, never below it, with more space above a heading than below it so
% that it binds to its text; \parskip is added below each heading
\setcounter{secnumdepth}{3}
\renewcommand{\section}{%
    \@startsection{section}{1}{0pt}{3ex plus 1ex minus .2ex}%
    {1ex plus .2ex}{\sffamily\Large\bfseries}%
}
% Sections are numbered without a chapter prefix outside a thesis
\ifupbcn@thesis\else
    \renewcommand{\thesection}{\arabic{section}}
\fi

\renewcommand{\subsection}{%
    \@startsection{subsection}{2}{0pt}{2.5ex plus 1ex minus .2ex}%
    {.5ex plus .2ex}{\sffamily\large\bfseries}%
}

\renewcommand{\subsubsection}{%
    \@startsection{subsubsection}{3}{0pt}{2ex plus .5ex minus .2ex}%
    {.2ex plus .1ex}{\sffamily\normalsize\bfseries}%
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
    backgroundcolor=\color{gray!5},
    basicstyle=\small\ttfamily\linespread{1}\selectfont,
    breaklines=true,
    columns=fullflexible,
    upquote=true,
    keepspaces=true,
    showstringspaces=false,
    keywordstyle=\color{upb},
    identifierstyle=\color{black},
    commentstyle=\color{gray}\itshape,
    escapeinside={(*@}{@*)},
    % listings reads its input byte by byte; map the German umlauts so they
    % may appear in code, e.g., in comments or LaTeX examples
    literate={ä}{{\"a}}1 {ö}{{\"o}}1 {ü}{{\"u}}1
             {Ä}{{\"A}}1 {Ö}{{\"O}}1 {Ü}{{\"U}}1 {ß}{{\ss}}1
}

% ---------------------------------------------------------------------------
% Assignments and exams
% ---------------------------------------------------------------------------
% All solutions below follow the solutions/nosolutions class option
\ifupbcn@solutions
    \PassOptionsToPackage{printsolution=true}{exercises}
\else
    \PassOptionsToPackage{printsolution=false}{exercises}
\fi
% Numbered questions and solutions: the exercise and solution environments;
% \begin{solution}[3cm] leaves 3cm of space when solutions are hidden
\RequirePackage[
    exercisename=Question,
    solutionname=Solution,
    exercisenameposition=inline,
    solutionnameposition=inline
]{exercises}
% Answer options of multiple-choice questions: the tasks environment
\RequirePackage{tasks}

\newcommand{\upbcn@ifsolutions}{%
    \ifupbcn@solutions
        \expandafter\@firstoftwo
    \else
        \expandafter\@secondoftwo
    \fi
}

% \choice{X}: the correct option (X) of a multiple-choice question, or a
% blank for the students to fill in
\newcommand{\choice}[1]{%
    \upbcn@ifsolutions{(\textbf{#1})}{(\underline{\hspace{1cm}})}%
}

% \solblank{height}{answer}: the answer, or empty space of the given height
\newcommand{\solblank}[2]{%
    \upbcn@ifsolutions{\textbf{Answer:} #2}{\vspace{#1}}%
}

% \soltemplate{template}{answer}: the answer, or a template to fill in
% (e.g., a table with empty cells)
\newcommand{\soltemplate}[2]{%
    \upbcn@ifsolutions{\textbf{Answer:} #2}{#1}%
}

% \stickerbox: the frame on the exam cover for the proctor's sticker
\newcommand{\stickerbox}{%
    \begin{center}
        \framebox{%
            \begin{minipage}[c][50.8mm][c]{96mm}
                \centering - Aufkleber der Klausuraufsicht -
            \end{minipage}%
        }
    \end{center}
}

% \gradingtable{18,26,22,24}: the grading table on the exam cover, with one
% column per task and a column for the total. It matches the notebox
% style: a black header band, the points on the notebox gray,
% and a tall row left blank for the graders' scores
\newcount\upbcn@gradingtasks
\newcount\upbcn@gradingtotal
\newlength{\upbcn@gradinglabel}
\newlength{\upbcn@gradingcell}
\setlength{\upbcn@gradinglabel}{2.2cm}
\newcommand{\gradingtable}[1]{%
    \begingroup
    \upbcn@gradingtasks\z@
    \upbcn@gradingtotal\z@
    \@for\upbcn@points:=#1\do{%
        \advance\upbcn@gradingtasks\@ne
        \advance\upbcn@gradingtotal\upbcn@points\relax
    }%
    % The frame's line width (0.5pt) is kept within \linewidth
    \setlength{\upbcn@gradingcell}{%
        \dimexpr(\linewidth-0.5pt-\upbcn@gradinglabel)/(\upbcn@gradingtasks+1)\relax}%
    % With few tasks, the cells keep a moderate width instead of filling
    % the line, and the table is set flush left
    \ifdim\upbcn@gradingcell>3cm
        \setlength{\upbcn@gradingcell}{3cm}%
    \fi
    \par\noindent
    \begin{tikzpicture}[
        x=\upbcn@gradingcell, y=1cm,
        every node/.style={font=\sffamily\small, inner sep=0pt},
        label/.style={anchor=west, font=\sffamily\small\bfseries}
    ]
        % The label column spans x from -\upbcn@gradinglabel to 0, task i
        % spans x from i-1 to i, and the total spans the last column; the
        % rows are 0.7cm (header), 0.7cm (points), and 1.5cm (scores) high
        \def\upbcn@last{\the\numexpr\upbcn@gradingtasks+1\relax}%
        \coordinate (nw) at (-\upbcn@gradinglabel, 0);
        \coordinate (se) at (\upbcn@last, -2.9);
        % Caption
        \node[anchor=south west, font=\sffamily\bfseries]
            at ([yshift=6pt]nw) {Grades};
        \node[anchor=south east, font=\sffamily\footnotesize, text=gray]
            at ([yshift=6pt]se |- nw) {For graders only. Please do not write in this table.};
        % Rows
        \fill[black] (nw) rectangle (\upbcn@last, -0.7);
        \fill[gray!5] (-\upbcn@gradinglabel, -0.7) rectangle (\upbcn@last, -1.4);
        % Grid: thin gray lines between the cells, and a black line before
        % the total and around the table
        \draw[gray!40] (-\upbcn@gradinglabel, -1.4) -- (\upbcn@last, -1.4);
        \foreach \c in {1,...,\upbcn@gradingtasks}
            \draw[gray!40] (\c-1, -0.7) -- (\c-1, -2.9);
        \draw[black, line width=0.5pt]
            (\upbcn@gradingtasks, 0) -- (\upbcn@gradingtasks, -2.9);
        \draw[black, line width=0.5pt] (nw) rectangle (se);
        % Labels
        \node[label, text=white] at ([xshift=8pt]-\upbcn@gradinglabel, -0.35) {Task};
        \node[label] at ([xshift=8pt]-\upbcn@gradinglabel, -1.05) {Points};
        \node[label] at ([xshift=8pt]-\upbcn@gradinglabel, -2.15) {Score};
        % Tasks and their points
        \foreach \p [count=\c] in {#1} {
            \node[text=white, font=\sffamily\small\bfseries] at (\c-0.5, -0.35) {\c};
            \node at (\c-0.5, -1.05) {\p};
        }
        \node[text=white, font=\sffamily\small\bfseries]
            at (\upbcn@last-0.5, -0.35) {Total};
        \node[font=\sffamily\small\bfseries]
            at (\upbcn@last-0.5, -1.05) {\the\upbcn@gradingtotal};
    \end{tikzpicture}\par
    \endgroup
}
