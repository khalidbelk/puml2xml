(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: main.ml
*)

open File_io
open Parse
open Xml_gen
open Utils

let ( >>= ) = Result.bind

let generate content =
  content
    |> split_classes
    |> List.mapi (fun i class_block -> parse_class class_block (i + 1))
    |> List.map class_to_xml
    |> String.concat "\n"

let process_file file =
  let open Result in
  is_file_extension_valid file
  >>= fun () ->
    let file_content = read_file file |> String.trim in
    is_file_content_valid file_content
  >>= fun () -> Ok (generate file_content)
  >>= writeToFile

let main () =
  match Array.to_list Sys.argv
  with
    | [_; "-h"] -> usage 0
    | [_; "-write"] -> writeToFile "Hello from main"
    | [_; filename] ->
         (match process_file filename with
          | Ok _ -> Ok ()
          | Error msg -> Printf.eprintf "Error: %s\n" msg; Error msg)
    | _ -> usage 1

let () = match main () with
  | Ok () -> exit 0
  | Error _ -> exit 1