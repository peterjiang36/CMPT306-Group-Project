extends Node2D

@onready var player = $Player
# Array of student nodes
var students = get_children().filter(func(child): child is Student)

# Main input event for sending exams
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		send_exam_to_student()

# Send an exam to a random student
func send_exam_to_student() -> void:
	if students.size() == 0:
		print("No students available.")
		return
	var exam = Exam.new()
	add_child(exam)
	var random_student = students[randi() % students.size()]
	var start_position = player.position
	var end_position = random_student.position
	exam.send_exam(start_position, end_position, 0.5)  # Duration of 0.5 seconds
	random_student.start_exam()
