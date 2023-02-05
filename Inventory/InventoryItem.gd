extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String) var itm_name=""

# Called when the node enters the scene tree for the first time.
func _ready():
	if itm_name in GameManager.inventory:
		$Item/ItemSprite.texture=GameManager.inventory[itm_name].texture
func select_itm():
	if !GameManager.inventory.has(itm_name) or GameManager.inventory[itm_name]["amount"]<=0:
		return
	get_node("Anim").play("select")
	GameManager.updateCurrItm(itm_name)

func _process(delta):
	if GameManager.inventory.has(itm_name):
		if GameManager.inventory[itm_name]["stackable"]:
			$Item/Amount.visible=true
		else:
			$Item/Amount.visible=false
		$Item/Amount.text=str(GameManager.inventory[itm_name]["amount"])
	$Item.rect_rotation=-rect_rotation
	if itm_name in GameManager.inventory:
		$Item.visible=true
	else:
		$Item.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
