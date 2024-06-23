extends Camera3D


func _ready ():
	EventBus.camera_loaded.emit(self);
