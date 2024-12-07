extends Area2D

@onready var timer = $Timer

func _on_body_entered(_body):
	if _body.is_in_group():
		_body.die()
		timer.start()


func _on_timer_timeout():
	queue_free()
	
