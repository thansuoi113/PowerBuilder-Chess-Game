$PBExportHeader$vo_line.sru
forward
global type vo_line from userobject
end type
end forward

global type vo_line from userobject
integer width = 1038
integer height = 92
long backcolor = 255
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_clicked pbm_lbuttonclk
end type
global vo_line vo_line

type variables
long il_width = 1000,il_height = 3
window parentWin
end variables

event ue_clicked;parentWin.Event Dynamic ue_chess_clicked()

end event

event constructor;This.Width = il_width
This.Height = il_height

end event

on vo_line.create
end on

on vo_line.destroy
end on

