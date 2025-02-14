(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: file_io.ml
*)

let read_file filename =
  let input_ch = open_in filename in
  let file_content = really_input_string input_ch (in_channel_length input_ch) in
  close_in input_ch;
  file_content

let write_to_file content filename =
  try
    let out_filename = Filename.remove_extension filename ^ ".xmi" in
    let output_channel = open_out out_filename in
    output_string output_channel content;
    close_out output_channel;
    Ok ()
  with
    | Sys_error msg -> Error ("Error writing to file: " ^ msg)
    | e -> Error ("Unexpected error while writing to file: " ^ Printexc.to_string e)
