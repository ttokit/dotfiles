{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/github_ed25519";
        extraOptions = {
          AddKeysToAgent = "yes";
        };
      };
    };
  };
}
