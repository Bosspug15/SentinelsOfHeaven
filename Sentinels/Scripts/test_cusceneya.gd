extends Area2D

@onready var animation_player = $textTestCutscene
@onready var player = get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animation_player.play("testFadeInYay")
		player.inCutscene()

func _on_text_test_cutscene_animation_finished(_anim_name: StringName) -> void:
	player.outCutscene()
