class_name RaycastWorld
extends Node

var player:RaycastPlayer = RaycastPlayer.new()
var objects = []
var textures = []

var worldCanvas = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
var worldSize = [5,5]
var colorPallet = [[0,0,0,0]]


func savepallet(pallet:Array):
	var buff = []
	buff.append(pallet[2]*255)
	buff.append(pallet[1]*255)
	buff.append(pallet[0]*255)
	buff.append(pallet[3]*255)
	return buff

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
	#Obj Data
	return worldString
