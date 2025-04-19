extends "res://scripts/collectable.gd"

@onready var animations: AnimationPlayer = $AnimationPlayer

func collect(inventory: Inventory):
	animations.play("spin")
	await animations.animation_finished
	super(inventory)
