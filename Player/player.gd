extends CharacterBody2D

const SPEED = 200



func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = SPEED * direction
	
	move_and_slide()

