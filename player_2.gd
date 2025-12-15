extends CharacterBody2D

@onready var ice_circle: Node2D = $iceCircle
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var blood_particles: CPUParticles2D = $bloodParticles


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Velocity X values
const STARTING_VEL = 300.0
const MAX_VEL = 600.0
const ACCEL = 200
const TEMPVECTOR = Vector2(0,1)

const RUNNING_ANIMATION_SPEEDUP = 2
const RUN_TILT = PI/ 8


func _ready() -> void:
	ice_circle.out_of_ice.connect(player_dead)
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
		#rotation = velocity.angle_to(TEMPVECTOR)
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
		rotation = 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.speed_scale = 1
		
	

	move_and_slide()


func _on_player_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		ice_circle.take_damage(100)
		velocity /= 2
		$DeathSound.play()
	if area.is_in_group("spikes"):
		ice_circle.take_damage(1000)
		$DeathSound.play()
	
func player_dead():
	
	
	
	var death_timer = Timer.new()
	death_timer.wait_time = 0.5
	death_timer.one_shot = true
	add_child(death_timer)
	death_timer.timeout.connect(restart_level)
	
	animated_sprite_2d.visible = false
	print("player should die")
	
	blood_particles.emitting = true
	
	
	#var death_tween = create_tween()
	#death_tween.tween_property(animated_sprite_2d, "modulate:a", 0.0, 0.4)
	
	death_timer.start()
	
	

func restart_level():
	get_tree().reload_current_scene()
