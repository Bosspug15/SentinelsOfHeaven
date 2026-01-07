extends Area2D

@export var player : CharacterBody2D
@export var fade_to_white : AnimationPlayer
@onready var timer = $timer
@onready var fade_timer = $FadeTimer
@onready var continue_timer = $ContinueTimer
@onready var sparkle_sprite = $Sparkle
@onready var can_continue = false

func _input(event):
	if can_continue && Input.is_action_just_pressed("continue_dialogue"):
		fade_to_white.play("FadeOut")
		continue_timer.start()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.fade_sprite.play("FadeInTest")
		sparkle_sprite.z_index = 20
		fade_to_white.play("FadeToWhite")
		sparkle_sprite.play("Flash")
		timer.start()
		fade_timer.start()
		player.playerLock()

func _on_transition_timer_timeout() -> void:
	can_continue = true

func _on_fade_timer_timeout() -> void:
	fade_to_white.play("ShowItem")

func _on_sparkle_animation_finished() -> void:
	if sparkle_sprite.animation == "Flash":
		self.visible = false

func _on_continue_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/TestLevels/SecondLevelTitanLevelDesign.tscn")
