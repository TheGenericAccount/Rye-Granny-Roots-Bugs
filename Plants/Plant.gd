extends Node2D

export (float) var health=100
export (float) var growthPeriod=30
const randomness=10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	setGrowthDelay()

func setGrowthDelay():
	$GrowthCycle.wait_time=growthPeriod+rand_range(-randomness, randomness)
	$GrowthCycle.start()
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
