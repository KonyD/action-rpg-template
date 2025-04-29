extends Node

class_name MarkerMovementAIComponent

@export var limit = 0.5
@export var speed = 20
@export var endPoint: Marker2D
@export var healthComponent: HealthComponent

@onready var parent: CharacterBody2D = get_parent()

var startPosition
var endPosition

func _ready() -> void:
	healthComponent.died.connect(disable)
	
	endPoint = parent.get_node_or_null("Marker2D")
	
	startPosition = parent.position
	if !endPoint:
		endPosition = startPosition + Vector2(0, 48)
		return
	# divided to 4 because of the scaling factor
	endPosition = endPoint.global_position / Vector2(4, 4)

func changeDirection():
	var temp = endPosition
	endPosition = startPosition
	startPosition = temp

func updateVelocity():
	var moveDirection = (endPosition - parent.position)
	if moveDirection.length() < limit:
		changeDirection()
	parent.velocity = moveDirection.normalized() * speed

func _physics_process(delta: float) -> void:
	updateVelocity()
	parent.move_and_slide()

func disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
