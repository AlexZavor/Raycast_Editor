extends Node
class_name PlayerEditorTab
var type = "PlayerEditorTab"

func drawPlayerEditorTab(player:RaycastPlayer):
	ImGui.BeginGroup()
	ImGui.PushItemWidth(400)
	ImGui.SeparatorText("Player")
	ImGui.SliderAngleEx("Rotation", player.rot, 0, 360)
	ImGui.PushItemWidth(200)
	ImGui.SliderFloat("Position",[player.pos[0]],0,3)
	ImGui.SameLine()
	ImGui.SliderFloat("",[player.pos[1]],0,3)
	ImGui.PopItemWidth()
	ImGui.ColorEdit3("Color", player.color)
	ImGui.Separator()
	ImGui.PopItemWidth()
	ImGui.EndGroup()
