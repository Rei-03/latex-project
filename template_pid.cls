% ibra :]
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{template_pid}[2025/10/09 Clase para informes técnicos UCI]

\LoadClass[a4paper,12pt]{report}

% ----------------------------------------------------------
% 📦 Paquetes básicos
% ----------------------------------------------------------
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[spanish, provide=*]{babel}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{geometry}
\usepackage{fancyhdr}
\usepackage{tocloft}
\usepackage{titlesec}
\usepackage{setspace}
\usepackage{booktabs}
\usepackage{float}
\usepackage{caption}
\usepackage{amsmath, amssymb}
\usepackage{natbib}
\usepackage{xparse}
\usepackage{etoolbox}
\usepackage{xstring}
\usepackage{xcolor}

% ----------------------------------------------------------
% 📄 Márgenes y formato general
% ----------------------------------------------------------
\geometry{top=2.5cm,bottom=2.5cm,left=3cm,right=2.5cm}
\onehalfspacing

\DeclareUnicodeCharacter{2248}{\ensuremath{\approx}}
\setlength{\headheight}{15pt}


% ----------------------------------------------------------
% 📌 Cabeceras y pies
% ----------------------------------------------------------
\pagestyle{fancy}
\fancyhf{} % limpia cabeceras y pies

% Cabecera derecha: muestra capítulo o sección
\fancyhead[R]{\nouppercase{\rightmark}}
% Pie de página centrado: número de página
\fancyfoot[C]{\thepage}

% Marcadores para capítulos y secciones
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}

% Evitar cabecera en portada o páginas especiales
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyfoot[C]{\thepage}
}

% ----------------------------------------------------------
% 📄 Formato de títulos
% ----------------------------------------------------------
\titleformat{\chapter}{\bfseries\huge}{\thechapter.}{1em}{}
\titleformat{\section}{\bfseries\Large}{\thesection.}{1em}{}
\titleformat{\subsection}{\bfseries\large}{\thesubsection.}{1em}{}

\renewcommand{\contentsname}{Tabla de Contenidos}
\renewcommand{\listtablename}{Índice de Tablas}
\renewcommand{\listfigurename}{Índice de Figuras}

% ----------------------------------------------------------
% 🧩 Comando auxiliar para formatear nombres
% ----------------------------------------------------------
\newcommand{\formatNames}[1]{%
  \begingroup
  \IfStrEq{#1}{}{%
    \endgroup
  }{%
    \IfStrEq{#1}{---}{%
      \endgroup
    }{%
      \def\namelist{#1}%
      \def\first{}%
      \renewcommand{\do}[1]{%
        \ifx\first\empty
          \def\first{##1}%
        \else
          \\[-0.2em]\hspace*{3.4cm}##1%
        \fi
      }%
      \docsvlist{\namelist}%
      \first
      \endgroup
    }%
  }%
}

% ----------------------------------------------------------
% 📄 Comando para la portada
% ----------------------------------------------------------
\newcommand{\portadaUCI}[9]{%
  \begin{titlepage}
  \centering

  % LOGO
  \IfFileExists{img/uci_logo.png}{
    \includegraphics[width=0.35\textwidth]{img/uci_logo.png}\par\vspace{2cm}
  }{
    \vspace{2cm}
    {\Large \textbf{[Logo de la UCI no disponible]}}\par\vspace{2cm}
  }

  % TÍTULO
  {\Large \textbf{#1}}\\[1.5cm]
  {\huge \textbf{#2}}\\[1.5cm]
  \textit{Trabajo de diploma para optar por el título de Ingeniero en Ciencias Informáticas}\\[2cm]

  % AUTORES Y TUTORES
  \begin{flushleft}
    \IfStrEq{#3}{}{ }{\textbf{Autor(es):} \formatNames{#3}\\[0.4cm]}
    \IfStrEq{#4}{}{ }{\textbf{Tutor(es):} \formatNames{#4}\\[0.4cm]}
    \IfStrEq{#5}{}{ }{\textbf{Co-tutor:} \formatNames{#5}\\[0.4cm]}
    \IfStrEq{#6}{}{ }{\textbf{Consultante:} \formatNames{#6}\\[0.4cm]}
    \IfStrEq{#7}{}{ }{\textbf{Asesor:} \formatNames{#7}\\[1cm]}
  \end{flushleft}

  \vfill
  {\large La Habana, #8 de #9}\\[0.2cm]
  \textit{“Año del Centenario del natalicio del Comandante Fidel Castro Ruz”}
  \end{titlepage}
}

% ----------------------------------------------------------
% 📌 Comando para la tabla de contenidos y listas con cabecera
% ----------------------------------------------------------
\newcommand{\CompleteIndex}{%
  % ----- Tabla de Contenidos -----
  \cleardoublepage
  \phantomsection
  \markboth{Tabla de Contenidos}{Tabla de Contenidos} % cabecera
  \renewcommand{\contentsname}{Tabla de Contenidos} % título
  \tableofcontents

  % ----- Índice de Tablas -----
  \cleardoublepage
  \phantomsection
  \markboth{Índice de Tablas}{Índice de Tablas} % cabecera
  \renewcommand{\listtablename}{Índice de Tablas} % título
  \listoftables

  % ----- Índice de Figuras -----
  \cleardoublepage
  \phantomsection
  \markboth{Índice de Figuras}{Índice de Figuras} % cabecera
  \renewcommand{\listfigurename}{Índice de Figuras} % título
  \listoffigures
}

% ----------------------------------------------------------
% 📌 Comando para capítulos sin número (Introducción, Conclusiones)
% ----------------------------------------------------------
\newcommand{\introduction}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Introducción}%
  \markboth{Introducción}{}%
  \chapter*{Introducción}%
}

\newcommand{\conclusions}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Conclusiones}%
  \markboth{Conclusiones}{}%
  \chapter*{Conclusiones}%
}



% ----------------------------------------------------------
% 📌 Numeración de páginas
% ----------------------------------------------------------
% Preliminares en números romanos
\newcommand{\preliminaries}{%
  \pagenumbering{roman}%
  \setcounter{page}{1}%
}

% Cuerpo principal en números arábigos a partir de la Introducción
\newcommand{\mainmatter}{%
  \cleardoublepage
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
}



% ----------------------------------------------------------
% 📌 Comando para la página de Resumen y Abstract 
% ----------------------------------------------------------
\long\def\ResumenAbstract#1#2{%
  \cleardoublepage                % nueva página impar
  \thispagestyle{plain}           % sin cabecera, solo pie centrado
  \phantomsection                 % ancla para hipervínculos

  % ----- Resumen -----
  \chapter*{Resumen}              % título del resumen
  \markboth{Resumen}{}            % actualiza la cabecera

  {\large #1}                     % contenido del resumen en español

  % ----- Abstract -----
  \chapter*{\textit{Abstract}}    % título en cursiva (igual formato que Resumen)
  \markboth{Abstract}{}            % actualiza la cabecera

  {\large \textit{#2}}            % contenido en cursiva

  \cleardoublepage                 % asegura que la siguiente sección comience en nueva página
}




% ----------------------------------------------------------
% 📌 Comando para la página de DATOS DE CONTACTO 
% ----------------------------------------------------------
\long\def\contactInformation#1{%
  \cleardoublepage                % nueva página impar
  \thispagestyle{plain}           % sin cabecera, solo pie centrado
  \phantomsection                 % ancla para hipervínculos

  % ----- Resumen -----
  \chapter*{Datos de Contacto}    % título
  \markboth{Datos de Contacto}{}  % actualiza la cabecera

  {\large #1}                     % contenido del resumen en español

  \cleardoublepage                 % asegura que la siguiente sección comience en nueva página
}


% ----------------------------------------------------------
% 📌 Comando para la página de Recomendaciones
% ----------------------------------------------------------
\long\def\Recommendations#1{%
  \cleardoublepage                % empieza en nueva página impar
  \phantomsection                 % ancla para hipervínculos
  \addcontentsline{toc}{chapter}{Recomendaciones}% agrega al índice
  \markboth{Recomendaciones}{}    % cabecera

  \chapter*{Recomendaciones}      % título sin numerar
  \thispagestyle{plain}           % pie centrado, sin cabecera

  {\large #1}                     % contenido de la sección

  \cleardoublepage                % deja lista la siguiente sección
}

% ----------------------------------------------------------
% 📌 Comando para la página de Anexos
% ----------------------------------------------------------
\long\def\Anexes#1{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Anexos}% agrega al índice
  \markboth{Anexos}{}             % cabecera

  \chapter*{Anexos}
  \thispagestyle{plain}

  {\large #1}

  \cleardoublepage
}


% ----------------------------------------------------------
% 📌 Comando para la página de OPINIÓN DEL TUTOR 
% ----------------------------------------------------------
\long\def\TutorsOpinion#1{%
  \cleardoublepage                % nueva página impar
  \thispagestyle{plain}           % sin cabecera, solo pie centrado
  \phantomsection                 % ancla para hipervínculos

  % ----- Resumen -----
  \chapter*{Opinión de los Tutores}    % título
  \markboth{Opinión de los Tutores}{}  % actualiza la cabecera

  {\large #1}                     % contenido del resumen en español

  \cleardoublepage                 % asegura que la siguiente sección comience en nueva página
}



% ----------------------------------------------------------
% 📌 Comando para la estructura del capítulo de desarrollo
% ----------------------------------------------------------

% --- Introducción del capítulo (no numerada pero en el índice) ---
\newcommand{\IntroCap}[2]{%
  \section*{Introducción}%
  \addcontentsline{toc}{section}{Introducción}%
  \phantomsection
  \label{intro:#1}%
  #2
  \vspace{0.5cm} % espacio antes del primer epígrafe
}

% --- Epígrafes numerados en romano (también en el índice) ---
\newcounter{epigrafe}[chapter]
\renewcommand{\theepigrafe}{\Roman{epigrafe}}

\newcommand{\Epigrafe}[2]{%
  \refstepcounter{epigrafe}
  \section*{\theepigrafe. #1}%
  \addcontentsline{toc}{section}{\theepigrafe. #1}%
  \phantomsection
  \label{epi:#1}%
  #2
  \vspace{0.5cm}
}


% ----------------------------------------------------------
%  Comando para Referencias bibliograficas
% ----------------------------------------------------------
\long\def\BibliRefer#1{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Referencias bibliográficas}% agrega al índice
  \markboth{Referencias bibliográficas}{}             % cabecera

  \chapter*{Referencias bibliográficas}
  \thispagestyle{plain}

  {\large #1}

  \cleardoublepage
}


% ----------------------------------------------------------
% 🟥 Comando para mostrar estructura de ejemplo (texto en rojo, sin numeración)
% ----------------------------------------------------------
\newenvironment{Explain}[2]{%
  \clearpage
  \pagestyle{empty}% 🔹 desactiva numeración mientras dure el entorno
  \begingroup
  \color{red}
  \noindent\textbf{#1}\\[0.3cm]%
  #2%
  \par
}{%
  \endgroup
  \clearpage
  \pagestyle{fancy}% 🔹 restaura numeración y cabecera
}



% ----------------------------------------------------------
% 📌 Comando para Referencias Bibliográficas
% ----------------------------------------------------------
\newcommand{\References}{%
  \cleardoublepage
  \phantomsection
  \addcontentsline{toc}{chapter}{Referencias Bibliográficas}
  \chapter*{Referencias Bibliográficas}%
  \markboth{Referencias Bibliográficas}{}%
  \renewcommand{\baselinestretch}{1.15}\selectfont % interlineado 1.15
  \fontsize{11pt}{13pt}\selectfont                 % Arial 11pt
  \bibliographystyle{apalike} % o cualquier estilo APA compatible
  \bibliography{referencias}   % tu archivo .bib
  \cleardoublepage
}
