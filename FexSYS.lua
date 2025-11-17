require("FexCore")
require("FexProgramBuild")
suojibiaozhi = true

local function SYSINIT()
    if(suojibiaozhi==true)then
        Program.INIT()
        GUI.DrawForm(1)
        IO.Service("SYS_Showtime")
        IO.Service("REDNET_CHECK")
        if(IO.modemchk == true)then
            IO.Service("REDNET_SET",true)
            Control.Service("INIT_Count")
            Control.Service("INIT_Check")
            Control.Service("INIT_InputIO")
            Control.Service("CUTOFF_OUT")
            Control.Service("INIT_OutputIO")
            IO.modemchk = false
        end
    else
        term.clear()
        IO.ScreenManage("GETTERMSIZE")
        GUI.DrawBox(1,1,GUI.TermWide,GUI.TermHigh,"red","filled")
        GUI.DrawBox(math.ceil(GUI.TermWide / 2)-math.ceil(string.len(" System Locked ") / 2),2,string.len(" System Locked "),3,"yellow","filled")
        GUI.DrawText(math.ceil(GUI.TermWide / 2)-math.ceil(string.len(" System Locked ") / 2),3," System Locked ","red","yellow")
        GUI.DrawTextBox("Since the Phineon Logmatic FEX system you are using is not a perpetual license (one-time purchase) model, you are now seriously overdue on payments in accordance with the dealer contract. Pursuant to the sales agreement, we have no choice but to lock your system—please note that all previously installed programs will remain fully operational. To resume system usage, please call 555-967-5838 to settle the outstanding dues, after which our technical team will promptly assist you with unlocking the system.",2,6,GUI.TermWide-2,14,"white","red")
    end
end

local function EventManager()
    local event,param1,param2,param3 = os.pullEvent()
    if(event=="mouse_click")then
        IO.MouseClick(param1,param2,param3)
    end
    if(event=="mouse_drag")then
        IO.MouseDrag(param1,param2,param3)
    end
    if(event=="mouse_scroll")then
        IO.MouseScroll(param1,param2,param3)
    end
    if(event=="mouse_up")then
        IO.MouseUp(param1,param2,param3)
    end
    if(event=="char")then
        IO.CharInput(param1)
    end
    if(event=="key")then
        IO.KeyPress(keys.getName(param1))
    end
    if(event=="term_resize")then
        IO.ScreenManage("resize")
    end
    if(event=="redstone")then
        Control.Service("INIT_InputIO")
        Control.RedstoneActive()
    end
    if(event=="timer")then
        if(param1==SYS_Timer and IO.ProcessManage["label"]~="lock")then
            IO.Service("SYS_Showtime")
        end
        IO.LisTimerUP(param1)
    end
    if(event=="peripheral" and PortSet.PowerButton == true)then

    end
    if(event=="peripheral_detach")then

    end
end

SYSINIT()
while IO.SYS_RUN do
    if(EventManager)then
        EventManager()
    end
end
term.setCursorBlink(false)
term.setCursorPos(1,2)
os.sleep(2)
term.clear()
term.setCursorPos(1,1)
