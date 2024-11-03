extends Node
class_name WorldCanvas

var worldCanvas = [[0,1,0],[1,0,1],[0,1,0]]
var worldSize = [3,3]
var newWorldSize = [0,0]
var popupErrText = ""
#var worldx = 3
#var worldy = 3
@onready var pallet = get_node("../ColorPallet")
var settool = 0

signal drawWorld(data:Array)

func resize():
	var oldCanvas = worldCanvas.duplicate(true)
	worldCanvas.clear()
	for y in worldSize[1]:
		worldCanvas.append([])
		for x in worldSize[0]:
			if(oldCanvas.size()>y && oldCanvas[0].size()>x):
				worldCanvas[y].append(oldCanvas[y][x])
			else:
				worldCanvas[y].append(0)

func drawWorldCanvas(tool):
	ImGui.BeginGroup()
	ImGui.BeginChild("item view", Vector2(-300, -ImGui.GetFrameHeightWithSpacing())) # Leave room for 1 line below us
	ImGui.Text("Selected tool: %d" % tool)
	ImGui.Separator()
	if(ImGui.ButtonEx("Resize", Vector2(80,40))):
		newWorldSize[0] = worldSize[0]
		newWorldSize[1] = worldSize[1]
		ImGui.OpenPopup("resizePopup")
	# Resize popup
	if(ImGui.BeginPopup("resizePopup")):
		ImGui.InputInt2("Size", newWorldSize, ImGui.InputTextFlags_CharsDecimal)
		if(ImGui.Button("Resize")):
			if(newWorldSize[0]>0 && newWorldSize[1]>0):
				worldSize[0] = newWorldSize[0]
				worldSize[1] = newWorldSize[1]
				popupErrText = ""
				resize()
				ImGui.CloseCurrentPopup();
			else:
				popupErrText = "Cant have a size of 0"
		ImGui.TextColored(Color(1,0,0), popupErrText)
		ImGui.EndPopup()
		
	
	settool = tool
	drawWorld.emit(pallet.transArray(worldCanvas))
	ImGui.EndChild()
	ImGui.EndGroup()


func _on_canvas_drawer_touched(x: int, y: int) -> void:
	worldCanvas[y][x] = settool
