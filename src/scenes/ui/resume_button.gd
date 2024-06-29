extends Button



func _on_pressed():
	print("unpase pressed")
	EventBus.game_unpaused.emit();
