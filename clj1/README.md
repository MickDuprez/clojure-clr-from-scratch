##Clojure CLR from scratch — Part 1 - The Tools
#First things first:
Please note that this is not a “learn Clojure from scratch” series of posts. You must have some programming experience and have at least studied some basic Clojure.


There are some articles out there but they are few and they are old. I’m basically just documenting my path on how to get up and running based on some of these old resources and by what I’m learning by trial and error.

*NOTE: This article is based on using a Windows paltform but the steps and concepts should be easily translated to a Unix type set up with Mono (I think).*

#Install Clojure Clr
Go to the sourceforge clojure-clr site and download the latest zip (release or debug), extract it to a suitable place. I put the contents of the Release or Debug folder in my C:\bin\clojure folder that I created so I have c:\bin\clojure\(copied contents). 
This folder should contain Clojure.Main.exe and Clojure.Compile.exe in it and you now need to add this folder to your PATH environment variable so you can execute these tools from all folders without having to use the full path to the .exe.

#Project and Build Tools
I have had a great deal of trouble here just getting a simple “hello world” app up and running. I tried Leiningen with lien-clr with mixed results that was very frustrating trying to work it all out.

We won’t be using these tools just yet and I think it’s good to know how to build something from scratch anyway. That way you always have an option and you won’t become hamstrung by a non functioning build tool, at least you may have a chance to debug it and fix it as you will know what’s going on ;)


#A Code Editor
Notice I didn’t say IDE?

You could install Visual Studio and the vsClojure extension (for community/professional 2013) but there is little activity in that project recently so I’d rather not be reliant on it. I don’t need no stinkin’ IDE :)


I did choose to go with Visual Studio Code however which is basically just a code editor with a project/folder view and a terminal along with some nice code formatting. 
So far it works and is barely a distraction in my learning process (i.e. I don’t need to learn an editor as well as a language, use notepad and a terminal if you want, just use the K.I.S.S. principle for now).


As a terminal is built into VS Code we can fire one up and do our coding and command line tasks all from the one application. The built in terminal is a bit slower than the standard system command prompt terminal at times though, especially when you have long error reports and you need to scroll around.


#Project Folder Structure
Here is my folder structure for a very simple project called clj1. You can put this wherever you like but I like the UNIX style of having short folder names that are easy to find so mine resides at C:\home\dev so my project folder is C:\home\dev\clj1

```
clj1
|   
+---build
|       Clojure.dll
|       Microsoft.Dynamic.dll
|       Microsoft.Scripting.dll
|       
\---src
    \---clj1
            core.clj
```            
            
Notice I copied the 3 dlls from the clojure install folder to my build folder, this is important as they contain the core libraries required by Clojure-CLR our app needs to run.

#The Source
Here is the simple source file from the src\clj1 folder:

```clojure
(ns clj1.core (:gen-class :main true))
(defn -main []
    (println "Hello World!"))
```

Very simple but note the :gen-class and :main true values passed in the ns (namespace) section of code. These tell the compiler to generate an .exe rather than a library (.dll) as output and that -main is the entry point.

The (ns <….blah>) sets up the namespace/pathing for the project, in this case our namespace is clj1.core which coresponds with our src\clj1\core.clj. We don’t use say src.clj1.core as that just adds unwanted names in our namespace but as it stands that’s what we would need if we compiled from our root folder for the compiler to find the file. 
The src folder is only there to help us organise our project. We will discuss this further in a minute.


#Some Environment Settings
To make things easy for the compiler to locate files and to keep namespaces clean we need to set up a few environment variables.

*NOTE: This is for Windows only, maybe someone can add a solution for a Linux with Mono set up.*


We need to set up a CLOJURE_LOAD_PATH and a CLOJURE_COMPILE_PATH environment variable.

Here’s what my set up looks like, change the path to your project folder to suit:
```
CLOJURE_LOAD_PATH = c:\home\dev\clj1\src; c:\home\dev\clj1\build; C:\bin\clojure
CLOJURE_COMPILE_PATH = c:\home\dev\clj1\build
```

Notice I have two paths for the CLOJURE_LOAD_PATH path, this tells the compiler to look in these folders for necessary files and compiled assemblies required to build the final application or library.

*Update: I added the path to the Clojure install path as well (where Clojure.Main.exe, Clojure.Compile.exe and other dlls live), I found this necessary on my laptop when I couldn’t get the steps here to work. This solved that problem and gives the compiler another (more complete) set of assemblies that might be required for compilation.*


The CLOJURE_COMPILE_PATH path is where we tell the compiler to put our output such as the .exe or .dll file. This is another reason why we need to have two LOAD paths, as the compiler builds the project it outputs intermediate files and assemblies here and it needs to be able to find them again for the final build.

Obviously this isn’t an ideal way to set up every project, I couldn’t imagine setting up these variables every time I want to make a new project but we’ll work on that soon as a seperate side project I think.


#Finally, Compiling
We’ve had a bit to get through but it’s all very important to get the set up right believe me! If you come from a java background this is probably common knowledge but if like me you come from a C# and VS background it just doesn’t make sense until you work it out (or read this perhaps ;) ).

Here’s my command line session to compile this ‘killer’ app:
```
C:\home\dev\clj1>clojure.compile clj1.core
Compiling clj1.core to C:\home\dev\clj1\build -- 10 milliseconds.
```

We call clojure.compile and pass it the namespace of our main source file which translates to the folder and file clj1\core.clj (which contains the clj1.core namespace). 

It all lines up and because we set out compile path to look in the source folder we eliminate the need for the ‘src’ folder in our command. I hope that makes sense because it’s important!

Your build folder should look like this now:
```
clj1
|
+---build
|       clj1.core.clj.dll
|       clj1.core.clj.pdb
|       clj1.core.exe
|       clj1.core.pdb
|       Clojure.dll
|       Microsoft.Dynamic.dll
|       Microsoft.Scripting.dll
|
\---src
    \---clj1
            core.clj
```

You can run your new app by entering:

```
C:\home\dev\clj1>build\clj1.core.exe
Hello World!
```

#Final Thoughts
I feel a bit dumb as this took me nearly 3 days to work this out but that was the whole impetus for writing this article. I couldn’t find a clear example and explanation of how to set it up.

Most articles do mention the path-ing thing in passing but it’s all a bit hand-wavy as if you know what they are talking about, that’s how it seemed to me anyway.

Working in Visual Studio for too long makes you lazy, we need to break that habit and start anew with Clojure!

I hope this is helpful to someone as I intend it to be the article that I was looking for. If I can make it clearer or you have any tips or corrections please let me know.

Cheers.
