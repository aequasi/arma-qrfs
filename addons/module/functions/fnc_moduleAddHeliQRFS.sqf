#include "script_component.hpp"
[{
	params ["_logic"];
	private _position = getPos _logic;
	disableSerialization;
	if (isNull (findDisplay 312)) then {
    	if (!isServer) exitWith {};

    	// 3den
    	private _classname = _logic getVariable "classname";
    	private _units = _logic getVariable "units";
    	private _size = _logic getVariable "objectarea";
    	private _triggerTimeout = parseSimpleArray (_logic getVariable "triggertimeout");
    	private _origin = _logic getVariable "origin";
    	private _distance = _logic getVariable "distance";
    	private _landingDistance = _logic getVariable "landingDistance";
    	private _condition = _logic getVariable "condition";
    	private _triggerArea = _logic getVariable "objectarea";
    	private _triggerTimeout = [(_triggerTimeout select 0), (_triggerTimeout select 1), (_triggerTimeout select 2), true];

    	/*
    		Trigger Logic
    	*/
    	private _channel = "[playerSide, ""HQ""] commandChat";
    	private _qrfTrigger = createTrigger ["EmptyDetector", _position, true];
    	private _notificationTrigger = createTrigger ["EmptyDetector", _position, true];

    	if (count _synced > 0) then {
    		_qrfTrigger triggerAttachVehicle _synced;
    		_notificationTrigger triggerAttachVehicle _synced;
    		_qrfTrigger setTriggerActivation ["GROUP", "PRESENT", true];
    		_notificationTrigger setTriggerActivation ["GROUP", "PRESENT", true];
    	} else {
    		_qrfTrigger setTriggerActivation ["WEST", "PRESENT", true];
    		_notificationTrigger setTriggerActivation ["WEST", "PRESENT", true];
    	};

    	_qrfTrigger setTriggerArea _triggerArea;
    	_notificationTrigger setTriggerArea _triggerArea;

    	_qrfTrigger setTriggerTimeout _triggerTimeout;

    	_notificationTrigger setTriggerStatements [
    		// Condition
    		_condition,
    		// On Activate
    		format ["%1 ""You are in danger of having QRFs called in!"";", _channel],
    		// On Deactivate
    		format ["%1 ""You are no longer in danger of having QRFs called in."";", _channel]
    	];

    	_qrfTrigger setTriggerStatements [
    		// Condition
    		_condition,
    		// On Activate
    		format [
    			"%1 ""A QRF has been called to your location."";
    	[(thisList select 0), ""%2"", %3, ""%4"", %5, %6] call qrfs_module_fnc_callInHeliQRF;",
    			_channel,
    			_classname,
    			_units,
    			_origin,
    			_distance,
    			_landingDistance
    		],
    		// On Deactive
    		""
    	];

    	/*
    		End Trigger Logic
    	*/
    } else {
    	if (!local _logic) exitWith {};
    	private _heliClasses = [];
    	private _unitClasses = [];
    	private _numCargo = [];
        {
            if (getNumber (_x >> "scope") != 2) then {continue};

            private _class = configName _x;

            if (_class isKindOf "CAManBase" && {getNumber (_x >> "side") == 0}) then {
                _unitClasses pushBack _class;
            };
            if (_class isKindOf "Helicopter" && {getNumber (_x >> "side") == 0}) then {
                _heliClasses pushBack _class;
				private _cfg = (configFile >> "CfgVehicles" >> _class);
				private _num = count("if ( isText(_x >> 'proxyType') && { getText(_x >> 'proxyType') isEqualTo 'CPCargo' } ) then {true};"configClasses ( _cfg >> "Turrets" )) + getNumber ( _cfg >> "transportSoldier" );

				_numCargo pushBack _num;
            };
        } forEach configProperties [configFile >> "CfgVehicles","isClass _x"];

    	[
    		"Add Heli QRF",
    		[
				[
					"COMBOBOX",
					"Class Name",
					[
						_heliClasses apply { [getText (configFile >> "CfgVehicles" >> _x >> "displayName"), _x]},
						_heliClasses find "O_Heli_Transport_04_bench_F"
					]
				],
				["EDITBOX", "Origin", "random"],
				["SLIDER", "Distance", [[300, 2000, 100], 1500]],
				["SLIDER", "Landing Distance", [[0, 1000, 10], 300]]
			],
			{
				params ["_values", "_custom"];
				_custom params ["_position", "_unitClasses", "_heliClasses", "_numCargo"];
				_values params ["_classnameIndex", "_origin", "_distance", "_landingdistance"];

				[
					"Add Heli QRF",
					[
						[
							"CARGOBOX",
							"Units",
							[
								_unitClasses apply { [getText (configFile >> "CfgVehicles" >> _x >> "displayName"), _x]},
								8,
								_numCargo select _classnameIndex
							]
						]
					],
					{
						params ["_values", "_custom"];
						_custom params ["_position", "_classname", "_origin", "_distance", "_landingDistance"];
						_values params ["_units"];

						[_position, _classname, _units, _origin, _distance, _landingDistance] call qrfs_module_fnc_callInHeliQRF;
						ZEUS_MESSAGE("QRF Spawned");
					},
					[_position, _heliClasses select _classnameIndex, _origin, _distance, _landingDistance]
				] call qrfs_sdf_fnc_dialog;
			},
			[_position, _unitClasses, _heliClasses, _numCargo]
		] call qrfs_sdf_fnc_dialog;
    };

    deleteVehicle _logic;
}, _this] call CBA_fnc_directCall;



