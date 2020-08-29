extends KinematicBody2D

const SPEED : int = 50

var velocity : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("default")

# This executes every frame
func _physics_process(_delta):
	#PowerOff check
	if Input.is_action_just_pressed("power_off"):
		$PowerOffTimer.start()
	if Input.is_action_just_released("power_off"):
		$PowerOffTimer.stop()
	
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
	velocity.x = SPEED
# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	if position.y < 7:
		position.y = 7
	if position.y > 137:
		position.y = 137

#Power off the GameBoy
func _on_PowerOffTimer_timeout():
	get_tree().quit()
