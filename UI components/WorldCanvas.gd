extends Node
class_name WorldCanvas

var worldCanvas = [[0,0,0],[0,0,0],[0,0,0]]
var pallet
var has_pallet = false;

signal drawWorld

func drawWorldCanvas(tool):
	ImGui.BeginGroup()
	ImGui.BeginChild("item view", Vector2(-300, -ImGui.GetFrameHeightWithSpacing())) # Leave room for 1 line below us
	ImGui.Text("Selected tool: %d" % tool)
	ImGui.Separator()
	drawWorld.emit()
	ImGui.EndChild()
	ImGui.Button("Revert")
	ImGui.SameLine()
	ImGui.Button("Save")
	ImGui.EndGroup()
