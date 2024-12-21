extends Node
class_name TextureEditorTab
var type = "TextureEditorTab"

#@onready var worldPallet = get_node("ColorPallet")

@onready var world:RaycastWorld = get_node("/root/Node/RaycastWorld")
@onready var texCanvas:TextureCanvas = null

var colorSelection = 0
var textureSelection = 0

# get Color from color array
func color(colorArray):
	return Color(colorArray[0],colorArray[1],colorArray[2],colorArray[3])

func drawTextureEditorTab():
	# Left section
	ImGui.BeginChild("left pane", Vector2(200, 0) ,ImGui.ChildFlags_Border)
	
	ImGui.SeparatorText("Textures")
	for i in world.textures.size():
		var flags = ImGui.ColorEditFlags_NoBorder if (i==textureSelection) else ImGui.ColorEditFlags_None
		if(ImGui.ColorButton("texture %d"%i, color(world.textures[i].color_replaced[0]), flags )):
			textureSelection = i;
		if(((i+1)%7) != 0):
			ImGui.SameLine()
		ImGui.Dummy(Vector2(1,1))
		
	ImGui.SeparatorText("Colors")
	for i in world.textures[textureSelection].colorPallet.size():
		var flags = ImGui.ColorEditFlags_NoBorder if (i==colorSelection) else ImGui.ColorEditFlags_None
		if(ImGui.ColorButton("color %d"%i, color(world.textures[textureSelection].colorPallet[i]), flags )):
			colorSelection = i;
		if(((i+1)%7) != 0):
			ImGui.SameLine()
	# Draw new pallet button
	if(ImGui.ButtonEx("+", Vector2(20,20))):
		world.textures[textureSelection].colorPallet.push_back([0,0,0,1])
		colorSelection = world.textures[textureSelection].colorPallet.size()-1
	if(world.textures[textureSelection].colorPallet.size() > 0):
		ImGui.SeparatorText("Selected Color")
		if(colorSelection == 0):
			# Color zero is background, cant be changed
			ImGui.ColorButton("Transparent", color(world.textures[textureSelection].colorPallet[colorSelection]),ImGui.ColorEditFlags_NoBorder)
		else:
			ImGui.ColorEdit3("color %d"%colorSelection, world.textures[textureSelection].colorPallet[colorSelection], ImGui.ColorEditFlags_NoInputs | ImGui.ColorEditFlags_NoLabel | ImGui.ColorEditFlags_NoBorder)
		#ImGui.ColorEdit3("color %d"%colorSelection, world.textures[textureSelection].colorPallet[colorSelection], ImGui.ColorEditFlags_NoInputs | ImGui.ColorEditFlags_NoLabel | ImGui.ColorEditFlags_NoBorder)
		ImGui.SameLine()
		ImGui.Text("color %d"%colorSelection)
	
	ImGui.EndChild()
	ImGui.SameLine()
	
	# Center, world canvas
	if(texCanvas == null):
		texCanvas = get_node("./TextureCanvas")
	texCanvas.drawTextureCanvas(textureSelection, colorSelection)
	ImGui.SameLine()
