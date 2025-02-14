(lang dune 3.16)

(name puml2xml)

(generate_opam_files true)

(source
 (github khalidbelk/puml2xml))

(authors "Khalid B.")

(maintainers "Khalid B.")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name puml2xml)
 (synopsis "A PlantUML to XML converter")
 (description "Convert .puml files to .xmi")
 (depends
  (ocaml (>= 4.08.0))
  (dune (>= 3.16)))
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
