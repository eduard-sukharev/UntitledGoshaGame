extends AbstractDestructable

class_name Destructable

export var hp = 5

func _ready():
	$DamageProgressBar.max_value = hp
	$DamageProgressBar.value = hp

func take_damage(damage):
	print('Crack!')
	hp -= damage
	$DamageProgressBar.value = max(float(hp), 0.0)

	if hp <= 0:
		emit_signal("is_destroyed")
