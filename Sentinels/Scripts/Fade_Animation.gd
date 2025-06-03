extends Node

@onready var animated_sprite = $AnimatedSprite2D
@onready var player = get_node("path/to/Player")

func _ready() -> void:
	animated_sprite.play("FadeOut")

func _process(_delta: float) -> void:
	if (player.Is_Dead):
		animated_sprite.playe("FadeIn")
