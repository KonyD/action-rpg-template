extends Node
class_name MoveAnimationComponent

@export var animations: AnimationPlayer
@onready var parent = get_parent()

func _physics_process(delta: float) -> void:
	if parent.isAttacking: return
	if parent.velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if parent.velocity.x < 0: direction = "Left"
		elif parent.velocity.x > 0: direction = "Right"
		elif parent.velocity.y < 0: direction = "Up"
		
		animations.play("walk" + direction)
		parent.lastAnimDirection = direction
