extends Node

var itm_indicator
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var inventory={
	"shovel":{
		"amount":1,
		"texture":preload("res://Inventory/Sprites/kastuvas.png"),
		"stackable":false
	},
	"basic":{
		"amount":1,
		"texture":preload("res://Plants/Plant/1_food_seed.png"),
		"plant_scene":preload("res://Plants/Plant.tscn"),
		"plant_ghost":preload("res://Plants/PlantGhost.tscn"),
		"stackable":true
	}
}
var curr_itm="shovel"
var plant_scene=null
var plant_ghost=null

func updateCurrItm(itm):
	if !inventory.has(itm) or (inventory[curr_itm]["amount"]<=0):
		itm="shovel"
	curr_itm=itm
	itm_indicator.get_node("Texture").texture=inventory[curr_itm].texture
	if(inventory[curr_itm].stackable):
		itm_indicator.get_node("Label").text=str(inventory[curr_itm].amount)
		itm_indicator.get_node("Label").visible=true
	else:
		itm_indicator.get_node("Label").visible=false
	
	if inventory[curr_itm].has("plant_scene")and inventory[curr_itm]["amount"]>0:
		plant_scene=inventory[curr_itm]["plant_scene"]
		plant_ghost=inventory[curr_itm]["plant_ghost"]
	else:
		plant_scene=null
		plant_ghost=null

func useSeed():
	inventory[curr_itm]["amount"]-=1
	updateCurrItm(curr_itm)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#updateCurrItm(curr_itm)
	#TRIGGERS FROM ITM INDICATOR

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
