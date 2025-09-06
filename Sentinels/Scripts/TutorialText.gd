extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@onready var text = $AnimationPlayer/Label

func fadeIn():
	animation_player.play("FadeIn")

func fadeOut():
	animation_player.play("FadeOut")

func changeText(changed_text):
	text.text = changed_text
