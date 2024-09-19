class_name ColorPallet

# Color pallet data, preloaded with bg color of black
var colorPallet = [[0,0,0,1]]

# On ready function
func _ready():
	pass

#draw pallet
func drawPallet(width):
	ImGui.BeginGroup()
	# draw each member of pallet
	for i in colorPallet.size():
		if(i == 0):
			# Can't edit background color
			ImGui.ColorButton("Background", Color(colorPallet[0][0],colorPallet[0][1],colorPallet[0][2]))
		else:
			ImGui.ColorEdit3("color %d"%i, colorPallet[i], ImGui.ColorEditFlags_NoInputs | ImGui.ColorEditFlags_NoLabel)
		if(((i+1)%width) != 0):
			ImGui.SameLine()
	# Draw new pallet button
	if(ImGui.ButtonEx("+", Vector2(20,20))):
		colorPallet.push_back([0,0,0,1])
	ImGui.EndGroup()

func getColor(n):
	return colorPallet[n]
