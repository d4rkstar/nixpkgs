{ callPackage, makeFontsConf, gnome2, buildFHSUserEnv, tiling_wm ? false }:

let
  mkStudio = opts: callPackage (import ./common.nix opts) {
    fontsConf = makeFontsConf {
      fontDirectories = [];
    };
    inherit (gnome2) GConf gnome_vfs;
    inherit buildFHSUserEnv;
    inherit tiling_wm;
  };
  stableVersion = {
    version = "2021.2.1.15"; # "Android Studio Chipmunk (2021.2.1)"
    sha256Hash = "ABjg38DdKSFwBRb3osRDN3xVd4jaf7CkUkPstDAHRb4=";
  };
  betaVersion = {
    version = "2021.3.1.14"; # "Android Studio Dolphin (2021.3.1) Beta 5"
    sha256Hash = "k1Qt54u45rwHsQNz9TVqnFB65kBKtfFZ3OknpfutKPI=";
  };
  latestVersion = { # canary & dev
    version = "2021.3.1.9"; # "Android Studio Dolphin (2021.3.1) Canary 9"
    sha256Hash = "0nx26xwy67mnbkz37m3nw354siv152sa6zx94pxrvbnxxgppigfb";
  };
in {
  # Attributes are named by their corresponding release channels

  stable = mkStudio (stableVersion // {
    channel = "stable";
    pname = "android-studio";
  });

  beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });

  dev = mkStudio (latestVersion // {
    channel = "dev";
    pname = "android-studio-dev";
  });

  canary = mkStudio (latestVersion // {
    channel = "canary";
    pname = "android-studio-canary";
  });
}
