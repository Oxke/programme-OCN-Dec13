\ProvidesClass{programme}[2026/11/17 v1.2 Classical Music Programme Class]

\newif\if@landscape
\@landscapefalse
\DeclareOption{landscape}{\@landscapetrue\PassOptionsToPackage{landscape}{geometry}}
\DeclareOption{portrait}{\@landscapefalse\PassOptionsToPackage{portrait}{geometry}}
\DeclareOption{a4paper}{\PassOptionsToPackage{a4paper}{geometry}}
\DeclareOption{a5paper}{\PassOptionsToPackage{a5paper}{geometry}}
\DeclareOption{letterpaper}{\PassOptionsToPackage{letterpaper}{geometry}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{portrait,a4paper,11pt}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage[T1]{fontenc}
\RequirePackage{mathpazo}
\RequirePackage[scaled=0.9]{helvet}
\RequirePackage{microtype}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage{enumitem}
\RequirePackage{parskip}

\if@landscape
  \geometry{top=1.4cm, bottom=1.4cm, left=1.6cm, right=1.6cm}
  \setlength{\columnsep}{1.4cm}
\else
  \geometry{top=2.0cm, bottom=2.0cm, left=2.2cm, right=2.2cm}
  \setlength{\columnsep}{1.0cm}
\fi

\pagestyle{empty}

% Palette & rules
% \definecolor{progaccent}{HTML}{4A1C24}
\definecolor{progaccent}{HTML}{5d4231}
\definecolor{progmuted}{HTML}{555555}

\newcommand{\progrule}{
  \par\vspace{0.35em}{\color{progaccent!60}\hrule height 0.5pt}\vspace{0.55em}
}

\renewcommand{\section}{\@startsection{section}{1}{\z@}
  {-1.4ex \@plus -0.3ex \@minus -0.2ex}{0.5ex \@plus 0.2ex}
  {\normalfont\normalsize\bfseries\scshape\color{progaccent}}}

% Metadata
\newcommand{\@when}[2]{\ifx#1\@empty\else#2\fi}
\newcommand{\@coverlogo}{}       \newcommand{\coverlogo}[1]{\renewcommand{\@coverlogo}{#1}}
\newcommand{\@ensemble}{}        \newcommand{\ensemble}[1]{\renewcommand{\@ensemble}{#1}}
\newcommand{\@concerttitle}{}    \newcommand{\concerttitle}[1]{\renewcommand{\@concerttitle}{#1}}
\newcommand{\@concertsubtitle}{} \newcommand{\concertsubtitle}[1]{\renewcommand{\@concertsubtitle}{#1}}
\newcommand{\@headliners}{}      \newcommand{\headliners}[1]{\renewcommand{\@headliners}{#1}}
\newcommand{\@concertdate}{}     \newcommand{\concertdate}[1]{\renewcommand{\@concertdate}{#1}}
\newcommand{\@venue}{}           \newcommand{\venue}[1]{\renewcommand{\@venue}{#1}}
\newcommand{\@coversponsors}{}   \newcommand{\coversponsors}[1]{\renewcommand{\@coversponsors}{#1}}
\newcommand{\@backsponsors}{}    \newcommand{\backsponsors}[1]{\renewcommand{\@backsponsors}{#1}}
\newcommand{\@notice}{}          \newcommand{\notice}[1]{\renewcommand{\@notice}{#1}}
\newcommand{\@contact}{}         \newcommand{\contact}[1]{\renewcommand{\@contact}{#1}}

% Images & logos
\newcommand{\logo}[2][0.75cm]{
  \raisebox{-0.5\height}{\includegraphics[height=#1]{#2}}
}
\NewDocumentCommand{\photo}{O{0.85\linewidth} O{0pt 0pt 0pt 0pt} m}{
  \par\vspace{0.4em}{\centering\includegraphics[trim={#2}, clip, width=#1]{#3}\par}\vspace{0.4em}
}

% Page 1: Front Cover
\newcommand{\makecover}{
  \begin{center}
    \vspace*{7em}
    \@when{\@coverlogo}{{\@coverlogo\par\vspace{1.2em}}}
    \@when{\@ensemble}{{\sffamily\small\MakeUppercase{\@ensemble}\par\vspace{1.6em}}}
    \@when{\@concerttitle}{{\Huge\bfseries\color{progaccent}\@concerttitle\par\vspace{0.4em}}}
    \@when{\@concertsubtitle}{{\large\itshape\@concertsubtitle\par}}
    \vspace{1.1em}
    {\color{progaccent!60}\rule{0.35\linewidth}{0.5pt}}
    \vspace{1.1em}\par
    \@when{\@headliners}{{\normalsize\@headliners\par}}
    {\small\color{progmuted}
      \@when{\@concertdate}{\@concertdate\par}
      \@when{\@venue}{\@venue\par}
    }
    \vfill
    \@when{\@coversponsors}{{\vspace{1.2em}\@coversponsors\par}}
    \vspace*{0.4em}
  \end{center}
}

% Page 2: Compact Interior Header
\newcommand{\makeheader}{
  \noindent{\scshape\bfseries\color{progaccent}\@concerttitle}
  \hfill{\footnotesize\color{progmuted}\@concertdate}
  \progrule
}

% Page 4: Back Cover
\newenvironment{backcover}{}{
  \vfill
  \@when{\@backsponsors}{{\begin{center}\@backsponsors\end{center}\vspace{0.3em}}}
  \@when{\@notice}{{\footnotesize\itshape\color{progmuted}\noindent\@notice\par}}
  \@when{\@contact}{
    \progrule
    {\footnotesize\sffamily\color{progmuted}\noindent\@contact\par}
  }
}

% Repertoire & Performers
\newcommand{\performer}[2]{
  \noindent\textbf{#1}\if\relax\detokenize{#2}\relax\else: \textit{#2}\fi\par\vspace{0.15em}
}
\newcommand{\conductor}[1]{\performer{#1}{conductor}}

\newcommand{\roster}[2]{%
  \noindent\hangindent=1em\hangafter=1{\small\textbf{#1:} #2}\par\vspace{0.15em}%
}
\newcommand{\rosterlegend}[1][* section leader]{%
  \par\vspace{0.25em}\noindent{\footnotesize\itshape\color{progmuted}#1}\par%
}

\newcommand{\piece}[3][]{
  \par\vspace{0.7em}
  \noindent{\bfseries #2}
  \if\relax\detokenize{#1}\relax\else\hfill{\small\color{progmuted}#1}\fi
  \par\vspace{0.1em}\noindent{\itshape #3}\par\vspace{0.15em}
}

\newcommand{\arrangedby}[1]{
  \noindent{\footnotesize\color{progmuted}#1}\par\vspace{0.15em}
}

\newlist{movements}{itemize}{1}
\setlist[movements]{label={}, leftmargin=1.4em, topsep=0.1em, itemsep=0.1em, parsep=0pt}
\newcommand{\mvt}[1]{\item \small #1}

\newcommand{\intermission}[1][Intermission]{
  \par\vspace{0.85em}
  \noindent\makebox[\linewidth]{
    \color{progaccent!50}\hrulefill\enspace{\small\scshape\color{progaccent}#1}\enspace\color{progaccent!50}\hrulefill
  }\par\vspace{0.85em}
}

% Notes, Bios & Upcoming Events
\newcommand{\note}[2]{\par\vspace{0.35em}\noindent\textbf{#1}\par\vspace{0.1em}\noindent #2\par}
\newcommand{\bio}[2]{\par\vspace{0.35em}\noindent\textbf{#1} --- #2\par}
\newcommand{\upcoming}[2]{\par\vspace{0.25em}\noindent{\small\textbf{#1} $\cdot$ \textit{#2}}\par}

% Side-by-Side Spread (\nextpanel draws a divider; \nextpanel* omits it for outer covers)
\newenvironment{twopanel}{
  \noindent\begin{minipage}[t][0.98\textheight][t]{0.47\textwidth}
}{
  \end{minipage}
}
\newcommand{\nextpanel}{\@ifstar{\@nextpanel{}}{\@nextpanel{\color{progaccent!56}\vrule width 0.5pt}}}
\newcommand{\@nextpanel}[1]{
  \end{minipage}\hfill#1\hfill\begin{minipage}[t][0.98\textheight][t]{0.47\textwidth}
}
