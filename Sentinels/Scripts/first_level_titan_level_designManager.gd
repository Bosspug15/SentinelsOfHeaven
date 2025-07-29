extends Node2D

@export var pause_target : Node
@export var pause_menu : Node
@export var player: Node

func toggle_pause():
	pause_menu.visible = !pause_menu.visible
	if pause_target.process_mode != Node.PROCESS_MODE_DISABLED:
		pause_target.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		pause_target.process_mode = Node.PROCESS_MODE_INHERIT

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") && player.is_Dead == false:
		toggle_pause()
		pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS
		if pause_menu.visible == true:
			pause_menu.playPauseSfx()
		else:
			pause_menu.playUnPauseSfx()
