extends Node

var _concurrent_sfx_limit := 6;
var _currently_playing_sfx: Array[AudioStreamPlayer] = [];


func _ready():
	EventBus.play_sfx_requested.connect(_on_play_sfx_requested);


func _on_play_sfx_requested (requested_sfx: AudioStream):
	_play_sfx(requested_sfx);


func _play_sfx(sfx: AudioStream):
	print("playing sfx")
	if _currently_playing_sfx.size() >= _concurrent_sfx_limit:
		_remove_oldest_audio_stream();
	
	var audio_stream = _create_audio_stream(sfx);
	add_child(audio_stream);
	audio_stream.play();
	_currently_playing_sfx.push_front(audio_stream);


func _remove_oldest_audio_stream ():
	var audio_stream_to_remove = _currently_playing_sfx.pop_back() as AudioStreamPlayer;
	audio_stream_to_remove.stop();
	audio_stream_to_remove.queue_free();


func _create_audio_stream (audio_stream):
	var audio_stream_player = AudioStreamPlayer.new();
	audio_stream_player.bus = "SFX";
	audio_stream_player.stream = audio_stream;
	
	return audio_stream_player;
