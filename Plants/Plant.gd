extends Node2D

export (float) var health=100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updateHealth():
	pass #TODO add visual feedback

func damage(amount):
	health-=amount
	print_debug(name, " health left", health)
	if health<0:
		queue_free()
		#TODO visual feedback
