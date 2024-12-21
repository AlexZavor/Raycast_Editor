extends Node
class_name LevelEditor

@onready var canvasDrawer:CanvasDrawer = get_node("/root/Node/CanvasDrawer")

var tabs = ["World", "Player"]
@onready var nodes = [get_node("./WorldEditorTab"), get_node("./PlayerEditorTab")]
#var openTabs = [true, true]

func drawLevelEditor(world:RaycastWorld):
	if world.objects.size() > 0:
		if !tabs.has("Objects"):
			tabs.append("Objects")
			var objectTab = ObjectEditorTab.new()
			add_child(objectTab)
			var objectCan = ObjectCanvas.new()
			objectCan.name = "ObjectCanvas"
			objectCan.drawWorld.connect(canvasDrawer._on_world_canvas_draw_world)
			objectTab.add_child(objectCan)
			nodes.append(objectTab)
		pass
	if world.textures.size() > 0:
		if !tabs.has("Textures"):
			tabs.append("Textures")
			var textureTab = TextureEditorTab.new()
			add_child(textureTab)
			var textureCan = TextureCanvas.new()
			textureCan.name = "TextureCanvas"
			textureCan.drawWorld.connect(canvasDrawer._on_world_canvas_draw_world)
			textureTab.add_child(textureCan)
			nodes.append(textureTab)
		pass
	if (ImGui.BeginTabBar("Tabs", ImGui.TabBarFlags_TabListPopupButton | ImGui.TabBarFlags_FittingPolicyScroll | ImGui.TabBarFlags_AutoSelectNewTabs)):
		for i in tabs.size():
			if (ImGui.BeginTabItem(tabs[i])):
				canvasDrawer.visible = false
				if(nodes[i].type == "WorldEditorTab"):
					world.selected_editor = 0
					nodes[i].drawWorldEditorTab()
					canvasDrawer.visible = true
				elif(nodes[i].type == "PlayerEditorTab"):
					world.selected_editor = 1
					nodes[i].drawPlayerEditorTab(world.player)
				elif(nodes[i].type == "TextureEditorTab"):
					world.selected_editor = 2
					nodes[i].drawTextureEditorTab()
					canvasDrawer.visible = true
				elif(nodes[i].type == "ObjectEditorTab"):
					world.selected_editor = 3
					nodes[i].drawTextureEditorTab()
					canvasDrawer.visible = true
				ImGui.EndTabItem()
		ImGui.EndTabBar()
