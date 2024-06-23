extends Node

var _total_score = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.collectable_collected.connect(_on_collectable_collected);
	EventBus.game_restarted.connect(_on_game_restarted);


func _on_collectable_collected(collectibleData: LaneItemData):
	if collectibleData.score > 0:
		_inrease_score(collectibleData.score);


func _on_game_restarted ():
	_reset_score();


func _inrease_score (additional_score: int):
	_total_score += additional_score;
	Logger.info(_total_score);
	EventBus.score_changed.emit(_total_score);


func _reset_score ():
	_total_score = 0;
	Logger.info(_total_score);
	EventBus.score_changed.emit(_total_score);
