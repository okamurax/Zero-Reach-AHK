; ^Ctrl, !Alt, +Shif, #Win

#Requires AutoHotkey v2.0
#SingleInstance Force
ProcessSetPriority "High"
SetMouseDelay -1
SetKeyDelay -1
SendMode "Input"
A_MaxHotkeysPerInterval := 200
InstallKeybdHook
InstallMouseHook
#UseHook
CoordMode "Mouse", "Window"

/*
# Google IME
*/

; Hiragana＞IMEを有効化
; Muhenkan＞IMEを無効化

; エントリーを削除
; Henkan
; Shift Henkan
; Shift Muhenkan

/*
# Hotstring
*/

:*:!ime:: {
  Run '"C:\\Program Files (x86)\\Google\\Google Japanese Input\\GoogleIMEJaTool.exe" -mode=config_dialog'
}

:*:!size:: {
  WinGetPos &x, &y, &w, &h, "A"
  SendText x "," y "," w "," h
}

/*
# Esc
*/

>+4::Send "{Enter}"

>+7::Send "{Home}"
>+8::Send "{End}"
>+9::Send "{.}"

>+q::Send "{&}"
>+w::Send "{'}"

>+a::Send "{~}"
>+s::Send "{``}"

>+z::Send "{^}"
>+x::Send "{$}"

>+u::Send "{|}"
>+i::Send "{\}"
>+o::Send "{@}"
>+p::Send "{`%}"

>+n::Send "{(}"
>+m::Send "{)}"

>+h::Send "{Left}"
>+j::Send "{Down}"
>+k::Send "{Up}"
>+l::Send "{Right}"

>+Backspace::Send "{Delete}"

/*
# Tab
*/

~sc07B::
{
  If (A_PriorHotkey = A_ThisHotkey && 500 > A_TimeSincePriorHotkey)
  {
    Send "{sc070}"
  }
}

sc07B & 2::Send "{F2}"

sc07B & q::Send "{Esc}"
sc07B & w::Send "#s"

sc07B & sc079::Send "!{Space}" ; CLaunch 

/*
# Ctrl 
*/

~^c::
{
  If (A_PriorHotkey = A_ThisHotkey && 500 > A_TimeSincePriorHotkey)
  {
    Send "{End}+{Home}^c"
  }
}

/*
# Shift
*/

~LShift up::
{
  If (A_PriorHotkey = A_ThisHotkey && 500 > A_TimeSincePriorHotkey)
  {
    Run "G:\Dropbox\Workspace\CodeSnippets\SnippetViewer\bin\Release\net8.0-windows\win-x64\SnippetViewer.exe"
  }
}

/*
# SpaceLeft
*/

/*
sc079::Ctrl ; SpreadSheet対策
*/

sc079::
{
  MouseGetPos(,,&id)
  WinActivate("ahk_id " . id)
}

sc079 & LControl::AltTab

sc079 & 1::MyWinMove(1)
sc079 & 2::MyWinMove(2)
sc079 & 3::Send "^{Home}" ; Ctrl+Home
sc079 & 4::Send "^{End}" ; Ctrl+End

sc079 & q::Send "!{Left}" ; 戻る
sc079 & w::Send "!{Right}" ; 進む
sc079 & e::Send "^w" ; 閉じる

sc079 & a::Send "^+{Tab}" ; 前のタブ
sc079 & s::Send "^{Tab}" ; 次のタブ
sc079 & d::Send "^+t" ; 再び開く
sc079 & f::Send "^{F5}" ; 更新

sc079 & g::Send "!+g" ; Alt+Shift+G / Chrome
sc079 & z::Send "!+z" ; Alt+Shift+Z / Chrome
sc079 & x::MyWinMove(3)

sc079 & c::
{
  this_id := WinGetID("A")
  If (WinGetMinMax(this_id) = 1)
  {
    WinRestore(this_id)
    WinMove(,,1200,750,this_id)
  }
  WinGetPos(,,&w,,this_id)
  MouseMove(w/2, 9)
}

sc079 & v::
{
  this_id := WinGetID("A")
  If (WinGetMinMax(this_id) = 1)
  {
    Return
  }
  WinGetPos(,,&w,&h,this_id)
  MouseMove(w-7, h-7)
}

mm := []
If (MonitorGetCount() = 3)
{
  MonitorGetWorkArea(1,&L,&T,&R,&B)
  mm.Push({L:L,T:T,R:R,B:B})
  MonitorGetWorkArea(2,&L,&T,&R,&B)
  mm.Push({L:L,T:T,R:R,B:B})
  MonitorGetWorkArea(3,&L,&T,&R,&B)
  mm.Push({L:L,T:T,R:R,B:B})
}
Else If (MonitorGetCount() = 2)
{
  MonitorGetWorkArea(1,&L,&T,&R,&B)
  mm.Push({L:L,T:T,R:R,B:B})
  MonitorGetWorkArea(2,&L,&T,&R,&B)
  mm.Push({L:L,T:T,R:R,B:B})
}
Else
{
  MonitorGetWorkArea(1,&L,&T,&R,&B)
  mm.Push({L:L,T:T,R:R,B:B})
}

MyWinMove(x)
{
  this_id := WinGetID("A")
  If (WinGetMinMax(this_id) = 1)
  {
    WinRestore(this_id)
  }
  If (isOverflowProcess())
  {
    WinMove(mm[x].L + 7,mm[x].T + 7,,,this_id)
    WinMove(,,mm[x].R - mm[x].L - 14,mm[x].B - mm[x].T - 14,this_id)
  }
  Else 
  {
    WinMove(mm[x].L,mm[x].T+7,,,this_id)
    WinMove(,,mm[x].R - mm[x].L,mm[x].B - mm[x].T - 7,this_id)
  }
}

isOverflowProcess()
{
  processName := WinGetProcessName("A")
  if (processName = "Obsidian.exe" || 
      processName = "Mattermost.exe" || 
      processName = "PDFelement.exe" || 
      processName = "LINE.exe" || 
      processName = "Code.exe")
  {
    Return true
  }
  Else
  {
    Return false
  }
}

sc079 & ^::Send "^{`^}" ; Ctrl+^ / ShareX
sc079 & \::Send "^{`\}" ; Ctrl+\ / ShareX

/*
# Mouse
*/

sc079 & WheelUp::Send "{WheelUp 4}"
sc079 & WheelDown::Send "{WheelDown 4}"

+WheelUp::Send "{WheelLeft}"
+WheelDown::Send "{WheelRight}"

XButton1::Send "#{Tab}"
XButton2::Run("taskmgr")

/*
# Chrome
*/

#HotIf WinActive("ahk_exe chrome.exe")

MButton::MouseClick "R"
RButton::MouseClick "M"

/*
# VSCode
*/

#HotIf WinActive("ahk_exe Code.exe")

sc079 & e::Send "^{F4}" ; 閉じる
sc079 & a::Send "^{PgUp}" ; 前のタブ
sc079 & s::Send "^{PgDn}" ; 次のタブ

/*
# Excel
*/

#HotIf WinActive("ahk_exe excel.exe")

sc079 & a::Send "^{PgUp}" ; 前のタブ
sc079 & s::Send "^{PgDn}" ; 次のタブ

sc079 & f::Send "^+{L}" ; オートフィルタ

sc079 & v::
{
  Send "!h"
  Sleep 100
  Send "s"
  Sleep 100
  Send "u"
}

+Space::
{
  Send "{sc07B}"
  Send "+{Space}"
}

MButton::
{
  MouseClick "L"
  Send "{F4}"
}

/*
# MPC-BE
*/

#HotIf WinActive("ahk_exe mpc-be64.exe")

sc079 & a::Send "^{PgUp}" ; 前のタブ
sc079 & s::Send "^{PgDn}" ; 次のタブ

w::Send "{Numpad1 10}"
e::Send "^{Numpad2 10}"
r::Send "{Numpad9 10}"

s::Send "^{Numpad6 10}"
d::Send "^{Numpad8 10}"
f::Send "^{Numpad4 10}"

c::Send "{Numpad5}"
v::Send "!{Numpad3}"

#HotIf


