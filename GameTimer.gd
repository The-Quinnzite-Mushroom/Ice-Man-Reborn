extends Node
class_name GameTimer

signal started
signal stopped
signal reset

var _running := false
var _elapsed := 0.0

func _process(delta):
	if _running:
		_elapsed += delta

func start():
	_elapsed = 0.0
	_running = true
	started.emit()

func stop():
	if not _running:
		return
	_running = false
	stopped.emit()

func resume():
	_running = true

func reset_timer():
	_elapsed = 0.0
	reset.emit()

func is_running() -> bool:
	return _running

func time() -> float:
	return _elapsed

func formatted_time() -> String:
	var minutes := int(_elapsed) / 60
	var seconds := int(_elapsed) % 60
	var milliseconds := int((_elapsed - int(_elapsed)) * 1000)

	return "%02d:%02d.%03d" % [minutes, seconds, milliseconds]
