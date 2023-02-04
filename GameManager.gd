extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inventory={
	"shovel":{
		"amount":-1,
		"texture":"res://Inventory/Sprites/kastuvas.png",
	},
	"basic":{
		"amount":1,
		"texture":"res://Plants/Plant/1_food_seed.png"
	}
}
var curr_itm="shovel"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
