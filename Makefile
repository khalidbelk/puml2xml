##
## @khalidbelk, 2024
## File description:
## Makefile
##

GREEN=\033[0;32m
RESET=\033[0m

NAME = puml2xml

all: $(NAME)

$(NAME):
	@echo "${GREEN}Building${RESET} $(NAME)..."
	@dune build src/main.exe
	@install -m 755 _build/default/src/main.exe $(NAME)
	@echo "\033[0;32m✔ Done.\033[0m"

clean:
	@echo "Cleaning..."
	@dune clean

fclean: clean
	@echo "${GREEN}Removing${RESET} $(NAME)..."
	@rm -f $(NAME)

re: fclean all

.PHONY: all clean