extends AbstractProcessable

class_name Processable

export var processing_time = 3
var eta = processing_time
const TIME_INCREMENT = 0.1


func _ready():
	$ProcessingProgressBar.max_value = processing_time * 10
	$ProcessingProgressBar.value = processing_time * 10

func start_processing():
	print('Tick!')
	$Timer.start(TIME_INCREMENT)

func stop_processing():
	$Timer.stop()


func _on_Timer_timeout():
	eta -= TIME_INCREMENT
	if eta <= 0:
		emit_signal("done")

	$ProcessingProgressBar.value = eta * 10
