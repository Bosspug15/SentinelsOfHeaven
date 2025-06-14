extends CharacterBody2D



const SPEED = 151.15
const JUMP_VELOCITY = -440.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var cut_jump_height: float = 0.5

var wind_Push = 1

@onready var animated_sprite = $AnimatedSprite2D
@onready var landing_sound = $landingSound
@onready var jumping_sound = $jumpingSound
@onready var coyote_timer = $CoyoteTimer
@onready var fade_sprite = $FadeOut
@onready var fade_timer = $FadeTimer
@onready var fade_in_timer = $FadeInTimer

@onready var is_Dead = false
@onready var dust = preload("res://Scenes/dust.tscn")
var isGrounded = true

func _ready() -> void:
	fade_sprite.play("FadeOutTest")

func _physics_process(delta):
	#if is_Dead:
		#velocity.y = 0
		#gravity = 0
	#else:
		#pass
		
	if isGrounded == false and is_on_floor() == true:
		coyote_timer.start()
		var instance = dust.instantiate()
		landing_sound.play()
		instance.global_position = $Marker2D.global_position
		get_parent().add_child(instance)
	
	isGrounded = is_on_floor()
	
	#if isGrounded && !is_on_floor():
		#coyote_timer.start()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 0.89 * wind_Push

	if Input.is_action_just_pressed("RestartScene"):
		get_tree().reload_current_scene()

	# Handle jump.
	if Input.is_action_just_pressed("jump") && (is_on_floor() || !coyote_timer.is_stopped()) && !is_Dead:
		velocity.y = JUMP_VELOCITY
		jumping_sound.play()
	
	# get input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# flip sprite
	if !is_Dead:
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
	
	# play anim
	if is_on_floor():
		if direction == 0 && is_Dead == false:
			animated_sprite.play("Idle")
		elif is_Dead == false:
			animated_sprite.play("Run")
	else:
		if velocity.y > 0 && is_Dead == false:
			animated_sprite.play("Fall")
		elif velocity.y < 0 && is_Dead == false:
			animated_sprite.play("Jump")
	
	# apply movement
	if direction && is_Dead == false:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
func _input(event):
	if event.is_action_released("jump"):
		if velocity.y < 0:
			velocity.y *= cut_jump_height

func die() -> void:
	is_Dead = true
	velocity.x = 0
	velocity.y = 0
	gravity = 0
	wind_Push = 1
	animated_sprite.play("Death")
	fade_timer.start()
	
func playerReset() -> void:
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	is_Dead = false


func _on_fan_wind_force_body_entered(_body):
	wind_Push = -0.85


func _on_fan_wind_force_body_exited(_body):
	wind_Push = 1
	

func _on_fade_timer_timeout() -> void:
	fade_sprite.play("FadeInTest")
	fade_in_timer.start()
	

#YO THIS SHIT ASS BRO PLEASE FIX LATER, THESE CHECKPOINTS ARE NOT WORKING YO
func _on_fade_in_timer_timeout() -> void:
	playerReset()
	fade_sprite.play("FadeOutTest")
