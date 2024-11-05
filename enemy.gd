extends Node2D
class_name Enemy

var timer = Timer.new()


func start_timer() -> void:
	# Randomize the timer duration between 1 and 5 seconds
	var duration = randf_range(1.0, 5.0)
	timer.start(duration)

func _on_Timer_timeout() -> void:
	
	print("I finished the exam! you loose!")
	queue_free()
