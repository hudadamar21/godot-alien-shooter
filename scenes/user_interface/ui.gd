extends CanvasLayer

@onready var laser_label: Label = $MarginContainer2/Control/HBoxContainer/LaserCounter/LaserLabel
@onready var grenade_label: Label = $MarginContainer2/Control/HBoxContainer/GrenadeCounter/GrenadeLabel
@onready var laser_icon: TextureRect = %LaserIcon
@onready var grenade_icon: TextureRect = %GrenadeIcon
@onready var health_value: TextureProgressBar = $MarginContainer/HealtBar 
@onready var artefact_found_value: Label = $MarginContainer3/Control/HBoxContainer/ArtefactFound

var red_color: Color = Color("ff4636")
var green_color: Color = Color("ffffff")

func _ready():
	Globals.connect("stats_changed", update_stats_value)
	update_stats_value()

func update_laser_value():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func update_grenade_value():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)

func update_health_value():
	health_value.value = Globals.health

func update_artefact_found():
	artefact_found_value.text = str(Globals.artefact_found) + "/6"

func update_stats_value():
	update_laser_value()
	update_grenade_value()
	update_health_value()
	update_artefact_found()

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount == 0:
		label.modulate = red_color
		icon.modulate = red_color
	else:
		label.modulate = green_color
		icon.modulate = green_color
	
