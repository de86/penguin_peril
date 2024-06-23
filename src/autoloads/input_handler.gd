extends Node


@export var _camera: Camera3D


func _ready():
	EventBus.camera_loaded.connect(_on_camera_loaded);


func _on_camera_loaded (camera: Camera3D):
	_camera = camera;


func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		if !_camera:
			Logger.error("Camera3D is not set");
			
			return;
		
		var world_pos = _camera.project_position(event.position, _camera.position.z)
		EventBus.player_attempted_move_to.emit(world_pos.x * 3.3) # TODO: Figure out why world_pos is so small
	elif event is InputEventMouseButton and event.pressed == true:
		EventBus.player_attempted_jump.emit()
