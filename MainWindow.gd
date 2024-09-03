extends Node

const FileHandler = preload("res://FileHandler.gd")


var menuFloat = [0.5]
var enabled = true
var n = [0]
var b = [true]
var selected = 0


func MainMenu():
	if (ImGui.BeginMainMenuBar()):
		if (ImGui.BeginMenu("File")):
			if(ImGui.MenuItemEx("Load", "Ctrl+O")):
				var dialog = get_node("FileDialog")
				dialog.popup()
			if(ImGui.MenuItemEx("Save", "Ctrl+S", false, FileHandler.file != "")):
				FileHandler.save()
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
	#Set shape of fullscreen window
	ImGui.SetNextWindowPos(Vector2(0,18))
	var winSize = get_window().size
	winSize.y -= 18
	ImGui.SetNextWindowSize(winSize)
	
	#Main screen
	if (ImGui.Begin("Example: Fullscreen window", [true], ImGui.WindowFlags_NoDecoration | ImGui.WindowFlags_NoMove | ImGui.WindowFlags_NoSavedSettings)):
		
		# Left section
		ImGui.BeginChild("left pane", Vector2(200, 0), ImGui.ChildFlags_Border | ImGui.ChildFlags_ResizeX)
		for i in 20:
			if (ImGui.SelectableEx("MyObject %d"%i, selected == i)):
				selected = i
		ImGui.EndChild()
		ImGui.SameLine()
		
		#// Center
		ImGui.BeginGroup()
		ImGui.BeginChild("item view", Vector2(-300, -ImGui.GetFrameHeightWithSpacing())) # Leave room for 1 line below us
		ImGui.Text("MyObject: %d" % selected)
		ImGui.Separator()
		if (ImGui.BeginTabBar("##Tabs", ImGui.TabBarFlags_None)):
			if (ImGui.BeginTabItem("Description")):
				ImGui.TextWrapped("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ")
				ImGui.EndTabItem()
			if (ImGui.BeginTabItem("Details")):
				ImGui.Text("ID: 0123456789")
				ImGui.EndTabItem()
			ImGui.EndTabBar()
		ImGui.EndChild()
		ImGui.Button("Revert")
		ImGui.SameLine()
		ImGui.Button("Save")
		ImGui.EndGroup()
		ImGui.SameLine()
		
		# Right side
		ImGui.BeginChild("right pane", Vector2(0, 0), ImGui.ChildFlags_Border)
		for i in 15:
			if (ImGui.SelectableEx("MyObject %d"%i, selected == i)):
				selected = i
		ImGui.EndChild()
		ImGui.SameLine()
	ImGui.End()

func _ready():
	Engine.max_fps = 60

func _process(_delta: float) -> void:
	MainMenu()
	MainWindow()
	ImGui.ShowDemoWindow()


func _on_file_dialog_file_selected(path: String) -> void:
	FileHandler.file = path
	FileHandler.load()


func _on_save_file_dialog_file_selected(path: String) -> void:
	FileHandler.file = path
	FileHandler.save()
