{ pkgs, ... }:

{
  # Determinate Nix を使用しているため、nix-darwin の Nix 管理を無効化
  # Determinate Nix が独自のデーモンで Nix を管理するため
  nix.enable = false;

  # zsh をデフォルトシェルとして有効化
  # Home Manager の programs.zsh と連携するために必要
  programs.zsh.enable = true;

  # 必須: nix-darwin のバージョン管理
  # これにより設定の互換性が保たれる
  system.stateVersion = 5;
}
