#include "script_component.hpp"
private["_module","_units","_activated"];
_module=_this select 0;
_units=_this select 1;
_activated=_this select 2;
params ["_logic"];

systemChat "Loading QFRS";
disableSerialization;
private _sideList = [east, west, independent];
private _side = _sideList select (_logic getVariable "side");
private _classname = _logic getVariable "classname";
private _dropoff = _logic getVariable "dropoff";
private _count = _logic getVariable "count";
private _units = _logic getVariable "units";
private _size = parseSimpleArray (_logic getVariable "size");
private _triggerTimeout = parseSimpleArray (_logic getVariable "triggertimeout");
private _position = getPos (_this select 0);

QRFS_LOG_FULL_1("Type: %1", typeName _size);
private _triggerArea = [
	(_size select 0),
	(_size select 1),
	0,
	false,
	(_size select 2)
];
QRFS_LOG_FULL_3("Position: %1. Size: %2. Trigger Area: %3", _position, _size, _triggerArea);
private _triggerTimeout = [(_triggerTimeout select 0), (_triggerTimeout select 1), (_triggerTimeout select 2), true];
QRFS_LOG_FULL_2("Trigger Area %1. Trigger Timeout %2", _triggerArea, _triggerTimeout);

/*
	Trigger Logic
*/
private _qrfTrigger = createTrigger ["EmptyDetector", _position, true];
private _notificationTrigger = createTrigger ["EmptyDetector", _position, true];

_qrfTrigger setTriggerArea _triggerArea;
_notificationTrigger setTriggerArea _triggerArea;

_qrfTrigger setTriggerTimeout _triggerTimeout;

_qrfTrigger setTriggerActivation ["WEST", "PRESENT", true];
_notificationTrigger setTriggerActivation ["WEST", "PRESENT", true];

_notificationTrigger setTriggerStatements [
	// Condition
	"this",
	// On Activate
	"hint 'You are in QRF Range'",
	// On Deactivate
	"hint 'You are out of QRF Range'"
];
_qrfTrigger setTriggerStatements [
    // Condition
    "this", // @todo Replace with _condition variable from config
    // On Activate
    "hint 'QRF Called In!'",
    // On Deactive
    "hint 'QRF Finished?'"
];
/*
 	End Trigger Logic
*/


QRFS_LOG_FULL_4("Spawning %1 %2 in %3 %4", _side, _units, _count, _classname);

deleteVehicle _logic;
