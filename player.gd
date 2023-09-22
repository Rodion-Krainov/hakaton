extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var isMovable = false
var prev_speed = 0
var pause = false
func _physics_process(delta):
	if pause:
		get_tree().change_scene_to_file("res://pause_menu.tscn")
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		
		if velocity.x == 0 and prev_speed != 0:
			pause = true
			print("stop")
			pass
		
		# Handle Jump.
		if Input.is_action_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		#var direction = Input.get_axis("ui_left", "ui_right")
		#if direction:
		#	velocity.x = direction * SPEED
		#else:
		#	velocity.x = move_toward(velocity.x, 0, SPEED)
		if not isMovable: velocity.x = SPEED
		prev_speed = velocity.x
		move_and_slide()
		if global_position.x >= 3600:
			get_tree().change_scene_to_file("res://second_level.tscn")
