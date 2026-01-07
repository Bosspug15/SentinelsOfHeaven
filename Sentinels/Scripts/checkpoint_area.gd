extends Area2D

@export var respawnPoint : Marker2D

@onready var checkpoint_manager = get_parent().get_node("CheckpointManager")
@onready var player = get_parent().get_node("Player")
@onready var respawn_point = $RespawnPoint

var hasChecked = false

# RESPAWN POINT IS BASED ON 0,0 IN SCENE
func _ready() -> void:
	checkpoint_manager.last_location = player.position

func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !hasChecked:
			#body.setCheckpoint()
			checkpoint_manager.last_location = respawnPoint.position
			hasChecked = true
