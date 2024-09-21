class_name WorldEditorTab

var worldPallet = ColorPallet.new()
var worldCanvas = WorldCanvas.new()

var selected_temp = 0
var tool = 0

func drawWorldEditorTab():
	# Left section
	ImGui.BeginChild("left pane", Vector2(200, 0) ,ImGui.ChildFlags_Border)
	ImGui.BeginChild("pallet", Vector2(0,400), ImGui.ChildFlags_AutoResizeY)
	worldPallet.drawPallet(7)
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
	for i in 15:
		if (ImGui.SelectableEx("MyObject %d"%i, selected_temp == i)):
			selected_temp = i
	ImGui.EndChild()
	ImGui.SameLine()
