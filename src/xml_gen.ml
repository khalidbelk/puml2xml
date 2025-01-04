(*
  Puml2xml - A PlantUML to XML generator
  @khalidbelk, 2025
  File: xml_gen.ml
*)

open Types

let feature_to_xml feature =
  let feature_tag = match feature.feature_type with
    | Attribute -> "UML:Attribute"
    | Method ->  "UML:Operation"
  in
  Printf.sprintf "<%s name=\"%s\" visibility=\"%s\" xmi.id=\"%s\"/>"
    feature_tag
    feature.name
    feature.visibility
    feature.id

let class_to_xml uml_class =
  let features_xml = List.map feature_to_xml uml_class.features |>
    String.concat "\n    " in
    Printf.sprintf "
    <UML:Class name=\"%s\" xmi.id=\"%s\">
      <UML:Classifier.feature>
        %s
      </UML:Classifier.feature>
    </UML:Class>
    "
    uml_class.name
    uml_class.id
    features_xml
