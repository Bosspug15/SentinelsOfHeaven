extends Node2D

@onready var timer = $Lifetime

var inRange = false
var vel = 10
var playerPos

func _physics_process(delta):
	position = position.move_toward(playerPos.position, delta*vel)

func _on_timer_timeout():
	queue_free()
	


func _on_test_tracking_body_entered(_body):
	playerPos = _body.position
	timer.start()
	if _body.is_in_group("ghostTrack"):
		inRange = true
		


func _on_test_tracking_body_exited(_body):
	inRange = false
