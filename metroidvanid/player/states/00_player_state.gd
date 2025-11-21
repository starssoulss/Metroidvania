@icon("res://player/states/state.svg")
class_name PlayState extends Node

var player : Player
var next_state : PlayState

#region ///所有其他状态的索引

#endregion

#状态初始化函数
func init() -> void:
	pass


#进入状态处理函数
func enter() -> void:
	pass
	
	
#退出状态处理函数
func exit() -> void:
	pass
	
	
	
#状态处理输入函数,需要传入输入事件
func handle_input( _event : InputEvent ) -> PlayState:
	return next_state



#状态帧渲染处理函数    
func process( _delta: float) -> PlayState:
	return next_state




#状态物理渲染处理函数
func physics_process( _delta: float) -> PlayState:
	return next_state
