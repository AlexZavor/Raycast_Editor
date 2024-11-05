extends Node
class_name PlayerEditorTab
var type = "PlayerEditorTab"

@onready var world:RaycastWorld = get_node("/root/Node/RaycastWorld")



func drawPlayerEditorTab(player:RaycastPlayer):
	ImGui.BeginGroup()
	ImGui.PushItemWidth(400)
	ImGui.SeparatorText("Player")
	ImGui.SliderAngleEx("Rotation", player.rot, 0, 360)
	ImGui.PushItemWidth(200)
	ImGui.SliderFloat("##slider1",player.pos_x,0,world.worldSize[0])
	ImGui.SameLine()
	ImGui.SliderFloat("Position",player.pos_y,0,world.worldSize[1])
	ImGui.PopItemWidth()
	ImGui.ColorEdit3("Color", player.color)
	ImGui.Separator()
	ImGui.PopItemWidth()
	ImGui.EndGroup()
