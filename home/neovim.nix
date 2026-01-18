{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      (nvim-treesitter.withPlugins (p: [
        p.nix p.lua p.markdown p.yaml p.json p.toml p.bash
        p.typescript p.javascript p.html p.css
        p.go p.rust p.python p.dockerfile p.make
      ]))
    ];

    extraLuaConfig = ''
      vim.cmd.colorscheme("tokyonight-night")

      vim.opt.number = true
      vim.opt.relativenumber = false
      vim.opt.termguicolors = true
      vim.opt.laststatus = 2

      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = true

      vim.opt.clipboard = "unnamedplus"

      vim.keymap.set("i", "jj", "<Esc>")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "make",
        callback = function()
          vim.opt_local.expandtab = false
          vim.opt_local.tabstop = 8
          vim.opt_local.shiftwidth = 8
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          vim.opt_local.expandtab = false
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          local save_cursor = vim.fn.getpos(".")
          vim.cmd([[%s/\s\+$//e]])
          vim.fn.setpos(".", save_cursor)
          vim.cmd([[silent! %s/\($\n\s*\)\+\%$//]])
          if vim.fn.getline("$") ~= "" then
            vim.fn.append("$", "")
          end
        end,
      })
    '';
  };
}
