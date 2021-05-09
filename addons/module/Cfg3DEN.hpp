class Cfg3DEN {
	class Attributes {
		class Default;
        class Title: Default {
        	class Controls {
        		class Title;
        	};
        };
		class Combo: Title {
			class Controls: Controls {
				class Title: Title {};
				class Value;
			};
			class Value;
		};
		class GVAR(HelicopterList): Combo {
			control = GVAR(HelicopterList);
			class Controls: Controls {
				class Title: Title {};
				class Value: Value {
					h = "6 * (pixelH * pixelGrid * 	0.50)";
					onload = "_control = _this select 0;\
{\
	if (getNumber (_x >> ""scope"") != 2) then {continue};\
	_class = configName _x;\
	if (!(_class isKindOf ""Helicopter"")) then {continue};\
	if (getNumber (_x >> ""side"") != 0) then {continue};\
	_cfg = (configFile >> ""CfgVehicles"" >> _class);\
	_num = count(""if ( isText(_x >> 'proxyType') && { getText(_x >> 'proxyType') isEqualTo 'CPCargo' } ) then {true};""configClasses ( _cfg >> ""Turrets"" )) + getNumber ( _cfg >> ""transportSoldier"" );\
	if (_num <= 0) then {continue};\
\
	_lbadd = _control lbadd gettext (_x >> 'displayname');\
	_control lbsetdata [_lbadd, _class];\
	_control lbsetpicture [_lbadd,gettext (_x >> 'picture')];\
	_dlcLogo = if (configsourcemod _x == '') then {''} else {modParams [configsourcemod  _x,['logo']] param [0,'']};\
	if (_dlcLogo != '') then {\
		_control lbsetpictureright [_lbadd,_dlcLogo];\
	};\
} foreach configProperties [configfile >> 'CfgVehicles','isClass _x'];\
lbsort _control;";
				};
			};
		};
	};
};
