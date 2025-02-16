FROM ocaml/opam:ubuntu-20.04-ocaml-4.14

WORKDIR /data

COPY . .

RUN sudo apt-get update && sudo apt-get install -y make

RUN opam init -y

RUN opam install -y dune

USER root

RUN eval $(opam env) && make

CMD ["./puml2xml"]
