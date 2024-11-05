class_name RaycastWorld
extends Node

var player:RaycastPlayer = RaycastPlayer.new()
var objects = []
var textures = []

var worldCanvas = [[0,1,0],[1,0,1],[0,1,0]]
var worldSize = [3,3]
var colorPallet = [[0,0,0,1],[1,0,0,1]]

func load(levelData):
	print(levelData)

func save() -> PackedByteArray:
	var worldString:PackedByteArray = "This is a world lvl file for AlexZavor's Raycast Game Engine
Thank you for viewing, for more info, check out the github repo:
https://github.com/AlexZavor/Raycaster\n".to_utf8_buffer()
	worldString.append(0)
	worldString.append(worldSize[0])
	worldString.append(worldSize[1])
	for y in worldCanvas:
		for x in y:
			worldString.append(x)
	return worldString
