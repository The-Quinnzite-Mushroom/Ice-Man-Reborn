extends RigidBody2D
class_name Moving_Enemy

@export var direction: Vector2 = Vector2.ZERO
var can_collide: bool
@export var speed: int = 700

func _ready() -> void:
	can_collide = true
	direction = direction.normalized()

func _physics_process(_delta: float) -> void:
	if $RayCast2D.is_colliding() and can_collide:
		swap_direction()
	apply_central_force(direction * speed)

func swap_direction() -> void:
	can_collide = false
	await get_tree().create_timer(2.0).timeout
	direction *= -1
	can_collide = true
