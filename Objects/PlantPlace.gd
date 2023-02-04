extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hasMouse=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if GameManager.plant_scene!=null and hasMouse and Input.is_action_just_pressed("use"):
		GameManager.useSeed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlantPlace_mouse_entered():
	hasMouse=true


func _on_PlantPlace_mouse_exited():
	hasMouse=false
