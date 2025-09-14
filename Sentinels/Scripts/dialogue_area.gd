extends Area2D

@export var dialog_key = ""
var area_active = false
@onready var continue_timer = $ContinueTimer

func _input(_event):
	if area_active && Input.is_action_just_pressed("continue_dialogue") && continue_timer.is_stopped():
		SignalBus.emit_signal("display_dialog", dialog_key)
		continue_timer.start()
		

func _on_body_entered(_body: Node2D) -> void:
	area_active = true
	continue_timer.start()
	if _body.is_in_group("Player"):
		SignalBus.emit_signal("display_dialog", dialog_key)

func _on_body_exited(_body: Node2D) -> void:
	area_active = false
	queue_free()
