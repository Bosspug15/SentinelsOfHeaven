extends Area2D

var checkpoint_manager
var player
@onready var timer = $Timer

func _ready() -> void:
	player = get_parent().get_parent().get_parent().get_node("Player")
	checkpoint_manager = get_parent().get_parent().get_parent().get_node("CheckpointManager")

func _on_body_entered(_body):
	if _body.is_in_group("Player"):
		_body.die()
		timer.start()
		


func _on_timer_timeout():
	player.position = checkpoint_manager.last_location
	
