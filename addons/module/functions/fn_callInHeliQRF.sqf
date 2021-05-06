/*
	Heavily inspired by: ARMA3Alpha REINFORCEMENT CHOPPER SCRIPT v3.5 - by SPUn / Kaarto Media

				Spawns chopper which transports infantry group to position and leaves after that

		Calling the script:

			default: 		nul = [this] execVM "LV\reinforcementChopper.sqf";
			custom: 		nul = [spot,exact,side,type,captive,patrol,target,direction,distance,precise,
								cycle,groupSize,skills,smoke,group,custom init,ID,MP,doors,classes] execVM "LV\reinforcementChopper.sqf";

	Parameters:

	spot 	= 	landing spot 	(name of marker or object or unit, or position array) 									DEFAULT: this
	exact 	= 	true or false 	(true = tries landing exactly on *spot, false = finds place where it fits) 				DEFAULT: true
	side 	= 	1 or 2 or 3		(1 = west, 2 = east, 3 = independent)													DEFAULT: 2
	type 	= 	string																									DEFAULT: O_Heli_Light_02_v2_F
	captive = 	true/false 		(if true, enemies wont notice them before chopper has landed) 							DEFAULT: false
	patrol 	= 	true/false 		(if false, units wont patrol in any way <- handy if you set (group player) as *group) 	DEFAULT: true
	target 	= 	patrol target 	(patrolling target for infantry group, options:											DEFAULT: player
								unit 	= 	units name, ex: enemyunit1
								marker 	= 	markers' name, ex: "marker01" (remember quotes with markers!)
								marker array = array of markers in desired order, ex: ["marker01","marker02","marker03"]
								group	= 	groups name, ex: (group enemy1)	OR BlueGroup17
								group array, ex: [(group player), (group blue2)]
								["PATROL",center position,radius] = uses patrol-vD.sqf, ex: ["PATROL",(getPos player),150]
	direction 	= 	"random" or 0-360 (direction where chopper comes from, use quotes with random!) 									DEFAULT: "random"
	distance 	= 	number (from how far KA60 comes from) 																				DEFAULT: 1500
	precise 	= 	true or false (true = heli will land even in middle of war, false = heli might have air fights etc before landing) 	DEFAULT: true
	cycle 		= 	true or false (if true and target is array of markers, unit will cycle these markers) 								DEFAULT: false
	groupSize 	= 	1-8 (infantry groups' size) 																						DEFAULT: 8
	skills 		= 	"default" 	(default AI skills) 																					DEFAULT: "default"
				or	number	=	0-1.0 = this value will be set to all AI skills, ex: 0.8
				or	array	=	all AI skills invidiually in array, values 0-1.0, order:
						[aimingAccuracy, aimingShake, aimingSpeed, spotDistance, spotTime, courage, commanding, general, endurance, reloadSpeed]
						ex: 	[0.75,0.5,0.6,0.85,0.9,1,1,0.75,1,1]
	smoke		=	[LZ smoke, cover smokes, flare, chemlights] (if chopper uses these on landing spot)									DEFAULT: [false,false,false,false]
	group 		= 	group name OR nil (if you want units in existing group, set it here. if this is left empty, new group is made) 		DEFAULT: nil
	custom init = 	"init commands" (if you want something in init field of units, put it here) 										DEFAULT: nil
					NOTE: Keep it inside quotes, and if you need quotes in init commands, you MUST use ' or "" instead of ",
						 ex: "hint 'this is hint';"
	ID 			= 	number (if you want to delete units this script creates, you'll need ID number for them)							DEFAULT: nil
	MP			= 	true/false	true = 'landing spot' will automatically be one of alive non-captive players							DEFAULT: false
	doors		=	true/false	true = units will close doors behind them while patrolling												DEFAULT: false
	classes		=	array	(classes from config_aissp.hpp, defines which unit classnames are being used)								DEFAULT: ["ALL"]

	EXAMPLE: 	nul = [player,false,2,3,false,true,player,"random",1000,true,false,8,0.75,[false,true,false,true],nil,nil,33,false,false,["ALL"]] execVM "LV\reinforcementChopper.sqf";
*/
if (!isServer) exitWith {};

// Example [(thisList select 0), _side, _heli, _units, _count, _origin, _distance, _landingDistance] execVM QFUNC(callInHeliQRF);
private _tPos = param [0] select 0;
private _side = param [1,2];
private _heliT = param [2];
private _units = param [3];
private _count = param [4];
private _origin = param [5];
private _distance = param [6];
private _landingDistance = param [7];
private _grpSize = count _units;
private _targetMarker = param [0] select 0;

private ["_dir", "_grp1", "_grp2", "_hq", "_e1", "_vehSpots", "_man"];

if (typeName _direction == "STRING") then {
	_dir = random 360;
} else {
	_dir = _direction;
};

private _targetPos = _tPos getPos [_landingDistance, _direction];

//Side related group creation:
switch (_side) do {
	case 1:{
		_hq = createCenter west;
		_grp1 = createGroup west;
		_grp2 = createGroup west;
	};
	case 2:{
		_hq = createCenter east;
		_grp1 = createGroup east;
		_grp2 = createGroup east;
	};
	case 3:{
		_hq = createCenter resistance;
		_grp1 = createGroup resistance;
		_grp2 = createGroup resistance;
	};
};
private _men = "O_helipilot_F";

// Find landing spot which is not close another ones:
//THIS block is fixed by GITS, now choppers should land!
//yet another fix by SPUn
if (isNil("REKA60padArray")) then {
	REKA60padArray = [];
};
private _finding = 1;
private _ra = 0;//here
while {_finding > 0} do {
		_tPos = [];
		while {count _tPos < 1} do {
				_tPos = [_targetPos,0,(50+_ra),8,0,0.4,0] call BIS_fnc_findSafePos;
				_ra = _ra + 10;//here
		};

		sleep 0.03;
		_targetPos = _tPos;
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

private _heliPad = createVehicle ["Land_helipadEmpty_F", _targetPos, [], 0, "NONE"];

private _range = _distance;
private _pos = [(_targetPos select 0) + (sin _dir) * _range, (_targetPos select 1) + (cos _dir) * _range, 0];
private _heli = createVehicle [_heliT, _pos, [], 0, "FLY"];
private _cfg = (configFile >> "CfgVehicles" >> _heliT);
private _numCargo = count("if ( isText(_x >> 'proxyType') && { getText(_x >> 'proxyType') isEqualTo 'CPCargo' } ) then {true};"configClasses ( _cfg >> "Turrets" )) + getNumber ( _cfg >> "transportSoldier" );

if (_grpSize > _numCargo) then {
	_vehSpots = _numCargo;
} else {
	_vehSpots = _grpSize;
};

_man = _grp1 createUnit [_men, _pos, [], 0, "NONE"];
_man moveInDriver _heli;
_man setUnitRank "SERGEANT";

[_man, _heli, _targetPos] spawn {
	private ["_man", "_heli", "_targetPos"];
	_man = _this select 0;
	_heli = _this select 1;
	_targetPos = _this select 2;
	waitUntil {sleep 1; !isNil "_man" && !isNil "_heli"};
	waitUntil {sleep 1; !alive _man || !canMove _heli || isNil "_man" || isNil "_heli"};
	if (true) exitWith {
		if (!isNil "_targetPos" && !isNil "REKA60padArray") then {
			if ((_heli distance _targetPos) > 50) then {
				REKA60padArray = REKA60padArray - [_targetPos];
			};
		};
		if (_heli distance _targetPos > 200) then {
			sleep 15;
			deleteVehicle _man;
			sleep 15;
			deleteVehicle _heli;
		};
	};
};

private _i = 1;
for "_i" from 1 to _vehSpots do {
	private ["_man1", "_man2"];
	_man1 = _units select i;
	_man2 = _grp2 createUnit [_man1, _pos, [], 0, "NONE"];
	_man2 moveInCargo _heli;
};

_heli doMove _targetPos;
while { _heli distance _targetPos > 260 } do { sleep 4; };
(driver _heli) setBehaviour "CARELESS";
//while {!(unitReady _heli)}do{sleep 2;};
doStop _heli;
_heli disableAI "TARGET";_heli disableAI "AUTOTARGET";_heli allowFleeing 0;_heli setBehaviour "CARELESS";
_heli land "LAND"; //you can also try "GET OUT" (then it wont land, only hovers)
while { (getPos _heli) select 2 > 7 } do { sleep 2; };
_heli setFuel 0;

while { (getPos _heli) select 2 > 1 } do { sleep 1; };

_grp2 leaveVehicle _heli;
{
	unassignVehicle _x;
	doGetOut _x;
	_x setBehaviour "AWARE";
} forEach units _grp2;
_grp2 setCombatMode "RED";
while { (count (crew _heli)) > 1 } do { sleep 2;  };
_heli doMove _pos;

if (alive _heli) then {
	_heli setFuel 1;
};

{
	_x setVariable ["target0",_targetMarker,false];
	_x setVariable ["mDis0", 1000, false];
	nul = [_x] call qrfs_module_fnc_follow;
} forEach units _grp2;

while { (_heli distance _pos > 200) } do { sleep 4; };

if (((_heli distance _targetPos) > 50)) then {
	REKA60padArray = REKA60padArray - [_targetPos];
};

if ((_heli distance _pos < 200)) exitWith {
	deleteVehicle _man;
	deleteVehicle _heli;
	waituntil {
		sleep 1;
		(count units _grp1) == 0
	};
    deletegroup _grp1;
};
