class_name WorldCanvas

var worldCanvas = [[0,0,0],[0,0,0],[0,0,0]]

func drawWorldCanvas(tool):
	ImGui.BeginGroup()
	ImGui.BeginChild("item view", Vector2(-300, -ImGui.GetFrameHeightWithSpacing())) # Leave room for 1 line below us
	ImGui.Text("Selected tool: %d" % tool)
	ImGui.Separator()
	ImGui.EndChild()
	ImGui.Button("Revert")
	ImGui.SameLine()
	ImGui.Button("Save")
	ImGui.EndGroup()
