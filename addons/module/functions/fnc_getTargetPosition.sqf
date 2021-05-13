#include "script_component.hpp"

params ["_tPos", "_distance", "_dir", "_type"];
if (isNil("REKA60padArray")) then {
	REKA60padArray = [];
};

private _targetPos = _tPos getPos [_distance, _dir];
private _finding = 1;
while {_finding > 0} do {
		_targetPos = [_targetPos, _type] call FUNC(getBestPosition);
		_e1 = 0;
		_finding = 0;

		while {_e1 < (count REKA60padArray)} do {
				if (((REKA60padArray select _e1) distance _targetPos) < 15) then {
					_finding = 1;
				};
				_e1 = _e1 + 1;
		};
};
REKA60padArray set [(count REKA60padArray), _targetPos];

_targetPos
