extends Node2D

const ICE_RECTANGLE = preload("res://Mechanics/ice_rectangle.tscn")

@export var character_body_2d: CharacterBody2D
@export var placement_epsilon = 1.0

var ice_rectangles: Array[IceRectangle] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ice_spawner = character_body_2d.get_node("./iceCircle") 
	ice_spawner.ice_placed.connect(spawn_ice_rectangle)
	
	

func spawn_ice_rectangle(rectangle_position, rectangle_rotation):
	
	var new_ice_rectangle = ICE_RECTANGLE.instantiate()
	add_child(new_ice_rectangle)
	
	new_ice_rectangle.global_position = rectangle_position
	new_ice_rectangle.rotation = rectangle_rotation
	
	new_ice_rectangle.melted.connect(remove_ice_rectangle)
	new_ice_rectangle.ice_hit.connect(projectile_hit_ice_rectangle)
	
	ice_rectangle_placement(new_ice_rectangle)
	

func ice_rectangle_placement(ice_rectangle):
	
	var removed_idxs = []
	#print("before: " + str(ice_rectangles))
	
	# checks to see if other rectangles are too close
	
	for i in range(ice_rectangles.size()):
		if ice_rectangles[i]:
			if ice_rectangles[i].global_position.distance_to(ice_rectangle.global_position) < placement_epsilon:
				removed_idxs.append(i)
				ice_rectangles[i].queue_free()
		else:
			removed_idxs.append(i)
	
	# deletes null and rectangles that are too close	
	for removed_idx in removed_idxs:
		ice_rectangles.remove_at(removed_idx)
		
	
	ice_rectangles.append(ice_rectangle)
	#print("After: " + str(ice_rectangles))
				
	

func projectile_hit_ice_rectangle(projectile_position, projectile_hit_radius):
	'''
	var removed_idxs = []
	for i in range(ice_rectangles.size()):
		if ice_rectangles[i].global_position.distance_to(projectile_position) < projectile_hit_radius:
			removed_idxs.append(i)
			ice_rectangles[i].queue_free()
			
	for removed_idx in removed_idxs:
		ice_rectangles.remove_at(removed_idx)
	'''
	pass
	

func remove_ice_rectangle(ice_rectangle_id):
	
	print(ice_rectangles)

	for i in range(len(ice_rectangles)):
		
		if !ice_rectangles[i] or ice_rectangles[i] == ice_rectangle_id:
			ice_rectangles.remove_at(i)
			break

		
	
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
