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
		scope = 2;
		scopeCurator = 1;
		curatorCanAttach = 1;
		function = "";
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		isDisposable = 0;
		canSetArea = 1;

		class AttributeValues {
			size3[] = {5, 5, 100};
		}
	};

	class GVAR(AddHeliQRFS) : GVAR(Base) {
		displayName = "Add Helicopter QRFS";
		icon = "z\qrfs\addons\main\ui\icons\heli.paa";
		category = "Supports";
		function = QFUNC(moduleAddHeliQRFS);
		scope = 2;
		scopeCurator = 1;

		class Arguments {
			class Classname {
				displayName = "Classname";
				description = "Classname of helicopter";
				typeName = "STRING";
				defaultValue = "O_Heli_Transport_04_bench_F";
			};
			class Units {
				displayName = "Units";
				description = "Classnames of the units that will be in each helicopter";
				typeName = "STRING";
				defaultValue = "[""O_G_Soldier_SL_F"", ""O_G_medic_F"", ""O_G_Soldier_AR_F"", ""O_G_Soldier_M_F"", ""O_G_Soldier_LAT_F"", ""O_G_Soldier_A_F"", ""O_G_Soldier_F"", ""O_G_Soldier_F""]";
			};
			class TriggerTimeout {
			    displayName = "Trigger Timeout";
			    description = "Time required for enemy units to be in the AO ([mid, min, max])";
			    typeName = "ARRAY";
			    defaultValue = "[5, 5, 5]";
			};
			class Origin {
				displayName = "Origin";
				description = "Where does the helicopter come from in regards to the point, as a bearing? 'random' will do a random direction.";
				typeName = "STRING";
				defaultValue = "random";
			};
			class Distance {
				displayName = "Distance";
				description = "How far away does the helicopter spawn?";
				typeName = "NUMBER";
				defaultValue = 1500;
			};
			class LandingDistance {
				displayName = "Landing Distance";
				description = "How far away does the helicopter land?";
				typeName = "NUMBER";
				defaultValue = 100;
			};
			class Condition {
				displayName = "Condition";
				description = "Condition for the qrf trigger to fire";
				typeName = "STRING";
				defaultValue = "this";
			};
		};
	};
};
