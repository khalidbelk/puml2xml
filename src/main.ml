(*
  Puml2xml - A PlantUML to XML generator
  @khalidbelk, 2025
  File: main.ml
*)

open File_io
open Parse


let usage exitcode =
  print_endline "USAGE: ./puml2xml [OPTIONS]\n";
  print_endline "   puml2xml  : the generated executable\n";
  print_endline "OPTIONS:";
  print_endline "   file  : the relative path of the .puml file to convert";
  print_endline "   -h    : display this message\n";
  exit exitcode

let exampleClass = "class Main {
    +main(String[] args)
    -Commands commands
}"

let main () =
  match Array.to_list Sys.argv
  with
    | [_; "-h"] -> usage 0
    | [_; "-write"] -> writeToFile ()
    | [_; "-parse"] ->
      let xml = parse_class exampleClass in
      print_endline xml
    | [_; filename] -> read_file filename
    | _ -> usage 1

let () = main ()