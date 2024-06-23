extends Control


@onready var _hud = $HUD as Control;
@onready var _restart = $Restart as Control;
@onready var _uis = [
	_hud,
	_restart
];


func _ready ():
	EventBus.player_died.connect(_on_player_died);
	EventBus.game_restarted.connect(_on_game_restart);


func _on_player_died ():
	_hide_all_uis();
	_restart.visible = true;


func _on_game_restart ():
	_hide_all_uis();
	_hud.visible = true;


func _hide_all_uis ():
	for ui in _uis:
		ui.visible = false;
