
params ["_targetPosition", "_type"];
private _radius = param [2, 40];

private _tPos = [];

while {count _tPos < 1} do {
	_radius = _radius + 10;
	if (_type == "land") then {
		private _road = [_targetPosition, _radius] call BIS_fnc_nearestRoad;
		if (!isNull _road) then {
			_tPos = getPos _road;
			if (_tPos isEqualTo objNull) then {
				_tPos = [];
			};
		};
	};

	if (_type == "air") then {
		_tPos = [_targetPosition, 0, (_radius), 8, 0, 0.2, 0] call BIS_fnc_findSafePos;
		if (_tPos isEqualTo objNull) then {
			_tPos = [];
		};
	};
};

_tPos
