{
  config,
  pkgs,
  ...
}:
let
  model = "mcgeedia/qwen";
in {
  home.packages = with pkgs; [
    ast-grep
    bun
  ];

  programs.opencode = {
    enable = true;
    package = pkgs.llm-agents.opencode;

    settings = {
      model = model;
      plugin = ["oh-my-openagent@latest"];
      lsp = true;
      provider = {
        mcgeedia = {
          name = "McGeedia";
          npm = "@ai-sdk/openai-compatible";

          options = {
            baseURL = "https://llm.mcgee.network/v1";
            apiKey = "{file:${config.sops.secrets.opencode_api_key.path}}";
          };

          models = {
            qwen = {
              name = "qwen";
              id = "qwen3.6-27b-autoround";
              tool_call = true;
            };
          };
        };
      };
    };
  };

  xdg.configFile."opencode/oh-my-openagent.jsonc" = {
    source = (pkgs.formats.json { }).generate "oh-my-openagent.jsonc" {
      "$schema" =
        "https://raw.githubusercontent.com/code-yeongyu/oh-my-openagent/dev/assets/oh-my-opencode.schema.json";
      agents = {
        sisyphus = {
          model = model;
          temperature = 0.3;
        };
        sisyphus-junior = {
          model = model;
          temperature = 0.3;
        };
        hephaestus = {
          model = model;
          temperature = 0.3;
        };
        prometheus = {
          model = model;
          temperature = 0.3;
        };
        oracle = {
          model = model;
          temperature = 0.5;
        };
        librarian = {
          model = model;
          temperature = 0.7;
        };
        explore = {
          model = model;
          temperature = 0.5;
        };
        multimodal-looker = {
          model = model;
          temperature = 0.5;
        };
        metis = {
          model = model;
          temperature = 0.5;
        };
        momus = {
          model = model;
          temperature = 0.5;
        };
        atlas = {
          model = model;
          temperature = 0.5;
        };
      };
    };
  };
}
