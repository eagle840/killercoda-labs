#sonarqube

sonarqube setup using Docker


https://www.sonarqube.org/

Is a SCA for  Code Quality & Code Security

https://en.wikipedia.org/wiki/List_of_tools_for_static_code_analysis


3 main parts:
  - sonarqube server (dashboard and choice of DB), with sets of rules (through quality profiles)
  - scanner, a tool to scan you code through the server, this is usually run and the command line, build tools or through ci/cd
  - code; that you want to check


The way it works:

When you run the scanner, it will pull the rules of the server, run the rules against the code, generate a report and return that report back to the server





