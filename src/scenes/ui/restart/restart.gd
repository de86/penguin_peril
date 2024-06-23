extends Control


@onready var restart_button = %Button as Button;


func _on_button_pressed():
	EventBus.game_restarted.emit();
