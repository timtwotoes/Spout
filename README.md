# Spout
A bare bones example that illustrates how to work with the command line in Swift 4.3. It includes the thought process behind the design decisions.

## Requirements

For this project following tools were used:

* xCode 10.1
* Swift 4.3

## Purpose
This project creates a command line tool named spout. It will print the contents of a given filename similar to the cat tool.

Example:
```
spout /etc/hosts
```

Will print the output of the /etc/hosts to the standard output. It also supports relative paths.

Example:

```
spout test.txt
```

This will print the contents of "test.txt" located in the current dirctory to the standard output.

## Design
First thing on the agenda is to parse the command line. There is no arguments in the main.swift file. Swift has a class called 'CommandLine' that supplies the arguments passed to the command line tool. It makes sense to put all parsing in this class through an extension. We do not require any state and everything is related to the command line. This will be unique to every command line tool so no need to create a seperate class for this.

### CommandLineExtensions.swift
We create an enum that contains the parsed arguments that the utility supports. It only supports a file giving no arguments or passing an input file.
We create an enum that describes any potential error, during the parsing process and make it conform to the Error protocol so we can throw it.
Finally we create a static function that can parse the arguments on the commandline and return the parsed arguments enum.

### main.swift
Only need a function for printing the contents of the passed url. Rest is just error handling.
