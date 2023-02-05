extends Node2D

export (float) var health=100
export (float) var value=1.5
export (float) var growthPeriod=30
export(Resource) var dieParticle=load("res://Particles/Lapai.tscn")
export(String)var normalSeed=""
export(int) var minSeeds=1
export(int)var maxSeeds=3
export(String)var specialSeed=""
export(float) var specialProbability=.2
const randomness=10
var growth=0
var player_in_range=false

var noPotatoes=0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Roots/Sprite.play("grow")
	$Roots/Sprite.set_frame(1)
	GameManager.plantValue+=value
	$AddDelay.start()
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

func _process(delta):
	if growth>=2 and player_in_range:
		$HarvestLabel.visible=true
		if Input.is_action_just_pressed("harvest"):
			harvest()
	else:
		$HarvestLabel.visible=false

func harvest():
	GameManager.play_sound(load("res://Audio/PlantTake.wav"), 60)
	GameManager.plantValue-=value
	var rng=RandomNumberGenerator.new()
	rng.randomize()
	if(normalSeed!=""):
		var amount=rng.randi_range(0, 1)
		GameManager.addSeed(normalSeed, noPotatoes)
	if(specialSeed!="'"):
		var res=rng.randf_range(0.0, 1.0)
		if res<=specialProbability:
			GameManager.addSeed(specialSeed)
	queue_free()

func damage(amount):
	if(noPotatoes>0):
		remove_potato()
		return
	health-=amount
	updateHealth()
	if health<0:
		$Anim.play("FadeOut")
		var lapai=dieParticle.instance()
		lapai.position=Vector2(0, -150)
		lapai.restart()
		get_parent().add_child(lapai)

func die():
	GameManager.plantValue-=value
	queue_free()

func add_potato():
	var pot
	while !pot or pot.visible:
		pot=$Potatoes.get_children()[randi()%$Potatoes.get_child_count()]
	pot.visible=true
	noPotatoes+=1

func remove_potato():
	noPotatoes=max(0, noPotatoes-1)
	for c in $Potatoes.get_children():
		if(c.visible):
			c.visible=false
			break

func _on_GrowthCycle_timeout():
	if growth<2:
		GameManager.play_sound(load("res://Audio/Grow.wav"), 60)
		$AddDelay.start()
	growth+=1
	setGrowthDelay()
	updateGrowthSprite()


func _on_Top_body_entered(body):
	player_in_range=true


func _on_Top_body_exited(body):
	player_in_range=false


func _on_AddDelay_timeout():
	add_potato()
