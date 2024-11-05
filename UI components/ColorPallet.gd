extends Node
class_name ColorPallet

# Color pallet data, preloaded with bg color of black
@onready var world = get_node("/root/Node/RaycastWorld")
var colorSelection = 0;

# get Color from color array
func color(colorArray):
	return Color(colorArray[0],colorArray[1],colorArray[2],colorArray[3])

#return color at index n
func getColor(n):
	return world.colorPallet[n]

#draw pallet
func drawPallet(width):
	ImGui.BeginGroup()
	# draw each member of pallet
	for i in world.colorPallet.size():
		var flags = ImGui.ColorEditFlags_NoBorder if (i==colorSelection) else 0
		if(i == 0):
			# Color zero is background
			if(ImGui.ColorButton("Background", color(world.colorPallet[i]), flags )):
				colorSelection = i;
		else:
			if(ImGui.ColorButton("color %d"%i, color(world.colorPallet[i]), flags )):
				colorSelection = i;
		if(((i+1)%width) != 0):
			ImGui.SameLine()
	# Draw new pallet button
	if(ImGui.ButtonEx("+", Vector2(20,20))):
		world.colorPallet.push_back([0,0,0,1])
		colorSelection = world.colorPallet.size()-1
	ImGui.SeparatorText("Selected Color")
	if(colorSelection == 0):
		# Color zero is background, cant be changed
		ImGui.ColorButton("Background", color(world.colorPallet[colorSelection]),ImGui.ColorEditFlags_NoBorder)
	else:
		ImGui.ColorEdit3("color %d"%colorSelection, world.colorPallet[colorSelection], ImGui.ColorEditFlags_NoInputs | ImGui.ColorEditFlags_NoLabel | ImGui.ColorEditFlags_NoBorder)
	ImGui.SameLine()
	ImGui.Text("color %d"%colorSelection)
	ImGui.EndGroup()

#translate array to color array
func transArray(array):
	var array2:Array
	#var array2 = [[0 for x in range(array[0].size())] for y in range(array.size()]
	for y in array.size():
		array2.append([])
		for x in array[0].size():
			var i = array[y][x]
			var colorarr = world.colorPallet[i]
			var colorval = color(colorarr)
			array2[y].append(colorval)
	return array2
