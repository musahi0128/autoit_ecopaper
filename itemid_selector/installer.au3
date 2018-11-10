#RequireAdmin
#pragma compile(Icon, "..\_common\ecopaper.ico")
#pragma compile(Out, "..\_releases\Orlansoft ItemID Selector x86 - Installer.exe")
Global $Title = "Orlansoft ItemID Selector x86 - Installer"
If FileExists(@ProgramFilesDir & "\SQL Anywhere 12\Bin32") == 0 Then
	MsgBox(0, $Title, "The directory for installing SQL Anywhere 12 binary is not exist and will be created.")
	DirCreate(@ProgramFilesDir & "\SQL Anywhere 12\Bin32")
EndIf
If @ProgramFilesDir == "C:\Program Files (x86)" Then
	If FileExists(@ProgramFilesDir & "\Orlansoft Tools") == 0 Then
		MsgBox(0, $Title, "The directory for installing Orlansoft Tools binary is not exist and will be created.")
		DirCreate(@ProgramFilesDir & "\Orlansoft Tools")
	EndIf
Else
	If FileExists(@ProgramFilesDir & "\Orlansoft Tools") == 0 Then
		MsgBox(0, $Title, "The directory for installing Orlansoft Tools binary is not exist and will be created.")
		DirCreate(@ProgramFilesDir & "\Orlansoft Tools")
	EndIf
EndIf
FileInstall("..\_releases\Orlansoft ItemID Selector x86.exe", @ProgramFilesDir & "\Orlansoft Tools\Orlansoft ItemID Selector x86.exe")
FileInstall("..\_common\sqla12\dbcon12.dll", @ProgramFilesDir & "\SQL Anywhere 12\Bin32\dbcon12.dll")
FileInstall("..\_common\sqla12\dbelevate12.exe", @ProgramFilesDir & "\SQL Anywhere 12\Bin32\dbelevate12.exe")
FileInstall("..\_common\sqla12\dbicu12.dll", @ProgramFilesDir & "\SQL Anywhere 12\Bin32\dbicu12.dll")
FileInstall("..\_common\sqla12\dbicudt12.dll", @ProgramFilesDir & "\SQL Anywhere 12\Bin32\dbicudt12.dll")
FileInstall("..\_common\sqla12\dblgen12.dll", @ProgramFilesDir & "\SQL Anywhere 12\Bin32\dblgen12.dll")
FileInstall("..\_common\sqla12\dbodbc12.dll", @ProgramFilesDir & "\SQL Anywhere 12\Bin32\dbodbc12.dll")
ShellExecuteWait("regsvr32.exe", "/s " & Chr(34) & @ProgramFilesDir & "\SQL Anywhere 12\Bin32\dbodbc12.dll" & Chr(34))
FileCreateShortcut(@ProgramFilesDir & "\Orlansoft Tools\Orlansoft ItemID Selector x86.exe", @DesktopCommonDir & "\Orlansoft ItemID Selector x86.lnk")
MsgBox(0, $Title, "Installation is finished.")