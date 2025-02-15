(*
  Puml2xml - A PlantUML to XML converter
  @khalidbelk, 2025
  File: xml_chunks.ml
*)

(* Static XML chunks needed for the final output *)

let xml_header = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><XMI xmlns:UML=\"href://org.omg/UML/1.3\" xmi.version=\"1.1\">
    <XMI.header>
        <XMI.documentation>
            <XMI.exporter>PlantUML</XMI.exporter>
            <XMI.exporterVersion>1.2024.7</XMI.exporterVersion>
        </XMI.documentation>
        <XMI.metamodel xmi.name=\"UML\" xmi.version=\"1.4\"/>
    </XMI.header>
    <XMI.content>
        <UML:Model name=\"PlantUML\" xmi.id=\"model1\">
            <UML:Namespace.ownedElement>
"

let xml_footer = "
            </UML:Namespace.ownedElement>
        </UML:Model>
    </XMI.content>
</XMI>
"