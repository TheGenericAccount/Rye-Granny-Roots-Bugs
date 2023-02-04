extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var itm_name=""

# Called when the node enters the scene tree for the first time.
func _ready():
	if itm_name in GameManager.inventory:
		$Item/ItemSprite.texture=load(GameManager.inventory[itm_name].texture)

func select_itm():
	GameManager.curr_itm=itm_name

func _process(delta):
	$Item.rect_rotation=-rect_rotation
	if itm_name in GameManager.inventory and abs(GameManager.inventory[itm_name].amount)>0:
		$Item.visible=true
	else:
		$Item.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
