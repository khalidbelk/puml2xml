(*
  Puml2xml - A PlantUML to XML generator
  @khalidbelk, 2025
  File: parse.ml
*)

open Types
open Xml_gen

let extract_class_name line =
  let after_class = String.trim (String.sub line 6 (String.length line - 6)) in
  match String.split_on_char '{' after_class with
  | feature::_ -> String.trim feature
  | [] -> after_class

let extract_class_features line =
  match String.split_on_char '{' line with
  | _::content::_ ->
    let content = String.trim content in
    let content = String.sub content 0 (String.length content - 1) in
    String.split_on_char '\n' content
    |> List.filter (fun s -> String.trim s <> "")
    |> List.map (fun s -> {
      name = String.trim (String.sub s 1 (String.length s - 1));
      visibility = (match (String.trim s).[0] with
        | '+' -> "public"
        | '-' -> "private"
        | '#' -> "protected"
        | _ -> "unknown"
      );
      id = "1";
      feature_type = if String.contains s '(' then Method else Attribute;
    })
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
