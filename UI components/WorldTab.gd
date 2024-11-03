extends Node
class_name WorldEditorTab
var type = "WorldEditorTab"

@onready var worldPallet = get_node("ColorPallet")
@onready var worldCanvas = get_node("./WorldCanvas")

var tool = 0


func drawWorldEditorTab():
	# Left section
	ImGui.BeginChild("left pane", Vector2(200, 0) ,ImGui.ChildFlags_Border)
	ImGui.BeginChild("pallet", Vector2(0,400), ImGui.ChildFlags_AutoResizeY)
	worldPallet.drawPallet(7)
	tool = worldPallet.colorSelection
	ImGui.Dummy(Vector2(0,100))
	ImGui.EndChild()
	ImGui.SeparatorText("Tools")
	ImGui.Button("Items:\ndraw, texture, object")
	ImGui.EndChild()
	
	ImGui.SameLine()
	
	# Center, world canvas
	worldCanvas.drawWorldCanvas(tool)
	ImGui.SameLine()
	
	# Right side
	ImGui.BeginChild("right pane", Vector2(0, 0), ImGui.ChildFlags_Border)
	ImGui.SeparatorText("Objects")
	ImGui.Text("Player")
	ImGui.Separator()
	ImGui.Text("Flower")
	ImGui.Indent()
	ImGui.Text("Position")
	ImGui.SameLine()
	ImGui.InputInt2("", [1,1])
	ImGui.Unindent()
	ImGui.EndChild()
	ImGui.SameLine()
