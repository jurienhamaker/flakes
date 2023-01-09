{
  programs = {
    git = {
      enable = true;
      userName = "Jurien Hamaker";
      userEmail = "whoami@jurien.dev";
      extraConfig = {
        url = {
          "ssh://git@github.com:jurienhamaker" = {
            insteadOf = "https://github.com/jurienhamaker/";
          };
        };
      };
    };
  };
}
