extends AbstractDestructable

class_name Destructable

export var hp = 5

func take_damage(damage):
	print('Crack!')
	hp -= damage
	emit_signal("health_set", hp)

	if hp <= 0:
		emit_signal("is_destroyed")
