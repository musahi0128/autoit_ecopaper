#NoTrayIcon
#pragma compile(Icon, ..\_common\ecopaper.ico)
#pragma compile(Out, "..\releases\Orlansoft ItemID Selector x86.exe")
#Include <Array.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
AutoItSetOption("GUICloseOnESC", 0)

Global $Title = "Orlansoft ItemID Selector"
Global $Driver = "{SQL Anywhere 12}"
Global $UID = "dba"
Global $PWD = "orlansoft10"
Global $Host = "192.168.1.251"
Global $Port = "2638"
Global $ServerName = "server1"
Global $DatabaseName = "orlansoft"

#Region ### START Koda GUI section ### Form=E:\Works\Tools\ItemID Selector\Form1.kxf
$Form1 = GUICreate($Title, 322, 338, -1, -1)
$Label1 = GUICtrlCreateLabel("Search by", 16, 16, 52, 17)
$Combo1 = GUICtrlCreateCombo("", 80, 16, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "ItemID|Description")
$Label2 = GUICtrlCreateLabel("Keywords", 16, 48, 50, 17)
$Input1 = GUICtrlCreateInput("", 80, 48, 225, 21)
$Label3 = GUICtrlCreateLabel("Result", 16, 80, 34, 17)
$ListView1 = GUICtrlCreateListView("", 16, 104, 290, 182)
_GUICtrlListView_AddColumn($ListView1, "ItemID", 100)
_GUICtrlListView_AddColumn($ListView1, "Description", 256)
_StartUp()
$Button1 = GUICtrlCreateButton("Search", 232, 296, 75, 25)
$Label4 = GUICtrlCreateLabel("Please wait ...", 16, 296, 70, 17)
GUICtrlSetState(-1, 32)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1
			_Proceed()
	EndSwitch
WEnd

Func _StartUp()
	$Query = "select null itemid, null description union select distinct itemid, description from initem " _
	& "where blocked = 0 and length(description) > 2 " _
	& "order by description, itemid asc;"
	$DB = ObjCreate("ADODB.Connection")
	$DB.Open("DRIVER=" & $Driver & ";UID=" & $UID & ";PWD=" & $PWD & ";Host=" & $Host & ":" & $Port & ";Encryption=NONE;Integrated=NO;ServerName=" _
	& $ServerName & ";DatabaseName=" & $DatabaseName & ";")
	$Result = $DB.Execute($Query).GetRows()
	$DB.Close
	_ArrayDelete($Result, 0)
	_GUICtrlListView_AddArray($ListView1, $Result)
EndFunc

Func _Proceed()
	If GUICtrlRead($Combo1) == "" Then
		MsgBox(0, "Warning", "Select search by criteria!", 0, $Form1)
	ElseIf GUICtrlRead($Input1) == "" Then
		MsgBox(0, "Warning", "Input keywords needed!", 0, $Form1)
	Else
		GUICtrlSetState($Label4, 16)
		$Query = "select null itemid, null description union select distinct itemid, description from initem " _
		& "where blocked = 0 and length(description) > 2 and " & GUICtrlRead($Combo1) & " like '%" & GUICtrlRead($Input1) & "%' " _
		& "order by description, itemid asc;"
		$DB = ObjCreate("ADODB.Connection")
		$DB.Open("DRIVER=" & $Driver & ";UID=" & $UID & ";PWD=" & $PWD & ";Host=" & $Host & ":" & $Port & ";Encryption=NONE;Integrated=NO;ServerName=" _
		& $ServerName & ";DatabaseName=" & $DatabaseName & ";")
		$Result = $DB.Execute($Query).GetRows()
		$DB.Close
		_ArrayDelete($Result, 0)
		_GUICtrlListView_DeleteAllItems($ListView1)
		_GUICtrlListView_AddArray($ListView1, $Result)
		GUICtrlSetState($Label4, 32)
	EndIf
EndFunc