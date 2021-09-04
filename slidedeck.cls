% (The MIT License)
%
% Copyright (c) 2021 Yegor Bugayenko
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the 'Software'), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{slidedeck}[00.00.0000 0.0.0 Slide Deck]

\RequirePackage{xcolor}
  \definecolor{sd-white}{HTML}{EEEEEE}
  \definecolor{sd-red}{HTML}{ED474A}
  \definecolor{sd-orange}{HTML}{F06543}
  \definecolor{sd-black}{HTML}{232527}
  \definecolor{sd-grey}{HTML}{C0BCB5}
  \definecolor{sd-green}{HTML}{5C946E}
  \definecolor{sd-blue}{HTML}{5299D3}
\RequirePackage{pagecolor}

\newif\ifwhite
\DeclareOption{white}{\whitetrue}
\newif\ifstatic
\DeclareOption{static}{\statictrue}
\ProcessOptions\relax

\LoadClass{article}
\RequirePackage{geometry}
  \geometry{paperwidth=16in, paperheight=9in, left=4in, right=2in, top=1.5in, bottom=1.5in}
\RequirePackage[tt=false,type1=true]{libertine}
\RequirePackage{microtype}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{multicol}
\RequirePackage{anyfontsize}
\RequirePackage{varwidth}
\RequirePackage{verbatim}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[inline]{enumitem}
\RequirePackage{ffcode}
\RequirePackage{multirow}
\RequirePackage{changepage}
\RequirePackage{tabularx}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage{qrcode}
\RequirePackage{soul}
\RequirePackage{tikz}
  \RequirePackage{tikzpagenodes}
  \usetikzlibrary{arrows}
  \usetikzlibrary{decorations}
  \usetikzlibrary{decorations.pathmorphing}
  \usetikzlibrary{intersections}
  \usetikzlibrary{positioning}
  \usetikzlibrary{backgrounds}
  \usetikzlibrary{calc}
  \usetikzlibrary{shapes.arrows}
\RequirePackage{lastpage}
\RequirePackage[absolute]{textpos}
  \TPGrid{16}{16}

\renewcommand\section[1]{\stepcounter{section}}
\renewcommand\subsection[1]{\stepcounter{subsection}}
\RequirePackage{/code/crumbs/crumbs}

\RequirePackage{fancyhdr}
  \pagestyle{fancy}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhf{}
  \renewcommand\crumb[2]{
    \ifnum\value{crumbi}=\value{section}
      {\setulcolor{sd-blue}\color{sd-blue}\ul{#1}}
    \else
      #1
    \fi
  }
  \renewcommand\subcrumb[2]{
    \ifnum\value{subcrumbi}=\value{subsection}
      {\setulcolor{sd-blue}\color{sd-blue}\ul{#1}}
    \else
      #1
    \fi
  }
  \fancyhead[L]{
    \ifx\crumbs\empty\else
      \begin{textblock}{12}(1,1)%
        \small\ttfamily%
        \ifnum\value{section}=0\else
          \crumbs
          \\[6pt]
          \quad\footnotesize\color{gray}\subcrumbs
        \fi
      \end{textblock}%
    \fi
  }
  \fancyhead[R]{
    \ifnum\value{page}=1\else%
      \begin{textblock}{4}[1,0](15,1)%
        \ttfamily {\thepage{}}{\small{\color{sd-grey}/\pageref{LastPage}}}
      \end{textblock}%
      \ifstatic\else%
        \begin{textblock}{1}[1,0](15.8,0.2)%
          \tikz{\node[inner sep=2pt,circle,draw=sd-grey]{\color{sd-grey}\footnotesize\ttfamily\thesdMinutes{}};}
        \end{textblock}%
      \fi
    \fi
  }

\newcommand\sdLeft[1]{
  \fancyfoot[L]{
    \ifnum\value{page}=1\else%
      \begin{textblock}{8}[0,1](1,15)%
        {\color{sd-grey}\footnotesize\ttfamily #1}
      \end{textblock}%
    \fi
  }
}

\newcommand\sdRight[1]{
  \fancyfoot[R]{
    \ifnum\value{page}=1\else%
      \begin{textblock}{8}[1,1](15,15)%
        {\color{sd-grey}\footnotesize\ttfamily #1}
      \end{textblock}%
    \fi
  }
}

\newcommand*\sdBODY{}
\newcommand\sdFLUSH{\sdBODY\vspace*{0pt}\newpage}
\newcommand\sdFlush[1][1]{\sdFLUSH\renewcommand*\sdBODY{}\sdMins{#1}}
\newcommand\sdClick{\ifstatic\else\sdFLUSH\fi}

\newcommand\br{\newline}

\newcommand\sdMiddle[1]{\vspace*{\fill}#1\vspace*{\fill}}

\newcommand\sdTitle[2]{
  {\sdBanner{\Huge #1}}
  {\sdBanner{\large #2}}
}

\newcommand*\sdTOC{}
\newcommand\sdToc{
  \renewcommand*\sdTOC{}
  \sdPrint{
    \tikz{
      \node (z) {
        \begin{varwidth}{\textwidth}
          \ifx\sdTOC\empty\else
            \begin{itemize}[label={}]
              \sdTOC
            \end{itemize}
          \fi
        \end{varwidth}
      };
      \path [draw=sd-blue,line width=4pt] (z.north west) -- (z.south west);
    }
  }
  \begin{@empty}
    \renewcommand\crumb[2]{
      \ifx\sdTOC\empty\else\sdClick\fi
      \gappto\sdTOC{\item ##2}
    }
    \crumbs
  \end{@empty}
  \sdFlush[1]
}

\let\theoldsection\section
\renewcommand\section[2]{
  \theoldsection[#1]{#2}
  \sdPrintAndFlush{
    \sdMiddle{%
      {\ttfamily Chapter \#\the\value{section}:}
      \sdBanner[blue]{\Large #2}
    }
  }
}

\newcommand\sdBanner[2][green]{
  \par
  {\setlength{\fboxsep}{6pt}\colorbox{sd-#1}{\color{sd-white} #2}}
  \par
}

\newcommand\sdPic[2]{
  {%
    \setlength{\fboxsep}{0pt}%
    \setlength{\fboxrule}{1pt}%
    \fcolorbox{sd-grey}{sd-white}{%
      \includegraphics[width=#1\columnwidth]{#2}%
    }%
  }
}

\newcommand\sdQR[2][2in]{
  \tikz{%
    \node[draw=sd-white]{%
      \href{#2}{%
        \qrcode[height=#1]{#2}%
      }%
    }%
  }
}

\newcommand\sdPrint[1]{
  \gappto\sdBODY{{
    #1
    \par
  }}
}

% [1]: How many minutes to stay here
% [1]: The content to print and flush
\newcommand\sdPrintAndFlush[2][1]{
  \sdPrint{#2}\sdFlush[#1]
}

\newcommand\sdCite[3]{
  \begin{tabularx}{\columnwidth}{c>{\raggedright\arraybackslash}X}
    \raisebox{\dimexpr-\height+\ht\strutbox}{\sdPic{0.25}{../images/books/#1}}
    &
    ``#2''
    \def\param{#3}%
    \ifx\param\empty\else
      \newline\newline
      \small
      --- #3
    \fi
    \\
  \end{tabularx}
}

\newcommand\sdQuote[3]{\sdCite{../people/#1}{#2}{#3}}

% How many minutes more we spend
\newcommand\sdMins[1]{
  \addtocounter{sdMinutes}{#1}
}
\newcounter{sdMinutes}

\newcommand\sdSnippet[2][]{
  \begin{samepage}
    \small #1\verbatiminput{#2}
  \end{samepage}
}

\newcommand\sdPin[1]{%
  \begin{tikzpicture}[remember picture,overlay]%
    \node[anchor=north east] at (current page text area.north east) {%
      \begin{minipage}{\textwidth}%
        \raggedleft{#1}%
      \end{minipage}%
    };%
  \end{tikzpicture}%
}

\newcommand\nospell[1]{#1}

\renewcommand\normalsize{\fontsize{28pt}{32pt}\selectfont}
\renewcommand\small{\fontsize{22pt}{24pt}\selectfont}
\renewcommand\footnotesize{\fontsize{16pt}{20pt}\selectfont}
\renewcommand\large{\fontsize{32pt}{36pt}\selectfont}
\renewcommand\Large{\fontsize{42pt}{42pt}\selectfont}
\renewcommand\LARGE{\fontsize{52pt}{56pt}\selectfont}
\renewcommand\Huge{\fontsize{92pt}{104pt}\selectfont}

\AtBeginDocument{%
  \ifwhite\else
    \pagecolor{sd-black}
    \color{sd-white}
  \fi
  \raggedbottom%
  \raggedright%
  \raggedcolumns%
  \setlength\topskip{0pt}%
  \setlength\headheight{32pt}%
  \setlength\footskip{32pt}%
  \setlength\parindent{0pt}%
  \setlength\parskip{18pt}%
  \setlength\columnsep{32pt}%
  \normalsize
}

\endinput