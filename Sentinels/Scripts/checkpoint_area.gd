extends Area2D

var checkpoint_manager

#YO THIS SHIT ASS BRO PLEASE FIX LATER, THESE CHECKPOINTS ARE NOT WORKING YO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpoint_manager = get_parent().get_node("CheckpointManager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		checkpoint_manager.last_location = $RespawnPoint.position      
