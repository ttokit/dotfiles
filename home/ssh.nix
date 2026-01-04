{ ... }:
{
  programs.ssh = {
    enable = true;
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
