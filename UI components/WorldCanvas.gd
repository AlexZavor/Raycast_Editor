extends Node
class_name WorldCanvas

var newWorldSize = [0,0]
var popupErrText = ""
var settool = 0

@onready var world = get_node("/root/Node/RaycastWorld")
@onready var pallet = get_node("../ColorPallet")

signal drawWorld(data:Array)

func resize():
	var oldCanvas = world.worldCanvas.duplicate(true)
	world.worldCanvas.clear()
	for y in world.worldSize[1]:
		world.worldCanvas.append([])
		for x in world.worldSize[0]:
			if(oldCanvas.size()>y && oldCanvas[0].size()>x):
				world.worldCanvas[y].append(oldCanvas[y][x])
			else:
				world.worldCanvas[y].append(0)

func drawWorldCanvas(tool):
	ImGui.BeginGroup()
	ImGui.BeginChild("item view", Vector2(-300, -ImGui.GetFrameHeightWithSpacing())) # Leave room for 1 line below us
	ImGui.Text("Selected tool: %d" % tool)
	ImGui.Separator()
	if(ImGui.ButtonEx("Resize", Vector2(80,40))):
		newWorldSize[0] = world.worldSize[0]
		newWorldSize[1] = world.worldSize[1]
		ImGui.OpenPopup("resizePopup")
	# Resize popup
	if(ImGui.BeginPopup("resizePopup")):
		ImGui.InputInt2("Size", newWorldSize, ImGui.InputTextFlags_CharsDecimal)
		if(ImGui.Button("Resize")):
			if(newWorldSize[0]>0 && newWorldSize[1]>0):
				world.worldSize[0] = newWorldSize[0]
				world.worldSize[1] = newWorldSize[1]
				popupErrText = ""
				resize()
				ImGui.CloseCurrentPopup();
			else:
				popupErrText = "Cant have a size of 0"
		ImGui.TextColored(Color(1,0,0), popupErrText)
		ImGui.EndPopup()
		
	
	settool = tool
	drawWorld.emit(pallet.transArray(world.worldCanvas))
	ImGui.EndChild()
	ImGui.EndGroup()


func _on_canvas_drawer_touched(x: int, y: int) -> void:
	world.worldCanvas[y][x] = settool
