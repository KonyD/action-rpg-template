extends Node
class_name FollowMovementComponent

@export var speed = 200
@export var healthComponent: HealthComponent
@export var overshoot_limit: int = 4
@export var follow_distance: int = 160
@export var follow_duration: int = 2
@export var follow_area: Area2D

@onready var parent: CharacterBody2D = get_parent()
@onready var visibility_tracker = $"../VisibleOnScreenNotifier2D"

var start_position
var start_visibility = VisibleOnScreenNotifier2D.new()
var target: Player

enum State {IDLE, FOLLOW, BACK}
var current_state: State = State.IDLE

func _ready() -> void:
	healthComponent.died.connect(disable)
	start_position = parent.global_position
	add_child(start_visibility)
	start_visibility.global_position = start_position

func idle() -> void:
	parent.velocity = Vector2.ZERO
	var overlapping = follow_area.get_overlapping_bodies()
	var filtered = overlapping.filter(func(b): return b is Player)
	if !filtered.is_empty():
		follow_body(filtered[0])

func follow() -> void:
	var dist_to_start = (start_position - parent.global_position).length()
	if dist_to_start > follow_distance:
		target = null
		current_state = State.BACK
		return
	
	var direction = target.global_position - parent.global_position
	var new_velocity = direction.normalized() * speed
	parent.velocity = new_velocity

func goBack() -> void:
	var dir_to_start = start_position - parent.global_position
	
	if dir_to_start.length() < overshoot_limit || out_of_sight():
		parent.global_position = start_position
		current_state = State.IDLE
		return
	
	parent.velocity = dir_to_start.normalized() * speed

func update_velocity():
	match current_state:
		State.IDLE:
			idle()
		State.FOLLOW:
			follow()
		State.BACK:
			goBack()

func out_of_sight() -> bool:
	return !visibility_tracker.is_on_screen() && !start_visibility.is_on_screen()

func follow_body(body) -> void:
	target = body
	current_state = State.FOLLOW
	#await  get_tree().create_timer(follow_duration).timeout
	#stop_follow()

func stop_follow() -> void:
	if current_state == State.FOLLOW:
		target = null
		current_state = State.BACK

func _physics_process(delta: float) -> void:
	update_velocity()
	parent.move_and_slide()

func disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
