{
  description = "ttokit's dotfiles";

  inputs = {
    # nixpkgs - パッケージのソース（unstableで最新版を使用）
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # nix-darwin - macOS システム設定
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs"; # nixpkgs を共有して一貫性を保つ
    };

    # home-manager - ユーザー環境設定
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # nixpkgs を共有
    };

    # Arto - Markdown リーダー
    arto.url = "github:arto-app/Arto";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }: {
    # darwinConfigurations.<ホスト名> で設定を定義
    darwinConfigurations."ttokit-mac-mini" = darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # Apple Silicon
      specialArgs = { inherit inputs; }; # inputs を darwin モジュールに渡す

      modules = [
        # macOS システム設定
        ./darwin/default.nix

        # Home Manager を nix-darwin のモジュールとして組み込む
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true; # nixpkgs を共有
          home-manager.useUserPackages = true; # ユーザーパッケージを使用
          home-manager.extraSpecialArgs = { inherit inputs; }; # inputs を Home Manager に渡す
          home-manager.users.ttokit = import ./home/default.nix;
        }
      ];
    };
  };
}
