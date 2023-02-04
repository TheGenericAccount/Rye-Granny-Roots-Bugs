extends Node

var itm_indicator
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var inventory={
	"shovel":{
		"amount":-1,
		"texture":preload("res://Inventory/Sprites/kastuvas.png"),
		"stackable":false
	},
	"basic":{
		"amount":1,
		"texture":preload("res://Plants/Plant/1_food_seed.png"),
		"stackable":true
	}
}
var curr_itm="shovel"

func updateCurrItm(itm):
	if !inventory.has(itm):
		return
	curr_itm=itm
	itm_indicator.get_node("Texture").texture=inventory[curr_itm].texture
	if(inventory[curr_itm].stackable):
		itm_indicator.get_node("Label").text=str(inventory[curr_itm].amount)
		itm_indicator.get_node("Label").visible=true
	else:
		itm_indicator.get_node("Label").visible=false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
