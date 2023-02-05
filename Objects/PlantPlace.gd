extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hasMouse=false
const MAX_PLANT_DISTANCE=400
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if $PlantPivot.get_node_or_null("plant"):
		return
	if GameManager.plant_scene!=null and hasMouse and global_position.distance_to(GameManager.player.global_position)<MAX_PLANT_DISTANCE:
		if $PlantPivot.get_node_or_null("ghost")==null:
			var ghost=GameManager.plant_ghost.instance()
			ghost.name="ghost"
			#ghost.position=$PlantPivot.position
			ghost.position=Vector2.ZERO
			$PlantPivot.add_child(ghost)
		if Input.is_action_just_pressed("use"):
			plant()
	else:
		destroyGhost()

func plant():
	destroyGhost()
	var plant=GameManager.plant_scene.instance()
	plant.name="plant"
	plant.position=Vector2.ZERO
	#plant.position=$PlantPivot.position
	$PlantPivot.add_child(plant)
	GameManager.useSeed()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func destroyGhost():
	var ghost =$PlantPivot.get_node_or_null("ghost")
	if ghost!=null:
		ghost.queue_free()

func _on_PlantPlace_mouse_entered():
	hasMouse=true


func _on_PlantPlace_mouse_exited():
	hasMouse=false
