#include "script_component.hpp"
params ["_logic", "_synced", "_activated"];
if (!_activated || !isServer) exitWith {};

disableSerialization;
private _classname = _logic getVariable "classname";
private _units = _logic getVariable "units";
private _size = _logic getVariable "objectarea";
private _triggerTimeout = parseSimpleArray (_logic getVariable "triggertimeout");
private _origin = _logic getVariable "origin";
private _distance = _logic getVariable "distance";
private _landingDistance = _logic getVariable "landingDistance";
private _condition = _logic getVariable "condition";
private _position = getPos (_this select 0);
private _triggerArea = _logic getVariable "objectarea";
private _triggerTimeout = [(_triggerTimeout select 0), (_triggerTimeout select 1), (_triggerTimeout select 2), true];

/*
	Trigger Logic
*/
private _channel = "[playerSide, ""HQ""] commandChat";
private _qrfTrigger = createTrigger ["EmptyDetector", _position, true];
private _notificationTrigger = createTrigger ["EmptyDetector", _position, true];

private _antenna = createSimpleObject ["OmniDirectionalAntenna_01_black_F", _position];
_antenna setPosATL _position;
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

deleteVehicle _logic;
