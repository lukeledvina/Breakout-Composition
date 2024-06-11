extends Area2D

# on spawn, pick a random direction and go
# whenever it collides with the boundaries, reverse velocity of one direction, keep velocity in other direction the same
# if colliding with the paddle, depending on which side of the paddle, change velocity accordingly

var direction: Vector2 = Vector2.ZERO
var initial_speed: int = 100
var speed: int = initial_speed
var velocity: Vector2

func _ready():
	await get_tree().create_timer(0.5).timeout
	
	direction = Vector2(randf_range(-1, 1), randf_range(0.1, 1)).normalized()

func _physics_process(delta):
	
	velocity = direction * speed
	
	position += velocity * delta

func _on_area_left_body_entered(body):
	if body.name == "block":
		#increment score depending on the type of block ( color )
		#increase the speed of the ball
		#destroy the block
		pass
	
	direction.x = -direction.x

func _on_area_up_body_entered(body):
	direction.y = -direction.y

func _on_area_down_body_entered(body):
	
	
	if body.is_in_group("block"):
		#increment score depending on the type of block ( color )
		#increase the speed of the ball
		#destroy the block
		pass
	elif body.name == "Player":
		#reflect differently depending on what area of player hit
		# get the global position of the ball and the player, depending of their difference, reflect accordingly with a gradient
		
		#THIS IS BACKWARDS, THE MORE TO THE EDGES (HIGHER DIFFERENCE), THE LESS Y DIRECTION SHOULD BE AND THE GREATER X DIRECTION SHOULD BE... GET TO THINKING...!
		var player_position_x: float = body.position.x
		var difference = player_position_x - position.x
		direction = Vector2(direction.x, direction.y * difference).normalized()
		
	direction.y = -direction.y
	
	

func _on_area_right_body_entered(body):
	direction.x = -direction.x

