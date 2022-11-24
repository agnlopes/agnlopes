#!/bin/bash

DOTFILES="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)"

# install brew
echo -n "Installing brew: "
if ! [ -x "$(command -v brew)" ]; then
	# installing
	/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# configuring environment
	echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.zprofile
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
	
	# done
	echo "DONE"
else
	# already installed, skipping
	echo "SKIPPING"
fi


# install oh-my-zsh
echo "Installing oh-my-zsh"
# I won't botter checking if it is already installed, the install script does that
/bin/sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install p10k
echo -n "Installing p10k theme to oh-my-zsh: "
if ! [ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ] ; then
	git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
	echo "DONE"
else
	# already installed, skipping
	echo "SKIPPING"
fi

# install the basic stuff
brew install tmux neomutt weechat gnupg

# install dev stuff
brew install --cask docker
brew install minikube kubectx helm k9s

# Configuring zsh
echo "Linking ZSH config files:" 
for cfg in zshrc zprofile p10k.zsh aliases environment ; do
	echo -e "\t$HOME/.$cfg -> $DOTFILES/zsh/$cfg"
	ln -sf "$DOTFILES/zsh/$cfg" "$HOME/.$cfg"
done

# Configuring tmux
echo -n "Enabling TMUX Plugin Manager: "
if ! [ -d $HOME.tmux/plugins/tpm ] ; then 
	mkdir -p "$HOME/.tmux/plugins/tpm"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
	echo "DONE"
	echo "Don't forget installing the the plugins with \"<prefix> I\""
else
	# already clonned, skipping
	echo "SKIPPING"
fi

echo "Linking TMUX config files:" 
for cfg in tmux.conf ; do
	echo -e "\t$HOME/.$cfg -> $DOTFILES/tmux/$cfg"
	ln -sf $DOTFILES/tmux/$cfg $HOME/.$cfg
done

echo "Configuring K9S"
echo "Linking K9S config files:" 
ln -sf "$DOTFILES/k9s" "$HOME/.k9s"
ln -sf "$HOME/Library/Application Support/k9s" "$HOME/.k9s"
echo -e "\t$HOME/.k9s -> $DOTFILES/k9s"
echo -e "\t$HOME/Library/Application Support/k9s -> $HOME/.k9s"
k9s info

echo "Configuring VIM"
echo "Linking VIM config files:" 
for cfg in vimrc vimrc.local ; do
	echo -e "\t$HOME/.$cfg -> $DOTFILES/vim/$cfg"
	ln -sf $DOTFILES/vim/$cfg $HOME/.$cfg
done
echo "Don't forget installing the the plugins with \":PlugInstall\""

