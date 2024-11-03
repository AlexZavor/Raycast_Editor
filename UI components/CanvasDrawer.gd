extends Node2D
class_name CanvasDrawer

var canvas

@export var width:int
@export var height:int

signal touched(x:int, y:int)

func _draw():
	if canvas: #yay error detection
		for y in canvas.size():
			for x in canvas[0].size():
				var sizex = width/canvas.size()
				var sizey = height/canvas[0].size()
				draw_rect(Rect2(x*sizex,y*sizey,sizex,sizey), canvas[y][x])

func _process(_delta: float) -> void:
	#if(visible):
		#if Input.is_action_just_pressed("click"):
			#touched.emit(Input.get)
	queue_redraw()
	
func _input(event):
	if(visible):
		#if event is InputEventMouseButton:
		if Input.is_action_pressed("click"):
			#print("Mouse Click/Unclick at: ", event.position)
			var click_x = (event.position.x)-(transform.get_origin().x)
			click_x = floor(click_x/(width/canvas[0].size()))
			var click_y = (event.position.y)-(transform.get_origin().y)
			click_y = floor(click_y/(height/canvas.size()))
			if(click_x > -1 && click_x < canvas[0].size() && click_y > -1 && click_y < canvas.size()):
				touched.emit(click_x, click_y)

func _on_world_canvas_draw_world(data) -> void:
	canvas = data
