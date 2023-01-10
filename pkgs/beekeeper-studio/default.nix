{ appimageTools
, lib
, fetchurl
, gtk3
, gsettings-desktop-schemas
}:

let
  pname = "beekeeper-studio";
  version = "3.7.10";
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v${version}/Beekeeper-Studio-${version}.AppImage";
    sha256 = "YZ1OZDGzBUKMWw7OeTCE0HMFAfaZ/HucwfAyzPyE8Gw=";
  };
  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };
in
appimageTools.wrapType2 rec {
  inherit name src;

  profile = ''
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
  '';

  extraPkgs = (pkgs: with pkgs; with xorg; [
    glib dbus libdrm libxshmfence nss nspr atk at-spi2-atk gdk-pixbuf pango cairo libX11
    libXcomposite libXdamage libXext libXfixes libXrandr expat libxcb
    libxkbcommon mesa alsa-lib cups at-spi2-core
  ]);

  multiPkgs = null; # no 32bit needed
  extraInstallCommands = ''
    mv $out/bin/{${name},${pname}}
    install -m 444 -D ${appimageContents}/beekeeper-studio.desktop $out/share/applications/beekeeper-studio.desktop
    install -m 444 -D ${appimageContents}/beekeeper-studio.png $out/share/icons/hicolor/512x512/apps/beekeeper-studio.png
    substituteInPlace $out/share/applications/beekeeper-studio.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = with lib; {
    description = "Open Source SQL Editor and Database Manager";
    homepage = "https://www.beekeeperstudio.io/";
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3;
    maintainers = with maintainers; [ kamilchm ];
  };
}