extends Node

@onready var animated_sprite = $AnimatedSprite2D
@onready var player = get_node("path/to/Player")

# DONT DO THIS PLEASE THINK OF A BETTER WAY I SWEAR TO GOD 
# DONT WANT MULTIPLE INSTANCES DOING FUNCTIONS UNLESS ONE THING CONTROLLS ALL ANIMS
func _ready() -> void:
	animated_sprite.play("FadeOut")

func _process(_delta: float) -> void:
	if (player.Is_Dead):
		animated_sprite.playe("FadeIn")
