extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Velocity X values
const STARTING_VEL = 300.0
const MAX_VEL = 600.0
const ACCEL = 200
const TEMPVECTOR = Vector2(0,-1)

const RUNNING_ANIMATION_SPEEDUP = 2

#wwd wdawdad

#Returns the proportion of how sped up the character is
func get_speedup():
	return (abs(velocity.x) - STARTING_VEL)/STARTING_VEL

func get_vel_jump_modifier():
	var modifier = get_speedup()/2
	if modifier < 0:
		return 1
	return 1 + modifier

func set_running_animaton_speed():
	$AnimatedSprite2D.speed_scale = 1 + RUNNING_ANIMATION_SPEEDUP * get_speedup()

#want to rotate player to the surface they are on
#speed up/slow down animation



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * get_vel_jump_modifier()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.play("running")
		set_running_animaton_speed()
		$AnimatedSprite2D.flip_h = false
		if direction > 0:# Going right
			if velocity.x < STARTING_VEL:
				velocity.x = STARTING_VEL
			else:
				velocity.x += ACCEL*delta
				if velocity.x > MAX_VEL:
					velocity.x = MAX_VEL
		else:# Going left
			$AnimatedSprite2D.flip_h = true
			if velocity.x > -STARTING_VEL:
				velocity.x = -STARTING_VEL
			else:
				velocity.x -= ACCEL*delta
				if velocity.x < -MAX_VEL:
					velocity.x = -MAX_VEL
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.speed_scale = 1
		
	#rotation = TEMPVECTOR.angle_to(velocity)

	move_and_slide()
