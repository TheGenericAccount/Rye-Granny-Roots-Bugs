extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level=0



onready var bugs=[
	preload("res://Enemies/Worm/Worm.tscn"),
	preload("res://Enemies/Bug/Bug.tscn"),
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
	var lvl=0
	var better_ticket=(max(0, GameManager.plantValue-8)*7)
	if rand_range(0, 100)<better_ticket:
		lvl=1
	else:
		lvl=0
	
	var curr_bug=bugs[lvl].instance()
	if randi()%2==0:
		print("left")
		curr_bug.move_dir=Direction.right
		curr_bug.position=$Left.position
	else:
		print("right")
		curr_bug.move_dir=Direction.left
		curr_bug.position=$Right.position
	add_child(curr_bug)

	$SpawnTimer.wait_time=(lvl+1)*10/GameManager.plantValue+ rand_range(0, 1)
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	spawnEnemy()
