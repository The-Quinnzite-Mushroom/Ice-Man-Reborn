extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var delta_total = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta_total += delta
	rotation = sin(delta_total*3 + 1)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		
		var ice_circle = area.get_node("./../iceCircle")
		ice_circle.current_health += ice_circle.full_health / 3.0
		
		if ice_circle.current_health > ice_circle.full_health:
			ice_circle.current_health = ice_circle.full_health
			
		
		ice_circle.ice_bar.value = ice_circle.current_health
		ice_circle.play_pickup()
		
		queue_free()
	
