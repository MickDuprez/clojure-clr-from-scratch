@ECHO OFF
ECHO Building a Clojure CLR project From Scratch!

:: Set some environment variables required for this build:
SET CLOJURE_LOAD_PATH=%CD%\src; %CD%\build;
SET CLOJURE_COMPILE_PATH=%CD%\build;

:: Run clojure.compile and build our app:
clojure.compile %1

