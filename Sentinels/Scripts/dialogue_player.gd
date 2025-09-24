extends CanvasLayer

@export_file("*json") var scene_text_file
@export var mentor_bird : Node

var scene_text: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false

@onready var background = $AnimationPlayer/background
@onready var text_label = $AnimationPlayer/textlabel
@onready var animation_player = $AnimationPlayer
@onready var caw_sfx = $Caw
var readyToPlayCaw = true
@export var titleFinished : bool

func _ready() -> void:
	background.visible = false
	scene_text = load_scene_text()
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))

func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()

func show_text():
	if titleFinished:
		mentor_bird.play("Caw")
		background.visible = true
		text_label.text = selected_text.pop_front()
		animation_player.play("textFadeIn")
		caw_sfx.play()

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	animation_player.play("TotalFadeOut")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TotalFadeOut":
		mentor_bird.play("Jump_Squat")
		in_progress = false
		get_tree().paused = false

func on_display_dialog(text_key):
	if in_progress:
		next_line()
	else:
		animation_player.play("textFadeOut")
		get_tree().paused = true
		background.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()

func _on_caw_finished() -> void:
	readyToPlayCaw = true
