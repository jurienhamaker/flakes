self: super:
{
  android-udev-rules = super.android-udev-rules.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "jurienhamaker";
      repo = "android-udev-rules";
      rev = "8c90b75";
      hash = "sha256-SYAPXQduhnu3kggW7tMn65IWYRX0RJBTu3NhajlPX3Q=";
    };
  });
}
