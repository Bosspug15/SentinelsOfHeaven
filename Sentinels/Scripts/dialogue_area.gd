extends Area2D

@export var dialog_key = ""
var area_active = false

func _input(_event):
	if area_active && Input.is_action_just_pressed("continue_dialogue"):
		print("lol")
		SignalBus.emit_signal("display_dialog", dialog_key)

func _on_body_entered(_body: Node2D) -> void:
	print("poop")
	area_active = true
	if _body.is_in_group("Player"):
		SignalBus.emit_signal("display_dialog", dialog_key)

func _on_body_exited(_body: Node2D) -> void:
	area_active = false
	queue_free()
