(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: parse_utils.ml
*)

open Types

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

let get_feature_type feature : feature_type =
  match (String.contains feature '(') with
    | true -> Method
    | false -> Attribute

