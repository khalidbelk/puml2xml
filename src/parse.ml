(*
  Puml2xml - A PlantUML to XML generator
  @khalidbelk, 2025
  File: parse.ml
*)

open Types
open Xml_gen

let extract_class_name line =
  let prefix = "class " in
  let prefix_length = String.length prefix in
  if String.starts_with ~prefix line then
    let after_class = String.trim (String.sub line (prefix_length) (String.length line - prefix_length)) in
    match String.split_on_char '{' after_class with
    | class_name::_ -> String.trim class_name
    | [] -> after_class
  else
      ""

let extract_class_features line =
  match String.split_on_char '{' line with
  | _::content::_ ->
    let content = String.trim content in
    let content = String.sub content 0 (String.length content - 1) in
    String.split_on_char '\n' content
    |> List.filter (fun s -> String.trim s <> "")
    |> List.map (fun s ->
      let trimmed = String.trim s in
      let visibility = match trimmed.[0] with
        | '+' -> "public"
        | '-' -> "private"
        | '#' -> "protected"
        | _ -> "unknown"
      in
      let name = String.trim (String.sub trimmed 1 (String.length trimmed - 1)) in
      {
        name = name;
        visibility = visibility;
        id = "1";
        feature_type = if String.contains trimmed '(' then Method else Attribute;
      }
    )
  | _ -> []

let parse_class line =
  let class_name = extract_class_name line in
  let class_features = extract_class_features line in
  let parsed_class = {
    name = class_name;
    id = "cl0001";
    features = class_features
  } in
  class_to_xml parsed_class
