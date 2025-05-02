extends CharacterBody2D
class_name Player

signal healthChanged

@export var SPEED = 300.0
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var effects: AnimationPlayer = $Effects
@onready var hurt_box: Area2D = $HurtBox
@onready var hurt_timer: Timer = $hurtTimer
@onready var weapon: Node2D = $weapon

@export var maxHealth = 3 * 4
@onready var currentHealth: int = maxHealth

@export var knockbackPower: int = 500

@export var inventory: Inventory

var lastAnimDirection: String = "Down"
var isHurt: bool = false
var isAttacking: bool = false
var equippedWeapon: bool = false

func _ready() -> void:
	inventory.use_item.connect(useItem)
	inventory.equip_item.connect(equip_item)
	inventory.unequip_item.connect(unequip_item)
	effects.play("RESET")

func handle_input() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	
	if Input.is_action_just_pressed("attack") and equippedWeapon:
		attack()

func attack():
	animations.play("attack" + lastAnimDirection)
	isAttacking = true
	weapon.enable()
	await animations.animation_finished
	isAttacking = false
	weapon.disable()

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func _physics_process(_delta: float) -> void:
	handle_input()
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

func increaseHealth(amount: int) -> void:
	currentHealth += amount
	currentHealth = min(maxHealth, currentHealth)
	
	healthChanged.emit(currentHealth)

func useItem(item: InventoryItem) -> void:
	if not item.canBeUsed(self): return
	item.use(self)
	
	if item.consumable: inventory.removeLastUsedItem()

func equip_item(item: InventoryItem) -> void:
	equippedWeapon = true
	item.equip(self)

func unequip_item(item: InventoryItem) -> void:
	equippedWeapon = false
	item.unequip(self)

func _on_hurt_box_area_exited(area: Area2D) -> void: pass
