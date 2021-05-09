class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class AttributesBase
		{
			class Default;
			class Edit;
			class Combo;
			class Moduletooltip;
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
		scope = 1;
		scopeCurator = 1;
		canSetArea = 1;
		canSetAreaHeight = 1;
		canSetAreaShape = 1;
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 1;
		isDisposable = 0;
		is3DEN = 0;

		class AttributeValues {
			size3[] = {5, 5, 100};
		};
	};

	class GVAR(AddHeliQRFS): GVAR(Base) {
		displayName = "Add Helicopter QRFS";
		icon = "z\qrfs\addons\main\ui\icons\heli.paa";
		function = QFUNC(moduleAddHeliQRFS);
		scope = 2;
		scopeCurator = 2;

		class Attributes: AttributesBase {
			class Classname: Default {
				property = MVAR(classname);
				control = GVAR(HelicopterList);
				displayName = "Helicopter";
				tooltip = "What helicopter is used to transport the QRF";
				defaultValue = """O_Heli_Transport_04_bench_F""";
			};
			class Units: Default {
				property = MVAR(units);
				control = "EditMulti3";
				displayName = "Units";
				tooltip = "Classnames of the units that will be in each helicopter";
				defaultValue = "[""O_G_Soldier_SL_F"", ""O_G_medic_F"", ""O_G_Soldier_AR_F"", ""O_G_Soldier_M_F"", ""O_G_Soldier_LAT_F"", ""O_G_Soldier_A_F"", ""O_G_Soldier_F"", ""O_G_Soldier_F""]";
			};
			class TriggerTimeout: Default {
				property = MVAR(triggerTimeout);
				control = "Timeout";
			    displayName = "Trigger Timeout";
			    tooltip = "Time required for enemy units to be in the AO (in seconds)";
			    typeName = "ARRAY";
			    defaultValue = "[5, 5, 5]";
			};
			class Origin: Default {
				property = MVAR(origin);
				control = "EditShort";
				displayName = "Origin";
				tooltip = "Where does the helicopter come from in regards to the point, as a bearing? 'random' will do a random direction.";
				typeName = "STRING";
				defaultValue = """random""";
			};
			class Condition: Default {
				property = MVAR(condition);
				control = "EditCodeMulti5";
				displayName = "Condition";
				tooltip = "Condition for the qrf trigger to fire";
				typeName = "STRING";
				defaultValue = """this""";
				size = 5;
			};
			class SpawnDistance: Default {
				property = MVAR(spawnDistance);
				control = "DynSimDist";
				displayName = "Spawn Distance";
				tooltip = "How far away does the helicopter spawn?";
				defaultValue = "1500";
			};
			class LandingDistance: Default {
				property = MVAR(landingDistance);
				control = "DynSimDist";
				displayName = "Landing Distance";
				tooltip = "How far away does the helicopter land?";
				defaultValue = "100";
			};

			class ModuleDescription: ModuleDescription{}; // Module Description should be shown last
		};

		class ModuleDescription: ModuleDescription {
			description = "Quick Reaction Force Spawner";
			sync[] = {};

			class Curator_F {
				description[] = {
					"Spawns a Helicopter QRF team that descends down on the players in the zone.",
					"Can place as many of these as you want."
				};
				position = 1;
				direction = 1;
				size = 1;
				optional = 1;
				duplicate = 1;
				synced[] = {};
			}
		}
	};
};
