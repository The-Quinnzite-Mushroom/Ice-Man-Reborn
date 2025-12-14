extends Node2D

#How this works:
#Instatiate desired tile map
#Add level exit rect on whatever you want


func _on_level_exit_area_entered(area: Area2D) -> void:
	if area.name == "playerArea":
		get_parent().go_to_next_level()
