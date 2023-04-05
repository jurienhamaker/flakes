final: prev: {
    wpa_supplicant = prev.wpa_supplicant.overrideAttrs (old: {
        patches = old.patches ++ [ ./eduroam.patch ];
    });
}
