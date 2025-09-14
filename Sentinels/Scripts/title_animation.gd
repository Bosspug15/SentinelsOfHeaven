extends AnimationPlayer

@export var dialogue_player : CanvasLayer

func _ready() -> void:
	play("TitleFadeIn")

func _on_animation_finished(anim_name: StringName) -> void:
	play("TitleFadeOut")
	if anim_name == "TitleFadeOut":
		dialogue_player.titleFinished = true
		if dialogue_player.in_progress:
			dialogue_player.show_text()
		queue_free()
