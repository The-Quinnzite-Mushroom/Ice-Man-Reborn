extends RigidBody2D
class_name Moving_Enemy

@export var direction: Vector2 = Vector2.ZERO
@export var can_collide: bool = false
@export var speed: int = 700

func _ready() -> void:
	direction = direction.normalized()

func _physics_process(_delta: float) -> void:
	linear_velocity = direction * speed
	if ($RayCast2D.is_colliding() or $RayCast2D2.is_colliding()) and can_collide:
		swap_direction()

func swap_direction() -> void:
	can_collide = false
	print("SnowMan Collided")
	await get_tree().create_timer(2.0).timeout
	direction *= -1
	can_collide = true
