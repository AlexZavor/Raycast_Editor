extends Node
class_name ObjectEditorTab
var type = "ObjectEditorTab"

#@onready var worldPallet = get_node("ColorPallet")

@onready var world:RaycastWorld = get_node("/root/Node/RaycastWorld")
@onready var objCanvas:ObjectCanvas = null

var colorSelection = 0
var objectSelection = 0

# get Color from color array
func color(colorArray):
	return Color(colorArray[0],colorArray[1],colorArray[2],colorArray[3])

func drawTextureEditorTab():
	# Left section
	ImGui.BeginChild("left pane", Vector2(200, 0) ,ImGui.ChildFlags_Border)
	
	ImGui.SeparatorText("Objects")
	for i in world.objects.size():
		var flags = ImGui.ColorEditFlags_NoBorder if (i==objectSelection) else ImGui.ColorEditFlags_None
		if(ImGui.ColorButton("object %d"%i, color(world.objects[i].color_disp), flags )):
			objectSelection = i;
			colorSelection = 0
		if(((i+1)%7) != 0):
			ImGui.SameLine()
		ImGui.Dummy(Vector2(1,1))
		
	ImGui.SeparatorText("Color pallet")
	for i in world.objects[objectSelection].colorPallet.size():
		var flags = ImGui.ColorEditFlags_NoBorder if (i==colorSelection) else ImGui.ColorEditFlags_None
		if(ImGui.ColorButton("color %d"%i, color(world.objects[objectSelection].colorPallet[i]), flags )):
			colorSelection = i;
		if(((i+1)%7) != 0):
			ImGui.SameLine()
	# Draw new pallet button
	if(ImGui.ButtonEx("+", Vector2(20,20))):
		world.objects[objectSelection].colorPallet.push_back([0,0,0,1])
		colorSelection = world.objects[objectSelection].colorPallet.size()-1
	if(world.objects[objectSelection].colorPallet.size() > 0):
		ImGui.SeparatorText("Selected Color")
		if(colorSelection == 0):
			# Color zero is background, cant be changed
			ImGui.ColorButton("Transparent", color(world.objects[objectSelection].colorPallet[colorSelection]),ImGui.ColorEditFlags_NoBorder)
		else:
			ImGui.ColorEdit3("color %d"%colorSelection, world.objects[objectSelection].colorPallet[colorSelection], ImGui.ColorEditFlags_NoInputs | ImGui.ColorEditFlags_NoLabel | ImGui.ColorEditFlags_NoBorder)
		#ImGui.ColorEdit3("color %d"%colorSelection, world.objects[objectSelection].colorPallet[colorSelection], ImGui.ColorEditFlags_NoInputs | ImGui.ColorEditFlags_NoLabel | ImGui.ColorEditFlags_NoBorder)
		ImGui.SameLine()
		ImGui.Text("color %d"%colorSelection)
	
	ImGui.EndChild()
	ImGui.SameLine()
	
	# Center, world canvas
	if(objCanvas == null):
		objCanvas = get_node("./ObjectCanvas")
	objCanvas.drawObjectCanvas(objectSelection, colorSelection)
	ImGui.SameLine()

	ImGui.BeginGroup()
	ImGui.PushItemWidth(200)
	ImGui.SeparatorText("Object")
	ImGui.PushItemWidth(100)
	ImGui.SliderFloat("##slider1",world.objects[objectSelection].x,0,world.worldSize[0])
	ImGui.SameLine()
	ImGui.SliderFloat("Position",world.objects[objectSelection].y,0,world.worldSize[1])
	ImGui.PopItemWidth()
	ImGui.ColorEdit3("Color", world.objects[objectSelection].color_disp)
	ImGui.Separator()
	ImGui.PopItemWidth()
	ImGui.EndGroup()
