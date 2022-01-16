$PBExportHeader$vo_round.sru
forward
global type vo_round from userobject
end type
type st_1 from statictext within vo_round
end type
type ov_1 from oval within vo_round
end type
type ov_2 from oval within vo_round
end type
end forward

global type vo_round from userobject
integer width = 169
integer height = 140
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_clicked pbm_lbuttonclk
st_1 st_1
ov_1 ov_1
ov_2 ov_2
end type
global vo_round vo_round

type variables
Long il_color, il_backcolor
Long il_clicked = 0 // 0=unchecked, 1=checked
String is_text = '' //text
Long il_type = 0 //1 black, 2 white, 0 unknown
window parentWin
Long il_player = 1
Boolean ib_choose = False

end variables
forward prototypes
public subroutine wf_backcolor ()
end prototypes

event ue_clicked;wf_backcolor()
end event

public subroutine wf_backcolor ();
//if isvalid(parentWin) then parentWin.Event Dynamic ue_round_player()
//
//if il_clicked = 0 then
//	if ib_choose then
//		parentWin.Event Dynamic ue_chess_clicked()
//	else
//		if this.tag = string(il_player) then
//			if isvalid(parentWin) then parentWin.Event Dynamic ue_choose_chess(parentWin.pointerx( ),parentWin.pointery( ),true)
//			il_clicked = 1
//			this.backcolor= 255
//		end if
//	end if
//else
//	if isvalid(parentWin) then parentWin.Event Dynamic ue_choose_chess(parentWin.pointerx( ),parentWin.pointery( ),false)
//	il_clicked = 0
//	this.backcolor = il_backcolor
//end if

If IsValid(parentWin) Then parentWin.Event Dynamic ue_test(This)

end subroutine

on vo_round.create
this.st_1=create st_1
this.ov_1=create ov_1
this.ov_2=create ov_2
this.Control[]={this.st_1,&
this.ov_1,&
this.ov_2}
end on

on vo_round.destroy
destroy(this.st_1)
destroy(this.ov_1)
destroy(this.ov_2)
end on

event constructor;ov_1.fillcolor = rgb(243,208,169)//
ov_2.fillcolor = rgb(243,208,169)
ov_1.linecolor = il_color
ov_2.linecolor = il_color
st_1.textcolor = il_color
st_1.backcolor = rgb(243,208,169)
st_1.text = is_text
this.backcolor =il_backcolor


end event

type st_1 from statictext within vo_round
integer x = 27
integer y = 32
integer width = 101
integer height = 76
integer textsize = -14
integer weight = 700
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "宋体"
long textcolor = 16777215
long backcolor = 255
string text = "空"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;wf_backcolor()
end event

type ov_1 from oval within vo_round
long linecolor = 33554432
integer linethickness = 3
long fillcolor = 16777215
integer width = 160
integer height = 140
end type

type ov_2 from oval within vo_round
long linecolor = 33554432
integer linethickness = 2
long fillcolor = 1073741824
integer x = 14
integer y = 12
integer width = 133
integer height = 120
end type

