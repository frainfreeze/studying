# Setting up environment

Detailed instructions on setting up your development environment (project independent).

## Git 

Install git.

## Java Development Kit version 8 or better

Install java.

## Spring Tool Suite 3 (v 4.11.0)

Install...

## Installing and setting up Maven

Download [apache-maven-3.6.1-bin.zip](http://ftp.carnet.hr/misc/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.zip)

The installation of Apache Maven is a simple process of extracting the archive and adding the bin folder with the mvn command to the PATH

**In spring tools suite** Go to Window -> Preferences -> Maven -> Installations -> choose your own maven installation folder there.

### Windows Tips

Check environment variable value e.g.

```
echo %JAVA_HOME% 
C:\Program Files\Java\jdk1.7.0_51
```

Adding to PATH: Add the unpacked distribution’s bin directory to your user PATH environment variable by opening up the 
system properties (WinKey + Pause), selecting the “Advanced” tab, and the “Environment Variables” button, then adding 
or selecting the PATH variable in the user variables with the value C:\Program Files\apache-maven-3.6.1\bin. The same 
dialog can be used to set JAVA_HOME to the location of your JDK, e.g. C:\Program Files\Java\jdk1.7.0_51

Open a new command prompt (Winkey + R then type cmd) and run mvn -v to verify the installation.