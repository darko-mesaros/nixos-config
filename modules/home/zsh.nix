{ config, lib, pkgs, ...}:
{
  # Some requisites
  home.packages = with pkgs; [
    bashmount
    fzf
    fastfetch
    bat
    figlet
    lolcat
    zoxide
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#framework_laptop";  # Replace hostname
      ll = "eza -l";
      l = "eza -la";
      ls = "eza";
    };
    initExtra = ''
      eval "$(direnv hook zsh)"
      autoload -U colors && colors
      autoload -Uz add-zsh-hook
      autoload -Uz vcs_info

      # set this up for version control information (git branch)
      add-zsh-hook precmd vcs_info

      zstyle ':vcs_info:*' enable git
      zstyle ':vcs_info:*' formats " %F{blue}%c%u(%b)%f"
      zstyle ':vcs_info:*' actionformats " %F{blue}%c%u(%b)%f %a"
      zstyle ':vcs_info:*' stagedstr "%F{green}"
      zstyle ':vcs_info:*' unstagedstr "%F{red}"
      zstyle ':vcs_info:*' check-for-changes true
      zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
      +vi-git-untracked() {
        if git --no-optional-locks status --porcelain 2> /dev/null | grep -q "^??"; then
          hook_com[staged]+="%F{red}"
        fi
      }
      # editor
      export EDITOR="nvim"
      export READER="zathura"
      # path
      export PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:$PATH"
      # prompt
      # checks the hostname and sets the colors
      host_color=$fg[green]
      user_color=$fg[cyan]
      setopt PROMPT_SUBST
      PROMPT="%{$user_color%}%n%{$reset_color%}@%{$host_color%}%m %{$reset_color%}[%{$fg[yellow]%}%~%{$reset_color%}]: "
# righthand promt (git info be here)
      RPROMPT='$vcs_info_msg_0_'

      # End of lines configured by zsh-newuser-install
      # The following lines were added by compinstall
      zstyle :compinstall filename '/home/darko/.zshrc'

      autoload -Uz compinit
      compinit
      # End of lines added by compinstall

      eval "$(zoxide init zsh)"
      #eval "$(thefuck --alias)"
      #eval "$(direnv hook zsh)"

      # ALIASES

      ## Utilities
      alias ll="eza -l --git"
      alias l="eza -la --git"
      alias bm="bashmount"
      alias wget="aria2c -x 16 -s 16"
      alias vim="nvim"
      alias k="kubectl"
      alias c="clear && pwd && ll"
      alias cd="z"
      alias cdi="zi"
      alias zshedit="vim /home/darko/.zshrc"
      alias cggpg="gpg --quiet --decrypt /home/darko/workspace/keys/chatgpt.txt.gpg > /dev/null"



      ## Needs Figlet and lolcat
      function lolbanner {
        figlet -c -f ~/.local/share/fonts/figlet-fonts/ANSI\ Shadow.flf $@ | lolcat
      }

      ## Needs BAT
      function cht {
        curl cheat.sh/$@ | bat
      }

      #source /usr/share/nvm/init-nvm.sh

      # Show system info
      fastfetch -c paleofetch.jsonc
    '';

  };
}
