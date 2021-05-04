#include "script_component.hpp"

class CfgPatches {
    class qrsf_module {
        name = QUOTE(COMPONENT);
        units[] = {
            QGVAR(AddHeliQRFS),
        };
        requiredAddons[] = {
            "A3_Modules_F",
			"A3_Modules_F_Curator",
			"cba_common",
			"cba_events",
			"cba_main",
			"cba_settings",
			"cba_xeh",
            "qrfs_main"
        };
        author = "CryptikLemur";
    };
};

#include "CfgEventHandlers.hpp"

class CfgFactionClasses {
    class qrfsBase;
    class qrfs_module: qrfsBase {
        priority = 2;
        side = 7;
        displayName = "Quick Reaction Force Spawner";
    };
};

#include "CfgVehicles.hpp"
