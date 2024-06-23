extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.terrain_spawned.connect(wrangle_terrain);


func wrangle_terrain (obstacle: Node3D):
	add_child(obstacle);
