class_name LaneItem
extends Node3D


@onready var _area: Area3D = %Area3D;
@onready var _mesh_instance: MeshInstance3D = %MeshInstance3D;

var _lane_item_data: LaneItemData;


func _ready ():
	_mesh_instance.mesh = _lane_item_data.mesh;
	EventBus.lane_item_hit_gutter.connect(_on_collide_with_gutter);
	EventBus.lane_item_hit_player.connect(_on_collide_with_player);
	EventBus.game_restarted.connect(_destroy_self)


func with_data (lane_item_data) -> LaneItem:
	_lane_item_data = lane_item_data;
	
	return self;


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
