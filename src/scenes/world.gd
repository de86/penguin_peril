extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.collectable_collected.connect(_on_collectable_collected);
	EventBus.game_restarted.emit();
	EventBus.play_bgm_requested.emit(Constants.BGM_TRACK_01);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_collectable_collected (lane_item: LaneItem):
	print(lane_item);
