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
  \definecolor{sd-red}{HTML}{E63946}
  \definecolor{sd-black}{HTML}{232527}
  \definecolor{sd-grey}{HTML}{EAF6FF}
  \definecolor{sd-green}{HTML}{5C946E}
  \definecolor{sd-blue}{HTML}{1D3557}
\RequirePackage{pagecolor}

\DeclareOption{inverse}{
  \pagecolor{sd-black}
  \color{sd-white}
}
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
\RequirePackage{enumitem}
\RequirePackage{multirow}
\RequirePackage{changepage}
\RequirePackage{tabularx}
\RequirePackage{graphicx}
\RequirePackage{soul}
\RequirePackage{tcolorbox}
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
  \fancyhead[R]{
    \ifnum\value{page}=1\else%
      \begin{textblock}{8}[1,0](15,1)%
        \ttfamily {\thepage{}}{\small/\pageref{LastPage}}
      \end{textblock}%
    \fi
  }

\newcommand*\sdBODY{}
\newcommand*\sdHOOKS{}
\newcommand\sdFLUSH{\sdHOOKS\sdBODY\vspace*{0pt}\newpage}
\newcommand\sdClear{\sdFLUSH\renewcommand*\sdBODY{}}
\newcommand\sdClick{\sdFLUSH}
\newcommand\sdHook[2]{
  \ifcsname sdHOOK#1\endcsname\else
    \expandafter\newcommand\csname sdHOOK#1\endcsname{}
  \fi
  \expandafter\renewcommand\csname sdHOOK#1\endcsname{#2}
  \gappto\sdHOOKS{\csname sdHOOK#1\endcsname}
}
\newcommand\sdHookDelete[1]{
  \expandafter\renewcommand\csname sdHOOK#1\endcsname{}
}

\newcommand\sdTopLeft[1]{
  \fancyhead[L]{
    \ifnum\value{page}=1\else%
      \begin{textblock}{8}(1,1)%
        \footnotesize\ttfamily #1
      \end{textblock}%
    \fi
  }
}
\newcommand\sdBottomLeft[1]{
  \fancyfoot[L]{
    \ifnum\value{page}=1\else%
      \begin{textblock}{8}[0,1](1,15)%
        \footnotesize\ttfamily #1
      \end{textblock}%
    \fi
  }
}

\newcommand\sdTitle[2]{
  {\fontsize{92pt}{92pt}\selectfont\sdBanner{#1}}
  {\fontsize{32pt}{32pt}\selectfont\sdBanner{#2}}
}

\newcommand*\sdTOC{}
\newcommand\sdToc[1]{
  \ifx\sdTOC\empty
    \gappto\sdBODY{
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
      \begin{textblock}{4}[0,1](1,14)%
        \tikz{
          \node[inner sep=0pt] (z) {
            \begin{varwidth}{\textwidth}
              \small\ttfamily
              \begin{enumerate}[label={},labelindent=0pt]
                \sdMENU
              \end{enumerate}
            \end{varwidth}
          };
          \path [draw=sd-white,line width=4pt] (z.north west) -- (z.south west);
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
}

\newtcbox{\sdSTICKER}{nobeforeafter,colback=sd-grey,boxsep=2pt,boxrule=0pt,arc=0pt,left=2pt,right=2pt,top=2pt,bottom=2pt}
\newcommand\sdSticker[1]{
  \sdHook{sticker}{
    \begin{textblock}{4}(1,2)%
      \sdSTICKER{\color{sd-black}\ttfamily #1}
    \end{textblock}%
  }
}
\newcommand\sdStickerDelete{
  \sdHookDelete{sticker}
}

\newtcbox{\sdBANNER}{nobeforeafter,colback=sd-green,boxsep=6pt,boxrule=0pt,arc=0pt,left=6pt,right=6pt,top=6pt,bottom=6pt}
\newcommand{\ff}[1]{\ffcodebox{\ffcoderule\texttt{#1}}}
\newcommand\sdBanner[2][]{\sdBANNER{#2}\par}

\newcommand\sdQR[1]{#1}

\newcommand\sdTwoColumns{}

\newcommand\sdPrint[1]{
  \gappto\sdBODY{#1}
}

\newcommand\sdQuote[3]{
  \begin{tabularx}{\columnwidth}{c>{\raggedright\arraybackslash}X}
  \raisebox{-\height}{\includegraphics[width=0.25\columnwidth]{#1}}
    % \multirow{2}*{\includegraphics[width=0.25\columnwidth]{#1}}
    &
    ``#2''
    \newline\newline
    \small
    --- #3
    \\
  \end{tabularx}
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
  \setlength\footskip{32pt}%
  \setlength\parindent{0pt}%
  \setlength\parskip{18pt}%
  \setlength\columnsep{32pt}%
  \normalsize
}

\endinput