extends Node2D
class_name CanvasDrawer

var canvas
@onready var world:RaycastWorld = get_node("/root/Node/RaycastWorld")

@export var width:int
@export var height:int

signal touched(x:int, y:int)

func _draw():
	if canvas: #yay error detection
		var sizex = width/canvas.size()
		var sizey = height/canvas[0].size()
		for y in canvas.size():
			for x in canvas[0].size():
				draw_rect(Rect2(x*sizex,y*sizey,sizex,sizey), canvas[y][x])
		if world.player && world.selected_editor == 0:
			draw_rect(Rect2(world.player.pos_x[0]*sizex, 
							world.player.pos_y[0]*sizey, 5,5), 
							Color(world.player.color[0],world.player.color[1],world.player.color[2]))
			for obj in world.objects:
				draw_rect(Rect2(obj.x[0]*sizex, 
								obj.y[0]*sizey, 5,5), 
								Color(obj.color_disp[0],obj.color_disp[1],obj.color_disp[2]))

func _process(_delta: float) -> void:
	queue_redraw()
	
func _input(event):
	if(visible):
		#if event is InputEventMouseButton:
		if Input.is_action_pressed("click"):
			if Input.is_key_pressed(KEY_CTRL): # err handle because why?
				return
			#print("Mouse Click/Unclick at: ", event.position)
			var click_x = (event.position.x)-(transform.get_origin().x)
			click_x = floor(click_x/(width/canvas[0].size()))
			var click_y = (event.position.y)-(transform.get_origin().y)
			click_y = floor(click_y/(height/canvas.size()))
			if(click_x > -1 && click_x < canvas[0].size() && click_y > -1 && click_y < canvas.size()):
				touched.emit(click_x, click_y)

func _on_world_canvas_draw_world(data) -> void:
	canvas = data
