extends Node


var bgm_tracks = {
	Constants.BGM_TRACK_01: preload("res://src/assets/audio/music/Three Red Hearts - Pixel War 2.ogg")
};

var audio_stream_player: AudioStreamPlayer;


func _ready ():
	audio_stream_player = AudioStreamPlayer.new();
	add_child(audio_stream_player);
	EventBus.play_bgm_requested.connect(_play_track);


func _play_track (track_name: String):
	if not track_name in bgm_tracks:
		Logger.warn("Track %s not found" % track_name);
	
	if audio_stream_player.playing:
		audio_stream_player.stop();
	
	audio_stream_player.stream = bgm_tracks[track_name];
	audio_stream_player.play();
