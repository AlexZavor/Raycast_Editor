extends Node
class_name LevelEditor

@onready var canvasDrawer = get_node("/root/Node/CanvasDrawer")

var tabs = ["World", "Player"]
@onready var nodes = [get_node("./WorldEditorTab"), get_node("./PlayerEditorTab")]
#var openTabs = [true, true]

func drawLevelEditor(world:RaycastWorld):
	for obj in world.objects:
		# add object tabs
		pass
	for texture in world.textures:
		# add texture tabs
		pass
	if (ImGui.BeginTabBar("Tabs", ImGui.TabBarFlags_TabListPopupButton | ImGui.TabBarFlags_FittingPolicyScroll | ImGui.TabBarFlags_AutoSelectNewTabs)):
		for i in tabs.size():
			if (ImGui.BeginTabItem(tabs[i])):
				canvasDrawer.visible = false
				if(nodes[i].type == "WorldEditorTab"):
					nodes[i].drawWorldEditorTab()
					canvasDrawer.visible = true
				elif(nodes[i].type == "PlayerEditorTab"):
					nodes[i].drawPlayerEditorTab(world.player)
				ImGui.EndTabItem()
		ImGui.EndTabBar()
