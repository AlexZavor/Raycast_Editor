extends Node
class_name WorldCanvas

var worldCanvas = [[0,1,0],[1,0,1],[0,1,0]]
var worldx = 3
var worldy = 3
@onready var pallet = get_node("/root/Node/WorldEditorTab/ColorPallet")
var settool = 0

signal drawWorld(data:Array)

func drawWorldCanvas(tool):
	ImGui.BeginGroup()
	ImGui.BeginChild("item view", Vector2(-300, -ImGui.GetFrameHeightWithSpacing())) # Leave room for 1 line below us
	ImGui.Text("Selected tool: %d" % tool)
	ImGui.Separator()
	if(ImGui.ButtonEx("Resize", Vector2(80,40))):
		ImGui.OpenPopup("resizePopup")
	if(ImGui.BeginPopup("resizePopup")):
		ImGui.Button("hi there!, You can't resize yet :3")
		ImGui.EndPopup()
	settool = tool
	drawWorld.emit(pallet.transArray(worldCanvas))
	ImGui.EndChild()
	ImGui.EndGroup()


func _on_canvas_drawer_touched(x: int, y: int) -> void:
	worldCanvas[y][x] = settool
