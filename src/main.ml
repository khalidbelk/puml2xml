(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: main.ml
*)

open File_io
open Parse
open Xml_gen
open Xml_chunks
open Utils

let ( >>= ) = Result.bind

let generate content =
  let classes = split_classes content in
  let att_count = ref (count_global_attributes classes) in
  let processed_content =
    classes
    |> List.mapi (fun i class_block -> parse_class class_block (i + 1) att_count)
    |> List.map class_to_xml
    |> String.concat "\n"
  in xml_header ^ processed_content ^ xml_footer

let process_file file out_file =
  is_file_extension_valid file
  >>= fun () ->
    let file_content = read_file file |> String.trim in
    is_file_content_valid file_content
  >>= fun () ->
      let generated_content = generate file_content in
      write_to_file generated_content (Option.value out_file ~default:file)

let handle_process filename opt_out_filename =
  match process_file filename opt_out_filename with
  | Ok _ -> Ok ()
  | Error msg -> Printf.eprintf "Error: %s\n" msg; Error msg

let main () =
  match Array.to_list Sys.argv
  with
    | [_; "-h"] -> usage 0
    | [_; filename] ->
        handle_process filename None
    | [_; filename ; "-f"; new_name ] ->
        handle_process filename (Some new_name)
    | _ -> usage 1

let () = match main () with
  | Ok () -> exit 0
  | Error _ -> exit 1
