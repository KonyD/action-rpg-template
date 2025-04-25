extends InventoryItem

class_name HealthItem

@export var health_increase: int = 1

func use(player: Player) -> void:
	player.increaseHealth(health_increase)

func canBeUsed(player: Player) -> bool:
	return player.currentHealth < player.maxHealth
