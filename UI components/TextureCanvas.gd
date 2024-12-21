extends Node
class_name TextureCanvas

var newTextureSize = [0,0]
var popupErrText = ""
var settool = 0
var selTex = 0

@onready var world:RaycastWorld = get_node("/root/Node/RaycastWorld")
#@onready var pallet = get_n

signal drawWorld(data:Array)
func _ready() -> void:
	var drawer = get_node("/root/Node/CanvasDrawer")
	drawer.touched.connect(_on_canvas_drawer_touched)

# get Color from color array
func color(colorArray):
	return Color(colorArray[0],colorArray[1],colorArray[2],colorArray[3])

#translate array to color array
func transArray(array):
	var array2:Array
	#var array2 = [[0 for x in range(array[0].size())] for y in range(array.size()]
	for y in array.size():
		array2.append([])
		for x in array[0].size():
			var i = array[y][x]
			var colorarr = world.textures[selTex].colorPallet[i]
			var colorval = color(colorarr)
			array2[y].append(colorval)
	return array2

func resize():
	var oldCanvas = world.textures[selTex].pixel_data.duplicate(true)
	world.textures[selTex].pixel_data.clear()
	for y in world.textures[selTex].height[0]:
		world.textures[selTex].pixel_data.append([])
		for x in world.textures[selTex].width[0]:
			if(oldCanvas.size()>y && oldCanvas[0].size()>x):
				world.textures[selTex].pixel_data[y].append(oldCanvas[y][x])
			else:
				world.textures[selTex].pixel_data[y].append(0)

func drawTextureCanvas(texture, tool):
	ImGui.BeginGroup()
	ImGui.BeginChild("item view", Vector2(-300, -ImGui.GetFrameHeightWithSpacing())) # Leave room for 1 line below us
	ImGui.Text("Texture - %d" % texture)
	ImGui.SameLine()
	ImGui.Text("Color - %d" % tool)
	ImGui.Separator()
	if(ImGui.ButtonEx("Resize", Vector2(80,40))):
		newTextureSize[0] = world.textures[texture].width[0]
		newTextureSize[1] = world.textures[texture].height[0]
		ImGui.OpenPopup("resizePopup")
	# Resize popup
	if(ImGui.BeginPopup("resizePopup")):
		ImGui.InputInt2("Size", newTextureSize, ImGui.InputTextFlags_CharsDecimal)
		if(ImGui.Button("Resize")):
			if(newTextureSize[0]>0 && newTextureSize[1]>0):
				world.textures[texture].width[0] = newTextureSize[0]
				world.textures[texture].height[0] = newTextureSize[1]
				popupErrText = ""
				resize()
				ImGui.CloseCurrentPopup();
			else:
				popupErrText = "Cant have a size of 0"
		ImGui.TextColored(Color(1,0,0), popupErrText)
		ImGui.EndPopup()
		
	
	settool = tool
	selTex = texture
	drawWorld.emit(transArray(world.textures[selTex].pixel_data))
	ImGui.EndChild()
	ImGui.EndGroup()


func _on_canvas_drawer_touched(x: int, y: int) -> void:
	if(world.selected_editor == 2):
		world.textures[selTex].pixel_data[y][x] = settool
