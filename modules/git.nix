{ config, pkgs, userSettings, ... }:

{
  # Git configuration using userSettings from flake.nix
  programs.git = {
    enable = true;
    
    # Set global user configuration from userSettings
    config = {
      user = {
        name = userSettings.name;
        email = userSettings.email;
      };
      
      # Additional git configuration
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      
      # Editor configuration
      core.editor = "nvim";
      
      # Color configuration
      color.ui = "auto";
      color.branch = "auto";
      color.diff = "auto";
      color.status = "auto";
      
      # Alias configuration
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        ca = "commit -a";
        cm = "commit -m";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        visual = "!gitk";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        ll = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all";
      };
      
      # Merge configuration
      merge.tool = "nvimdiff";
      merge.conflictstyle = "diff3";
      
      # Diff configuration
      diff.tool = "nvimdiff";
      diff.algorithm = "patience";
      diff.indentHeuristic = true;
      
      # Pager configuration
      pager.branch = false;
      pager.log = false;
      
      # Credential configuration
      credential.helper = "store";
      
      # Safe directory configuration
      safe.directory = "*";
    };
  };
  
  # Additional git-related packages
  environment.systemPackages = with pkgs; [
    # Git GUI tools
    gitAndTools.gitk
    gitAndTools.git-cola
    
    # Git utilities
    gitAndTools.gitFull
    gitAndTools.gitflow
    gitAndTools.git-extras
    
    # Git credential helpers
    gitAndTools.git-credential-manager
    
    # Git hosting integration
    gitAndTools.hub
    gitAndTools.lab
    
    # Git visualization
    gitAndTools.git-quick-stats
    gitAndTools.git-recent
  ];
} 