self: super:
{
  flameshot = super.android-udev-rules.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "jurienhamaker";
      repo = "android-udev-rules";
      rev = super.version;
    };
  });
}
