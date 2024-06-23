extends Node3D

@export_group("Scenes")
@export var _lane_item_scene: PackedScene;
@export var _tree_scene: PackedScene;

@export_group("Obstacle Lane Item Data")
@export var _collectable_star_lane_item_data: LaneItemData;

@export_group("Collectable Lane Item `data")
@export var _obstacle_rock_lane_item_data: LaneItemData;

@onready var _spawn_timer = %SpawnTimer as Timer;
@onready var _scenery_spawn_timer = %ScenerySpawnTimer as Timer;
@onready var _obastacle_spawn_positions = [
	%SpawnLaneLeft,
	%SpawnLaneCenter,
	%SpawnLaneRight
]
@onready var _scenery_spawn_position_left = %SceneryLaneLeft;
@onready var _scenery_spawn_position_right = %SceneryLaneRight;

var _scenery_spawn_offset_range = 0.3;
var _spawn_count = 0;


func _ready ():
	_spawn_timer.timeout.connect(_spawn);
	_scenery_spawn_timer.timeout.connect(_spawn_scenery);


func _spawn ():
	if _spawn_count > 0 and _spawn_count % 3 == 0:
		_spawn_lane_item(_collectable_star_lane_item_data);
	
	_spawn_lane_item(_obstacle_rock_lane_item_data);
	_spawn_count += 1;


func _spawn_lane_item (lane_item_data: LaneItemData):
	var lane_item = _lane_item_scene.instantiate().with_data(lane_item_data) as LaneItem;
	add_child(lane_item);
	var lane = _obastacle_spawn_positions.pick_random();
	lane_item.global_position = Vector3(lane.position.x, position.y, position.z);
	lane_item.global_rotation = Vector3.ZERO;


func _spawn_scenery ():
	_spawn_in_scenic_lane(_tree_scene, _scenery_spawn_position_left);
	_spawn_in_scenic_lane(_tree_scene, _scenery_spawn_position_right);


func _spawn_in_scenic_lane (scene: PackedScene, lane: Marker3D):
	var obstacle = scene.instantiate() as Node3D;
	add_child(obstacle);
	var offset = randf_range(-_scenery_spawn_offset_range, _scenery_spawn_offset_range);
	obstacle.global_position = Vector3(lane.position.x + offset, position.y, position.z);
	var rotation_offset = randi_range(0, 180);
	obstacle.global_rotation = Vector3(0, rotation_offset, 0);


