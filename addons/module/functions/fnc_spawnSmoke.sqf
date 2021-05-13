#include "script_component.hpp"

[{
	params ["_targetPos", "_distance"];
	private _a = 0;
	private _timesLimit = ceil(_distance / 1000);
	while {_a < _timesLimit} do {
		_smoke1 = "SmokeShellGreen" createVehicle _targetPos;
		sleep 50;
		_a = _a + 1;
	};
}, this] call CBA_fnc_directCall;
