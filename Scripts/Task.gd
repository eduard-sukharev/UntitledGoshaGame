extends KinematicBody2D

class_name Task

var grippers: Dictionary = {}

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
	$Behaviors/Destructable.take_damage(damage)

func _on_Destructable_is_destroyed():
	grippers.clear()
	queue_free()
