#include "script_component.hpp"
params ["_logic", "_synced", "_activated"];
if (!_activated || !isServer) exitWith {};

systemChat "Loading QFRS";
disableSerialization;
private _side = east;
private _classname = _logic getVariable "classname";
private _dropoff = _logic getVariable "dropoff";
private _count = _logic getVariable "count";
private _units = parseSimpleArray (_logic getVariable "units");
private _size = _logic getVariable "objectarea";
private _triggerTimeout = parseSimpleArray (_logic getVariable "triggertimeout");
private _origin = _logic getVariable "origin";
private _distance = _logic getVariable "distance";
private _landingDistance = _logic getVariable "landingDistance";
private _condition = _logic getVariable "condition";
private _position = getPos (_this select 0);
private _triggerArea = _logic getVariable "objectarea";
private _triggerTimeout = [(_triggerTimeout select 0), (_triggerTimeout select 1), (_triggerTimeout select 2), true];

QRFS_LOG_FULL_4("Module: %1, Player: %2 - %3. Condition %4", _position, getPos player, _triggerArea, _condition);

/*
	Trigger Logic
*/
private _channel = "[playerSide, ""HQ""] commandChat";
private _qrfTrigger = createTrigger ["EmptyDetector", _position, true];
private _notificationTrigger = createTrigger ["EmptyDetector", _position, true];

// _qrfTrigger synchronizeObjectsAdd (group player);
_qrfTrigger triggerAttachVehicle _synced;
_notificationTrigger triggerAttachVehicle _synced;

QRFS_LOG_FULL_1("Trigger Area: %1", _triggerArea);
_qrfTrigger setTriggerArea [5, 5, 0, false, 15]; //_triggerArea;
_notificationTrigger setTriggerArea [5, 5, 0, false, 15]; //_triggerArea;

_qrfTrigger setTriggerTimeout _triggerTimeout;

_qrfTrigger setTriggerActivation ["GROUP", "PRESENT", true];
_notificationTrigger setTriggerActivation ["GROUP", "PRESENT", true];

_notificationTrigger setTriggerStatements [
	// Condition
	_condition,
	// On Activate
	format ["%1 ""You are in danger of having QRFs called in!"";", _channel],
	// On Deactivate
	format ["%1 ""You are no longer in danger of having QRFs called in."";", _channel]
];

private _exec = format [
	"[(thisList select 0), %1, ""%2"", %3, %4, ""%5"", %6, %7] call qrfs_module_fnc_follow;",
	_side,
	_classname,
	_units,
	_count,
	_origin,
	_distance,
	_landingDistance
];
_qrfTrigger setTriggerStatements [
    // Condition
    _condition,
    // On Activate
	format [
		"%1 ""A QRF has been called to your location."";
%2",
		_channel,
		_exec
	],
    // On Deactive
    ""
];

/*
 	End Trigger Logic
*/

deleteVehicle _logic;
