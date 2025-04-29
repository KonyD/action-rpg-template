extends CharacterBody2D

@onready var animations = $AnimationPlayer

@export var knockbackPower: int = 500

var isDead: bool = false

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("walk" + direction)

func  _physics_process(_delta: float) -> void:
	if isDead: return
	updateAnimation()

func is_dead():
	isDead = true
	animations.play("death")
	await animations.animation_finished
	queue_free()


# might use in future
func knockback(enemyPosition: Vector2):
	var knockbackDirection = (position - enemyPosition).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()
