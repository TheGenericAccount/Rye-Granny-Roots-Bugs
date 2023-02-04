extends KinematicBody2D

const WALK_SPEED = 600
const JUMP_FORCE = 0
const DAMPING=0.3
onready var GRAVITY=ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2()
var screen_size
func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		$Sprite.flip_h=true
	elif Input.is_action_pressed("ui_right"):
		velocity.x = WALK_SPEED
		$Sprite.flip_h=false
	else:
		velocity.x = lerp(velocity.x, 0, DAMPING)
	if abs(velocity.x)>WALK_SPEED/2:
		$Sprite.play("walk")
	else:
		$Sprite.play("stand")
	
	#if Input.is_action_pressed("ui_up") and is_on_floor():
	#	velocity.y = -JUMP_FORCE
	 
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# prevent player going out of screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
