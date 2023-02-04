extends KinematicBody2D
onready var GRAVITY=ProjectSettings.get_setting("physics/2d/default_gravity")
enum Direction{
	left=-1, right=1
}

enum State{
	moving, attacking
}

export (Direction) var move_dir=Direction.right
export (float) var speed=150
export (float) var damage=10
export (float) var health=20
export (Resource) var damageParticle=load("res://Particles/Traiskiux.tscn")
export (Resource) var deathParticle=load("res://Particles/Traiskiuxmazas.tscn")

var curr_state=State.moving
var target=null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var velocity=Vector2.ZERO

func updateState():
	match curr_state:
		State.moving:
			velocity.x=speed*move_dir
			$Sprite.play("Move")
		State.attacking:
			velocity.x=0
			$Sprite.play("Eat")
	match move_dir:
		Direction.left:
			$Sprite.flip_h=false
		Direction.right:
			$Sprite.flip_h=true

func _ready():
	updateState()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	updateState()
	velocity=move_and_slide(velocity)


func _on_DetectionRight_area_entered(area):
	curr_state=State.attacking
	move_dir=Direction.right
	target=area.get_parent()
	$AttackTimer.start()
	updateState()


func _on_DetectionLeft_area_entered(area):
	curr_state=State.attacking
	move_dir=Direction.left
	target=area.get_parent()
	$AttackTimer.start()
	updateState()

func stopAttack():
	$AttackTimer.stop()
	curr_state=State.moving
	updateState()

func _on_DetectionRight_area_exited(area):
	stopAttack()


func _on_DetectionLeft_area_exited(area):
	stopAttack()
	
func _on_AttackTimer_timeout():
	#TODO animate
	if !is_instance_valid(target) or !target.has_method("damage"):
		stopAttack()
		return
	target.damage(damage)
	
func damage(amount):
	health-=amount
	var explosion_small=damageParticle.instance()
	explosion_small.global_position=global_position
	get_parent().add_child(explosion_small)
	explosion_small.restart()
	if health<=0:
		var explosion=deathParticle.instance()
		explosion.global_position=global_position
		get_parent().add_child(explosion)
		explosion.restart()
		queue_free()
	
