# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"

if [[ -x /opt/homebrew/bin/brew ]]; then
	# Set PATH, MANPATH, etc., for Homebrew.
	eval "$(/opt/homebrew/bin/brew shellenv)"

	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Added by Toolbox App
export PATH="$PATH:/Users/takuya.fukuju/Library/Application Support/JetBrains/Toolbox/scripts"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
