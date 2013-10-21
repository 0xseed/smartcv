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
% usage: \begin{cventry}[<name>][<title>]{<style>} (All Optional)
\DeclareDocumentEnvironment{cventry}{O{}O{}G{}}{%
  \cvifdef{#3}{%
    \def\@style{#3}%
  }{%
    \def\@style{\cvsection@defaultstyle}%
  }% default style (suitable for job experience description)
  \def\@name{#1}%
  \def\@title{#2}%
  \def\@startdate{}%
  \def\@enddate{}%
  \def\@location{}%
  \def\@summary{}%
  \def\date##1##2{\def\@startdate{##1}\def\@enddate{##2}}%
  \def\location##1{\def\@location{##1}}%
  \def\summary##1{\def\@summary{##1}}%
  \def\style##1{\def\@style{##1}}%
}{%
  \appendtolist{\@cvssname @entries}{\nextindex{\@cvssname @entries}}%
  \csdef{@index}{\listsize{\@cvssname @entries}}%
  %
  \global\cslet{cventry@\@cvssname @\@index @style}{\@style}%
  \global\cslet{cventry@\@cvssname @\@index @name}{\@name}%
  \global\cslet{cventry@\@cvssname @\@index @title}{\@title}%
  \global\cslet{cventry@\@cvssname @\@index @startdate}{\@startdate}%
  \global\cslet{cventry@\@cvssname @\@index @enddate}{\@enddate}%
  \global\cslet{cventry@\@cvssname @\@index @location}{\@location}%
  \global\cslet{cventry@\@cvssname @\@index @summary}{\@summary}%
}

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
%        \startdate - start date in the entry
%        \enddate - end date in the entry
%        \location - location in the entry (eg. New York, London)
%        \description - description of the entry
\NewDocumentCommand{\foreachcventry}{m}{%
  \iteratelist{\cvsubsection @entries}{index}{%
    \def\style{\csuse{cventry@\cvsubsection @\index @style}}%
    \def\name{\csuse{cventry@\cvsubsection @\index @name}}%
    \def\title{\csuse{cventry@\cvsubsection @\index @title}}%
    \def\startdate{\csuse{cventry@\cvsubsection @\index @startdate}}%
    \def\enddate{\csuse{cventry@\cvsubsection @\index @enddate}}%
    \def\location{\csuse{cventry@\cvsubsection @\index @location}}%
    \def\summary{\csuse{cventry@\cvsubsection @\index @summary}}%
    #1%
  }%
}

\NewDocumentCommand{\cvitem}{O{}G{}}{% TODO fix this hack
  \appendtolist{\@cvssname @entries}{\nextindex{\@cvssname @entries}}%
  \csdef{@index}{\listsize{\@cvssname @entries}}%
  %
  \global\csdef{cventry@\@cvssname @\@index @name}{#1}%
  \global\csdef{cventry@\@cvssname @\@index @summary}{#2}%
  \global\csdef{cventry@\@cvssname @\@index @style}{short}%
}%

