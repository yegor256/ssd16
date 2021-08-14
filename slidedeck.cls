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

\RequirePackage{pagecolor}
\RequirePackage{xcolor}
  \definecolor{sd-white}{HTML}{EEEEEE}
  \definecolor{sd-red}{HTML}{E63946}
  \definecolor{sd-black}{HTML}{232527}
  \definecolor{sd-grey}{HTML}{EAF6FF}
  \definecolor{sd-green}{HTML}{5C946E}
  \definecolor{sd-blue}{HTML}{1D3557}

\DeclareOption{inverse}{
  \pagecolor{sd-black}
  \color{sd-white}
}
\ProcessOptions\relax

\LoadClass{article}
\RequirePackage{geometry}
  \geometry{paperwidth=16in, paperheight=9in, left=0.5in, right=0.5in, textwidth=10in, top=2in, bottom=2in, headsep=1.5in, footskip=1.5in}
\RequirePackage[tt=false,type1=true]{libertine}
\RequirePackage{microtype}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{multicol}
\RequirePackage{varwidth}
\RequirePackage{enumitem}
\RequirePackage{pbox}
\RequirePackage{changepage}
\RequirePackage{graphicx}
\RequirePackage{soul}
\RequirePackage{tikz}
  \usetikzlibrary{arrows}
  \usetikzlibrary{decorations}
  \usetikzlibrary{decorations.pathmorphing}
  \usetikzlibrary{intersections}
  \usetikzlibrary{positioning}
  \usetikzlibrary{backgrounds}
  \usetikzlibrary{calc}
  \usetikzlibrary{shapes.arrows}
\RequirePackage{lastpage}
\RequirePackage{etoolbox}
\RequirePackage[absolute]{textpos}
  \TPGrid{16}{16}
\RequirePackage{fancyhdr}
  \pagestyle{fancy}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhf{}
  \fancyhead[R]{\ttfamily {\thepage{}}{\small/\pageref{LastPage}}}

\newcommand*\sdBODY{}
\newcommand*\sdHOOKS{}
\newcommand\sdFLUSH{\sdHOOKS\sdBODY\vspace*{0pt}\newpage}
\newcommand\sdClear{\sdFLUSH\renewcommand*\sdBODY{}}
\newcommand\sdClick{\sdFLUSH}
\newcommand\sdHook[2]{
  \expandafter\newcommand\csname sdHOOK#1\endcsname{#2}
  \gappto\sdHOOKS{\csname sdHOOK#1\endcsname}
}
\newcommand\sdHookDelete[1]{
  \expandafter\renewcommand\csname sdHOOK#1\endcsname{}
}

\newcommand\sdTopLeft[1]{\fancyhead[L]{\footnotesize\ttfamily #1}}
\newcommand\sdBottomLeft[1]{\fancyfoot[L]{\footnotesize\ttfamily #1}}

\newcommand\sdTitle[2]{
  \sdCenter{\tikz{
    \begin{scope}[rotate=12,transform shape]
      \node[fill=sd-green,font={\color{sd-black}\fontsize{92pt}{92pt}\selectfont}] (title) {#1};
      \node[fill=sd-green,font={\color{sd-black}\fontsize{48pt}{48pt}\selectfont},below right=1cm and 4cm of title.south, anchor=north] (subtitle) {#2};
    \end{scope}
  }}
}

\newcommand\sdSkip[1]{\parshape 1 #1 \dimexpr\linewidth-#1\relax}

\newcommand*\sdTOC{}
\newcommand\sdToc[1]{
  \ifx\sdTOC\empty
    \gappto\sdBODY{
      \sdSkip{6in}
      \tikz{
        \node (z) {
          \begin{varwidth}{\textwidth}
            \begin{itemize}[label={}]
              \sdTOC
            \end{itemize}
          \end{varwidth}
        };
        \path [draw=sd-white,line width=4pt] (z.north west) -- (z.south west);
      }
    }
  \fi
  \gappto\sdTOC{\item #1}
}
\newcommand\sdTocNext{}
\newcommand\sdTocDelete{}

\newcommand*\sdMENU{}
\newcounter{sdMENUcnt}
\newcommand\sdMenu[1]{
  \ifx\sdMENU\empty
    \setcounter{sdMENUcnt}{1}
    \sdHook{menu}{
      \newgeometry{textwidth=6in}
      \begin{textblock}{4}(1,3)%
        \tikz{
          \node (z) {
            \begin{varwidth}{\textwidth}
              \small\ttfamily
              \begin{enumerate}[label={}]
                \sdMENU
              \end{enumerate}
            \end{varwidth}
          };
          \path [draw=sd-white,line width=4pt] (z.north east) -- (z.south east);
        }
      \end{textblock}%
    }
  \fi
  \gappto\sdMENU{
    \item \ifnum\value{enumi}=\value{sdMENUcnt}
      \ul{#1}
    \else
      {#1}
    \fi
  }
}
\newcommand\sdMenuNext{\stepcounter{sdMENUcnt}}
\newcommand\sdMenuDelete{
  \sdHookDelete{menu}
  \restoregeometry
}

\newcommand\sdBanner[2][]{
  \tikz{\node[rotate=6,transform shape,fill=sd-green,font={\color{sd-black}}]{#2};}\par
}

\newcommand\sdQR[1]{#1}

\newcommand\sdTwoColumns{}

\newcommand\sdPrint[1]{
  \gappto\sdBODY{#1}
}

\newcommand\sdCenter[1]{
  \vspace*{\fill}
  \begin{center} #1 \end{center}
  \vspace*{\fill}
}

\newcommand\sdQuote[3]{
  \begin{multicols}{2}\raggedcolumns
    \begin{flushright}
      \includegraphics[width=0.5\columnwidth]{#1}
    \end{flushright}

    \columnbreak

    \begin{raggedright}
      ``#2''
    \end{raggedright}

    \begin{flushright}
      \small --- #3
    \end{flushright}
  \end{multicols}
}

\renewcommand\normalsize{\fontsize{28pt}{32pt}\selectfont}
\renewcommand\small{\fontsize{22pt}{24pt}\selectfont}
\renewcommand\footnotesize{\fontsize{16pt}{20pt}\selectfont}
\renewcommand\large{\fontsize{32pt}{36pt}\selectfont}

\AtBeginDocument{%
  \raggedbottom%
  \raggedright%
  \setlength\topskip{0pt}%
  \setlength\headheight{32pt}%
  \setlength\parindent{0pt}%
  \setlength\parskip{18pt}%
  \setlength\columnsep{32pt}%
  \normalsize
}

\endinput