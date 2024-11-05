extends CanvasModulate

@onready var health_label = $HealthLabel

# Set up the player connection to update health on change
func _ready() -> void:
	var player = $"../Player"
	player.connect("health_changed", Callable(self, "_on_health_changed"))
	_on_health_changed(player.health)

# Update health label when health changes
func _on_health_changed(new_health: int) -> void:
	health_label.text = "Health: " + str(new_health)
	if new_health <= 0:
		show_game_over()

# Show Game Over screen
func show_game_over() -> void:
	print("Game Over")
