{ config, lib, pkgs, ... }:

let
  dockerConfigPath = "${config.home.homeDirectory}/.docker/config.json";
  dockerCliPluginsDir = "/opt/homebrew/lib/docker/cli-plugins";
in
{
  home.activation.configureDockerCliPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.python3}/bin/python3 <<'PY'
    import json
    from pathlib import Path

    config_path = Path("${dockerConfigPath}")
    plugin_dir = "${dockerCliPluginsDir}"

    config_path.parent.mkdir(parents=True, exist_ok=True)

    if config_path.exists() and config_path.stat().st_size > 0:
        with config_path.open(encoding="utf-8") as f:
            config = json.load(f)
    else:
        config = {}

    dirs = config.get("cliPluginsExtraDirs", [])
    if not isinstance(dirs, list):
        raise TypeError("Docker config cliPluginsExtraDirs must be a list")

    if plugin_dir not in dirs:
        dirs.append(plugin_dir)
        config["cliPluginsExtraDirs"] = dirs
        with config_path.open("w", encoding="utf-8") as f:
            json.dump(config, f, indent=2, ensure_ascii=False)
            f.write("\n")
    PY
  '';
}
