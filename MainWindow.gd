extends Node

const FileHandler = preload("res://FileHandler.gd")

@onready var openLevel = get_node("/root/Node/RaycastWorld")
@onready var editor = get_node("/root/Node/LevelEditor")

var menuFloat = [0.5]
var enabled = true
var n = [0]
var b = [true]

func MenuBar():
	if (ImGui.BeginMainMenuBar()):
		if (ImGui.BeginMenu("File")):
			if(ImGui.MenuItemEx("Load", "Ctrl+O")):
				var dialog = get_node("FileDialog")
				dialog.popup()
			if(ImGui.MenuItemEx("Save", "Ctrl+S", false, FileHandler.file != "")):
				FileHandler.save(openLevel)
			if(ImGui.MenuItem("Save As..")):
				var dialog = get_node("SaveFileDialog")
				dialog.popup()

			ImGui.Separator()
			if (ImGui.BeginMenu("Options")):
				if(ImGui.MenuItemEx("Enabled", "", enabled)):
					enabled = !enabled
				ImGui.BeginChild("child", Vector2(0, 60))
				for i in 10:
					ImGui.Text("Scrolling Text %d" % i)
				ImGui.EndChild()
				ImGui.SliderFloat("Value", menuFloat, 0.0, 1.0)
				ImGui.InputFloatEx("Input", menuFloat, 0.1)
				ImGui.Combo("Combo", n, ["Yes","No","Maybe"])
				ImGui.Checkbox("SomeOption", b)
				ImGui.EndMenu()

			ImGui.Separator()
			if(ImGui.MenuItemEx("Quit", "Alt+F4")):
				get_tree().quit()
			ImGui.EndMenu()
		ImGui.EndMainMenuBar()

func MainWindow():
	#Set shape of fullscreen window - leave out menu bar
	ImGui.SetNextWindowPos(Vector2(0,18))
	ImGui.SetNextWindowBgAlpha(0.1)
	var winSize = get_window().size
	winSize.y -= 18
	ImGui.SetNextWindowSize(winSize)
	#Main screen
	if (ImGui.Begin("Editor Window", [true], ImGui.WindowFlags_NoDecoration | ImGui.WindowFlags_NoMove | ImGui.WindowFlags_NoSavedSettings)):
		editor.drawLevelEditor(openLevel)
	ImGui.End()

func _process(_delta: float) -> void:
	MenuBar()
	MainWindow()
	#ImGui.ShowDemoWindow()


func _on_file_dialog_file_selected(path: String) -> void:
	FileHandler.file = path
	FileHandler.load()
	openLevel.load(FileHandler.levelData)

func _on_save_file_dialog_file_selected(path: String) -> void:
	FileHandler.file = path
	FileHandler.save(openLevel)
