final: prev: {
    wpa_supplicant = prev.wpa_supplicant.overrideAttrs (old: {
        patches = old.patches ++ [ ./nemo-avoid-segfault.patch ];
    });
}
