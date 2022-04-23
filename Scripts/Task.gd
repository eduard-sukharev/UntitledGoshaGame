extends KinematicBody2D

class_name Task

func _physics_process(delta):
	$Behaviors/Movable.move(self, delta)

func _on_LookoutRange_body_entered(body: Node2D):
	if body.is_in_group('player') and not $Behaviors/Movable.avoid_objects.has(body.get_name()):
		$Behaviors/Movable.avoid_objects[body.get_name()] = body


func _on_LookoutRange_body_exited(body):
	if body.is_in_group('player'):
		$Behaviors/Movable.avoid_objects.erase(body.get_name())
