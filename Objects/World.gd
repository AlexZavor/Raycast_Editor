class_name RaycastWorld
extends Node

var player:RaycastPlayer = RaycastPlayer.new()
var objects = []
var textures = []

var worldCanvas = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
var worldSize = [5,5]
var colorPallet = [[0,0,0,0]]

var selected_editor = 0


func savepallet(pallet:Array):
	var buff = []
	buff.append(pallet[2]*255)
	buff.append(pallet[1]*255)
	buff.append(pallet[0]*255)
	buff.append(pallet[3]*255)
	return buff

func f_array_equals(f1:Array, f2:Array) -> bool:
	if(f1.size() != f2.size()):
		return false
	for x in f1.size():
		if abs(f1[x]-f2[x]) > 0.0001:
			return false
	return true

func has_texture(color:Array) -> bool:
	for tex:RaycastTexture in textures:
		if f_array_equals(tex.color_replaced[0], color):
			return true
	return false

func load(levelData):
	var index = 0
	var found = levelData.find(0, index)
	while(found != -1):
		index = found+1
		if(index == levelData.size()):
			break 
		# World Data
		if((levelData[index] == 'W'.to_utf8_buffer()[0]) && 
		   (levelData[index+1] == 'L'.to_utf8_buffer()[0]) && 
		   (levelData[index+2] == 'D'.to_utf8_buffer()[0])):
			# found world data at index
			index += 3;
			worldSize[0] = levelData[index]
			worldSize[1] = levelData[index+1]
			index += 2;
			worldCanvas.clear()
			for x in range(worldSize[0]):
				worldCanvas.append([])
				for y in range(worldSize[1]):
					worldCanvas[x].append(levelData[index])
					index+=1;
			var pal_size = levelData[index]
			index += 1
			colorPallet.clear()
			for p in range(pal_size):
				colorPallet.append([])
				colorPallet[p].append(float(levelData[index+2])/255)
				colorPallet[p].append(float(levelData[index+1])/255)
				colorPallet[p].append(float(levelData[index])/255)
				colorPallet[p].append(float(levelData[index+3])/255)
				index+=4;
		# Player Data
		if((levelData[index] == 'P'.to_utf8_buffer()[0]) && 
		   (levelData[index+1] == 'L'.to_utf8_buffer()[0]) && 
		   (levelData[index+2] == 'R'.to_utf8_buffer()[0])):
			index += 3;
			player.pos_x[0] = levelData.decode_float(index)
			player.pos_y[0] = levelData.decode_float(index+4)
			index += 8;
			player.color[0]=(float(levelData[index+2])/255)
			player.color[1]=(float(levelData[index+1])/255)
			player.color[2]=(float(levelData[index])/255)
			player.color[3]=(float(levelData[index+3])/255)
			index+=4;
		if (index == levelData.size()):
			break
		# Texture Data
		if((levelData[index] == 'T'.to_utf8_buffer()[0]) && 
		   (levelData[index+1] == 'E'.to_utf8_buffer()[0]) && 
		   (levelData[index+2] == 'X'.to_utf8_buffer()[0])):
			index += 3;
			var num_of_tex = levelData[index]
			index += 1;
			for n in num_of_tex:
				var tex:RaycastTexture = RaycastTexture.new()
				tex.width[0] = levelData[index]
				tex.height[0] = levelData[index+1]
				index += 2;
				tex.pixel_data.clear()
				for y in tex.height[0]:
					tex.pixel_data.append([])
					for x in tex.width[0]:
						var color = []
						color.append(float(levelData[index+2])/255)
						color.append(float(levelData[index+1])/255)
						color.append(float(levelData[index])/255)
						color.append(float(levelData[index+3])/255)
						index+=4;
						var loc = tex.colorPallet.find(color)
						if(loc == -1):
							tex.colorPallet.append(color)
							tex.pixel_data[y].append(tex.colorPallet.size()-1)
						else:
							tex.pixel_data[y].append(loc)
				var color_replaced = []
				color_replaced.append(float(levelData[index+2])/255)
				color_replaced.append(float(levelData[index+1])/255)
				color_replaced.append(float(levelData[index])/255)
				color_replaced.append(float(levelData[index+3])/255)
				tex.color_replaced.append(color_replaced)
				index+=4;
				textures.append(tex)
		if (index == levelData.size()):
			break
		# Object Data
		if((levelData[index] == 'O'.to_utf8_buffer()[0]) && 
		   (levelData[index+1] == 'B'.to_utf8_buffer()[0]) && 
		   (levelData[index+2] == 'J'.to_utf8_buffer()[0])):
			index += 3;
			var num_of_objs = levelData[index]
			index += 1;
			for n in num_of_objs:
				var obj:RaycastObject = RaycastObject.new()
				obj.width[0] = levelData[index]
				obj.height[0] = levelData[index+1]
				index += 2;
				obj.pixel_data.clear()
				for y in obj.height[0]:
					obj.pixel_data.append([])
					for x in obj.width[0]:
						var color = []
						color.append(float(levelData[index+2])/255)
						color.append(float(levelData[index+1])/255)
						color.append(float(levelData[index])/255)
						color.append(float(levelData[index+3])/255)
						index+=4;
						var loc = obj.colorPallet.find(color)
						if(loc == -1):
							obj.colorPallet.append(color)
							obj.pixel_data[y].append(obj.colorPallet.size()-1)
						else:
							obj.pixel_data[y].append(loc)
				obj.x[0] = levelData.decode_float(index)
				obj.y[0] = levelData.decode_float(index+4)
				index += 8;
				var color_display = []
				color_display.append(float(levelData[index+2])/255)
				color_display.append(float(levelData[index+1])/255)
				color_display.append(float(levelData[index])/255)
				color_display.append(float(levelData[index+3])/255)
				obj.color_disp=(color_display)
				index+=4;
				objects.append(obj)
		found = levelData.find(0, index)


func save() -> PackedByteArray:
	var worldString:PackedByteArray = "This is a world lvl file for AlexZavor's Raycast Game Engine
Thank you for viewing, for more info, check out the github repo:
https://github.com/AlexZavor/Raycaster\n".to_utf8_buffer()
	# World Data
	worldString.append(0)
	worldString.append_array("WLD".to_utf8_buffer())
	worldString.append(worldSize[0])
	worldString.append(worldSize[1])
	for y in worldCanvas:
		for x in y:
			worldString.append(x)
	worldString.append(colorPallet.size())
	for p in colorPallet:
		worldString.append_array(savepallet(p))
	# Player Data
	worldString.append(0)
	worldString.append_array("PLR".to_utf8_buffer())
	worldString.append_array([0,0,0,0])
	worldString.encode_float(worldString.size()-4,player.pos_x[0])
	worldString.append_array([0,0,0,0])
	worldString.encode_float(worldString.size()-4,player.pos_y[0])
	#worldString.append(int(player.pos_x[0]))
	#worldString.append(int(player.pos_y[0]))
	worldString.append_array(savepallet(player.color))
	worldString.append(0)
	#Texture data
	if(textures.size() > 0):
		worldString.append(0)
		worldString.append_array("TEX".to_utf8_buffer())
		worldString.append(textures.size())
		for tex:RaycastTexture in textures:
			worldString.append(tex.width[0])
			worldString.append(tex.height[0])
			for y in tex.pixel_data:
				for x in y:
					worldString.append_array(savepallet(tex.colorPallet[x]))
			worldString.append_array(savepallet(tex.color_replaced[0]))
	#Obj Data
	if(objects.size() > 0):
		worldString.append(0)
		worldString.append_array("OBJ".to_utf8_buffer())
		worldString.append(objects.size())
		for obj:RaycastObject in objects:
			worldString.append(obj.width[0])
			worldString.append(obj.height[0])
			for y in obj.pixel_data:
				for x in y:
					worldString.append_array(savepallet(obj.colorPallet[x]))
			worldString.append_array([0,0,0,0])
			worldString.encode_float(worldString.size()-4,obj.x[0])
			worldString.append_array([0,0,0,0])
			worldString.encode_float(worldString.size()-4,obj.y[0])
			worldString.append_array(savepallet(obj.color_disp))
	return worldString
