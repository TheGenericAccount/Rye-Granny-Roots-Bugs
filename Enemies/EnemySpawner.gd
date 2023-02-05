extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level=0



onready var bugs=[
	preload("res://Enemies/Worm/Worm.tscn")
]

enum Direction{
	left=-1, right=1
}

# Called when the node enters the scene tree for the first time.
func _ready():
	refreshTimer()

func _process(delta):
	GameManager.enemies=get_child_count()-3

func refreshTimer():
	$SpawnTimer.wait_time=10/GameManager.plantValue+ rand_range(0, 1)
	$SpawnTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnEnemy():
	var curr_bug=bugs[level].instance()
	if randi()%2==0:
		print("left")
		curr_bug.move_dir=Direction.right
		curr_bug.position=$Left.position
	else:
		print("right")
		curr_bug.move_dir=Direction.left
		curr_bug.position=$Right.position
	add_child(curr_bug)

func _on_SpawnTimer_timeout():
	spawnEnemy()
	refreshTimer()
