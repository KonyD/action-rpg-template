extends Camera2D

@export var tilemap: TileMap
@export var follow_node: Node2D

func _ready() -> void:
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.tile_set.tile_size
	var worldSizeInPixels = mapRect.size * tileSize
	var tilemap_scale = tilemap.scale
	print(worldSizeInPixels)
	limit_right = worldSizeInPixels.x * tilemap_scale.x
	limit_bottom = worldSizeInPixels.y * tilemap_scale.y

func _process(delta: float) -> void:
	global_position = follow_node.global_position
