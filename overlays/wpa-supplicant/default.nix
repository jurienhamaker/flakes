final: prev: {
    wpa_supplicant = cprev.wpa_supplicant.overrideAttrs (old: {
        patches = old.patches ++ [ ./nemo-avoid-segfault.patch ];
    });
}
