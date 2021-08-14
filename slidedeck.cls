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
  \definecolor{sd-green}{HTML}{5C946E}
  \definecolor{sd-blue}{HTML}{1D3557}

\DeclareOption{inverse}{
  \pagecolor{sd-black}
  \color{sd-white}
}
\ProcessOptions\relax

\LoadClass{article}
\RequirePackage{geometry}
  \geometry{paperwidth=16in, paperheight=9in, marginparsep=2in, marginparwidth=2in, left=0.5in, right=0.5in, textwidth=10in, top=2in, bottom=2in, headsep=1.5in, footskip=1.5in}
\RequirePackage[tt=false,type1=true]{libertine}
\RequirePackage{microtype}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{multicol}
\RequirePackage{enumitem}
\RequirePackage{changepage}
\RequirePackage{graphicx}
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
  \fancyhead[R]{\ttfamily {\Huge\thepage{}}{\Large/\pageref{LastPage}}}

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

\newcommand\sdTopLeft[1]{\fancyhead[L]{\Large\ttfamily #1}}
\newcommand\sdBottomLeft[1]{\fancyfoot[L]{\Large\ttfamily #1}}

\newcommand\sdTitle[2]{
  \gappto\sdBODY{
    \begin{textblock}{14}[0.5,0.5](8,8)%
      \begin{center}\tikz{
        \begin{scope}[rotate=12,transform shape]
          \node[fill=sd-green,font={\color{sd-black}\fontsize{92pt}{92pt}\selectfont}] (title) {#1};
          \node[fill=sd-green,font={\color{sd-black}\fontsize{48pt}{48pt}\selectfont},below right=1cm and 4cm of title.south, anchor=north] (subtitle) {#2};
        \end{scope}
      }\end{center}%
    \end{textblock}
  }
}

\newcommand*\sdTOC{}
\newcommand\sdToc[1]{
  \ifx\sdTOC\empty
    \gappto\sdBODY{
      \begin{adjustwidth}{6in}{0in}
        \begin{itemize}[label={}]
          \sdTOC
        \end{itemize}
      \end{adjustwidth}
    }
  \fi
  \gappto\sdTOC{\item #1}
}
\newcommand\sdTocNext{}
\newcommand\sdTocDelete{}

\newcommand*\sdMENU{}
\newcommand\sdMenu[1]{
  \ifx\sdMENU\empty
    \sdHook{menu}{
      \begin{textblock}{4}(1,1)%
        \begin{itemize}[label={}]
          \sdMENU
        \end{itemize}
      \end{textblock}%
    }
  \fi
  \gappto\sdMENU{\item #1}
}
\newcommand\sdMenuNext{}
\newcommand\sdMenuDelete{\sdHookDelete{menu}}

\newcommand\sdBanner[1][1]{\tikz{\node[fill=sd-green,color=sd-black]{#1};}}

\newcommand\sdQR[1]{#1}

\newcommand\sdTwoColumns{}

\newcommand\sdImage[1][1]{#1}

\newcommand\sdPrint[1]{#1}

\newcommand\sdQuote[3]{
  \gappto\sdBODY{
    \begin{multicols}{2}\raggedcolumns
      \begin{flushright}
        \includegraphics[width=0.5\columnwidth]{#1}
      \end{flushright}

      \columnbreak

      ``#2''

      \begin{flushright}
        \Large --- #3
      \end{flushright}
    \end{multicols}
  }
}

\AtBeginDocument{%
  \raggedbottom%
  \raggedright%
  \setlength\topskip{0mm}%
  \setlength\headheight{24pt}%
  \setlength\parindent{0pt}%
  \setlength\parskip{6pt}%
  \setlength\columnsep{32pt}%
  \fontsize{28pt}{32pt}\selectfont
}

\endinput