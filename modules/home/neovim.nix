# ~/nixos-config/modules/home/neovim.nix
{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      nodePackages.typescript-language-server
      nodePackages.typescript
      rust-analyzer
      pyright
      prettierd
      # Lua
      luajitPackages.luacheck
      stylua
      eslint_d
      # Nix
      nil
      alejandra
      statix
    ];
    plugins = with pkgs.vimPlugins; [
      # COLORSCHEMES - They are configured later on
      lush-nvim
      tokyonight-nvim
      noctis-nvim
      noctis-hc # THIS IS CUSTOM - if it becomes available as a package remove it
      # END COLORSCHEMES
      plenary-nvim
      nvim-autopairs
      nvim-ts-context-commentstring
      nvim-web-devicons
      bufdelete-nvim # TODO: Figure out if this needs to be configured
      project-nvim # TODO: Configure this plugin or something - I never had config before
      which-key-nvim # TODO: Do I need configuration?
      cellular-automaton-nvim
      telescope-media-files-nvim
      telescope-cheat-nvim
      sqlite-lua # Needed for telescope-cheat-nvim
      ron-vim
      vim-nix # Nix syntax highlighting
      # CMP
      cmp-buffer
      cmp-path
      cmp-nvim-lua
      cmp-nvim-lsp
      cmp_luasnip
      luasnip
      friendly-snippets
      # LSP
      null-ls-nvim
      trouble-nvim
      lsp-status-nvim
      vim-illuminate
      actions-preview-nvim
      # Noice - UI for messages, cmdline and popupmenu
      {
        plugin = noice-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/noice.lua;
      }
      # Commenting out Lines
      {
        plugin = comment-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/comment.lua;
      }
      # netrw replacement written in Lua
      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/nvim-tree.lua;
      }
      # Buffer line
      {
        plugin = bufferline-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/bufferline.lua;
      }
      # Blazing fast status line written in Lua
      {
        plugin = lualine-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/lualine.lua;
      }
      # Toggling terminal
      {
        plugin = toggleterm-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/toggleterm.lua;
      }
      # Rainbow colored indents
      {
        plugin = indent-blankline-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/indentline.lua;
      }
      # Greeter for neovim (homepage)
      {
        plugin = alpha-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/alpha.lua;
      }
      # Eyeliner - fast movement with f and F
      {
        plugin = eyeliner-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/eyeliner.lua;
      }
      # Convert hexes and words into colors
      {
        plugin = nvim-colorizer-lua;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/colorizer.lua;
      }
      # A sidebar with a tree-like outlione of symbols from your code (LSP powered)
      {
        plugin = outline-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/outline.lua;
      }
      # TELESCOPE - YES
      {
        plugin = telescope-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/telescope.lua;
      }
      # Those nice TODO comments
      {
        plugin = todo-comments-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/todo.lua;
      }
      # CMP Configuration
      {
        plugin = nvim-cmp;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/cmp.lua;
      }
      # LSP
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/lsp.lua;
      }
      # Fidget for showing LSP messages
      {
        plugin = fidget-nvim;
        config = toLuaFile ./../../dotfiles/nvim/lua/user/fidget.lua;
      }
      # COLORSCHEMES
      {
        plugin = gruvbox-nvim;
        config = "colorscheme noctishc";
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./../../dotfiles/nvim/lua/user/options.lua}
      ${builtins.readFile ./../../dotfiles/nvim/lua/user/keymaps.lua}
    '';
  };
}
