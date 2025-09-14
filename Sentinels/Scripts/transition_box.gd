extends Area2D

@export var player : CharacterBody2D
@onready var transition_timer = $"Transition Timer"
#var sceneTest = "res://Scenes/TestLevels/FirstLevelTest.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.fade_sprite.play("FadeInTest")
		transition_timer.start()
		
		



func _on_transition_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/TestLevels/FirstLevelTitanLevelDesign.tscn")
	#THIS IS A TESTlol
