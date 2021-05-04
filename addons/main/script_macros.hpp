#define DEBUG_SYNCHRONOUS
#define DEBUG_ENABLED_MODULE true
#define DEBUG_SETTINGS_MODULE true
#include "\x\cba\addons\main\script_macros_common.hpp"

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#define QFRS_CHAT(MESSAGE) \
	private _logMessage = format ["QRFS - %1",MESSAGE]; \
	systemChat _logMessage;
#define QRFS_LOG(MESSAGE) \
	private _logMessage = format ["QRFS - %1",MESSAGE]; \
	diag_log _logMessage;
#define QRFS_LOG_FULL(MESSAGE) \
	private _logMessage = format ["QRFS - %1",MESSAGE]; \
	diag_log _logMessage; \
	systemChat _logMessage;

#define QRFS_LOG_1(MESSAGE,ARG1) 								QRFS_LOG(FORMAT_1(MESSAGE,ARG1))
#define QRFS_LOG_2(MESSAGE,ARG1,ARG2) 							QRFS_LOG(FORMAT_2(MESSAGE,ARG1,ARG2))
#define QRFS_LOG_3(MESSAGE,ARG1,ARG2,ARG3) 						QRFS_LOG(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define QRFS_LOG_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) 					QRFS_LOG(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define QRFS_LOG_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) 			QRFS_LOG(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))
#define QRFS_LOG_FULL_1(MESSAGE,ARG1) 							QRFS_LOG_FULL(FORMAT_1(MESSAGE,ARG1))
#define QRFS_LOG_FULL_2(MESSAGE,ARG1,ARG2) 						QRFS_LOG_FULL(FORMAT_2(MESSAGE,ARG1,ARG2))
#define QRFS_LOG_FULL_3(MESSAGE,ARG1,ARG2,ARG3) 					QRFS_LOG_FULL(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define QRFS_LOG_FULL_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) 			QRFS_LOG_FULL(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define QRFS_LOG_FULL_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) 		QRFS_LOG_FULL(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))
#define QRFS_ERROR(MESSAGE) 										QRFS_LOG_FULL(FORMAT_1("Error: %1",MESSAGE))
#define QRFS_ERROR_1(MESSAGE,ARG1) 								QRFS_ERROR(FORMAT_1(MESSAGE,ARG1))
#define QRFS_ERROR_2(MESSAGE,ARG1,ARG2) 							QRFS_ERROR(FORMAT_2(MESSAGE,ARG1,ARG2))
#define QRFS_ERROR_3(MESSAGE,ARG1,ARG2,ARG3) 					QRFS_ERROR(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define QRFS_ERROR_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) 				QRFS_ERROR(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define QRFS_ERROR_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) 			QRFS_ERROR(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))
#define QRFS_WARNING(MESSAGE) 									QRFS_LOG_FULL(FORMAT_1("Warning: %1",MESSAGE))
#define QRFS_WARNING_1(MESSAGE,ARG1) 							QRFS_ERROR(FORMAT_1(MESSAGE,ARG1))
#define QRFS_WARNING_2(MESSAGE,ARG1,ARG2) 						QRFS_ERROR(FORMAT_2(MESSAGE,ARG1,ARG2))
#define QRFS_WARNING_3(MESSAGE,ARG1,ARG2,ARG3) 					QRFS_ERROR(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define QRFS_WARNING_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) 				QRFS_ERROR(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define QRFS_WARNING_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) 		QRFS_ERROR(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))

#define ZEUS_MESSAGE(MESSAGE) [objNull,MESSAGE] call BIS_fnc_showCuratorFeedbackMessage

#define VEHICLE_TYPE_HALO "halo"
#define VEHICLE_TYPE_HELI "heli"
#define VEHICLE_TYPE_PLANE "plane"
#define VEHICLE_TYPE_CAR "car"
#define VEHICLE_TYPE_NONE "none"

#define DEFAULT_SIDE 2
#define DEFAULT_VEHICLE_COUNT 1

#define DEFAULT_VEHICLE_HELI "O_Heli_Light_02_dynamicLoadout_F"

#define DEFAULT_VEHICLE_BEHAVIOR "combat"
#define DEFAULT_VEHICLE_SPEED "full"
#define DEFAULT_VEHICLE_FORMATION "diamond"
#define DEFAULT_VEHICLE_FLIGHT_HEIGHT 50

#define DEFAULT_UNIT_BEHAVIOR "combat"
#define DEFAULT_UNIT_SPEED "full"
#define DEFAULT_UNIT_FORMATION "diamond"
#define DEFAULT_UNIT_FLIGHT_HEIGHT 50
#define DEFAULT_UNIT_WAYPOINT "search_and_destroy"

#define DEFAULT_VEHICLE_ORIGIN "random"
#define DEFAULT_VEHICLE_FINISHED_BEHAVIOR "rtb"

#define DEFAULT_QRFS_COOLDOWN 900

#define DEFAULT_MODULE_CONDITION "true"
#define DEFAULT_TASK_TITLE "A QRFS has been called in!"
#define DEFAULT_TASK_ICON "attack"
#define DEFAULT_QRFS_DESPAWN_TIME 1800

#define DEFAULT_NOTIFICATION_CHANNEL "command"
#define DEFAULT_NOTIFICATION_MESSAGE_ENTER_ZONE "You are in danger of having QRFs called in!"
#define DEFAULT_NOTIFICATION_MESSAGE_LEAVE_ZONE "You are no longer in danger of having QRFs called in."
#define DEFAULT_NOTIFICATION_MESSAGE_CALLED "A QRFS has been called to your location."
#define DEFAULT_NOTIFICATION_TRIGGER_DISABLED "We've taken out their ability to call in QRFs."

#define GLOBAL_QRFS_ENABLED true