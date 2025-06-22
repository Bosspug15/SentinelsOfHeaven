extends AnimatedSprite2D

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = true

func _on_timer_timeout() -> void:
	if self.visible == true:
		self.visible = false
