#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "A3_Modules_F",
			"A3_Modules_F_Curator",
			"cba_common",
			"cba_events",
			"cba_main",
			"cba_settings",
			"cba_xeh"
        };
        author = "CryptikLemur";
        VERSION_CONFIG;
    };
};
