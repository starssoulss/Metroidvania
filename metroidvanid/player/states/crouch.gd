class_name PlayStateCrouch extends PlayState

@export var deceleration_rate : float = 10 #设置减速速率


func init() -> void:
	pass


#进入状态处理函数
func enter() -> void:
	player.animation_player.play( "crouch" )
	#设置禁用
	player.collision_crouch.disabled = false
	player.collision_stand.disabled = true
	pass
	
	
#退出状态处理函数
func exit() -> void:
	#设置禁用
	player.collision_crouch.disabled = true
	player.collision_stand.disabled = false
	pass
	
	
#状态处理输入函数,需要传入输入事件
func handle_input( _event : InputEvent ) -> PlayState:
	#检测单向平台下蹲
	if _event.is_action_pressed( "jump" ):
		player.one_way_platform_shape_cast.force_shapecast_update()
		#if player.one_way_platform_raycast.is_colliding() == true:
		if player.one_way_platform_shape_cast.is_colliding():
			player.position.y += 4
			return fall
		return jump
	return next_state
	
#状态帧渲染处理函数    
func process( _delta: float) -> PlayState:
	if player.direction.y <= 0.5:
		return idle
	return next_state




#状态物理渲染处理函数
func physics_process( _delta: float) -> PlayState:
	#水平向量=0
	player.velocity.x -= player.velocity.x * deceleration_rate * _delta
	if player.is_on_floor() == false:
		return fall
	return next_state
