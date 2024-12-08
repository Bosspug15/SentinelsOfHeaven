extends Area2D

@onready var animated_sprite = $playAnimation


func _on_body_entered(_body):
	animated_sprite.play("moveLeft")


