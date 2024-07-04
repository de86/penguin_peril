class_name LaneItem
extends Node3D


@onready var _area: Area3D = %Area3D;
@onready var _mesh_instance: MeshInstance3D = %MeshInstance3D;
@onready var _collision_shape_small: CollisionShape3D = %Small;
@onready var _collision_shape_tall: CollisionShape3D = %Tall;
@onready var _collision_shape_long: CollisionShape3D = %Long;
@onready var _collision_shapes = [
	_collision_shape_small,
	_collision_shape_tall,
	_collision_shape_long
] as Array[CollisionShape3D]

var _lane_item_data: LaneItemData;


func _ready ():
	_mesh_instance.mesh = _lane_item_data.mesh;
	_set_collision_size(_lane_item_data.collision_size);
	
	EventBus.lane_item_hit_gutter.connect(_on_collide_with_gutter);
	EventBus.lane_item_hit_player.connect(_on_collide_with_player);
	EventBus.game_restarted.connect(_destroy_self)


func with_data (lane_item_data) -> LaneItem:
	_lane_item_data = lane_item_data;
	
	return self;


func _set_collision_size (size: Constants.OBSTACLE_SIZE):
	for shape in _collision_shapes:
		shape.disabled = true;
	
	match size:
		Constants.OBSTACLE_SIZE.SMALL:
			_collision_shape_small.disabled = false;
		Constants.OBSTACLE_SIZE.TALL:
			_collision_shape_tall.disabled = false;
		Constants.OBSTACLE_SIZE.LONG:
			_collision_shape_long.disabled = false;
		_:
			Logger.warn("Unrecognised collision size %s. Setting default collision size of small" %size);
			_collision_shape_small.disabled = false;


func get_data () -> LaneItemData:
	return _lane_item_data;


func _physics_process(delta):
	var move_speed = _lane_item_data.speed * delta;
	position.z += move_speed;


func _on_collide_with_gutter (lane_item: LaneItem):
	if lane_item == self:
		_destroy_self();


func _on_collide_with_player (lane_item: LaneItem):
	if lane_item == self:
		_lane_item_data.on_collide_with_player_behaviour.execute(self);


func _destroy_self ():
	queue_free();
