%% start of file 'smartcv.cls'
%% Copyright 2013 Bryan Yap (bryan.yap.mh@gmail.com)
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License version 1.3c,
% available at http://www.latex-project.org/lppl/.

% --------------------------------------------------------------------
% --- Identification
% ---
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{smartcv}[2013/10/17 v0.0 smart curriculum vitae document class]

% --------------------------------------------------------------------
% --- Class Options
% ---
% Declares the class options for the document

% --
% -- Paper Size Options
% paper size option (taken from article.cls)
\DeclareOption{a4paper}{%
  \setlength\paperheight  {297mm}%
  \setlength\paperwidth   {210mm}%
}
\DeclareOption{a5paper}{%
  \setlength\paperheight  {210mm}%
  \setlength\paperwidth   {148mm}%
}
\DeclareOption{b5paper}{%
  \setlength\paperheight  {250mm}%
  \setlength\paperwidth   {176mm}%
}
\DeclareOption{letterpaper}{%
  \setlength\paperheight  {11in}%
  \setlength\paperwidth   {8.5in}%
}
\DeclareOption{legalpaper}{%
  \setlength\paperheight  {14in}%
  \setlength\paperwidth   {8.5in}%
}
\DeclareOption{executivepaper}{%
  \setlength\paperheight  {10.5in}%
  \setlength\paperwidth   {7.25in}%
}
\DeclareOption{landscape}{%
  \setlength\@tempdima    {\paperheight}%
  \setlength\paperheight  {\paperwidth}%
  \setlength\paperwidth   {\@tempdima}%
}

% --
% -- Font Sizes
% font size options (taken from article.cls)
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

% --
% -- Draft and Final Option
% draft/final declaration
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

% default options
\ExecuteOptions{a4paper,11pt,final}

% process user specified options
\ProcessOptions
\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}

% spacing penalties (from article.cls)
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}

% indents and margins (from article.cls)
\setlength\leftmargini    {2.5em}
\setlength\leftmarginii   {2.2em}
\setlength\leftmarginiii  {1.87em}
\setlength\leftmarginiv   {1.7em}
\setlength\leftmarginv    {1em}
\setlength\leftmarginvi   {1em}
\setlength\labelsep       {0.5em}
\setlength\labelwidth     {\leftmargini}
\addtolength\labelwidth   {-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
                                
% --------------------------------------------------------------------
% --- 3rd Party Packages
% ---
% Loads 3rd party packages used by this class

% --
% -- fancyhdr Package
% use the fancyhdr package for custom headers and footers
\RequirePackage{fancyhdr}

% --
% -- xparse Package
% required for the \NewDocumentCommand
\RequirePackage{xparse}

% --
% -- xifthen Package
% allows for the use of \isempty
\RequirePackage{xifthen}

% --
% -- xcolor Package
% use the coloring package
\RequirePackage{xcolor}

% --
% -- etoolbox Package
% allows the definition of complex datastructures (maps and lists)
\RequirePackage{etoolbox}

% --
% -- forloop Package
% allows the construction of for loops
\RequirePackage{forloop}

% --
% -- enumitem Package
% allows customization of the list environments
\RequirePackage{enumitem}
\setlist{topsep=0em,parsep=0em,partopsep=0em,itemsep=0em}

% --
% -- amsmath Package
% allows the use of the \collect@body macro
\RequirePackage{amsmath}

% --
% -- hyperref Package
% allows the creation of hyperlinks on the document
\AtEndOfPackage{
  \RequirePackage{hyperref}

  % setup the hyperref package
  \hypersetup{
    hidelinks,
    pdftitle    = {\cvtitle}
  }
}

% --------------------------------------------------------------------
% --- Definition data structures which will be used in the package
% ---

% -- List Data Structure
% ------------------------

% creates a new list
% usage: \makenewlist{<list>}{<initial capacity>} (Optional)
\NewDocumentCommand{\makenewlist}{mG{}}{%
  \@ifundefined{c@list@#1@counter}{%
    \newcounter{list@#1@counter}%
    \newcounter{list@#1@loopcounter}%
  }{%
    \clearlist{#1}%
  }%
  \cvifdef{#2}{%
    \setcounter{list@#1@counter}{#2}%
  }%
}

% appends an item onto the list
% usage: \appendtolist{<list>}{<item>}
\newcommand*{\appendtolist}[2]{%
  \stepcounter{list@#1@counter}%
  \csxdef{list@#1@item\roman{list@#1@counter}}{#2}%
}

% sets an item in the list
% usage: \setlistitem{<list>}{<index>}{<item>}
\newcommand*{\setlistitem}[3]{%
  \csxdef{list@#1@item\romannumeral#2}{#3}%
}

% gets an item from the list
% usage: \getlistitem{<list>}{<index>}
\newcommand*{\getlistitem}[2]{%
  \csuse{list@#1@item\romannumeral#2}%
}

% get the list size
% usage: \listsize{<list>}
\NewDocumentCommand{\listsize}{m}{%
  \arabic{list@#1@counter}%
}

% sets the counter back to zero
% usage: \clearlist{<list>}
\NewDocumentCommand{\clearlist}{m}{%
  \setcounter{list@#1@counter}{0}%
}

\NewDocumentCommand{\nextindex}{m}{%
  \stepcounter{list@#1@counter}%
  \listsize{#1}%
  \addtocounter{list@#1@counter}{-1}%
}

% iterates over a list and applies the code
% usage: \iteratelist{<list>}{<variable>}{<code>}
% where: variable is the name of the loop variable, therefore it can
%        be accessed in the code using \<variable>
\NewDocumentCommand{\iteratelist}{mmm}{%
  \setcounter{list@#1@loopcounter}{0}%
  \csdef{#2}{\arabic{list@#1@loopcounter}}%
  \forloop{list@#1@loopcounter}{1}{\value{list@#1@loopcounter} < \numexpr\listsize{#1}+1}{%
    #3%
  }%
}

% --------------------------------------------------------------------
% --- Definition of basic data in the package
% ---

% -- Default values
\newcommand*{\cvtitle}{}
\newcommand*{\cvlastname}{}
\newcommand*{\cvdate}{\today}
\newcommand*{\cvcity}{}
\newcommand*{\cvcountry}{}
\newcommand*{\cvphone}{}
\newcommand*{\cvmobile}{}
\newcommand*{\cvfax}{}
\newcommand*{\cvwebsite}{}
\newcommand*{\cvextrainfo}{}
\newcommand*{\cvlinkedin}{}
\newcommand*{\cvtwitter}{}
\newcommand*{\cvgithub}{}

% defines the colors used in the document
\definecolor{cvcolor0}{rgb}{0,0,0} % default color (black by default)
\definecolor{cvcolor1}{rgb}{0,0,0} % primary color
\definecolor{cvcolor2}{rgb}{0,0,0} % secondary color
\definecolor{cvcolor3}{rgb}{0,0,0} % tertiary color

\NewDocumentCommand{\cvifdef}{mmG{}}{%
  \ifthenelse{\equal{#1}{}}{%
    #3%
  }{%
    #2
  }%
}

% --------------------------------------------------------------------
% --- Setter commands for personal information
% ---

% defines the name on the document
% usage: \cvname{<first name>}{<last name>}
\newcommand*{\setcvname}[1]{\def\cvname{#1}}

% defines the title of the document
% usage: \cvtitle{<title>}
\newcommand*{\setcvtitle}[1]{\def\cvtitle{#1}}

% defines the revision date on the document
% usage: \cvdate{<date>}
\newcommand*{\setcvdate}[1]{\def\cvdate{#1}}

% defines the address on the document
% usage: \cvaddress{<street>}{<city>}{<country>}
\NewDocumentCommand{\setcvaddress}{mG{}G{}}{\def\cvstreet{#1}\def\cvcity{#2}\def\cvcountry{#3}}

% defines the email address on the document
% usage: \setcvemail{<email>}
\newcommand*{\setcvemail}[1]{\def\cvemail{#1}}

% defines the website on the document
% usage: \setcvwebsite{<url>}
\newcommand*{\setcvwebsite}[1]{\def\cvwebsite{#1}}

% defines the phone number on the document
% usage: \setcvphone{<number>}
\newcommand*{\setcvphone}[1]{\def\cvphone{#1}}

% defines the mobile number on the document
% usage: \setcvmobile{<number>}
\newcommand*{\setcvmobile}[1]{\def\cvmobile{#1}}

% define the fax number on the document
% usage: \setcvfax{<number>}
\newcommand*{\setcvfax}[1]{\def\cvfax{#1}}

% define the linkedin username on the document
% usage: \setcvlinkedin{<profile>}
\newcommand*{\setcvlinkedin}[1]{\def\cvlinkedin{#1}}

% define the twitter account on the document
% usage: \setcvtwitter{<profile>}
\newcommand*{\setcvtwitter}[1]{\def\cvtwitter{#1}}

% define the github account on the document
% usage: \setcvgithub{<profile>}
\newcommand*{\setcvgithub}[1]{\def\cvgithub{#1}}

% defines additional personal information on the document
% usage: \setcvextrainfo{<info>}
\newcommand*{\setcvextrainfo}[1]{\def\cvextrainfo{#1}}

% --------------------------------------------------------------------
% --- Convenient commands
% ---

\newcommand*{\cvifhasanyphone}[1]{\cvifdef{\cvphone\cvmobile\cvfax}{#1}}

\newcommand*{\cvemaillink}{\cvifdef{\cvemail}{\href{mailto: \cvemail}{\cvemail}}}

\newcommand*{\cvwebsitelink}{\cvifdef{\cvwebsite}{\href{\cvwebsite}{\cvwebsite}}}

\newcommand*{\cvlinkedinlink}{\cvifdef{\cvlinkedin}{\href{http://www.linkedin.com/in/\cvlinkedin}{\cvlinkedin}}}

\newcommand*{\cvtwitterlink}{\cvifdef{\cvtwitter}{\href{http://www.twitter.com/\cvtwitter}{\cvtwitter}}}

\newcommand*{\cvgithublink}{\cvifdef{\cvgithub}{\href{http://www.github.com/\cvgithub}{\cvgithub}}}

% --------------------------------------------------------------------
% --- Default document format
% ---

\newcommand{\cvsummarytopsep}{0pt}
\newcommand{\cvsummarybottomsep}{0pt}

\parindent=0pt

%\raggedbottom

\pagestyle{empty}

\pagenumbering{arabic}

\NewDocumentCommand{\maketitle}{}

\NewDocumentCommand{\cvsection@pre@execute}{}

% declares a new command, this command will be used to layout the 
% document sections
\NewDocumentCommand{\cvsection@execute}{}

\NewDocumentCommand{\cventry@pre@execute}{}

\NewDocumentCommand{\cventry@execute}{}

% --------------------------------------------------------------------
% --- Definition of new environments in the document
% ---

% preallocates a list for each subsection
\makenewlist{cvsection@subsections}%

% declares a new environment
% usage: \begin{cvsection}[<title>]
% note:  the environment executes cvsection@execute at the post-
%        environment code
\DeclareDocumentEnvironment{cvsection}{O{}G{}}{%
  \def\cvsection@title{#1}%
  \cvifdef{#2}{%
    \def\cvsection@defaultstyle{#2}%
  }{%
    \def\cvsection@defaultstyle{default}%
  }%
  \clearlist{cvsection@subsections}%
  \edef\@cvssname{}%
  \appendtolist{cvsection@subsections}{\@cvssname}%
  \makenewlist{\@cvssname @entries}%
  \cvsection@pre@execute%
}{%
  \def\cvsectiontitle{\cvsection@title}%
  \cvsection@execute%
}

\DeclareDocumentEnvironment{cvsubsection}{O{}}{%
  \edef\@cvssname{#1}%
  \appendtolist{cvsection@subsections}{\@cvssname}%
  \makenewlist{\@cvssname @entries}%
}{%
}

% declares a new environment
% usage: \begin{cventry}[<heading>]{<style>} (All Optional)
\DeclareDocumentEnvironment{cventry}{O{}G{}}{%
  \cvifdef{#2}{%
    \def\@style{#2}%
  }{%
    \def\@style{\cvsection@defaultstyle}%
  }% default style (suitable for job experience description)
  \def\@heading{#1}%
  \def\@subheading{}%
  \def\@date{}%
  \def\subheading##1{\def\@subheading{##1}}%
  \def\date##1{\def\@date{##1}}%
  \def\style##1{\def\@style{##1}}%
  \csgdef{@tmpbody}{}%
}{%
  \appendtolist{\@cvssname @entries}{\nextindex{\@cvssname @entries}}%
  \csdef{@index}{\listsize{\@cvssname @entries}}%
  %
  \global\cslet{cventry@\@cvssname @\@index @style}{\@style}%
  \global\cslet{cventry@\@cvssname @\@index @heading}{\@heading}%
  \global\cslet{cventry@\@cvssname @\@index @subheading}{\@subheading}%
  \global\cslet{cventry@\@cvssname @\@index @date}{\@date}%
  \global\cslet{cventry@\@cvssname @\@index @summary}{\@tmpbody}%
}

\newenvironment{summary}{%
  \def\@wrap##1{\global\def\@tmpbody{%
    \par\addvspace{\cvsummarytopsep}%
    ##1%
    \par\addvspace{\cvsummarybottomsep}}%
  }%
  \collect@body\@wrap%
}{}

\NewDocumentCommand{\foreachcvsubsection}{m}{%
  \iteratelist{cvsection@subsections}{ssindex}{%
    \edef\cvsubsection{\getlistitem{cvsection@subsections}{\ssindex}}%
    #1%
  }%
}

% convenient command, for use inside \foreachcvsubsection only
% usage: \foreachcventry{<code>}
% note:  allocates a few useful definitions before executing code:
%        \index - index of the current entry
%        \name - name of the entry (eg. employer/institution name)
%        \title - title on the entry (eg. job title, degree earned)
%        \date - date in the entry
%        \location - location in the entry (eg. New York, London)
%        \description - description of the entry
\NewDocumentCommand{\foreachcventry}{m}{%
  \iteratelist{\cvsubsection @entries}{index}{%
    \def\style{\csuse{cventry@\cvsubsection @\index @style}}%
    \def\heading{\csuse{cventry@\cvsubsection @\index @heading}}%
    \def\subheading{\csuse{cventry@\cvsubsection @\index @subheading}}%
    \def\date{\csuse{cventry@\cvsubsection @\index @date}}%
    \def\summary{\csuse{cventry@\cvsubsection @\index @summary}}%
    #1%
  }%
}

\NewDocumentCommand{\cvitem}{O{}G{}}{% TODO fix this hack
  \appendtolist{\@cvssname @entries}{\nextindex{\@cvssname @entries}}%
  \csdef{@index}{\listsize{\@cvssname @entries}}%
  %
  \global\csdef{cventry@\@cvssname @\@index @heading}{#1}%
  \global\csdef{cventry@\@cvssname @\@index @summary}{#2}%
  \global\csdef{cventry@\@cvssname @\@index @style}{short}%
}%

