extends KinematicBody

export var speed = 14
export var fall_acceleration = 75

var velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# look_at: 此方法在空间中取一个位置以查看全局坐标和向上方向。在这种情况下，我们可以使用 Vector3.UP 常量
		$Pivot.look_at(translation + direction, Vector3.UP)
	
	# Ground velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# Vertical velocity
	velocity.y -= fall_acceleration * delta
	
	# Moving the character
	# KinematicBody.move_and_slide()。这是 KinematicBody 类的一个强大方法，
	# 可以让你顺利地移动一个角色。如果它在运动过程中撞到了墙，引擎会试着为你把它平滑处理。
	
	# 该函数需要两个参数：我们的速度和向上方向。它移动角色并在应用碰撞后返回剩余的速度。
	# 当撞到地板或墙壁时，该函数将减少或重置你在该方向的速度。
	# 在我们的例子中，存储函数的返回值可以防止角色积累垂直动量，否则可能会变得很大，角色会在一段时间后穿过地面。
	velocity = move_and_slide(velocity, Vector3.UP)
