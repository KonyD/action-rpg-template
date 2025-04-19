extends CharacterBody2D
class_name Player

signal healthChanged

@export var SPEED = 300.0
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var effects: AnimationPlayer = $Effects
@onready var hurt_box: Area2D = $HurtBox
@onready var hurt_timer: Timer = $hurtTimer
@onready var weapon: Node2D = $weapon

@export var maxHealth = 3
@onready var currentHealth: int = maxHealth

@export var knockbackPower: int = 500

@export var inventory: Inventory

var lastAnimDirection: String = "Down"
var isHurt: bool = false
var isAttacking: bool = false

func _ready() -> void:
	effects.play("RESET")

func handle_input() -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	
	if Input.is_action_just_pressed("attack") and inventory.hasItem("Sword"):
		attack()

func attack():
	animations.play("attack" + lastAnimDirection)
	isAttacking = true
	weapon.enable()
	await animations.animation_finished
	isAttacking = false
	weapon.disable()

func update_animation():
	if isAttacking: return
	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("walk" + direction)
		lastAnimDirection = direction

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func _physics_process(_delta: float) -> void:
	handle_input()
	update_animation()
	move_and_slide()
	if !isHurt:
		for area in hurt_box.get_overlapping_areas():
			if area.name == "hitBox":
				hurtByEnemy(area)

func hurtByEnemy(area: Area2D):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
	
	healthChanged.emit(currentHealth)
	isHurt = true
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurt_timer.start()
	await hurt_timer.timeout
	effects.play("RESET")
	isHurt = false

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.has_method("collect"):
		area.collect(inventory)

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func _on_hurt_box_area_exited(area: Area2D) -> void: pass
