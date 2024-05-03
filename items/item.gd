extends Area2D


var rotation_speed = 5
var available_items = ['laser','laser','laser','laser', 'grenade', 'health']
var item = available_items[randi()%len(available_items)]


func _ready():
	
	if item == 'laser':
		$Sprite2D.modulate = Color('008bff')
	if item == 'grenade':
		$Sprite2D.modulate = Color('ff7200')
	if item == 'health':
		$Sprite2D.modulate = Color('00cf19')
		
func _process(delta):
	$Sprite2D.rotation += rotation_speed * delta


func _on_body_entered(_body):
	if item == 'laser':
		Globals.laser_amount += 5
	if item == 'grenade':
		Globals.grenade_amount += 1
	if item == 'health' and Globals.health < 100:
		Globals.health += 20
	queue_free()
