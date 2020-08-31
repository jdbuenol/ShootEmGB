extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2.visible = false
	$AnimationPlayer.play("enemy")

#This executes every frame
func _physics_process(_delta):
	position.x += 1

# basic enemy die from one hit
func get_hurt():
	$Sprite2.visible = true
	$AnimationPlayer.queue_free()
	$Sprite.queue_free()
	$CollisionShape2D.queue_free()
	$AnimationPlayer2.play("death")

func _on_AnimationPlayer2_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
