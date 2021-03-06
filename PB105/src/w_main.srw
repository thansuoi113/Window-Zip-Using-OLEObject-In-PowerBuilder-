$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_3 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type sle_des from singlelineedit within w_main
end type
type sle_sc from singlelineedit within w_main
end type
type cb_unzip from commandbutton within w_main
end type
type cb_zipfolder from commandbutton within w_main
end type
type cb_zipfile from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 2496
integer height = 740
boolean titlebar = true
string title = "PB Window Zip"
boolean controlmenu = true
boolean minbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_3 st_3
st_2 st_2
st_1 st_1
sle_des sle_des
sle_sc sle_sc
cb_unzip cb_unzip
cb_zipfolder cb_zipfolder
cb_zipfile cb_zipfile
end type
global w_main w_main

on w_main.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_des=create sle_des
this.sle_sc=create sle_sc
this.cb_unzip=create cb_unzip
this.cb_zipfolder=create cb_zipfolder
this.cb_zipfile=create cb_zipfile
this.Control[]={this.st_3,&
this.st_2,&
this.st_1,&
this.sle_des,&
this.sle_sc,&
this.cb_unzip,&
this.cb_zipfolder,&
this.cb_zipfile}
end on

on w_main.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_des)
destroy(this.sle_sc)
destroy(this.cb_unzip)
destroy(this.cb_zipfolder)
destroy(this.cb_zipfile)
end on

type st_3 from statictext within w_main
integer y = 32
integer width = 2450
integer height = 128
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Window Zip"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 37
integer y = 384
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Destination:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 37
integer y = 256
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Source:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_des from singlelineedit within w_main
integer x = 366
integer y = 368
integer width = 2011
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_sc from singlelineedit within w_main
integer x = 366
integer y = 244
integer width = 2011
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_unzip from commandbutton within w_main
integer x = 2011
integer y = 520
integer width = 370
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "UnZip"
end type

event clicked;String ls_sc, ls_des

ls_sc = sle_sc.Text
ls_des = sle_des.Text

If IsNull(ls_sc) Or Len(Trim(ls_sc)) = 0 Then
	MessageBox("Warning", "File Zip IsNull")
	sle_sc.setfocus( )
	Return
End If

If IsNull(ls_des) Or Len(Trim(ls_des)) = 0 Then
	MessageBox("Warning", "Folder UnZip Destination IsNull")
	sle_des.setfocus( )
	Return
End If

If Not FileExists(ls_sc) Then
	MessageBox("Warning", "File Zip Not Exists")
	sle_sc.setfocus( )
	Return
End If

nvo_winzip lnvo_winzip
lnvo_winzip.of_unzip( ls_sc, ls_des) 

end event

type cb_zipfolder from commandbutton within w_main
integer x = 1207
integer y = 520
integer width = 370
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Zip Folder"
end type

event clicked;String ls_sc, ls_des

ls_sc = sle_sc.Text
ls_des = sle_des.Text

If IsNull(ls_sc) Or Len(Trim(ls_sc)) = 0 Then
	MessageBox("Warning", "Folder Source IsNull")
	sle_sc.setfocus( )
	Return
End If

If IsNull(ls_des) Or Len(Trim(ls_des)) = 0 Then
	MessageBox("Warning", "File Zip IsNull")
	sle_des.setfocus( )
	Return
End If

If Not DirectoryExists(ls_sc) Then
	MessageBox("Warning", "Folder Source Not Exists")
	sle_sc.setfocus( )
	Return
End If

nvo_winzip lnvo_winzip
lnvo_winzip.of_addfolderzip( ls_sc,ls_des) 

end event

type cb_zipfile from commandbutton within w_main
integer x = 366
integer y = 520
integer width = 370
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Zip File"
end type

event clicked;
String ls_sc, ls_des

ls_sc = sle_sc.Text
ls_des = sle_des.Text

If IsNull(ls_sc) Or Len(Trim(ls_sc)) = 0 Then
	MessageBox("Warning", "File To Zip IsNull")
	sle_sc.setfocus( )
	Return
End If

If IsNull(ls_des) Or Len(Trim(ls_des)) = 0 Then
	MessageBox("Warning", "File Zip IsNull")
	sle_des.setfocus( )
	Return
End If

If Not FileExists(ls_sc) Then
	MessageBox("Warning", "File Source Not Exists")
	sle_sc.setfocus( )
	Return
End If

nvo_winzip lnvo_winzip
lnvo_winzip.of_addzip( ls_sc, ls_des)



end event

