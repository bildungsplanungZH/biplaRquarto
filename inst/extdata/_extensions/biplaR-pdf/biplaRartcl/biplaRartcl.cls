%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% biplaRartcl.cls
% document class for Bildungsmonitoring reports
%
% Author: Flavian Imlig <flavian.imlig@bi.zh.ch>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\filedate{2021/06/25}
\def\fileversion{2.0}
\def\filename{biplaRartcl.cls}

\ProvidesClass{biplaRartcl}[\filedate\space v\fileversion\space biplaR article publication template (fi)]

%%%%%%
%% BASE CLASS
%%%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass{scrartcl}

%%%%%
%% Various packages
%%%%%
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{longtable, booktabs}

\RequirePackage{etoolbox}

%%%%%
%% Font settings
%%%%%
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}

\AtBeginDocument{%
	\setmainfont{Arial}[
		BoldFont = {Arial Black}]%
	%\setmainfont{Helvetica}%
	\setsansfont{Arial Black}%
	%\setsansfont{Helvetica Black}%
	\urlstyle{same} % disable monospaced font for URLs
}

\newfontfamily \zhbold{Arial Black}
\newfontfamily \zhsmall{Arial Narrow}[
    ItalicFont={Arial Narrow Italic},
    BoldFont={Arial Narrow Bold},
    BoldItalicFont={Arial Narrow Bold Italic}]

\newkomafont{zhbasic}{\fontsize{10.5bp}{14bp}\selectfont}
\newkomafont{zhbold}{\usesizeofkomafont{zhbasic}\zhbold\color{black}}

\AtBeginDocument{\KOMAoptions{fontsize = 10.5bp}}
\AtBeginDocument{\usekomafont{zhbasic}}
\AtBeginDocument{\KOMAoptions{parskip = full}}
\KOMAoptions{headings = small}

\setkomafont{title}{\usekomafont{zhbold}\addfontfeature{LetterSpace=-6.5}\raggedright}
\setkomafont{subtitle}{\usekomafont{zhbold}\addfontfeature{LetterSpace=-5.5}\raggedright}
\setkomafont{titlehead}{\usekomafont{zhbold}\fontsize{8bp}{10bp}\selectfont\raggedright}

\setkomafont{disposition}{\usekomafont{zhbold}\addfontfeature{LetterSpace=-2}}
\addtokomafont{paragraph}{\color{zhblue}}
\addtokomafont{subparagraph}{\color{zhgrey}}

\RedeclareSectionCommand[font=\fontsize{24bp}{24bp}\selectfont,%
						 afterindent = false,%
						 beforeskip=24bp plus 6bp minus 6bp,%
						 runin = false,%
						 afterskip=0bp]{section}
\xpreto\section{\clearpage}

\RedeclareSectionCommand[font=\fontsize{16bp}{16bp}\selectfont,%
						 afterindent = false,%
						 beforeskip=12bp plus 3bp minus 3bp,%
						 runin = false,%
						 afterskip=0bp]{subsection}

\RedeclareSectionCommand[afterindent = false,%
						  beforeskip=12bp plus 1bp minus 1bp,%
						  runin = false,%
						  afterskip=0bp]{subsubsection}

\setkomafont{pageheadfoot}{\rmfamily\scriptsize}
\setkomafont{pagination}{\usekomafont{pageheadfoot}}

\newkomafont{small}{\fontsize{9bp}{12bp}\selectfont\zhsmall}
\newkomafont{small_col}{\usekomafont{small}\color{zhblue}}
\setkomafont{caption}{\usekomafont{zhbold}\fontsize{8bp}{10.6bp}\selectfont}
\setkomafont{captionlabel}{\usekomafont{caption}}

\newkomafont{bibliography}{\usekomafont{small}\KOMAoptions{parskip=half-}\selectfont}

\setkomafont{labelinglabel}{\usekomafont{small_col}}
\setkomafont{descriptionlabel}{\usekomafont{caption}\color{zhblue}}

\setkomafont{footnote}{\usekomafont{small}}
\deffootnote[1em]{1em}{0em}{\makebox[1em][l]{\textsuperscript{\thefootnotemark}}}

\KOMAoptions{captions=nooneline}
\setcapindent{0em}

%%%%%
%% Page settings
%%%%%
\KOMAoptions{usegeometry}
\KOMAoptions{BCOR=0bp}
\KOMAoptions{twoside}

\RequirePackage{calc}
\RequirePackage{geometry}
\geometry{%
	a4paper,
	top=54mm,
	bottom=30mm,
	outer=35mm,
	inner=25mm,
	marginparsep=2.5mm,
	marginparwidth=22.5mm,
	headheight=20mm,
	headsep=31.5mm - 20mm / 2,
	}

%%%
% Page and text layout settings
%%%
\RequirePackage{graphicx}
\RequirePackage{lastpage}
\RequirePackage{scrlayer-scrpage}
\RequirePackage{tikz}

\input{biplaRartcl_header}
\newtoggle{cl_header}
\toggletrue{cl_header}
\AtEndPreamble{%
    \iftoggle{cl_header}{\csuse{def_header}}{}}

\input{biplaRartcl_penalties}
\newtoggle{cl_penalties}
\toggletrue{cl_penalties}
\AtEndPreamble{%
    \iftoggle{cl_penalties}{\csuse{set_penalties}}{}}
\AtEndDocument{%
    \iftoggle{cl_penalties}{\csuse{log_penalties}}{}}

\input{biplaRartcl_hyphenation}
\newtoggle{cl_hyphenation}
\toggletrue{cl_hyphenation}
\AtEndPreamble{%
    \iftoggle{cl_hyphenation}{\csuse{set_hyphenation}}{}}
\AtEndDocument{%
    \iftoggle{cl_hyphenation}{\csuse{log_hyphenation}}{}}

\AtEndPreamble{%
    \RequirePackage[autostyle=true,german=quotes]{csquotes}}

%%%%%
%% Colours
%%%%%
\RequirePackage{xcolor}

\input{biplaRartcl_colours}
\newtoggle{cl_colours}
\toggletrue{cl_colours}
\AtEndPreamble{%
    \iftoggle{cl_colours}{\csuse{set_colours}}{}}

%%%%%
%% Hyperlinks
%%%%%
%\RequirePackage{url}
%\AtBeginDocument{%
\RequirePackage[breaklinks, colorlinks=true, linkcolor=black, citecolor=black, urlcolor=black, pdfpagemode=UseNone, pdfborder={0 0 0}]{hyperref}%}
\gappto{\UrlBreaks}{\UrlOrds}

%%%%%%
%% Enumerations, Lists, Boxes, TOC, LOT, LOF
%%%%%%
\RequirePackage[inline]{enumitem}
\RequirePackage[skins,breakable,xparse]{tcolorbox}

\input{biplaRartcl_lists}
\csuse{def_toc}
\csuse{def_lists}

%%%%%%
%% Acronyms
%%%%%%
\RequirePackage{acro}

\newtoggle{acrolist} % defaults to false
\AtEndPreamble{%
    \input{acrocode}
    \input{acrodef}}

%%%%%%
%% Reference macros
%%%%%%
\def\refAbb#1{%
	\refBase{$\rightarrow$~\figurename~\ref{#1}}%
	}

\def\refAbbNP#1{%
	\refBaseNP{$\rightarrow$~\figurename~\ref{#1}}%
	}

\def\refTab#1{%
	\refBase{$\rightarrow$~\tablename~\ref{#1}}%
	}

\def\refTabNP#1{%
	\refBaseNP{$\rightarrow$~\tablename~\ref{#1}}%
	}

\def\refKap#1{%
	\refBase{$\rightarrow$~Kap.~\ref{#1}}%
	}

\def\refKapNP#1{%
	\refBaseNP{$\rightarrow$~Kap.~\ref{#1}}%
	}

\def\refBase#1{%
    {\usekomafont{small}(#1)}%
    }

\def\refBaseNP#1{%
	{\usekomafont{small}#1}%
    }

%%%%%%
%% Various macros and definitions
%%%%%%
\defcaptionname{ngerman, german}{\contentsname}{Inhalt}

\def\texcode#1{#1}

\newcommand{\todo}[3][]{%
	\ifblank{#1}{%
		\begin{taskitemize}[label={[#2]}] \item #3 \end{taskitemize}%
		}{}%
	}

%%%%%
%% Title pages
%%%%%
\KOMAoptions{titlepage}
\input{biplaRartcl_titlepage_setup}
\input{biplaRartcl_titlepage}
\AtBeginDocument{\csuse{cl_tp_refreshmeta}}
