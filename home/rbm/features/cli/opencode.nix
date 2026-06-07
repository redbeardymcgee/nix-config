{pkgs, ...}: {
  programs.opencode = {
    enable = true;

    settings = {
      model = "mcgeedia/qwen";
      # lsp = true;
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
              name = "qwen";
              id = "qwen3.6-27b-autoround";
              tool_call = true;
            };
          };
        };
      };
    };
  };
  # {
  #   "plugin": ["oh-my-openagent@latest"],
  #   "model": "local-vllm/qwen3.6-27b-autoround",
  #   "agent": {
  #     "build": { "model": "local-vllm/qwen3.6-27b-autoround" },
  #     "explore": { "model": "local-vllm/qwen3.6-27b-autoround" },
  #     "scout": { "model": "local-vllm/qwen3.6-27b-autoround" },
  #     "oracle": { "model": "local-vllm/qwen3.6-27b-autoround" },
  #     "librarian": { "model": "local-vllm/qwen3.6-27b-autoround" },
  #     "title": { "model": "local-vllm/qwen3.6-27b-autoround" },
  #     "summary": { "model": "local-vllm/qwen3.6-27b-autoround" },
  #     "compaction": { "model": "local-vllm/qwen3.6-27b-autoround" },
  #     "plan": { "model": "local-vllm/qwen3.6-27b-autoround" }
  #   }
  # }

  # {
  #   "$schema": "https://raw.githubusercontent.com/code-yeongyu/oh-my-openagent/dev/assets/oh-my-opencode.schema.json",
  #   "agents": {
  #     "hephaestus": {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     },
  #     "oracle": {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     },
  #     "librarian": {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     },
  #     "explore": {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     },
  #     "multimodal-looker": {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     },
  #     "prometheus": {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     },
  #     "metis": {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     },
  #     "momus": {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     },
  #     "atlas": {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     },
  #     "sisy: {
  #       "model": "local-vllm/qwen3.6-27b-autoround"
  #     }
}
