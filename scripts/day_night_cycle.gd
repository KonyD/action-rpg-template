extends CanvasModulate

@onready var animations: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	var time = Time.get_time_dict_from_system()
	var timeInSeconds = time.hour * 3600 + time.minute * 60 + time.second
	var currentFrame = remap(timeInSeconds, 0, 86400, 0, 24)
	animations.play("DayNightCycle")
	animations.seek(currentFrame)
