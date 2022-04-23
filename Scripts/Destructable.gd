extends AbstractDestructable

class_name Destructable

export var hp = 1

func take_damage(damage):
	print('Crack!')
	hp -= damage

	if hp <= 0:
		emit_signal("is_destroyed")
