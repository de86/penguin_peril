extends Node3D
class_name SceneryItem

@export var _speed = 5.00;


func _ready():
	EventBus.scenery_item_hit_gutter.connect(_on_hit_gutter);


func _on_hit_gutter(scenery_item: SceneryItem):
	if scenery_item == self:
		queue_free();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var move_speed = _speed * delta;
	position.z += move_speed;
