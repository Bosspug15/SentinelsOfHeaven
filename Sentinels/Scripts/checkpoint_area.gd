extends Area2D


@onready var checkpoint_manager = get_parent().get_parent().get_node("CheckpointManager")
@onready var respawn_point = $RespawnPoint

#YO THIS SHIT ASS BRO PLEASE FIX LATER, THESE CHECKPOINTS ARE NOT WORKING YO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		checkpoint_manager.last_location = respawn_point.position

	
