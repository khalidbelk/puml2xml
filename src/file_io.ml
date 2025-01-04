(*
  Puml2xml - A PlantUML to XML generator
  @khalidbelk, 2025
  File: file_io.ml
*)

let read_file filename =
  let input_channel = open_in filename in
  try
    try
      while true do
        let line = input_line input_channel in
        print_endline line
      done
    with End_of_file ->
      close_in input_channel
  with e ->
      close_in input_channel;
      raise e

let out_file = "out.xml"
let writeToFile () =
  let output_channel = open_out out_file in
  try
    output_string output_channel "Hello from the future";
    close_out output_channel
  with e ->
    close_out output_channel;
    raise e
