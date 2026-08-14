{ llm-agents, ... }:
{
  programs.claude-code = {
    enable = true;
    package = llm-agents.claude-code;
    settings = {
      language = "japanese";
      statusLine = {
        type = "command";
        command = "~/.claude/statusline.sh";
      };
    };
  };
  home.file.".claude/statusline.sh" = {
    source = ./statusline.sh;
    executable = true;
  };
}
