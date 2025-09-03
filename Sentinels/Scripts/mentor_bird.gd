extends AnimatedSprite2D

@export var animation_player : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animation = "Idle_Peck"
	pass

func _on_animation_finished() -> void:
	if animation == "Jump_Squat":
		flip_h = false
		self.play("Fly")
		animation_player.play("FlyAway")
