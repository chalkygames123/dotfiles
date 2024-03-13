.PHONY: lint
lint:
	statix check

.PHONY: format
format:
	nixpkgs-fmt .

.PHONY: switch
switch:
	darwin-rebuild switch --flake .

.PHONY: update
update:
	nix flake update

.PHONY: clean
clean:
	sudo nix-collect-garbage --delete-old
