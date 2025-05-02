extends HBoxContainer

@onready var HeartGuiClass = preload("res://scenes/heart_gui.tscn")

func setMaxHearts(max: int):
	max = max / 4
	for i in range(max):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)

func updateHearts(currentHealth):
	var hearts = get_children()
	
	var full_hearts: int = currentHealth / 4
	
	for i in range(full_hearts):
		hearts[i].update(4)
	
	if full_hearts == hearts.size(): return
	
	var remainder = currentHealth % 4
	hearts[full_hearts].update(remainder)
	
	for i in range(full_hearts + 1, hearts.size()):
		hearts[i].update(0)
