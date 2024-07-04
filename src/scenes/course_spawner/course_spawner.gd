extends Node3D

@export_group("Scenes")
@export var _lane_item_scene: PackedScene;
@export var _tree_scene: PackedScene;

@export_group("Lane Items")
@export var _collectable_lane_items: Array[LaneItemData];
@export var _obstacle_lane_items: Array[LaneItemData];

@export_group("Spawn Interval Settings")
@export var _starting_spawn_interval: float
@export var _min_spawn_interval: float
@export var _spawn_interval_reduction: float

@onready var _spawn_timer = %SpawnTimer as Timer;
@onready var _scenery_spawn_timer = %ScenerySpawnTimer as Timer;
@onready var _obastacle_spawn_positions = [
	%SpawnLaneLeft,
	%SpawnLaneCenter,
	%SpawnLaneRight
]
@onready var _scenery_spawn_position_left = %SceneryLaneLeft;
@onready var _scenery_spawn_position_right = %SceneryLaneRight;
@onready var _scenery_items_collection = %SceneryItems;
@onready var _lane_items_collection = %LaneItems;

var _scenery_spawn_offset_range := 0.3;
var _spawn_count := 0;
var _current_spawn_interval_reduction := 0.0;


func _ready ():
	EventBus.game_paused.connect(_on_game_paused)
	EventBus.game_unpaused.connect(_on_game_unpaused)
	EventBus.game_restarted.connect(_on_game_restarted)
	
	_spawn_timer.start(_starting_spawn_interval);
	_spawn_timer.timeout.connect(_spawn);
	_scenery_spawn_timer.timeout.connect(_spawn_scenery);


func _on_game_paused (): Utils.pause_branch(self);
func _on_game_unpaused (): Utils.unpause_branch(self);
func _on_game_restarted (): _current_spawn_interval_reduction = 0.0;


func _spawn ():
	_reset_spawn_timer();
	
	if _spawn_count > 0 and _spawn_count % 3 == 0:
		_spawn_lane_item(_collectable_lane_items.pick_random());
	else:
		_spawn_lane_item(_obstacle_lane_items.pick_random());
	
	_spawn_count += 1;


func _reset_spawn_timer ():
	_current_spawn_interval_reduction += _spawn_interval_reduction
	var _next_spawn_interval = clampf(
		_starting_spawn_interval - _current_spawn_interval_reduction,
		_min_spawn_interval,
		_starting_spawn_interval
	);
	_spawn_timer.start(_next_spawn_interval)


func _spawn_lane_item (lane_item_data: LaneItemData):
	var lane_item = _lane_item_scene.instantiate().with_data(lane_item_data) as LaneItem;
	_lane_items_collection.add_child(lane_item);
	var lane = _obastacle_spawn_positions.pick_random();
	lane_item.global_position = Vector3(lane.position.x, position.y, position.z);
	lane_item.global_rotation = Vector3.ZERO;


func _spawn_scenery ():
	_spawn_in_scenic_lane(_tree_scene, _scenery_spawn_position_left);
	_spawn_in_scenic_lane(_tree_scene, _scenery_spawn_position_right);


func _spawn_in_scenic_lane (scene: PackedScene, lane: Marker3D):
	var obstacle = scene.instantiate() as Node3D;
	_scenery_items_collection.add_child(obstacle);
	var offset = randf_range(-_scenery_spawn_offset_range, _scenery_spawn_offset_range);
	obstacle.global_position = Vector3(lane.position.x + offset, position.y, position.z);
