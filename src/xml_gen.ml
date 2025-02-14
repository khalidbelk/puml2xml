(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: xml_gen.ml
*)

open Types

let feature_to_xml feature =
  let feature_tag = match feature.feature_type with
    | Attribute -> "UML:Attribute"
    | Method ->  "UML:Operation"
  in
  Printf.sprintf "\t\t<%s name=\"%s\" visibility=\"%s\" xmi.id=\"%s\"/>"
    feature_tag
    feature.name
    feature.visibility
    feature.id

let class_to_xml uml_class =
  let features_xml = List.fold_left (fun acc f ->
    acc ^ "\n" ^ feature_to_xml f) "" uml_class.features in
    Printf.sprintf "<UML:Class name=\"%s\" xmi.id=\"%s\">\n\t<UML:Classifier.feature>%s\n\t</UML:Classifier.feature>\n</UML:Class>\n"
    uml_class.name
    uml_class.id
    features_xml
