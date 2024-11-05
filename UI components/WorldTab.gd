extends Node
class_name WorldEditorTab
var type = "WorldEditorTab"

@onready var worldPallet = get_node("ColorPallet")
@onready var worldCanvas = get_node("./WorldCanvas")

@onready var world:RaycastWorld = get_node("/root/Node/RaycastWorld")

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
	ImGui.SeparatorText("Player")
	printPlayer(world.player)
	ImGui.SeparatorText("Objects")
	for obj in world.objects:
		ImGui.Separator()
		#printObject(obj)
	ImGui.EndChild()
	ImGui.SameLine()

func printPlayer(player:RaycastPlayer):
	ImGui.SliderAngleEx("Rot.", player.rot, 0, 360)
	var wid = ImGui.CalcItemWidth()
	ImGui.PushItemWidth(wid/2)
	ImGui.SliderFloat("##sliderposx",player.pos_x,0,world.worldSize[0])
	ImGui.SameLine()
	ImGui.SliderFloat("Position",player.pos_y,0,world.worldSize[1])
	ImGui.PopItemWidth()
	ImGui.ColorEdit3("Color", player.color)
	ImGui.Separator()
