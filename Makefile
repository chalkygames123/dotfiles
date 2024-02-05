.PHONY: clean
clean:
	sudo nix-collect-garbage --delete-old

.PHONY: format
format:
	nixpkgs-fmt .

.PHONY: lint
lint:
	statix check

.PHONY: switch
switch:
	darwin-rebuild switch --flake .
