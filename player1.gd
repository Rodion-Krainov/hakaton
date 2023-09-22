extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -700.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var prev_speed = 0
var pause = false
func _physics_process(delta):
	if pause:
		get_tree().change_scene_to_file("res://pause_menu.tscn")
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
		# Handle Jump.
		if Input.is_action_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		prev_speed = velocity.x
		move_and_slide()
		if global_position.y > 800:
			get_tree().change_scene_to_file("res://pause_menu.tscn")
