extends ActionResource
class_name OnCollideWithPlayer

## The AudioStream to play when this item collides with the player.
@export var sfx_player_collision: AudioStream;


# Called when the node enters the scene tree for the first time.
func execute(target: Variant) -> Variant:
	EventBus.play_sfx_requested.emit(sfx_player_collision);
	target = target as Node;
	target.queue_free()
	return

