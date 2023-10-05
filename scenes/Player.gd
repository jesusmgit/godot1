extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") or  Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animationPlayer.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animationPlayer.play("Idle")
	if direction < 0: 
		sprite.flip_h = false
	if direction > 0:
		sprite.flip_h = true  
	
	move_and_slide()
