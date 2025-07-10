extends Node2D

@onready var exit_button = $Exit
@onready var resume_button = $Resume



func _on_exit_pressed() -> void:
	get_tree().quit()
