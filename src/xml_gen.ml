(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: xml_gen.ml
*)

open Types

let indent n = String.make (n * 4) ' '

let feature_to_xml feature =
  let feature_tag = match feature.feature_type with
    | Attribute -> "UML:Attribute"
    | Method ->  "UML:Operation"
  in
  Printf.sprintf "%s<%s name=\"%s\" visibility=\"%s\" xmi.id=\"%s\"/>"
    (indent 2)
    feature_tag
    feature.name
    feature.visibility
    feature.id

let get_formatted_features features =
  features
  |> List.sort (fun f1 f2 ->
    match f1.feature_type, f2.feature_type with
    | Attribute, Method -> -1
    | Method, Attribute -> 1
    | _ -> 0)
  |> List.fold_left (fun acc f -> acc ^ "\n" ^ indent 4 ^ feature_to_xml f) ""

let class_to_xml uml_class =
  let features_xml = get_formatted_features uml_class.features in
  Printf.sprintf "%s<UML:Class name=\"%s\" xmi.id=\"%s\">\n%s<UML:Classifier.feature>%s\n%s</UML:Classifier.feature>\n%s</UML:Class>"
  (indent 4)
  uml_class.name
  uml_class.id
  (indent 5)
  features_xml
  (indent 5)
  (indent 4)
