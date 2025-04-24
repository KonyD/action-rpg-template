extends Node2D

func _ready() -> void:
	if scene_manager.player:
		scene_manager.player.scale = Vector2(4, 4)
		add_child(scene_manager.player)
