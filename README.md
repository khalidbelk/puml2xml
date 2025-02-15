# Puml2xml 🌱

A **PlantUML** (.puml) to **XML** (.xmi) converter.

### Prerequisites

Before starting, ensure you have the following dependencies installed locally:

- **dune** (v**3.16** or higher)
- **OCaml** (v**4.08.0** or higher)
- **make**

### Usage

**Steps**

1. Clone this repository and open it

2. Compile the program with the command

```
make
```

3. Then you can use it as specified here :

```
USAGE: ./puml2xml <file> [OPTIONS]

   <file>          : the relative path of the .puml file to convert

OPTIONS:
   -f <new_name>   : specify the output file name. Default: same as input with .xmi extension.
   -h              : display this message
```

### Why and how was this project created ?

This project was born from my experience working on a university project, where we were required to create PlantUML diagrams and also deliver them in XML format. Logically, I thought "It shouldn't be that hard to find a PlantUML tool that does this". After searching for a while, I encountered an issue : either finding a solution was quite tedious for such a simple problem, or many users found issues with the tools provided by PlantUml.

After more digging, I finally found a Docker command line provided somewhere by PlantUML, which, by chance, worked for me. However, as a result, I wanted a more accessible, native tool, primarily to save others the hassle of facing the same situation as me in the future (and also as an excuse for myself to make a project in **OCaml** ^^).

This project was made possible by **reverse-engineering the given output**. For reference, you can find the .xmi output file [here](/diagrams/diagram.xml) and the .puml file I used [here](/diagrams/diagram.puml).

### Contributions 📥

To contribute, fork this repository and open a pull request describing the fix or feature you're adding. Please ensure that your commits follow the [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/) format.

### License

This project is licensed under the Apache 2.0 License - see the [LICENSE]() file for details.