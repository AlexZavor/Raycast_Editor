extends Node
class_name LevelEditor

@onready var worldTab = get_node("/root/Node/WorldEditorTab")
@onready var canvasDrawer = get_node("/root/Node/CanvasDrawer")

func drawLevelEditor():
		if (ImGui.BeginTabBar("##Tabs", ImGui.TabBarFlags_TabListPopupButton | ImGui.TabBarFlags_FittingPolicyScroll)):
			if (ImGui.BeginTabItem("World")):
				worldTab.drawWorldEditorTab()
				canvasDrawer.visible = true
				ImGui.EndTabItem()
			if (ImGui.BeginTabItem("Player")):
				ImGui.Text("ID: 0123456789")
				canvasDrawer.visible = false
				ImGui.EndTabItem()
			if (ImGui.BeginTabItem("Texture 1")):
				ImGui.Text("Wow look, it's a texture")
				canvasDrawer.visible = false
				ImGui.EndTabItem()
			if (ImGui.BeginTabItem("Object: \"flower\"")):
				ImGui.Text("pretty flower")
				canvasDrawer.visible = false
				ImGui.EndTabItem()
			ImGui.EndTabBar()
