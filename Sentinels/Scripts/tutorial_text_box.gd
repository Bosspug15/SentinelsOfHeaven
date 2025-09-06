extends Area2D

@export var tutorial_text : Node
@export var new_text : String
@export var action_to_complete : String
var area_active = false

func _input(_event):
	if area_active && Input.is_action_just_pressed(action_to_complete):
		tutorial_text.fadeOut()
		queue_free()

func _on_body_entered(_body: Node2D) -> void:
	tutorial_text.changeText(new_text)
	area_active = true
	if _body.is_in_group("Player"):
		tutorial_text.fadeIn()

func _on_body_exited(_body: Node2D) -> void:
	tutorial_text.fadeOut()
	queue_free()
