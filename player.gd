extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var jump_sound = $jump
@onready var death_sound = $death

func _play_death_sound():
	death_sound.stream = preload("res://sound/death.mp3")
	death_sound.play()

func _play_jump_sound():
	jump_sound.stream = preload("res://sound/jump.wav")
	jump_sound.play()
	

	
var isMovable = false
var prev_speed = 0
var pause = false
func _physics_process(delta):
	if pause:
		_play_death_sound()
		get_tree().change_scene_to_file("res://pause_menu.tscn")
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
		if velocity.x == 0 and prev_speed != 0:
			pause = true
			print("stop")
		
		if Input.is_action_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			_play_jump_sound()
		if not isMovable: velocity.x = SPEED
		prev_speed = velocity.x
		move_and_slide()
		if global_position.x >= 3600:get_tree().change_scene_to_file("res://second_level.tscn")
