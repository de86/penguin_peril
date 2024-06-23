extends Control


@onready var _score_label = %Label as Label;


func _ready ():
	EventBus.score_changed.connect(_on_score_chaged);
	_score_label.text = str(0);


func _on_score_chaged (latest_score: int):
	_score_label.text = str(latest_score);
