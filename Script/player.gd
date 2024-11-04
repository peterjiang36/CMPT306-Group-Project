extends Node2D



	
# Player's health points
var health: int = 100

# Signal to notify when the player’s health changes
signal health_changed(health)

# Method to reduce health when a student finishes an exam
func reduce_health(amount: int) -> void:
	health -= amount
	emit_signal("health_changed", health)
	if health <= 0:
		game_over()

# Method to handle game over condition
func game_over() -> void:
	print("Game Over!")
	# You might want to trigger an end-game screen or reset logic here
