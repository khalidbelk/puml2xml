(*
  Puml2xml - A PlantUML to XML generator
  @khalidbelk, 2025
  File: types.ml
*)

type feature_type =
  | Attribute
  | Method

type feature = {
  name: string;
  visibility: string;
  id: string;
  feature_type: feature_type
}

type uml_class = {
  name: string;
  id: string;
  features: feature list;
}
