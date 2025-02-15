(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: parse.ml
*)

open Types

let extract_class_name line =
  let words = String.split_on_char ' ' (String.trim line) in
  let filtered = List.filter (fun s -> s <> "") words in
  match filtered with
    | "class" :: name :: _ -> String.trim (String.split_on_char '{' name |> List.hd)
    | _ -> ""

(* Gives us the access modifier from a sign *)
let get_visibility sign =
  match sign with
    | '+' -> "public"
    | '-' -> "private"
    | '#' -> "protected"
    | _ -> "unknown"

let format_name name =
  name
    |> Str.global_replace (Str.regexp "<") "&lt;"
    |> Str.global_replace (Str.regexp ">") "&gt;"

let parse_feature feature_line =
  let trimmed_line = String.trim feature_line in
  let sign = trimmed_line.[0] in
  let name = String.sub trimmed_line 1 (String.length trimmed_line - 1) in
  {
    name = format_name name;
    visibility = get_visibility sign;
    id = "1";
    feature_type = if (String.contains trimmed_line '(') then Method else Attribute;
  }

let extract_class_features content=
  let class_body = String.split_on_char '{' content in
  match class_body with
  | _::class_body::_ -> class_body
    |> String.trim
    |> String.split_on_char '\n'
    |> List.filter (fun s -> String.trim s <> "" && String.trim s <> "}")
    |> List.map parse_feature
  | _ -> []

let parse_class class_block (i: int) =
  let class_name = extract_class_name class_block in
  let class_features = extract_class_features class_block in
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

