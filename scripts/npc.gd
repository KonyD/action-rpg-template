extends StaticBody2D

class_name NPC

signal dialogue_started

@export var area: Area2D
@export var dialogue_res: DialogueResource
@export var player: Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var in_range: bool = false

func _ready() -> void:
	if area:
		area.body_entered.connect(_on_area_body_entered)
		area.body_exited.connect(_on_area_body_exited)
	
	if not player:
		player.get_tree().current_scene.find_child("Player")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") && in_range:
		face_player()
		dialogue_started.emit()
		DialogueManager.show_dialogue_balloon(dialogue_res, "start")

func _on_area_body_entered(body: Node) -> void:
	in_range = true

func _on_area_body_exited(body: Node) -> void:
	in_range = false

func face_player() -> void:
	var player_direction = (player.global_position - global_position).normalized()
	var direction := "Down"  
	
	if abs(player_direction.x) > abs(player_direction.y):
		direction = "Right" if player_direction.x > 0 else "Left"
	else:
		direction = "Down" if player_direction.y > 0 else "Up"
	
	animated_sprite.play("look" + direction)
