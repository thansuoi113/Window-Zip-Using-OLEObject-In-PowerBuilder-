$PBExportHeader$nvo_winzip.sru
forward
global type nvo_winzip from nonvisualobject
end type
end forward

global type nvo_winzip from nonvisualobject autoinstantiate
end type

type prototypes
Subroutine SleepMS ( ulong dwMilliseconds ) Library "kernel32.dll" Alias For "Sleep"
end prototypes

forward prototypes
public function integer of_addfolderzip (string as_folder, string as_zipfile)
public function integer of_unzip (string as_unzipfile, string as_unzipfolder)
public function integer of_addzip (string as_file, string as_zipfile, boolean ab_append)
public function integer of_addzip (string as_file, string as_zipfile)
end prototypes

public function integer of_addfolderzip (string as_folder, string as_zipfile);//====================================================================
// Function: nvo_winzip.of_addfolderzip()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_folder 	
// 	value	string	as_zipfile	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/03/24
//--------------------------------------------------------------------
// Usage: nvo_winzip.of_addfolderzip ( string as_folder, string as_zipfile )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

OleObject oZipShell, oZipFSO, oNewZipFile, oZip, oFolder
Int li_rc
String ls_ZipFile, ls_Folder

ls_Folder = as_folder
ls_ZipFile = as_zipfile
If IsNull(ls_Folder) Or Len(Trim(ls_Folder)) = 0 Then
	MessageBox("Warning", "Folder To Zip IsNull Or Empty")
	Return -1
End If
If IsNull(ls_ZipFile) Or Len(Trim(ls_ZipFile)) = 0 Then
	MessageBox("Warning", "Zip File IsNull Or Empty")
	Return -1
End If
If not DirectoryExists(ls_Folder) Then
	MessageBox("Warning", "Folder Not Exists")
	Return -1
End If

Try
	//Create Oleobject
	oZipShell = Create OleObject
	li_rc = oZipShell.ConnectToNewObject ( "Shell.Application")
	If li_rc < 0 Then
		MessageBox("Warning", "ConnectToNewObject Shell.Application")
		Destroy oZipShell
		Return -1
	End If
	
	oZipFSO = Create OleObject
	li_rc = oZipFSO.ConnectToNewObject ("Scripting.FileSystemObject" )
	If li_rc < 0 Then
		MessageBox("Warning", "ConnectToNewObject Scripting.FileSystemObject")
		Destroy oZipFSO
		Return -1
	End If
	
	//That zip file already exists - deleting it.
	If oZipFSO.FileExists(ls_ZipFile) Then
		oZipFSO.DeleteFile (ls_ZipFile)
	End If
	
	//Create File
	If Not oZipFSO.FileExists(ls_ZipFile) Then
		oNewZipFile = Create OleObject
		oNewZipFile = oZipFSO.CreateTextFile(ls_ZipFile)
		oNewZipFile.Close
	End If
	
	//Add File
	oZip = oZipShell.NameSpace(ls_ZipFile)
	oFolder = oZipShell.NameSpace(ls_Folder)
	oZip.Copyhere( ls_Folder, 4)
	/*
	//Keep script waiting until Compressing is done
	Do While oFolder.Items.Count >  oZip.Items.Count
		SleepMS(500)
	Loop
	*/
	
Catch (runtimeerror  e)
	String  ls_msg
	ls_msg = e.getMessage()
	MessageBox("Warning", ls_msg)
	Destroy oZipShell
	Destroy oZipFSO
	Destroy oNewZipFile
	Destroy oZip
	Return -1
End Try

Destroy oZipShell
Destroy oZipFSO
Destroy oNewZipFile
Destroy oZip

Return 0


end function

public function integer of_unzip (string as_unzipfile, string as_unzipfolder);//====================================================================
// Function: nvo_winzip.of_unzip()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_unzipfile  	
// 	value	string	as_unzipfolder	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/03/24
//--------------------------------------------------------------------
// Usage: nvo_winzip.of_unzip ( string as_unzipfile, string as_unzipfolder )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

OleObject oZipShell, oUnzipFSO
Int li_rc
String ls_UnZipFile, ls_UnZipfolder

ls_UnZipfolder = as_UnZipfolder
ls_UnZipFile = as_UnZipFile
If IsNull(ls_UnZipfolder) Or Len(Trim(ls_UnZipfolder)) = 0 Then
	MessageBox("Warning", "Folder UnZip IsNull Or Empty")
	Return -1
End If
If IsNull(ls_UnZipFile) Or Len(Trim(ls_UnZipFile)) = 0 Then
	MessageBox("Warning", "Zip File IsNull Or Empty")
	Return -1
End If

Try
	
	//Create Oleobject
	oZipShell = Create OleObject
	li_rc = oZipShell.ConnectToNewObject ( "Shell.Application")
	If li_rc < 0 Then
		MessageBox("Warning", "ConnectToNewObject Shell.Application")
		Destroy oZipShell
		Return -1
	End If
	
	oUnzipFSO = Create OleObject
	li_rc = oUnzipFSO.ConnectToNewObject ("Scripting.FileSystemObject" )
	If li_rc < 0 Then
		MessageBox("Warning", "ConnectToNewObject Scripting.FileSystemObject")
		Destroy oUnzipFSO
		Return -1
	End If
	
	//Create Directory Destination
	If Not oUnzipFSO.FolderExists(ls_UnZipfolder) Then
		oUnzipFSO.CreateFolder(ls_UnZipfolder)
	End If
	
	oZipShell.NameSpace(ls_UnZipfolder).Copyhere (oZipShell.NameSpace(ls_UnZipFile).Items)
	
Catch (runtimeerror  e)
	String  ls_msg
	ls_msg = e.getMessage()
	MessageBox("Warning", ls_msg)
	Destroy oZipShell
	Destroy oUnzipFSO
	Return -1
End Try

Destroy oZipShell
Destroy oUnzipFSO

Return 0



end function

public function integer of_addzip (string as_file, string as_zipfile, boolean ab_append);//====================================================================
// Function: nvo_winzip.of_addzip()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string 	as_file   	
// 	value	string 	as_zipfile	
// 	value	boolean	ab_append 	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/03/24
//--------------------------------------------------------------------
// Usage: nvo_winzip.of_addzip ( string as_file, string as_zipfile, boolean ab_append )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

OleObject oZipShell, oZipFSO, oNewZipFile, oZip
Int li_rc
String ls_ZipFile, ls_File
Long ll_ZipFileCount

ls_File = as_file
ls_ZipFile = as_zipfile
If IsNull(ls_File) Or Len(Trim(ls_File)) = 0 Then
	MessageBox("Warning", "File To Zip IsNull Or Empty")
	Return -1
End If
If IsNull(ls_ZipFile) Or Len(Trim(ls_ZipFile)) = 0 Then
	MessageBox("Warning", "Zip File IsNull Or Empty")
	Return -1
End If

Try
	//Create Oleobject
	oZipShell = Create OleObject
	li_rc = oZipShell.ConnectToNewObject ( "Shell.Application")
	If li_rc < 0 Then
		MessageBox("Warning", "ConnectToNewObject Shell.Application")
		Destroy oZipShell
		Return -1
	End If
	
	oZipFSO = Create OleObject
	li_rc = oZipFSO.ConnectToNewObject ("Scripting.FileSystemObject" )
	If li_rc < 0 Then
		MessageBox("Warning", "ConnectToNewObject Scripting.FileSystemObject")
		Destroy oZipFSO
		Return -1
	End If
	
	//That zip file already exists - deleting it.
	If oZipFSO.FileExists(ls_ZipFile) And Not ab_append Then
		oZipFSO.DeleteFile (ls_ZipFile)
	End If
	
	//Create File
	If Not oZipFSO.FileExists(ls_ZipFile) Then
		oNewZipFile = Create OleObject
		oNewZipFile = oZipFSO.CreateTextFile(ls_ZipFile)
		oNewZipFile.Close
	End If
	
	//Add File
	oZip = oZipShell.NameSpace(ls_ZipFile)
	ll_ZipFileCount = oZip.Items.Count
	oZip.Copyhere( ls_File, 4)
	
	//Keep script waiting until Compressing is done
	Do While ll_ZipFileCount >=  oZip.Items.Count
		SleepMS(500)
	Loop
	
Catch (runtimeerror  e)
	String  ls_msg
	ls_msg = e.getMessage()
	MessageBox("Warning", ls_msg)
	Destroy oZipShell
	Destroy oZipFSO
	Destroy oNewZipFile
	Destroy oZip
	Return -1
End Try

Destroy oZipShell
Destroy oZipFSO
Destroy oNewZipFile
Destroy oZip

Return 0


end function

public function integer of_addzip (string as_file, string as_zipfile);Return of_addzip(as_file, as_zipfile, False)
end function

on nvo_winzip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_winzip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

