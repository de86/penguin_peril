extends Resource
class_name LaneItemData

@export var speed = 5.00;
@export var mesh: Mesh;
@export var visual_scene: PackedScene;
@export var on_collide_with_player_behaviour: ActionResource;
@export var is_collectible: bool;
@export var score: int;
@export var collision_size: Constants.OBSTACLE_SIZE;
