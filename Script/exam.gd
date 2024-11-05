# Exam.gd
extends Node2D
class_name Exam

# Define different types of exams
var exam_types = ["Math", "Science", "History"]
var exam_type: String

# Set a random exam type upon creation
func _ready() -> void:
	exam_type = exam_types[randi() % exam_types.size()]
	print("Exam type:", exam_type)

# Animate the exam from point A (Player) to point B (Student)
func send_exam(start_position: Vector2, end_position: Vector2, duration: float) -> void:
	position = start_position
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self, "position", start_position, end_position, duration)
	tween.start()
