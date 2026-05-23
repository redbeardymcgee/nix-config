{pkgs, ...}: {
  programs.opencode = {
    enable = true;

    settings = {
      model = "mcgeedia/qwen";
      lsp = true;
      provider = {
        mcgeedia = {
          name = "McGeedia";
          npm = "@ai-sdk/openai-compatible";

          options = {
            baseURL = "https://llm.mcgee.network/v1";
            apiKey = "f8a2ee91f287ecb6da4f321f3d9b0ea478bc84b1a6fb552d2796a3443dd4bed2";
          };

          models = {
            qwen = {
              # name = "qwen3.6-27b-awq";
              name = "qwen";
              id = "qwen3.6-27b-awq";
            };
          };
        };
      };
    };
  };
}
