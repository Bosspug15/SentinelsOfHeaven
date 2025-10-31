extends Area2D

@export var player : CharacterBody2D
@export var fade_to_white : AnimationPlayer
@onready var timer = $timer
@onready var fade_timer = $FadeTimer
@onready var sparkle_sprite = $Sparkle


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.fade_sprite.play("FadeInTest")
		fade_to_white.play("FadeToWhite")
		sparkle_sprite.play("Flash")
		fade_timer.start()
		player.playerLock()

func _on_transition_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/TestLevels/FirstLevelTitanLevelDesign.tscn")

func _on_fade_timer_timeout() -> void:
	fade_to_white.play("ShowItem")

func _on_sparkle_animation_finished() -> void:
	if sparkle_sprite.animation == "Flash":
		self.visible = false
