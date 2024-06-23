extends Node


# Input
signal camera_loaded (camera: Camera3D);
signal player_attempted_move_to (target_x_pos: float);
signal player_attempted_jump;


# Spawn
signal terrain_spawned (obstacle: Node3D);


# Collision
signal collectable_collected (collectableData: LaneItemData);
signal lane_item_hit_gutter (lane_item: LaneItem);
signal lane_item_hit_player (lane_item);
signal scenery_item_hit_gutter (scenery_item: SceneryItem);


# Score
signal score_changed (new_score: int);


# Game
signal player_died;
signal game_restarted;


# Audio
signal play_sfx_requested(sfx: AudioStream);
signal play_bgm_requested(bgm_track_name: )
