extends Node2D

export (float) var health=100
export (float) var growthPeriod=30
export(Resource) var dieParticle=load("res://Particles/Lapai.tscn")
const randomness=10
var growth=0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	setGrowthDelay()
	updateGrowthSprite()

func setGrowthDelay():
	$GrowthCycle.wait_time=growthPeriod+rand_range(-randomness, randomness)
	$GrowthCycle.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func updateGrowthSprite():
	var top=$Top/Sprite
	match growth:
		0:top.play("small")
		1:top.play("med")
		2:top.play("big")
			

func updateHealth():
	var root=$Roots/Sprite
	if health>75:
		root.play("damage_0")
	elif health>50:
		root.play("damage_1")
	elif health>25:
		root.play("damage_2")
	else:
		root.play("damage_3")

func damage(amount):
	health-=amount
	updateHealth()
	if health<0:
		$Anim.play("FadeOut")
		var lapai=dieParticle.instance()
		lapai.global_position=$ParticleSpawn.global_position
		lapai.restart()
		get_parent().add_child(lapai)

func die():
	queue_free()

func _on_GrowthCycle_timeout():
	growth+=1
	setGrowthDelay()
	updateGrowthSprite()
