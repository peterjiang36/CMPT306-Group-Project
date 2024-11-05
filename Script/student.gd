# Student.gd
extends Node2D
class_name Student

# Define the timer duration for each exam completion
var exam_timer_duration: float = 5.0
var exam_timer: Timer
var is_exam_in_progress: bool = false

# Reference to the Player (to reduce health when exam finishes)
var player: Node

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	exam_timer = Timer.new()
	add_child(exam_timer)
	exam_timer.wait_time = exam_timer_duration
	exam_timer.connect("timeout", Callable(self, "_on_exam_finished"))


# Start an exam for the student
func start_exam() -> void:
	if not is_exam_in_progress:
		
		is_exam_in_progress = true
		exam_timer.start()

# Handle exam completion
func _on_exam_finished() -> void:
	is_exam_in_progress = false
	player.reduce_health(10)  # Reduce player health by 10 points when exam is finished
	print("Student finished exam!")

# Reset the student's state (optional if they receive multiple exams)
func reset_exam() -> void:
	exam_timer.stop()
	is_exam_in_progress = false
