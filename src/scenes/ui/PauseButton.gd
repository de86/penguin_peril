extends Button


func _on_pressed():
	EventBus.game_paused.emit();
