extends Node2D

const CURRENT_LEVEL_NUM = 1

func go_to_next_level():
	get_tree().change_scene_to_file("res://levels/level_"+str(CURRENT_LEVEL_NUM)+".tscn")
