extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

#func _ready() -> void:
	#animated_sprite.play("Idle")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animated_sprite.play("Collected")

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
