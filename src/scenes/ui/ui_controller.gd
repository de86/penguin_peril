extends Control


@onready var _hud = $HUD as Control;
@onready var _restart = $Restart as Control;
@onready var _pause = $Pause as Control;
@onready var _uis = [
	_hud,
	_restart
];


func _ready ():
	EventBus.player_died.connect(_on_player_died);
	EventBus.game_restarted.connect(_on_game_restart);
	EventBus.game_paused.connect(_on_game_paused);
	EventBus.game_unpaused.connect(_on_game_unpaused);


func _on_player_died ():
	_hide_all_uis();
	_restart.visible = true;


func _on_game_restart ():
	_hide_all_uis();
	_hud.visible = true;


func _on_game_paused ():
	_hide_all_uis();
	_hud.visible = true;
	_pause.visible = true;


func _on_game_unpaused ():
	print("hiding pause menu")
	_hide_all_uis();
	_pause.visible = false;
	_hud.visible = true;


func _hide_all_uis ():
	for ui in _uis:
		ui.visible = false;
