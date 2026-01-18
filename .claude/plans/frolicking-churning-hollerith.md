# Neovim導入計画

## 概要
yaziでファイル編集時にデフォルトエディタとしてNeovimを使用できるよう、Home Managerで最小限のNeovim設定を導入する。

## 変更対象ファイル

| ファイル | 操作 | 内容 |
|---------|------|------|
| `home/neovim.nix` | 新規作成 | Neovim設定モジュール |
| `home/default.nix` | 編集 | importsに`./neovim.nix`追加 |
| `home/zsh.nix` | 編集 | sessionVariablesに`EDITOR = "nvim"`追加 |

## 1. home/neovim.nix（新規作成）

```nix
{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # プラグイン（TokyoNight + TreeSitter）
    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      (nvim-treesitter.withPlugins (p: [
        p.nix p.lua p.markdown p.yaml p.json p.toml p.bash
        p.typescript p.javascript p.html p.css
        p.go p.rust p.python p.dockerfile p.make
      ]))
    ];

    # Lua設定
    extraLuaConfig = ''
      -- カラースキーム
      vim.cmd.colorscheme("tokyonight-night")

      -- 見やすさ
      vim.opt.number = true
      vim.opt.relativenumber = false
      vim.opt.termguicolors = true
      vim.opt.laststatus = 2

      -- インデント（デフォルト: 2スペース）
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      -- 検索
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = true

      -- クリップボード共有
      vim.opt.clipboard = "unnamedplus"

      -- jjでEsc
      vim.keymap.set("i", "jj", "<Esc>")

      -- ファイルタイプ別インデント設定
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

      -- 保存時の整形
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          -- 末尾空白削除
          local save_cursor = vim.fn.getpos(".")
          vim.cmd([[%s/\s\+$//e]])
          vim.fn.setpos(".", save_cursor)
          -- 最終行に改行確保
          vim.cmd([[silent! %s/\($\n\s*\)\+\%$//]])
          if vim.fn.getline("$") ~= "" then
            vim.fn.append("$", "")
          end
        end,
      })
    '';
  };
}
```

## 2. home/default.nix（編集）

importsセクションに追加：
```nix
imports = [
  ./git.nix
  ./zsh.nix
  ./ghostty.nix
  ./claude.nix
  ./ssh.nix
  ./yazi.nix
  ./neovim.nix      # ← 追加
  ./npm.nix
  ./modern-cli.nix
  ./fzf.nix
  ./zoxide.nix
  ./starship.nix
];
```

## 3. home/zsh.nix（編集）

sessionVariablesセクションに追加：
```nix
sessionVariables = {
  USE_STARSHIP = "1";
  EDITOR = "nvim";  # ← 追加
};
```

## 技術的ポイント

### TreeSitterパーサー
`nvim-treesitter.withPlugins`でパーサーを選択。Nixのevaluationtime時にパーサーがビルドされるため、初回起動時のダウンロード不要。

### TokyoNightテーマ
`tokyonight-nvim`はnixpkgs.vimPluginsに含まれており、プラグインマネージャー不要。GhosttyのTokyoNightテーマと統一。

### クリップボード
macOSでは`unnamedplus`でpbcopy/pbpasteが自動的に使用される。

### yazi連携
yaziは既に`${EDITOR:-vim}`を参照しているため、$EDITOR設定のみで自動的にNeovimが使われる。

## 検証手順

1. **ビルドテスト**（read-only確認）
   ```bash
   darwin-rebuild build --flake .#ttokit-mac-mini
   ```

2. **適用**
   ```bash
   sudo darwin-rebuild switch --flake .#ttokit-mac-mini
   ```

3. **動作確認**
   - `nvim --version` でバージョン確認
   - `echo $EDITOR` で環境変数確認
   - `yazi`で任意ファイルを選択し`e`キーでNeovimが起動するか
   - TokyoNightテーマが適用されているか
   - TreeSitterハイライトが効いているか（.nixファイルなど）
   - jjでEscが効くか
   - クリップボード共有（Neovim内でyankしてターミナルでpaste）
   - 保存時に末尾空白が削除されるか
