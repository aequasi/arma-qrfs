class CfgVehicles {
	class Logic;
	class Module_F : Logic {
		class AttributesBase
		{
			class Default;
			class Edit;					// Default edit box (i.e., text input field)
			class Combo;				// Default combo box (i.e., drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
			class MarkerText;
		};
        class ModuleDescription
        {
            class AnyBrain;
            class Curator_F;
        };
	};

	class GVAR(Base): Module_F {
		category = "qrfs_module";
		author = "CryptikLemur";
		displayName = "";
		icon = "";
		scope = 1;
		scopeCurator = 1;
		curatorCanAttach = 1;
		function = "";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		isDisposable = 0;
	};

	class GVAR(AddHeliQRFS) : GVAR(Base) {
		displayName = "Add Helicopter QRFS";
		icon = "z\qrfs\addons\main\ui\icons\heli.paa";
		category = "Supports";
		function = QFUNC(moduleAddHeliQRFS);
		scope = 2;
		scopeCurator = 2;

		class Arguments {
			class Side {
				displayName = "Side";
				description = "Support side";
				typeName = "NUMBER";
				class values {
					class BLUFOR {
						name = "BLUFOR";
						value = 0;
					};
					class OPFOR {
						default = 1;
						name = "OPFOR";
						value = 1;
					};
					class Independent {
						name = "Independent";
						value = 2;
					};
				};
			};
			class Classname {
				displayName = "Classname";
				description = "Classname of helicopter";
				typeName = "STRING";
				defaultValue = DEFAULT_VEHICLE_HELI;
			};
			class Dropoff {
				displayName = "Dropoff Style";
				description = "How should the units be dropped off";
				typeName = "NUMBER";
				class values {
					class Land {
						default = 1;
						name = "Land";
						value = 0;
					};
					class Fastrope {
						name = "Fastrope";
						value = 1;
					};
					class Parachute {
						name = "Parachute";
						value = 2;
					};
				};
			};
			class Count {
				displayName = "Number of Vehicles";
				description = "How many Vehicles with the QRF units will be sent";
				typeName = "NUMBER";
				defaultValue = DEFAULT_VEHICLE_COUNT;
			};
		};
	};
};