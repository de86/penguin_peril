class_name Gutter
extends Node3D



func _on_area_3d_area_entered(area: Area3D):
	var area_owner = area.get_parent();
	if area_owner is LaneItem:
		EventBus.lane_item_hit_gutter.emit(area_owner);
	elif area_owner is SceneryItem:
		EventBus.scenery_item_hit_gutter.emit(area_owner);
