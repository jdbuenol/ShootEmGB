extends KinematicBody2D

const SPEED : int = 50

var velocity : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("default")

# This executes every frame
func _physics_process(_delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
# warning-ignore:return_value_discarded
	move_and_slide(velocity)
