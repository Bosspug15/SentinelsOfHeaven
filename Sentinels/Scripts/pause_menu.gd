extends Node2D

@export var scene_pause : Node
@onready var exit_button = $Exit
@onready var resume_button = $Resume
@onready var unpause_sfx = $Resume/UnPauseSFX
@onready var pause_sfx = $PauseSFX

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_resume_pressed() -> void:
	unpause_sfx.play()
	scene_pause.toggle_pause()

func playPauseSfx() -> void:
	pause_sfx.play()

func playUnPauseSfx() -> void:
	unpause_sfx.play()
