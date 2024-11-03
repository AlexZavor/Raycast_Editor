extends Node
class_name LevelEditor

#@onready var worldTab = get_node("./WorldEditorTab")
@onready var canvasDrawer = get_node("/root/Node/CanvasDrawer")

var tabs = ["World", "Player"]
@onready var nodes = [get_node("./WorldEditorTab"), get_node("./PlayerEditorTab")]
#var openTabs = [true, true]

func drawLevelEditor():
	if (ImGui.BeginTabBar("Tabs", ImGui.TabBarFlags_TabListPopupButton | ImGui.TabBarFlags_FittingPolicyScroll | ImGui.TabBarFlags_AutoSelectNewTabs)):
		for i in tabs.size():
			if (ImGui.BeginTabItem(tabs[i])):
				canvasDrawer.visible = false
				if(nodes[i].type == "WorldEditorTab"):
					nodes[i].drawWorldEditorTab()
					canvasDrawer.visible = true
				elif(nodes[i].type == "PlayerEditorTab"):
					nodes[i].drawPlayerEditorTab()
				ImGui.EndTabItem()
		#if (ImGui.BeginTabItem("Player")):
			#ImGui.Text("ID: 0123456789")
			#canvasDrawer.visible = false
			#ImGui.EndTabItem()
		#if (ImGui.BeginTabItem("Texture 1")):
			#ImGui.Text("Wow look, it's a texture")
			#canvasDrawer.visible = false
			#ImGui.EndTabItem()
		#if (ImGui.BeginTabItem("Object: \"flower\"")):
			#ImGui.Text("pretty flower")
			#canvasDrawer.visible = false
			#ImGui.EndTabItem()
		ImGui.EndTabBar()
