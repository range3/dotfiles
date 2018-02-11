DOTPATH     := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES  := $(wildcard [!.]*) $(wildcard atom/*)
EXCLUSIONS  := Makefile README.md scripts atom
DOTFILES    := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@/bin/ls -dF --color $(DOTFILES)

pre-link: ## Run pre-link scripts
	@$(foreach val, $(wildcard $(DOTPATH)/scripts/pre-link/*.sh), DOTPATH=$(DOTPATH) bash $(val);)

link: ## Create symlinks to the home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

post-link: ## Run post-link scripts
	@$(foreach val, $(wildcard $(DOTPATH)/scripts/post-link/*.sh), DOTPATH=$(DOTPATH) bash $(val);)

install: pre-link link post-link ## Run make pre-link link post-link

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
