extends Node

const LAST_LEVEL = 10 # When player gets to the end of this level they win

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level_num = sneaky_level_getter()

# Gets level number based on name of scene
func sneaky_level_getter():
	var text = name
	var chars_to_remove = ["L","e","v","l"]
	for c in chars_to_remove:
		text = text.replace(c, "")
	return int(text)

func go_to_next_level():
	var level_num = sneaky_level_getter()
	if level_num == LAST_LEVEL:
		get_tree().change_scene_to_file("res://levels/win_screen.tscn")
		
	else:
		print("leveing level",level_num)
		get_tree().change_scene_to_file("res://levels/level_"+str(sneaky_level_getter()+1)+".tscn")

func reload_level():
	get_tree().reload_urrent_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_exit_area_entered(area: Area2D) -> void:
	go_to_next_level()
