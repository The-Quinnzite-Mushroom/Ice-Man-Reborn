extends CanvasLayer

const FIRST_LEVEL = 1

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func go_to_first_level():
	get_tree().change_scene_to_file("res://levels/level_"+str(FIRST_LEVEL)+".tscn")

func _on_play_again_pressed() -> void:
	go_to_first_level()
