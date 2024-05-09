extends Area2D


var rotation_speed = 5
var available_items = ['laser','laser','laser','laser', 'grenade', 'health']
var item = available_items[randi()%len(available_items)]

var direction: Vector2
var distance: int = randi_range(150, 250)

#colors
var green_color: Color = Color('588f13d5')
var blue_color: Color = Color('1984c5d5')
var orange_color: Color = Color('b46800d5')

func _ready():
	
	if item == 'laser': $Sprite2D.modulate = blue_color
	if item == 'grenade': $Sprite2D.modulate = orange_color
	if item == 'health': $Sprite2D.modulate = green_color
		
	#tween
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0.2,0.2))
		
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
