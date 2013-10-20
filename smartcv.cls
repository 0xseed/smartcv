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
\ProvidesClass{smartcv}[2013/10/17 v0.0 smart curriculum vitae and cover letter document class]

% class options
%\DeclareOption{a4paper}{\setlength\paperheight{297mm}}

\ProcessOptions \relax

\LoadClass{article}

% --------------------------------------------------------------------
% --- 3rd Party Packages
% ---
% Loads 3rd party packages used by this class

% set custom page sizes
\RequirePackage[left=1in,right=1in,top=1in,bottom=1in]{geometry}

% use the fancyhdr package for custom headers and footers
\RequirePackage{fancyhdr}

% required for the \NewDocumentCommand
\RequirePackage{xparse}

% allows for the use of \isempty
\RequirePackage{xifthen}

% allows the definition of complex datastructures (maps and lists)
\RequirePackage{etoolbox}

% allows the construction of for loops
\RequirePackage{forloop}

\RequirePackage{hyperref}

% --------------------------------------------------------------------
% --- Definition data structures which will be used in the package
% ---

% -- List Data Structure
% ------------------------

% creates a new list
% usage: \makenewlist{<list>}{<initial capacity>} (Optional)
\NewDocumentCommand{\makenewlist}{mG{}}{%
  \newcounter{list@#1@counter}%
  \cvifdef{#2}{%
    \setcounter{list@#1@counter}{#2}%
  }%
}

% appends an item onto the list
% usage: \appendtolist{<list>}{<item>}
\NewDocumentCommand{\appendtolist}{mm}{%
  \stepcounter{list@#1@counter}%
  \csdef{list@#1@item\roman{list@#1@counter}}{#2}%
}

% sets an item in the list
% usage: \setlistitem{<list>}{<index>}{<item>}
\NewDocumentCommand{\setlistitem}{mmm}{%
  \csdef{list@#1@item\romannumeral#2}{#3}%
}

% gets an item from the list
% usage: \getlistitem{<list>}{<index>}
\NewDocumentCommand{\getlistitem}{mm}{%
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

% iterates over a list and applies the code
% usage: \iteratelist{<list>}{<variable>}{<code>}
% where: variable is the name of the loop variable, therefore it can
%        be accessed in the code using \<variable>
\NewDocumentCommand{\iteratelist}{mmm}{%
  \setcounter{cvloop@var}{0}%
  \csdef{#2}{\arabic{cvloop@var}}%
  \forloop{cvloop@var}{1}{\value{cvloop@var} < \numexpr\listsize{#1}+1}{%
    #3%
  }%
}

\newcounter{cvloop@var}

% --------------------------------------------------------------------
% --- Definition of basic data in the package
% ---

% -- Default values
\def\cvlastname{}
\def\cvdate{\today}
\def\cvcity{}
\def\cvcountry{}
\def\cvphone{}
\def\cvmobile{}
\def\cvfax{}
\def\cvwebsite{}
\def\cvextrainfo{}
\def\cvlinkedin{}
\def\cvtwitter{}
\def\cvgithub{}

% defines the colors used in the document
\definecolor{cvcolor0}{rgb}{0,0,0} % default color (black by default)
\definecolor{cvcolor1}{rgb}{0,0,0} % primary color
\definecolor{cvcolor2}{rgb}{0,0,0} % secondary color
\definecolor{cvcolor3}{rgb}{0,0,0} % tertiary color

\NewDocumentCommand{\cvifdef}{mmG{}}{%
  \ifthenelse{\equal{#1}{}}{#3}{#2}%
}

% --------------------------------------------------------------------
% --- Setter commands for personal information
% ---

% defines the name on the document
% usage: \cvname{<first name>}{<last name>}
\newcommand*{\setcvname}[2]{\def\cvfirstname{#1}\def\cvlastname{#2}}

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

\newcommand*{\cvfullname}{\cvfirstname{} \cvlastname{}}

\newcommand*{\cvifhasanyphone}[1]{\cvifdef{\cvphone\cvmobile\cvfax}{#1}}

\newcommand*{\cvemaillink}{\cvifdef{\cvemail}{\href{mailto: \cvemail}{\cvemail}}}

\newcommand*{\cvwebsitelink}{\cvifdef{\cvwebsite}{\href{\cvwebsite}{\cvwebsite}}}

\newcommand*{\cvlinkedinlink}{\cvifdef{\cvlinkedin}{\href{http://www.linkedin.com/in/\cvlinkedin}{\cvlinkedin}}}

\newcommand*{\cvtwitterlink}{\cvifdef{\cvtwitter}{\href{http://www.twitter.com/\cvtwitter}{\cvtwitter}}}

\newcommand*{\cvgithublink}{\cvifdef{\cvgithub}{\href{http://www.github.com/\cvgithub}{\cvgithub}}}

% --------------------------------------------------------------------
% --- Default document format
% ---

\NewDocumentCommand{\makecvtitle}{}

% declares a new command, this command will be used to layout the 
% document sections
\NewDocumentCommand{\cvsection@execute}{}

% --------------------------------------------------------------------
% --- Definition of new environments in the document
% ---

% preallocates a list for each section
\makenewlist{cvsection@entries}%

% declares a new environment
% usage: \begin{cvsection}[<title>]
% note:  the environment executes cvsection@execute at the post-
%        environment code
\DeclareDocumentEnvironment{cvsection}{O{}}{%
  \def\cvsection@title{#1}%
  \clearlist{cvsection@entries}%
}{%
  \def\section{\cvsection@title}%
  \cvsection@execute%
}

% declares a new environment
% usage: \begin{cventry}[<title>]
\DeclareDocumentEnvironment{cventry}{O{}}{%
  \def\@title{}%
  \def\@startdate{}%
  \def\@enddate{}%
  \def\@location{}%
  \def\@description{}%
  \cvifdef{#1}{%
    \def\@title{#1}%
  }%
  % redefine the commands
  \renewcommand{\title}[1]{\def\@title{##1}}%
  \renewcommand{\date}[2]{\def\@startdate{##1}\def\@enddate{##2}}%
  \newcommand{\location}[1]{\def\@location{##1}}%
  \renewcommand{\description}[1]{\def\@description{##1}}%
}{% TODO this still feels slightly hack-ish
  \stepcounter{list@cvsection@entries@counter}%
  \csdef{@index}{\listsize{cvsection@entries}}%
  \appendtolist{cvsection@entries}{\@index}%
  \addtocounter{list@cvsection@entries@counter}{-1}
  \global\cslet{cventry@\@index @title}{\@title}
  \global\cslet{cventry@\@index @startdate}{\@startdate}%
  \global\cslet{cventry@\@index @enddate}{\@enddate}%
  \global\cslet{cventry@\@index @location}{\@location}%
  \global\cslet{cventry@\@index @description}{\@description}%
}

% convenient command, for use inside cvsection@execute only
% usage: \foreachcventry{<code>}
% note:  allocates a few useful definitions before executing code:
%        \index - index of the current entry
%        \title - title of the entry
%        \startdate - start date in the entry
%        \enddate - end date in the entry
%        \location - location in the entry
%        \description - description of the entry
\NewDocumentCommand{\foreachcventry}{m}{%
  \iteratelist{cvsection@entries}{index}{%
    \csdef{title}{\csuse{cventry@\index @title}}%
    \csdef{startdate}{\csuse{cventry@\index @startdate}}%
    \csdef{enddate}{\csuse{cventry@\index @enddate}}%
    \csdef{location}{\csuse{cventry@\index @location}}%
    \csdef{description}{\csuse{cventry@\index @description}}%
    #1%
  }%
}

