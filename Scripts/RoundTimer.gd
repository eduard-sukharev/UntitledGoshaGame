extends Timer

export var _count = 120

signal counted_down(number)
signal time_is_out()

func _ready() -> void:
	connect("timeout", self, "_on_Timer_timeout")


func _on_Timer_timeout() -> void:
	emit_signal("counted_down", _count)

	_count -= 1

	if _count < 0:
		stop()
		emit_signal("time_is_out")
