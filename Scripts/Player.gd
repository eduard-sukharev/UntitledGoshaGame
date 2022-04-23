extends KinematicBody2D

class_name Player

func _physics_process(delta):
	$Behaviors/Movable.move(self, delta)


