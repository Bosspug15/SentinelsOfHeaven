extends Area2D


@onready var checkpoint_manager = get_parent().get_parent().get_node("CheckpointManager")
@onready var player = get_parent().get_parent().get_node("Player")
@onready var respawn_point = $RespawnPoint
@onready var checkpoint_spark = $AnimatedSprite2D
@onready var anim_offset = $AnimOffset

var hasChecked = false

# RESPAWN POINT IS BASED ON 0,0 IN SCENE
func _ready() -> void:
	checkpoint_manager.last_location = player.position

func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !hasChecked:
			body.setCheckpoint()
			anim_offset.start()
			checkpoint_manager.last_location = respawn_point.position
			hasChecked = true

func _on_anim_offset_timeout() -> void:
	checkpoint_spark.play("CheckpointForm")

func _on_animated_sprite_2d_animation_finished() -> void:
	checkpoint_spark.play("Sparkle")
