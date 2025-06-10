extends BaseScene

@onready var heartsContainer = $CanvasLayer/HeartsContainer
@onready var camera = $FollowCamera

func  _ready() -> void:
	super()
	camera.follow_node = player
	
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)


func _on_gui_element_opened() -> void:
	get_tree().paused = true

func _on_gui_element_closed() -> void:
	get_tree().paused = false
