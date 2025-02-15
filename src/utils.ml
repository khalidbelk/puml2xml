(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: utils.ml
*)

let usage exitcode =
  print_endline "USAGE: ./puml2xml <file> [OPTIONS]\n";
  print_endline "   <file>          : the relative path of the .puml file to convert\n";
  print_endline "OPTIONS:";
  print_endline "   -f <new_name>   : specify the output file name. Default: same as input with .xmi extension.";
  print_endline "   -h              : display this message\n";
  exit exitcode

let contains str1 str2 =
  let rg = Str.regexp_string str2 in
  try
    let _ = Str.search_forward rg str1 0 in
    true
  with Not_found -> false

let is_file_extension_valid file =
  let file_extension = String.split_on_char '.' file |> List.rev |> List.hd in
    match file_extension with
      | "puml" -> Ok ()
      | _ -> Error "Invalid file extension. Expected .puml"

let is_file_content_valid content =
  let contains_tags = contains content "@startuml" && contains content "@enduml" in
    match contains_tags with
      | true -> Ok ()
      | false -> Error "Invalid puml file. Please make sure your file content is valid first."
