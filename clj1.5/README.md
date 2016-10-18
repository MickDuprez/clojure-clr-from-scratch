#Clojure CLR From Scratch — Part 1.5

Hi All, been a while and very sorry about that, been extra busy!

Anyway, I thought I’d put in a little in between post to describe a simple build system using a Windows batch file to handle our build tasks. I plan to build on this file and add functionality as we go but I think we will eventually build our very own ‘build’ or project application and I plan on doing it in Clojure CLR.
Should be fun :)


##Take One
Please note I’m not that experienced with batch files and know just enough to be dangerous as they say so feel free to correct my sources and gives tips or pointers on the best/better way of doing things (keeping in mind I think the bat files will be a temporary fix for now).

Create a new file in the main folder of your project (in my case C:\home\dev\clj1) and we’ll call it ‘build.bat’ and add the following text:

```
ECHO Building a Clojure CLR project From Scratch!
:: Set some environment variables required for this build:
SET CLOJURE_LOAD_PATH=%CLOJURE_LOAD_PATH%; c:\home\dev\clj1\src; c:\home\dev\clj1\build;
SET CLOJURE_COMPILE_PATH=c:\home\dev\clj1\build;
:: Run clojure.compile and build our app:
clojure.compile clj1.core
:: pause for effect:
PAUSE
```

Save the file and open a command prompt in this folder and enter ‘build’ to run the build.bat file in this folder and you should get the following output:

```
c:\home\dev\clj1>build
c:\home\dev\clj1>ECHO Building a Clojure CLR project From Scratch!
Building a Clojure CLR project From Scratch!
c:\home\dev\clj1>SET CLOJURE_LOAD_PATH=; c:\home\dev\clj1\src; c:\home\dev\clj1\build;
c:\home\dev\clj1>SET CLOJURE_COMPILE_PATH=.\build;
c:\home\dev\clj1>clojure.compile clj1.core
Compiling clj1.core to c:\home\dev\clj1\build; -- 8 milliseconds.
c:\home\dev\clj1>PAUSE
Press any key to continue . . .
```

Yay! It seems to have worked but it’s a bit noisy, a quick bit of research and I found that if you start the bat file with @ECHO OFF it will make things a lot cleaner.

Add that to the start of the bat file and run it again and you should get:

```
c:\home\dev\clj1>build
Building a Clojure CLR project From Scratch!
Compiling clj1.core to c:\home\dev\clj1\build; — 8 milliseconds.
Press any key to continue . . .
```

Cool, much better!


##Take Two
There’s some tidying up we could do to the file paths to make future batch files easier to create, we don’t really need the PAUSE in there either. Let’s change all the hard coded file paths to relative paths using the %CD% system variable that gives use the current working directory for this shell session, here’s my file:

```
@ECHO OFF
ECHO Building a Clojure CLR project From Scratch!
:: Set some environment variables required for this build:
SET CLOJURE_LOAD_PATH=%CD%\src; %CD%\build;
SET CLOJURE_COMPILE_PATH=%CD%\build;
:: Run clojure.compile and build our app:
clojure.compile clj1.core
```

Save and run it again and the output should be the same but there is almost no editing to do to this file for future projects - until they become more complicated at least :)


##Take Three (Optional)
If you want to make this even more reusable we can add a parameter to the call to our bat file, for example we may not always call our main .clj file ‘core.clj’ so we can then call it like this:
c:\home\dev\clj1>build clj1.core

When we call a batch file with variables like this they get stored in to shell variables such as %1, %2, %3, etc in the order that they are entered. This means we can get this variable and use it in our script like so:

```
@ECHO OFF
ECHO Building a Clojure CLR project From Scratch!
:: Set some environment variables required for this build:
SET CLOJURE_LOAD_PATH=%CD%\src; %CD%\build;
SET CLOJURE_COMPILE_PATH=%CD%\build;
:: Run clojure.compile and build our app:
clojure.compile %1
```

##Some Notes:
Batch files are pretty cool, I should use them more often really for repetitive tasks like this.

Note that the ‘SET’ command only sets the environment variables for the current shell/terminal session and they won’t be written to the system Environment Variables registry which is good. In fact, be sure to go back and remove the ‘project’ paths from the CLOJURE_LOAD_PATH system variable (leave the path to the clojure install) and test again to convince yourself it’s all working as expected. You can also delete the CLOJURE_COMPILE_PATH variable as this is a ‘project’ only variable which we set in our bat file.

Thinking on this script more we can easily add some more parameters and logic to run different commands such as running a test suite say. We may look at that next time but it wouldn’t take much study to come up with some cool features and I’d love to see what you come up with!


##Coming Up Next
Next time I will be adding some more structure to our very simple app to get a feel for how we can organise our projects and get it all to build nicely. If I get a chance I might add some .Net interop as well, that’s why we are using Clojure CLR in the first place right? :)


Stay Well,

Mick.
