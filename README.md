# Puml2xml 🌱➡️📄

<div align="center">
    <a href="https://github.com/khalidbelk/puml2xml/actions/workflows/build-ubuntu.yml">
        <img src="https://github.com/khalidbelk/puml2xml/actions/workflows/build-ubuntu.yml/badge.svg?branch=main" alt="ubuntu-latest"></a>
      &nbsp;&nbsp;&nbsp;&nbsp;  <!-- Spaces -->
  <a href="https://github.com/khalidbelk/puml2xml/actions/workflows/build-macos.yml">
    <img src="https://github.com/khalidbelk/puml2xml/actions/workflows/build-macos.yml/badge.svg?branch=main" alt="macOS-latest"></a>
    &nbsp;&nbsp;&nbsp;&nbsp;  <!-- Spaces -->
  <a href="https://github.com/khalidbelk/puml2xml/actions/workflows/docker-build.yml">
    <img src="https://github.com/khalidbelk/puml2xml/actions/workflows/docker-build.yml/badge.svg?branch=main" alt="Docker Build">
  </a>
</div>

<br>

A **PlantUML** (.puml) to **XML** (.xmi) converter.

### Prerequisites

Before starting, If you want to run it locally, ensure you have the following dependencies installed, otherwise **you'll just need Docker**, and can ignore this :

- **dune** (v**3.16** or higher)
- **OCaml** (v**4.08.0** or higher)
- **make**

## Installation

**Steps**

1. Clone this repository and open it

### Local install

2. Compile the program with the command

```
make
```

### Docker 🐳

2. Build the image with the command

```
docker build -t puml2xml .
```

3.  Run the container

```
docker run --rm -v $(pwd):/data/input puml2xml ./puml2xml /data/input/<yourfile.puml>
```

> Note: for this last command, you'll just have to replace <yourfile.puml> by the .puml file you want to convert (located in your current directory).


## Usage

You can use it as specified here :

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

This project is licensed under the Apache 2.0 License - see the [LICENSE](/LICENSE) file for details.