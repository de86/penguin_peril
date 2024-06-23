extends Node


var _ERROR = "ERROR";
var _WARN = "WARNING";
var _INFO = "INFO";
var _DEBUG = "DEBUG";


# Called when the node enters the scene tree for the first time.
func error(message: Variant):
	_print(_ERROR, message);

func warn(message: Variant):
	_print(_WARN, message);

func info(message: Variant):
	_print(_INFO, message);

func debug(message: Variant):
	_print(_DEBUG, message);

func _print(level: String, message: Variant):
	if not message is String:
		message = str(message);
	
	print("[%s] %s" % [level, message]);
