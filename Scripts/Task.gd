extends KinematicBody2D

class_name Task

var grippers: Dictionary = {}
var tech_debt_config : Dictionary = {}
var possible_tech_debt : int
var cost : int

signal generate_technical_debt()

const DEFAULT_COST = 10
const DEFAULT_TECH_DEBT_LIMIT = 0

func configure(config: Dictionary):
	var types = config.get('types', {})
	if 'processable' in types:
		var p_instance = load("res://Scenes/Processable.tscn").instance()
		p_instance.processing_time = types['processable']['processing_time']
		p_instance.set_name('Processable')
		p_instance.connect("done", self, '_on_Processable_done')
		$Behaviors.add_child(p_instance, true)

	if 'destructable' in types:
		var d_instance = load("res://Scenes/Destructable.tscn").instance()
		d_instance.hp = types['destructable']['hp']
		d_instance.set_name('Destructable')
		d_instance.connect("is_destroyed", self, '_on_Destructable_is_destroyed')
		$Behaviors.add_child(d_instance, true)

	cost = config.get('cost', DEFAULT_COST)
	possible_tech_debt = config.get('tech_debt_limit', DEFAULT_TECH_DEBT_LIMIT)

	tech_debt_config = config.get('tech_debt', {})

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
	var damaged = false
	for behavior in $Behaviors.get_children():
		if behavior is AbstractDestructable:
			behavior.take_damage(damage)
			damaged = true
	if not damaged:
		print('generate tech debt')
		_generate_tech_debt()

func start_processing():
	var processed = false
	for behavior in $Behaviors.get_children():
		if behavior is AbstractProcessable:
			behavior.start_processing()
			processed = true
	if not processed:
		print('generate tech debt')
		_generate_tech_debt()

func stop_processing():
	for behavior in $Behaviors.get_children():
		if behavior is AbstractProcessable:
			behavior.stop_processing()

func _generate_tech_debt():
	if tech_debt_config.size() > 0 and possible_tech_debt > 0:
		$TaskSpawner.configure(tech_debt_config)
		possible_tech_debt -= 1
		cost -= tech_debt_config.get('cost', DEFAULT_COST)
		print('New task cost: ', cost)

func _award_grippers():
	var award = cost / grippers.size()
	for gripper_name in grippers:
		grippers[gripper_name].award(award)

func _on_Destructable_is_destroyed():
	_award_grippers()
	grippers.clear()
	queue_free()

func _on_Processable_done():
	_award_grippers()
	grippers.clear()
	queue_free()


func _on_TaskSpawner_new_task(task):
	get_parent().add_child(task)
