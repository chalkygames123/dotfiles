if [[ -x /opt/homebrew/bin/brew ]]; then
	# Set PATH, MANPATH, etc., for Homebrew.
	eval "$(/opt/homebrew/bin/brew shellenv)"

	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
