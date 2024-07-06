extends Node3D
class_name SceneryItem

@export var _speed = 5.00;
@export var _tree_lean_in_degrees = 10.0;
@export var _random_tree_scale_offset = 0.2; 

@onready var _tree_visual = %alpine_tree;

func _ready():
	EventBus.scenery_item_hit_gutter.connect(_on_hit_gutter);
	_tree_visual.rotate_y(deg_to_rad(randf_range(0, 359)));
	_tree_visual.rotate_x(deg_to_rad(_tree_lean_in_degrees));
	var random_scale_offset = randf_range(-_random_tree_scale_offset, _random_tree_scale_offset);
	_tree_visual.scale = Vector3(
		1 + random_scale_offset,
		1 + random_scale_offset,
		1 + random_scale_offset
	);


func _on_hit_gutter(scenery_item: SceneryItem):
	if scenery_item == self:
		queue_free();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var move_speed = _speed * delta;
	position.z += move_speed;
