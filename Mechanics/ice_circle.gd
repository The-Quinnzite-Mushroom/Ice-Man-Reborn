extends Node2D

signal ice_placed(position: Vector3, rotation: Vector3)
signal out_of_ice()

@onready var ice_placement_indictor: MeshInstance2D = $icePlacementIndictor

@onready var ice_bar: ProgressBar = $CanvasLayer/MarginContainer/IceBar


@export var ice_placement_radius = 2

var mouse_direction: Vector2
var ice_placement_direction: Vector2
var spawning_ice: bool = false

@export var full_health = 50.0
@export var placement_cost = 0.5
@export var current_health = 50
@export var use_full_health: bool = true


func _ready() -> void:
	if use_full_health:
		current_health = full_health
	ice_bar.max_value = full_health
	ice_bar.value = current_health
	


func _physics_process(delta: float) -> void:
	
	mouse_direction = get_mouse_direction()
	
	ice_placement_direction = Vector2(-mouse_direction.y, mouse_direction.x)
	ice_placement_indictor.position = mouse_direction * ice_placement_radius
	
	if spawning_ice:
		spawn_ice_rectangle()
	
func take_damage(damage):
	current_health -= damage
	ice_bar.value = current_health
	
	if current_health <= 0.0:
		await get_tree().create_timer(0.5).timeout
		if current_health <= 0.0:
			out_of_ice.emit()
			print("signal")

func spawn_ice_rectangle():
	ice_placed.emit((mouse_direction*ice_placement_radius) + global_position, ice_placement_direction.angle())
	current_health -= placement_cost
	ice_bar.value = current_health
	print(current_health)
	if current_health <= 0.0:
		out_of_ice.emit()

func get_mouse_direction():
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	return direction
func play_pickup():
	$PickupSound.play()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			spawning_ice = true
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			spawning_ice = false
