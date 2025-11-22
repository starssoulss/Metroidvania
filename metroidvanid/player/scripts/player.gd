class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("res://player/debug_jump_indicator.tscn")



#region ///导出变量
@export var move_speed : float = 150
#endregion

#region ///状态机变量
var states : Array[ PlayState ] #状态数组，初始获得所有，后续只保留当前及上一个状态
var current_state : PlayState :  #当前玩家状态
	get : return states.front() #数组首位
var previous_state : PlayState : #上一个玩家状态
	get : return states[ 1 ] #数组第二位
#endregion


#region ///常量
var direction : Vector2 = Vector2.ZERO #方向，二维向量
var gravity : float = 980 #重力，自己定义合适的量
var gravity_mulitplier : float = 1.0 #重力系数，用于调整坠落感
#endregion

#初始化函数
func _ready() -> void:
	initialize_states()
	pass


func _unhandled_input(event: InputEvent) -> void:
	change_state( current_state.handle_input( event ))
	pass

func _process( _delta: float) -> void:
	#调用更新方向函数
	update_direction()
	#调用变更状态函数，由当前状态帧渲染决定返回的新状态
	change_state( current_state.process( _delta ))
	pass


func _physics_process( _delta: float) -> void:
	#施加重力，计算重力在_delta时间内对于y分量的影响
	velocity.y += gravity * _delta * gravity_mulitplier
	#添加移动滑动功能
	move_and_slide()
	#调用变更状态函数，由当前状态物理渲染决定返回的新状态
	change_state( current_state.physics_process( _delta ))
	pass
	
	
#状态机初始化
func initialize_states() -> void:
	states = []
	
	#获得所有状态
	for c in $States.get_children(): 
		if c is PlayState:
			states.append( c )
			c.player = self #绑定角色
		pass
		
	#检查状态数组是否为空，防止报错
	if states.size() == 0:
		return
		
	#完成所有状态初始化
	for state in states: 
		state.init()
		pass
		
	#设置第一个状态，本例中为Idle
	change_state( current_state )
	current_state.enter()
	$Label.text = current_state.name

	pass
	
#状态变更函数
func change_state( new_state : PlayState ) -> void:
	
	#检查是否真的传入新状态
	if new_state == null:
		return
		
	#检查新状态是否为当前状态
	if new_state == current_state:
		return
	
	#检查当前状态是否为空，不为空则执行当前状态退出函数
	if current_state:
		current_state.exit()
		pass
	
	#将新状态置入状态数组首项
	states.push_front( new_state )
	#进入当前状态
	current_state.enter()
	#保持状态数组只有3个项
	states.resize( 3 )
	$Label.text = current_state.name
	pass
	
#方向更新函数
func update_direction() -> void:
	#var prev_direction : Vector2 = direction
	
	#根据输入获得新的方向
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("down", "up")
	direction = Vector2(x_axis, y_axis)
	
	pass
	
func add_debug_indicator( color :Color = Color.RED ) -> void:
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3.0 ).timeout
	d.queue_free()
	pass
