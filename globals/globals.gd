extends Node

signal stats_changed

var health = 50:
	set(value):
		health = value
		stats_changed.emit()
		
var laser_amount = 20:
	set(value):
		laser_amount = value
		stats_changed.emit()
		
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stats_changed.emit()

var current_scene: String = 'outside'
