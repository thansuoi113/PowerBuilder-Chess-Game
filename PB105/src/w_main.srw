$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_2 from commandbutton within w_main
end type
type dw_1 from datawindow within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type cb_1 from commandbutton within w_main
end type
type ln_1 from line within w_main
end type
type ln_2 from line within w_main
end type
type ln_3 from line within w_main
end type
type ln_4 from line within w_main
end type
end forward

global type w_main from window
integer width = 2254
integer height = 2484
boolean titlebar = true
string title = "chess"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event ue_choose_chess ( long al_chessx,  long al_chessy,  boolean al_bool )
event ue_round_player ( )
event ue_chess_clicked ( )
event ue_test ( any av_round )
cb_2 cb_2
dw_1 dw_1
st_2 st_2
st_1 st_1
cb_1 cb_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
end type
global w_main w_main

type variables
long il_x = 200,il_y = 200,il_lenght=1800
int il_span_y
long  ll_chess_color = 0,ll_chess_color2 = 255

long il_chessX,il_chessY
boolean ib_choose = false
vo_round iv_arr_round[],iv_arr_null[]
long il_any_chess[10,9],il_any_null[10,9]
long il_player //1=Black 2=Red play



end variables

forward prototypes
public function any wf_return_coordinates (integer al_x, integer al_y)
public subroutine wf_draw_chess_attribute (integer al_x, integer al_y, string as_name, integer al_type)
public subroutine wf_draw_chess ()
public function boolean wf_chess_rules (integer gi, integer gj, integer si, integer sj)
public subroutine wf_draw_board ()
public subroutine wf_empty_chess ()
public function boolean wf_meet ()
end prototypes

event ue_choose_chess(long al_chessx, long al_chessy, boolean al_bool);//
Long ll_i

For ll_i = 1 To UpperBound(iv_arr_round)
	iv_arr_round[ll_i].BackColor = This.BackColor
	iv_arr_round[ll_i].il_clicked = 0
Next

ib_choose = al_bool
il_chessX = al_chessX
il_chessY = al_chessY

end event

event ue_round_player();//
Long ll_i
String ls_type

For ll_i = 1 To UpperBound(iv_arr_round)
	iv_arr_round[ll_i].il_player = il_player
	iv_arr_round[ll_i].ib_choose = ib_choose
Next



end event

event ue_chess_clicked();
This.Event Clicked(1,This.PointerX( ),This.PointerY( ))

end event

event ue_test(any av_round);//
Long ll_i
Long ll_type,ll_type2
Long ll_arr[]
vo_round Round

Round = av_round

If Round.il_clicked = 0 Then
	If ib_choose Then
		ll_arr = wf_return_coordinates(il_chessx,il_chessY)
		ll_type = il_any_chess[ll_arr[1],ll_arr[2]]
		ll_arr = wf_return_coordinates(This.PointerX( ),This.PointerY( ))
		ll_type2 = il_any_chess[ll_arr[1],ll_arr[2]]
		If (ll_type > 0 And ll_type < 10 And ll_type2 > 0 And ll_type2 < 10) Or +&
			(ll_type > 10 And ll_type2 > 10) Then
			If Round.Tag = String(il_player) Then
				For ll_i = 1 To UpperBound(iv_arr_round)
					iv_arr_round[ll_i].BackColor = This.BackColor
					iv_arr_round[ll_i].il_clicked = 0
				Next
				ib_choose = True
				
				Round.il_clicked = 1
				Round.BackColor = 255
				il_chessx = This.PointerX( )
				il_chessY = This.PointerY( )
			End If
		Else
			This.Event Clicked(1,This.PointerX( ),This.PointerY( ))
		End If
	Else
		If Round.Tag = String(il_player) Then
			For ll_i = 1 To UpperBound(iv_arr_round)
				iv_arr_round[ll_i].BackColor = This.BackColor
				iv_arr_round[ll_i].il_clicked = 0
			Next
			ib_choose = True
			
			Round.il_clicked = 1
			Round.BackColor = 255
			il_chessx = This.PointerX( )
			il_chessY = This.PointerY( )
		End If
	End If
Else
	For ll_i = 1 To UpperBound(iv_arr_round)
		iv_arr_round[ll_i].BackColor = This.BackColor
		iv_arr_round[ll_i].il_clicked = 0
	Next
	ib_choose = False
	
	Round.il_clicked = 0
	Round.BackColor = This.BackColor
End If



end event

public function any wf_return_coordinates (integer al_x, integer al_y);//Returns chess array coordinates
Long ll_i,ll_x,ll_y
Long ll_number
Long ll_arr[]
ll_arr[1] = 0
ll_arr[2] = 0
For ll_i = 1 To 10 //X
	ll_y = il_x*ll_i
	ll_number = il_y/2
	If al_y >= ll_y - ll_number And al_y <= ll_number+ll_y Then
		ll_arr[1] = ll_i
		Exit
	End If
Next

For ll_i = 0 To 8 //Y
	ll_x = il_x+(ll_i*il_span_y)
	ll_number = il_span_y/2
	If al_x >= ll_x - ll_number And al_x <= ll_number+ll_x Then
		ll_arr[2] = ll_i+1
		Exit
	End If
Next

Return ll_arr

end function

public subroutine wf_draw_chess_attribute (integer al_x, integer al_y, string as_name, integer al_type);//Parent
vo_round round
round = create vo_round
round.is_text = as_name
round.il_type = al_type
round.il_backcolor = this.backcolor
round.parentWin = this
if al_type = 1 then //1 black 2 red
	round.il_color = ll_chess_color
	round.tag = '1'
else
	round.il_color = ll_chess_color2
	round.tag = '2'
end if
OpenUserObject(round,al_x -(round.width/2),al_y -(round.height/2)) 	
iv_arr_round[UpperBound(iv_arr_round) + 1] = round 
round.visible = true



end subroutine

public subroutine wf_draw_chess ();//This.setredraw(false)
//This.setredraw(true)
Long ll_number
Long ll_x,ll_y
Long ll_i,ll_j
This.SetRedraw(False)
For ll_i = 1 To UpperBound(iv_arr_round)
	CloseUserObject(iv_arr_round[ll_i])
Next

iv_arr_round = iv_arr_null
For ll_i = 1 To 10
	For ll_j = 0 To 8
		ll_x = il_x+(ll_j*il_span_y)
		ll_y = il_y*ll_i
		ll_number = il_any_chess[ll_i,ll_j +1]
		//1車 ，2马，3象，4士，5将，6炮，7卒
		If ll_number = 1 Then
			wf_draw_chess_attribute(ll_x,ll_y,'車',1)
		ElseIf ll_number = 2 Then
			wf_draw_chess_attribute(ll_x,ll_y,'马',1)
		ElseIf ll_number = 3 Then
			wf_draw_chess_attribute(ll_x,ll_y,'象',1)
		ElseIf ll_number = 4 Then
			wf_draw_chess_attribute(ll_x,ll_y,'士',1)
		ElseIf ll_number = 5 Then
			wf_draw_chess_attribute(ll_x,ll_y,'将',1)
		ElseIf ll_number = 6 Then
			wf_draw_chess_attribute(ll_x,ll_y,'炮',1)
		ElseIf ll_number = 7 Then
			wf_draw_chess_attribute(ll_x,ll_y,'卒',1)
		ElseIf ll_number = 11 Then
			wf_draw_chess_attribute(ll_x,ll_y,'車',2)
		ElseIf ll_number = 22 Then
			wf_draw_chess_attribute(ll_x,ll_y,'马',2)
		ElseIf ll_number = 33 Then
			wf_draw_chess_attribute(ll_x,ll_y,'象',2)
		ElseIf ll_number = 44 Then
			wf_draw_chess_attribute(ll_x,ll_y,'士',2)
		ElseIf ll_number = 55 Then
			wf_draw_chess_attribute(ll_x,ll_y,'帅',2)
		ElseIf ll_number = 66 Then
			wf_draw_chess_attribute(ll_x,ll_y,'炮',2)
		ElseIf ll_number = 77 Then
			wf_draw_chess_attribute(ll_x,ll_y,'卒',2)
		End If
	Next
Next
This.SetRedraw(True)
//	vo_round round
//	round = create vo_round
//	round.il_color = ll_chess_color
//	OpenUserObject(round,ll_x -(round.width/2),ll_y -(round.height/2)) 	
//	round.visible = true
//



end subroutine

public function boolean wf_chess_rules (integer gi, integer gj, integer si, integer sj);//  1  2  3  4  5  6  7  8  9
//{ 1, 2, 3, 4, 5, 4, 3, 2, 1 } 1
//{ 0, 0, 0, 0, 0, 0, 0, 0, 0 } 2
//{ 0, 6, 0, 0, 0, 0, 0, 6, 0 } 3
//{ 7, 0, 7, 0, 7, 0, 7, 0, 7 } 4
//{ 0, 0, 0, 0, 0, 0, 0, 0, 0 } 5
//{ 0, 0, 0, 0, 0, 0, 0, 0, 0 } 6
//{ 77,0, 77,0, 77,0, 77,0,77 } 7
//{ 0, 66,0, 0, 0, 0, 0, 66,0 } 8
//{ 0, 0, 0, 0, 0, 0, 0, 0, 0 } 9
//{ 11,22,33,44,55,44,33,22,11} 10
//1車 ，2马，3象，4士，5将，6炮，7卒

Long ll_type
Long ll_i,ll_start,ll_end
Int t = 0
ll_type = il_any_chess[gi,gj] //Return to the selected chess logo

//車 straight line
If ll_type = 1 Or ll_type = 11 Then
	If gi = si Then
		ll_start = Min(gj, sj);
		ll_end = Max(gj, sj);
		
		For ll_i = 1  To ll_end -ll_start -1
			If il_any_chess[gi,ll_start+ll_i] <> 0 Then
				Return False
			End If
		Next
		Return True
	ElseIf gj = sj Then
		ll_start = Min(gi, si);
		ll_end = Max(gi, si);
		
		For ll_i = 1  To ll_end -ll_start  -1
			If il_any_chess[ll_start+ll_i,gj] <> 0 Then
				Return False
			End If
		Next
		Return True
	End If
	
	//马 walking day
ElseIf ll_type = 2 Or ll_type = 22 Then
	//下
	If gi+1 > 0 And gi+1 <= 10 Then
		If si - gi = 2 And Abs(gj -sj) = 1 And il_any_chess[gi+1,gj] = 0 Then
			Return True
		End If
	End If
	//上
	If gi -1 > 0 And gi -1 <= 10 Then
		If gi - si = 2 And Abs(gj -sj) = 1 And il_any_chess[gi -1,gj] = 0 Then
			Return True
		End If
	End If
	//右	
	If gj +1 > 0 And gj +1 <= 9 Then
		If sj - gj = 2 And Abs(gi -si) = 1 And il_any_chess[gi,gj +1] = 0 Then
			Return True
		End If
	End If
	//左	
	If gj -1 > 0 And gj -1 <= 9 Then
		If gj - sj = 2 And Abs(gi -si) = 1 And il_any_chess[gi,gj -1] = 0 Then
			Return True
		End If
	End If
	
	Return False
	
	//象 walking field
ElseIf ll_type = 3 Or ll_type = 33 Then
	//左上
	If gi -1 > 0 And gi -1 <= 10 And gj -1 > 0 And gj -1 <= 9 Then
		If gi - si = 2 And gj - sj = 2 And il_any_chess[gi -1,gj -1] = 0 Then
			If (ll_type = 33 And si >= 6) Or (ll_type = 3 And si <= 5) Then
				Return True
			Else
				Return False
			End If
		End If
	End If
	//右上
	If gi -1 > 0 And gi -1 <= 10 And gj +1 > 0 And gj +1 <= 9 Then
		If gi - si = 2 And sj - gj = 2 And il_any_chess[gi -1,gj +1] = 0 Then
			If (ll_type = 33 And si >= 6) Or (ll_type = 3 And si <= 5) Then
				Return True
			Else
				Return False
			End If
		End If
	End If
	//左下
	If gi +1 > 0 And gi +1 <= 10 And gj -1 > 0 And gj -1 <= 9 Then
		If si - gi = 2 And gj - sj = 2 And il_any_chess[gi +1,gj -1] = 0 Then
			If (ll_type = 33 And si >= 6) Or (ll_type = 3 And si <= 5) Then
				Return True
			Else
				Return False
			End If
		End If
	End If
	//右下
	If gi +1 > 0 And gi +1 <= 10 And gj +1 > 0 And gj +1 <= 9 Then
		If si - gi = 2 And sj - gj = 2 And il_any_chess[gi +1,gj +1] = 0 Then
			If (ll_type = 33 And si >= 6) Or (ll_type = 3 And si <= 5) Then
				Return True
			Else
				Return False
			End If
		End If
	End If
	//士 You can't get out of the field if you walk obliquely
ElseIf ll_type = 4 Or ll_type = 44 Then
	If Abs(gj -sj) = 1 And Abs(gi -si) = 1 Then
		If ll_type = 44 And si >= 8 And sj >= 4 And sj <= 6 Then
			Return True
		ElseIf ll_type = 4 And si <= 3 And sj >= 4 And sj <= 6 Then
			Return True
		Else
			Return False
		End If
	End If
	//将 Can't get out of the field and can't meet
ElseIf ll_type = 5 Or ll_type = 55 Then
	//mle_1.text = mle_1.text+'~r~n' + string(gi)+':'+string(gj)+':'+ string(si)+':'+string(sj)
	//mle_1.text = mle_1.text+'~r~n'+string(abs(gj -sj))+':'+string(gi - si)+':'+string(abs(gj -sj))+':'+string( gi - si)
	If (Abs(gj -sj) = 1 And gi - si = 0) Or (gj -sj = 0 And Abs(gi - si) = 1) Then
		If ll_type = 55 And si >= 8 And sj >= 4 And sj <= 6 Then
			Return True
		ElseIf ll_type = 5 And si <= 3 And sj >= 4 And sj <= 6 Then
			Return True
		Else
			Return False
		End If
	End If
	//炮 every other one
ElseIf ll_type = 6 Or ll_type = 66 Then
	If il_any_chess[si,sj] <> 0 Then
		t = 0
		If gi = si Then
			For ll_i = Min(gj, sj) To Max(gj, sj)
				If il_any_chess[gi,ll_i] <> 0 Then t++
			Next
		ElseIf gj = sj Then
			For ll_i = Min(gi, si) To Max(gi, si)
				//mle_1.text = mle_1.text+'~r~n' + string(gi)+':'+string(ll_i)+':'+ string(si)+':'+string(sj)
				If il_any_chess[ll_i,gj] <> 0 Then t++
			Next
		End If
		
		If t = 3 Then Return True
	Else
		t = 0
		If gi = si Then
			For ll_i = Min(gj, sj) To Max(gj, sj)
				If(il_any_chess[gi,ll_i] <> 0) Then	t++
		Next
	ElseIf gj = sj Then
		For ll_i = Min(gi, si) To Max(gi, si)
			If il_any_chess[ll_i,gj] <> 0 Then t++
		Next
	End If
	If t = 1 Then Return True
End If
//To capture a pawn, there must be one and only one pawn in the middle
//			if(x*y!=0){
//				int t = 0;
//				if(gi == si){
//					for(int m = Math.min(gj, sj); m <= Math.max(gj, sj); m++){
//						if(place[gi][m] != 0)	t++;
//					}
//				}
//				else if(gj == sj){
//					for(int m = Math.min(gi, si); m <= Math.max(gi, si); m++){
//						if(place[m][gj] != 0)	t++;
//					}
//				}
//				if(t == 3)	return true;
//				
//			}	
//				
//			//In the case of not taking a piece, there must be no other pieces in the middle, and only a straight line can be played
//			else {
//				int t = 0;
//				if(gi == si){
//					for(int m = Math.min(gj, sj); m <= Math.max(gj, sj); m++){
//						if(place[gi][m] != 0)	t++;
//					}
//				}
//				else if(gj == sj){
//					for(int m = Math.min(gi, si); m <= Math.max(gi, si); m++){
//						if(place[m][gj] != 0)	t++;
//					}
//				}
//				if(t == 1) return true;
//				else return false;
//			}


//兵 You can't go back, and you can move left and right after crossing the river
ElseIf ll_type = 7 Or ll_type = 77 Then
	If ll_type = 77 Then
		If gi > 5 Then //Determine whether to cross the river
			If gi - si = 1 And gj = sj Then
				Return True
			Else
				Return False
			End If
		ElseIf (gi - si = 1 And gj - sj = 0) Or (gi - si = 0 And Abs(sj -gj) = 1) Then
			Return True
		Else
			Return False
		End If
	ElseIf ll_type = 7 Then
		If gi <= 5 Then
			If(si - gi = 1 And gj = sj) Then
			Return True
		Else
			Return False
		End If
	ElseIf (si - gi = 1 And sj - gj = 0) Or (gi - si = 0 And Abs(sj -gj) = 1)	Then
		Return True
	Else
		Return False
	End If
End If
End If

Return False

end function

public subroutine wf_draw_board ();vo_line Line
Long ll_i,ll_j,ll_k
Long ll_max_height


il_span_y = il_lenght/8

//horizontal line
For ll_i = 1 To 10
	Line = Create vo_line
	Line.il_height = 3
	Line.il_width = il_lenght
	Line.parentwin = This
	If ll_i = 4 Then ll_max_height = il_y*ll_i
	OpenUserObject(Line,il_x,il_y*ll_i)
Next

//vertical line
For ll_i = 0 To 8
	Line = Create vo_line
	Line.il_width = 3
	Line.parentwin = This
	If ll_i = 0 Or ll_i = 8 Then
		Line.il_height = il_y * 9
		OpenUserObject(Line,il_x+ll_i*il_span_y,il_y)
	Else
		
		Line.il_height = ll_max_height
		OpenUserObject(Line,il_x+ll_i*il_span_y,il_y)
	End If
Next

//under the vertical bar
For ll_i = 0 To 8
	Line = Create vo_line
	Line.il_width = 3
	Line.parentwin = This
	If ll_i = 0 Or ll_i = 8 Then
	Else
		Line.il_height = ll_max_height
		OpenUserObject(Line,il_x+ll_i*il_span_y,il_y * 6)
	End If
Next

//Chu River and Han World
statictext ls_new
ls_new = Create statictext
ls_new.Width = il_span_y*2
ls_new.Height = il_y/1.5
ls_new.Visible = True
ls_new.Text = "楚河"
ls_new.Alignment = center!
ls_new.TextSize = il_y/5
ls_new.Weight = 700
ls_new.BackColor = This.BackColor
ls_new.TextColor = 255
This.OpenUserObject(ls_new,"statictext",il_x+1*il_span_y, ll_max_height+il_y+((il_y -ls_new.Height)/2))

ls_new = Create statictext
ls_new.Width = il_span_y*2
ls_new.Height = il_y/1.5
ls_new.Visible = True
ls_new.Text = "汉界"
ls_new.Alignment = center!
ls_new.TextSize = il_y/5
ls_new.Weight = 700
ls_new.BackColor = This.BackColor
ls_new.TextColor = 255
This.OpenUserObject(ls_new,"statictext",il_x+5*il_span_y, ll_max_height+il_y+((il_y -ls_new.Height)/2))


//upslash, dash
ln_1.BeginX = il_x+(3*il_span_y)
ln_1.BeginY = il_y
ln_1.EndX = il_x+(5*il_span_y)
ln_1.EndY = il_y * 3
ln_1.LineStyle = dot!
ln_1.LineColor = 255

ln_2.BeginX = il_x+(5*il_span_y)
ln_2.BeginY = il_y
ln_2.EndX = il_x+(3*il_span_y)
ln_2.EndY = il_y * 3
ln_2.LineStyle = dot!
ln_2.LineColor = 255
//underslash, dash
ln_3.BeginX = il_x+(3*il_span_y)
ln_3.BeginY = il_y* 8
ln_3.EndX = il_x+(5*il_span_y)
ln_3.EndY = il_y* 10
ln_3.LineStyle = dot!
ln_3.LineColor = 255

ln_4.BeginX = il_x+(5*il_span_y)
ln_4.BeginY = il_y* 8
ln_4.EndX = il_x+(3*il_span_y)
ln_4.EndY = il_y * 10
ln_4.LineStyle = dot!
ln_4.LineColor = 255
//draw corners
Long ll_width = 30,ll_height = 3
Long ll_radius = ll_width/2

For ll_i = 0 To 9
	For ll_k = 0 To 8
		If ((ll_i = 1 Or ll_i = 7) And (ll_k = 3 Or ll_k = 8)) Or ((ll_i = 0 Or ll_i = 2 Or ll_i = 4 Or ll_i = 6 Or ll_i = 8) And (ll_k = 4 Or ll_k = 7)) Then
			For ll_j = 1 To 4
				Line = Create vo_line
				Line.il_width = ll_width
				Line.il_height = ll_height
				Line.parentwin = This
				If ll_j = 1 Then
					If ll_i = 8  Then
					Else
						OpenUserObject(Line,il_x+(ll_i*il_span_y) +ll_radius,(il_y*ll_k) -ll_radius)
					End If
				ElseIf ll_j = 2 Then
					If ll_i = 8  Then
					Else
						OpenUserObject(Line,il_x+(ll_i*il_span_y) +ll_radius,(il_y*ll_k) +ll_radius)
					End If
				ElseIf ll_j = 3 Then
					If ll_i = 0 Then
					Else
						OpenUserObject(Line,il_x+(ll_i*il_span_y) -(ll_width+ll_radius),(il_y*ll_k) -ll_radius)
					End If
				ElseIf ll_j = 4 Then
					If ll_i = 0 Then
					Else
						OpenUserObject(Line,il_x+(ll_i*il_span_y) -(ll_width+ll_radius),(il_y*ll_k) +ll_radius)
					End If
				End If
			Next
		End If
	Next
Next


For ll_i = 0 To 9 //Column
	For ll_k = 0 To 8 //Row
		If ((ll_i = 1 Or ll_i = 7) And (ll_k = 3 Or ll_k = 8)) Or ((ll_i = 0 Or ll_i = 2 Or ll_i = 4 Or ll_i = 6 Or ll_i = 8) And (ll_k = 4 Or ll_k = 7)) Then
			For ll_j = 1 To 4
				Line = Create vo_line
				Line.il_width = ll_height
				Line.il_height = ll_width
				Line.parentwin = This
				If ll_j = 1 Then
					If ll_i = 8 Then
					Else
						OpenUserObject(Line,il_x+(ll_i*il_span_y) +ll_radius,(il_y*ll_k) -(ll_width+ll_radius))
					End If
				ElseIf ll_j = 2 Then
					If ll_i = 0 Then
					Else
						OpenUserObject(Line,il_x+(ll_i*il_span_y) -ll_radius,(il_y*ll_k) -(ll_width+ll_radius))
					End If
				ElseIf ll_j = 3 Then
					If ll_i = 0  Then
					Else
						OpenUserObject(Line,il_x+(ll_i*il_span_y) -ll_radius,(il_y*ll_k) +ll_radius)
					End If
				ElseIf ll_j = 4 Then
					If ll_i = 8  Then
					Else
						OpenUserObject(Line,il_x+(ll_i*il_span_y) +ll_radius,(il_y*ll_k) +ll_radius)
					End If
				End If
			Next
		End If
	Next
Next
//outermost border
Line = Create vo_line
Line.il_width = il_lenght + 40
Line.il_height = 3
Line.parentwin = This
OpenUserObject(Line,il_x - 20,(il_y*10)+15)

Line = Create vo_line
Line.il_width = il_lenght + 40
Line.il_height = 3
Line.parentwin = This
OpenUserObject(Line,il_x - 20,(il_y*1) -15)

Line = Create vo_line
Line.il_width = 3
Line.il_height = (il_y * 9) + 40
Line.parentwin = This
OpenUserObject(Line,(il_x+0*il_span_y) - 20,(il_y * 1) -15)

Line = Create vo_line
Line.il_width = 3
Line.il_height = (il_y * 9) + 40
Line.parentwin = This
OpenUserObject(Line,(il_x+8*il_span_y) + 20,(il_y * 1) -15)

//OpenUserObject(line,il_x+ll_i*il_span_y,il_y * 6) 			


end subroutine

public subroutine wf_empty_chess ();long ll_i
string ls_type

for ll_i = 1 to UpperBound(iv_arr_round)
	closeuserobject(iv_arr_round[ll_i])
next

end subroutine

public function boolean wf_meet ();//decide whether to meet
Int i,j
Int jiangi = 0, jiangj = 0, shuaii = 0, shuaij = 0, temp = 0;
For i = 1 To 10
	For j = 1 To 9
		If il_any_chess[i,j] = 55 Then
			shuaii = i;
			shuaij = j;
			
		ElseIf il_any_chess[i,j] = 5 Then
			jiangi = i;
			jiangj = j;
		End If
	Next
Next

If shuaij = jiangj Then
	For i = jiangi+1 To shuaii -1
		If il_any_chess[i,shuaij] <> 0 Then	temp++
	Next
Else
	Return False;
	//did not meet
End If

If temp <> 0 Then
	Return False;
	//did not meet
Else
	Return True;
	//meet up
End If
Return False

end function

on w_main.create
this.cb_2=create cb_2
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.Control[]={this.cb_2,&
this.dw_1,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4}
end on

on w_main.destroy
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
end on

event clicked;Long ll_mous_x, ll_mous_y
Long ll_i,ll_j
Long ll_x,ll_y,ll_number
Long ll_choosex,ll_choosey,ll_movex,ll_movey
Long ll_arr[], ll_type
Boolean lb_bool = False

//mle_1.text = mle_1.text +'~r~n'+string(il_chessX)+ ':'+ string(il_chessY)
If ib_choose Then
	//select coordinates
	ll_arr = wf_return_coordinates(il_chessx,il_chessY)
	ll_choosex = ll_arr[1]
	ll_choosey = ll_arr[2]
	ll_type = il_any_chess[ll_choosex,ll_choosey] //Return the selected chess ID
	//move coordinates
	ll_mous_x = xpos //w_chess.pointerx( )
	ll_mous_y = ypos //w_chess.pointery( )
	ll_arr = wf_return_coordinates(ll_mous_x,ll_mous_y)
	ll_movex = ll_arr[1]
	ll_movey = ll_arr[2]
	If ll_movex <= 0 Or ll_movey <= 0 Then Return
	//Judging the position (the selected chess cannot be the same color as the chess that moves to the specified position)
	If (ll_type > 0 And ll_type < 10 And il_any_chess[ll_movex,ll_movey] > 0 And il_any_chess[ll_movex,ll_movey] < 10) Or +&
		(ll_type > 10 And il_any_chess[ll_movex,ll_movey] > 10) Then
		//messagebox("","")
	Else
		// Judge the rules of chess pieces
		If wf_chess_rules(ll_choosex,ll_choosey,ll_movex,ll_movey) Then
			//Eat the general or handsome to judge the outcome
			If il_any_chess[ll_movex,ll_movey] = 5 Or il_any_chess[ll_movex,ll_movey] = 55 Then
				lb_bool = True
			End If
			
			//Save the chess point for regret
			Long ll_insertrow
			ll_insertrow = dw_1.InsertRow(0)
			dw_1.Object.a[ll_insertrow] = ll_choosex
			dw_1.Object.b[ll_insertrow] = ll_choosey
			dw_1.Object.c[ll_insertrow] = ll_type
			dw_1.Object.d[ll_insertrow] = ll_movex
			dw_1.Object.e[ll_insertrow] = ll_movey
			dw_1.Object.f[ll_insertrow] = il_any_chess[ll_movex,ll_movey]
			dw_1.Object.g[ll_insertrow] = il_player
			//change position
			il_any_chess[ll_choosex,ll_choosey] = 0
			il_any_chess[ll_movex,ll_movey] = ll_type
			//Redraw the chessboard
			wf_draw_chess()
			
			// handsome will meet
			If wf_meet() Then
				lb_bool = True
				If il_player = 1 Then
					il_player = 2
				Else
					il_player = 1
				End If
			End If
			
			//Finish
			If lb_bool Then
				If il_player = 1 Then
					MessageBox("Tips","Black wins")
				Else
					MessageBox("Prompt","Red team wins")
				End If
				Return
			End If
			
			//play switch
			ib_choose = False
			If il_player = 1 Then
				il_player = 2
				st_2.Text = 'Current player: Red'
				st_2.TextColor = 255
			Else
				il_player = 1
				st_2.Text = 'Current player: Black'
				st_2.TextColor = 0
			End If
		End If
	End If
End If

end event

event open;wf_draw_board()
end event

type cb_2 from commandbutton within w_main
integer x = 727
integer y = 2152
integer width = 457
integer height = 128
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Back"
end type

event clicked;long a,b,c,d,e,f,g
long ll_i

if dw_1.rowcount() > 0 then
	ll_i = dw_1.rowcount()
	a=dw_1.object.a[ll_i]
	b=dw_1.object.b[ll_i]
	c=dw_1.object.c[ll_i]
	d=dw_1.object.d[ll_i]
	e=dw_1.object.e[ll_i]
	f=dw_1.object.f[ll_i]
	g=dw_1.object.g[ll_i]
	
	il_any_chess[a,b] = c
	il_any_chess[d,e] = f
	
	wf_draw_chess()
	il_player = g
	dw_1.deleterow(ll_i)
end if
end event

type dw_1 from datawindow within w_main
boolean visible = false
integer x = 50
integer y = 64
integer width = 1673
integer height = 668
integer taborder = 10
boolean titlebar = true
string title = "none"
string dataobject = "d_arrxy"
boolean controlmenu = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_main
integer x = 1257
integer y = 2140
integer width = 855
integer height = 152
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
boolean visible = false
integer x = 2373
integer y = 56
integer width = 1271
integer height = 100
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "1車 ，2马，3象，4士，5将，6炮，7卒"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_main
integer x = 151
integer y = 2152
integer width = 457
integer height = 128
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Start Game"
end type

event clicked;long ll_i,ll_j

//initial
il_chessX = 0
il_chessY = 0
ib_choose = false
il_player = 2 //1=black 2=red
wf_empty_chess()
iv_arr_round =iv_arr_null
il_any_chess= il_any_null
dw_1.reset()
st_2.text = 'Current Chess Team: Red'
st_2.textcolor = 255

// initialize chess
//{ 1, 2, 3, 4, 5, 4, 3, 2, 1 } 1
//{ 0, 0, 0, 0, 0, 0, 0, 0, 0 } 2
//{ 0, 6, 0, 0, 0, 0, 0, 6, 0 } 3
//{ 7, 0, 7, 0, 7, 0, 7, 0, 7 } 4
//{ 0, 0, 0, 0, 0, 0, 0, 0, 0 } 5
//{ 0, 0, 0, 0, 0, 0, 0, 0, 0 } 6
//{ 77,0, 77,0, 77,0, 77,0,77 } 7
//{ 0, 66,0, 0, 0, 0, 0, 66,0 } 8
//{ 0, 0, 0, 0, 0, 0, 0, 0, 0 } 9
//{ 11,22,33,44,55,44,33,22,11} 10
//1車 ，2马，3象，4士，5将，6炮，7卒
//long ll_i,ll_j

for ll_i=1 to 10
  for ll_j=1 to 9
     il_any_chess[ll_i,ll_j] = 0
  next
next

il_any_chess[1,1] = 1
il_any_chess[1,2] = 2
il_any_chess[1,3] = 3
il_any_chess[1,4] = 4
il_any_chess[1,5] = 5
il_any_chess[1,6] = 4
il_any_chess[1,7] = 3
il_any_chess[1,8] = 2
il_any_chess[1,9] = 1

il_any_chess[3,2] = 6
il_any_chess[3,8] = 6

il_any_chess[4,1] = 7
il_any_chess[4,3] = 7
il_any_chess[4,5] = 7
il_any_chess[4,7] = 7
il_any_chess[4,9] = 7


il_any_chess[10,1] = 11
il_any_chess[10,2] = 22
il_any_chess[10,3] = 33
il_any_chess[10,4] = 44
il_any_chess[10,5] = 55
il_any_chess[10,6] = 44
il_any_chess[10,7] = 33
il_any_chess[10,8] = 22
il_any_chess[10,9] = 11

il_any_chess[8,2] = 66
il_any_chess[8,8] = 66

il_any_chess[7,1] = 77
il_any_chess[7,3] = 77
il_any_chess[7,5] = 77
il_any_chess[7,7] = 77
il_any_chess[7,9] = 77

wf_draw_chess()




end event

type ln_1 from line within w_main
long linecolor = 33554432
integer linethickness = 3
integer beginx = 3186
integer beginy = 52
integer endx = 3685
integer endy = 472
end type

type ln_2 from line within w_main
long linecolor = 33554432
integer linethickness = 3
integer beginx = 3237
integer endx = 3735
integer endy = 420
end type

type ln_3 from line within w_main
long linecolor = 33554432
integer linethickness = 3
integer beginx = 2139
integer beginy = 2180
integer endx = 2638
integer endy = 2600
end type

type ln_4 from line within w_main
long linecolor = 33554432
integer linethickness = 3
integer beginx = 2190
integer beginy = 2128
integer endx = 2688
integer endy = 2548
end type

