extends CharacterBody2D

const SPEED = 300

var initial_position: Vector2 = Vector2(320, 320)

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = SPEED * direction
	
	move_and_slide()

func reset_player():
	position = initial_position
