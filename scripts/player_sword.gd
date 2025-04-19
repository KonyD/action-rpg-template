extends Area2D

@onready var shape = $CollisionShape2D

func enable():
	shape.disabled = false

func disable():
	shape.disabled = true
