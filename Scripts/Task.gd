extends KinematicBody2D

class_name Task

var grippers: Dictionary = {}

func configure(config):
	if 'processable' in config:
		var p_instance = load("res://Scenes/Processable.tscn").instance()
		p_instance.processing_time = config['processable']['processing_time']
		p_instance.set_name('Processable')
		p_instance.connect("done", self, '_on_Processable_done')
		$Behaviors.add_child(p_instance, true)

	if 'destructable' in config:
		var d_instance = load("res://Scenes/Destructable.tscn").instance()
		d_instance.hp = config['destructable']['hp']
		d_instance.set_name('Destructable')
		d_instance.connect("is_destroyed", self, '_on_Destructable_is_destroyed')
		$Behaviors.add_child(d_instance, true)

func _physics_process(delta):
	if grippers.empty():
		$Behaviors/Movable.move(self, delta)

func _on_LookoutRange_body_entered(body: Node2D):
	if body.is_in_group('player') and not $Behaviors/Movable.avoid_objects.has(body.get_name()):
		$Behaviors/Movable.avoid_objects[body.get_name()] = body


func _on_LookoutRange_body_exited(body):
	if body.is_in_group('player'):
		$Behaviors/Movable.avoid_objects.erase(body.get_name())

func grip(body: Node2D):
	grippers[body.get_name()] = body

func release(body: Node2D):
	grippers.erase(body.get_name())

func take_damage(damage):
	for behavior in $Behaviors.get_children():
		if behavior is AbstractDestructable:
			behavior.take_damage(damage)

func start_processing():
	for behavior in $Behaviors.get_children():
		if behavior is AbstractProcessable:
			behavior.start_processing()

func stop_processing():
	for behavior in $Behaviors.get_children():
		if behavior is AbstractProcessable:
			behavior.stop_processing()

func _on_Destructable_is_destroyed():
	grippers.clear()
	queue_free()

func _on_Processable_done():
	grippers.clear()
	queue_free()
