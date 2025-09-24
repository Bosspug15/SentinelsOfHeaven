extends CharacterBody2D

const SPEED = 151.15
const JUMP_VELOCITY = -440.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var cut_jump_height: float = 0.5
var wind_Push = 1
var in_transition = false
var is_Dead = true
var isGrounded = true

@export var camera : Node

@onready var player_collision = $PlayerCollision
@onready var animated_sprite = $PlayerSprite
@onready var mentor_bird_anim = $MentorBird
@onready var fade_sprite = $FadeOut
@onready var landing_sound = $landingSound
@onready var jumping_sound = $jumpingSound
@onready var death_sound = $deathSound
@onready var coyote_timer = $CoyoteTimer
@onready var fade_timer = $FadeTimer
@onready var fade_in_timer = $FadeInTimer
@onready var reset_wait = $ResetWait
@onready var lock_timer = $LockTimer
@onready var dust = preload("res://Scenes/dust.tscn")
@onready var checkpoint = preload("res://Scenes/checkpoint_area.tscn")


func _ready() -> void:
	fade_sprite.play("FadeOutTest")
	Input.action_release("move_right")

func _physics_process(delta):

	if isGrounded == false and is_on_floor() == true:
		coyote_timer.start()
		var instance = dust.instantiate()
		landing_sound.play()
		instance.global_position = $Marker2D.global_position
		get_parent().add_child(instance)
	
	isGrounded = is_on_floor()
	
	if not is_on_floor():
		velocity.y += gravity * delta * 0.89 * wind_Push

#OLD PLEASE DELETE
	if Input.is_action_just_pressed("checkpoint"):
		var checkpointInstance = checkpoint.instantiate()
		get_parent().add_child(checkpointInstance)
		setCheckpoint()

	if Input.is_action_just_pressed("RestartScene"):
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("jump") && (is_on_floor() || !coyote_timer.is_stopped()) && !is_Dead:
		velocity.y = JUMP_VELOCITY
		jumping_sound.play()
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if !is_Dead:
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
	
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
	
	if direction && is_Dead == false:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if in_transition:
		Input.action_press("move_right", 1.0)
	
	move_and_slide()
	
func _input(event):
	if event.is_action_released("jump"):
		if velocity.y < 0:
			velocity.y *= cut_jump_height

func inCutscene() -> void:
	is_Dead = true

func outCutscene() -> void:
	is_Dead = false

func die() -> void:
	is_Dead = true
	camera.process_mode = Node.PROCESS_MODE_DISABLED
	velocity.x = 0
	velocity.y = 0
	gravity = 0
	wind_Push = 1
	animated_sprite.play("Death")
	death_sound.play()
	fade_timer.start()
	player_collision.set_deferred("disabled", true)

func playerReset() -> void:
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	camera.process_mode = Node.PROCESS_MODE_INHERIT
	player_collision.set_deferred("disabled", false)

func playerLock() -> void:
	gravity = 0
	velocity.y = 0
	is_Dead = true

#delete this
func playerForceMove() -> void:
	velocity.x = 1
	pass

#Make it something that the player controls where they place, make it so they can
#only place one when they are grounded
#REMOVE THE ANIMATIONS, KEEP THE CHECKPOINT SETTING
func setCheckpoint() -> void:
	velocity.x = 0
	is_Dead = true #DONT DO THIS, MAKE IT WITH A DIFFERENT BOOL
	animated_sprite.play("SetCheckpoint")

func _on_fan_wind_force_body_entered(_body):
	wind_Push = -0.85

func _on_fan_wind_force_body_exited(_body):
	wind_Push = 1
	
func _on_fade_timer_timeout() -> void:
	fade_sprite.visible = true
	fade_sprite.play("FadeInTest")
	fade_in_timer.start()

func _on_fade_in_timer_timeout() -> void:
	playerReset()
	reset_wait.start()

func _on_lock_timer_timeout() -> void:
	is_Dead = false

func _on_reset_wait_timeout() -> void:
	is_Dead = false
	fade_sprite.play("FadeOutTest")
	mentor_bird_anim.play("MentorBird")
