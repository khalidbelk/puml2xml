(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: parse.ml
*)

open Types
open Parse_utils

let extract_class_name line =
  let words = String.split_on_char ' ' (String.trim line) in
  let filtered = List.filter (fun s -> s <> "") words in
  match filtered with
    | "class" :: name :: _ -> String.trim (String.split_on_char '{' name |> List.hd)
    | _ -> ""

let parse_feature feature_line att_id =
  let trimmed_line = String.trim feature_line in
  let sign = trimmed_line.[0] in
  let name = String.sub trimmed_line 1 (String.length trimmed_line - 1) in
  {
    name = format_name name;
    visibility = get_visibility sign;
    id =  Printf.sprintf "att%d" att_id;
    feature_type = get_feature_type trimmed_line;
  }

let extract_class_features content att_count =
  let class_body = String.split_on_char '{' content in
  match class_body with
  | _::class_body::_ ->
    let lines = class_body
      |> String.trim
      |> String.split_on_char '\n'
      |> List.filter (fun s -> String.trim s <> "" && String.trim s <> "}")
    in
      List.map (fun line ->
        let feature = parse_feature line !att_count in
        att_count := !att_count + 1;
        feature
      ) lines
  | _ -> []

let parse_class class_block i att_count =
  let class_name = extract_class_name class_block in
  let class_features = extract_class_features class_block att_count in
  {
    name = class_name;
    id = Printf.sprintf "cl%04d" i;
    features = class_features
  }

let split_classes (content: string) : string list =
  let class_regex = Str.regexp "class[ \t\n]+\\([A-Za-z0-9_]+\\)[ \t\n]*{[^}]*}" in
  let rec find_classes start acc =
    try
      let _ = Str.search_forward class_regex content start in
      let class_content = Str.matched_string content in
      find_classes (Str.match_end()) (class_content :: acc)
    with Not_found ->
      List.rev acc
  in
    find_classes 0 []

let count_global_attributes classes =
  List.fold_left (fun acc cls ->
    let features = extract_class_features cls (ref 0) in
    List.fold_left (fun count f -> if f.feature_type = Attribute then count + 1 else count) acc features
  ) 0 classes
