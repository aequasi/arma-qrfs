#include "script_component.hpp"

if (!isServer) exitWith {};
private ["_enemies", "_aware", "_enemy"];
params ["_units", "_area", "_side"];

if (count _units == 0) exitWith {false};

_enemies = [allUnits, {side _x == _side && _x inArea _area}] call BIS_fnc_conditionalSelect;
if (count _enemies <= 0) exitWith {false};

_aware = [_enemies, { _enemy = _x; count ([_units, {_enemy knowsAbout _x > 0}] call BIS_fnc_conditionalSelect) > 0 }] call BIS_fnc_conditionalSelect;

if (true) exitWith{count _aware > 0};
