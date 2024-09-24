extends Node2D
class_name CanvasDrawer



func _draw():
	draw_circle(Vector2(100,100), 100, Color.RED)
	draw_rect(Rect2(100,100,100,100), Color.AQUA)

func _on_world_canvas_draw_world() -> void:
	pass
