extends Node3D
class_name Player


@export var _move_speed := 3.0;
@export var _acceleration  := 0.01;
@export var _deceleration  := 0.05;
@export var _max_speed := 3.0;
@export var _sfx_player_jump: AudioStream;

@onready var _animations = %AnimationPlayer as AnimationPlayer;

var _target_x_position: float;
var _is_alive := true;
var _is_grounded := true;
var _start_position: Vector3;
var _x_velocity := 0.0;
var _x_movement_dead_zone := 0.025;


func _ready ():
	_start_position = Vector3(0, 0, -2);
	EventBus.player_attempted_move_to.connect(_on_player_attempted_move_to);
	EventBus.player_attempted_jump.connect(_on_player_attempted_jump);
	EventBus.game_restarted.connect(_on_game_restarted);
	EventBus.game_paused.connect(_on_game_paused);
	EventBus.game_unpaused.connect(_on_game_unpaused);


func _on_game_paused ():
	Utils.pause_branch(self);


func _on_game_unpaused ():
	Utils.unpause_branch(self);


func _physics_process (delta):
	if _is_alive and position.x != _target_x_position:
		_accelerate_towards(_target_x_position, delta);


func _accelerate_towards (target_x_position: float, delta: float):
	if abs(target_x_position - position.x) < _x_movement_dead_zone:
		_x_velocity = 0;
		
		return;
	
	var distance_to_target = target_x_position - position.x;
	var direction = sign(target_x_position - position.x);
	var target_speed = distance_to_target * _deceleration;
	target_speed = clamp(target_speed, -_max_speed * delta, _max_speed * delta);

	if direction != 0:
		_x_velocity += direction * _acceleration * delta
		_x_velocity = lerp(_x_velocity, target_speed, 0.1)
	
	position.x += _x_velocity;


func _on_player_attempted_move_to (target_x: float):
	_target_x_position = target_x;


func _on_player_attempted_jump ():
	if _is_alive and _is_grounded:
		_is_grounded = false;
		EventBus.play_sfx_requested.emit(_sfx_player_jump);
		_animations.play("jump"); 


# Called in jump animation
func _ground_player ():
	_is_grounded = true;


func _on_collision_shape_3d_area_entered (area: Area3D):
	if not _is_alive: return;
	
	var area_owner = area.get_parent();
	if not area_owner is LaneItem: return;
	
	area_owner = area_owner as LaneItem;
	EventBus.lane_item_hit_player.emit(area_owner);
	
	var laneItemData = area_owner.get_data();
	if laneItemData is LaneItemData and laneItemData.is_collectible:
		EventBus.collectable_collected.emit(laneItemData);
		return;
	
	if laneItemData is LaneItemData and not laneItemData.is_collectible:
		_kill_player();
		return;


func _kill_player ():
	if not _is_alive: return;
	
	_is_alive = false;
	_animations.play("die");
	EventBus.player_died.emit();


func _on_game_restarted ():
	_reset();


func _reset ():
	print("Player Reset")
	_animations.play("RESET");
	_is_alive = true;
	_is_grounded = true;
	global_position = _start_position;
