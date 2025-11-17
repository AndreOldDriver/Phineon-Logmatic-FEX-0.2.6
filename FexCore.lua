require("FexIO")
GUI = {}
GUI.TermWide,GUI.TermHigh = term.getSize()
local SYS_StartSec,SYS_Time
GUI.Form = {}
GUI.Form[1] = {}
GUI.Form[1]["label"] = "Desktop"
GUI.Form[1]["name"] = "Logmatic FEX 0.2.6"
GUI.Form[1]["taskbutton"] = "logo"
GUI.Form[1]["background_color"] = "cyan"
GUI.Form[1]["button_class"] = ""
GUI.Form[1]["progressbar_class"] = ""
GUI.AccessForm = {}

GUI.QuickON_SYS = {}
GUI.QuickON_SYS[1] = {" ShutDown   ",2,GUI.TermHigh,"white","red",function() os.shutdown() end}
GUI.QuickON_SYS[2] = {" Reboot     ",2,GUI.TermHigh-1,"white","orange",function() os.reboot() end}
GUI.QuickON_SYS[3] = {" LockScreen ",2,GUI.TermHigh-2,"white","green",function() IO.ScreenManage("LOCKSCREEN") end}

IO = {}
IO.SYS_RUN = true
IO.ProcessManage = {}
IO.ProcessManage["label"] = GUI.Form[1]["label"]
IO.ProcessManage["event"] = "main"
IO.ProcessManage["formnum"] = 1
IO.ProcessManage["textbarnum"] = 1
IO.ModemSign = false
IO.modemchk = false

Control = {}
local InputIO_Count = 0
local OutputIO_Count = 0

Phi = {}

function GUI.TermColor(Tcolor,Bcolor)
    local SW_TCOLOR = {
        white = function() term.setTextColor(colors.white) end,
        orange = function() term.setTextColor(colors.orange) end,
        magenta = function() term.setTextColor(colors.magenta) end,
        lightblue = function() term.setTextColor(colors.lightBlue) end,
        yellow = function() term.setTextColor(colors.yellow) end,
        lime = function() term.setTextColor(colors.lime) end,
        pink = function() term.setTextColor(colors.pink) end,
        gray = function() term.setTextColor(colors.gray) end,
        lightgray = function() term.setTextColor(colors.lightGray) end,
        cyan = function() term.setTextColor(colors.cyan) end,
        purple = function() term.setTextColor(colors.purple) end,
        blue = function() term.setTextColor(colors.blue) end,
        brown = function() term.setTextColor(colors.brown) end,
        green = function() term.setTextColor(colors.green) end,
        red = function() term.setTextColor(colors.red) end,
        black = function() term.setTextColor(colors.black) end,
    }
    local SW_TCOLOR_RUN = SW_TCOLOR[Tcolor]
    if(SW_TCOLOR_RUN)then SW_TCOLOR_RUN() end
    local SW_BCOLOR = {
        white = function() term.setBackgroundColor(colors.white) end,
        orange = function() term.setBackgroundColor(colors.orange) end,
        magenta = function() term.setBackgroundColor(colors.magenta) end,
        lightBlue = function() term.setBackgroundColor(colors.lightBlue) end,
        yellow = function() term.setBackgroundColor(colors.yellow) end,
        lime = function() term.setBackgroundColor(colors.lime) end,
        pink = function() term.setBackgroundColor(colors.pink) end,
        gray = function() term.setBackgroundColor(colors.gray) end,
        lightgray = function() term.setBackgroundColor(colors.lightGray) end,
        cyan = function() term.setBackgroundColor(colors.cyan) end,
        purple = function() term.setBackgroundColor(colors.purple) end,
        blue = function() term.setBackgroundColor(colors.blue) end,
        brown = function() term.setBackgroundColor(colors.brown) end,
        green = function() term.setBackgroundColor(colors.green) end,
        red = function() term.setBackgroundColor(colors.red) end,
        black = function() term.setBackgroundColor(colors.black) end,
    }
    local SW_BCOLOR_RUN = SW_BCOLOR[Bcolor]
    if(SW_BCOLOR_RUN)then SW_BCOLOR_RUN() end
end

function GUI.HexColor(color)
    local temp = ""
    if(color=="white")then temp = "0" return temp end
    if(color=="orange")then temp = "1" return temp end
    if(color=="magenta")then temp = "2" return temp end
    if(color=="lightblue")then temp = "3" return temp end
    if(color=="yellow")then temp = "4" return temp end
    if(color=="lime")then temp = "5" return temp end
    if(color=="pink")then temp = "6" return temp end
    if(color=="gray")then temp = "7" return temp end
    if(color=="lightgray")then temp = "8" return temp end
    if(color=="cyan")then temp = "9" return temp end
    if(color=="purple")then temp = "a" return temp end
    if(color=="blue")then temp = "b" return temp end
    if(color=="brown")then temp = "c" return temp end
    if(color=="green")then temp = "d" return temp end
    if(color=="red")then temp = "e" return temp end
    if(color=="black")then temp = "f" return temp end
end

function GUI.FexColor(color)
    if(color=="white")then return colors.white end
    if(color=="orange")then return colors.orange end
    if(color=="magenta")then return colors.magenta end
    if(color=="lightblue")then return colors.lightblue end
    if(color=="yellow")then return colors.yellow end
    if(color=="lime")then return colors.lime end
    if(color=="pink")then return colors.pink end
    if(color=="gray")then return colors.gray end
    if(color=="lightgray")then return colors.lightGray end
    if(color=="cyan")then return colors.cyan end
    if(color=="purple")then return colors.purple end
    if(color=="blue")then return colors.blue end
    if(color=="brown")then return colors.brown end
    if(color=="green")then return colors.green end
    if(color=="red")then return colors.red end
    if(color=="black")then return colors.black end
end

function GUI.DrawText(x,y,Text,Tcolor,Bcolor)
    if(type(x)=="number" and type(y)=="number" and type(Text)=="string" and type(Tcolor)=="string" and type(Bcolor)=="string")then
        local TEXT_COLOR_TEMP1,TEXT_COLOR_TEMP2 = "",""
        local TEXT_COLOR_FLAG,TEXT_BGCOLOR_FLAG = "",""
        TEXT_COLOR_FLAG = GUI.HexColor(Tcolor)
        TEXT_BGCOLOR_FLAG = GUI.HexColor(Bcolor)
        term.setCursorPos(x,y)
        local TEXT_LEN = string.len(Text)
        for i=1,TEXT_LEN do
            TEXT_COLOR_TEMP1 = string.format("%s%s",TEXT_COLOR_TEMP1,TEXT_COLOR_FLAG)
            TEXT_COLOR_TEMP2 = string.format("%s%s",TEXT_COLOR_TEMP2,TEXT_BGCOLOR_FLAG)
        end
        term.blit(Text,TEXT_COLOR_TEMP1,TEXT_COLOR_TEMP2)
        GUI.TermColor("white","black")
    end
end

function GUI.DrawBox(x,y,w,h,color,model)
    if(type(x)=="number" and type(y)=="number" and type(w)=="number" and type(h)=="number" and type(color)=="string")then
        if(x>=1 and y>=1 and w>=1 and h>=1)then
            if(string.upper(model)=="FILLED")then
                paintutils.drawFilledBox(x,y,x+w-1,y+h-1,GUI.FexColor(color))
            elseif(string.upper(model)=="EMPTY")then
                paintutils.drawBox(x,y,x+w-1,y+h-1,GUI.FexColor(color))
            end
        end
    end
end

function GUI.DrawButton(name,x,y,Tcolor,Bcolor)
    local trans = string.upper(name)
    term.setCursorPos(x,y)
    local SW_BUTTON = {
        LOGO = function()
            term.blit("   ","51b","51b")
        end,
        CLOSE = function()
            term.blit(" X ","e4e","eee")
        end,
        BACK = function()
            term.blit(" < ","747","777")
        end,
        INTO = function()
            term.blit(" > ","747","777")
        end,
        MORE = function()
            term.blit(" + ","747","777")
        end,
        LESS = function()
            term.blit(" - ","747","777")
        end
    }
    local SW_BUTTON_RUN = SW_BUTTON[trans]
    if(SW_BUTTON_RUN)then
        SW_BUTTON_RUN()
    else
        GUI.DrawText(x,y,name,Tcolor,Bcolor)
    end
end

function GUI.DrawSwitch(set,x,y,sign)
    if(string.upper(set)=="2SET")then
        if(sign==true)then
            GUI.DrawText(x,y,"ON","white","lime")
            GUI.DrawText(x+2,y,"OFF","white","black")
        elseif(sign==false or sign==nil)then
            GUI.DrawText(x,y,"ON","white","black")
            GUI.DrawText(x+2,y,"OFF","white","red")
        end
    end
    if(string.upper(set)=="3SET")then
        if(sign==1 or sign==nil)then
            GUI.DrawText(x,y,"I","white","lime")
            GUI.DrawText(x+1,y,"O","white","black")
            GUI.DrawText(x+2,y,"O","white","black")
        elseif(sign==2)then
            GUI.DrawText(x,y,"O","white","black")
            GUI.DrawText(x+1,y,"I","white","lime")
            GUI.DrawText(x+2,y,"O","white","black")
        elseif(sign==3)then
            GUI.DrawText(x,y,"O","white","black")
            GUI.DrawText(x+1,y,"O","white","black")
            GUI.DrawText(x+2,y,"I","white","lime")
        end
    end
    if(string.upper(set)=="8SET")then
        if(string.len(sign)<=2 and string.len(sign)>0)then
            if(string.len(sign)==1)then
                if(tonumber(sign))then
                    local temp1 = tonumber(sign)
                    local biotabel = {0,0,0,0}
                    for i=1,4 do
                        biotabel[i] = temp1 % 2
                        temp1 = math.floor(temp1 / 2)
                    end
                    GUI.DrawText(x,y,"8 Set SW","white","gray")
                    for i=0,3 do
                        GUI.DrawText(x+i,y+1,"0","white","black")
                    end
                    for i=1,4 do
                        if(biotabel[5-i]==1)then
                            GUI.DrawText(x+i+3,y+1,tostring(biotabel[5-i]),"white","lime")
                        else
                            GUI.DrawText(x+i+3,y+1,tostring(biotabel[5-i]),"white","black")
                        end
                    end
                else
                    local temp2 = string.upper(sign)
                    local biotabel = {0,0,0,0}
                    local alphatabel = {
                        A = function() biotabel[1] = 0 biotabel[2] = 1 biotabel[3] = 0 biotabel[4] = 1 end,
                        B = function() biotabel[1] = 1 biotabel[2] = 1 biotabel[3] = 0 biotabel[4] = 1 end,
                        C = function() biotabel[1] = 0 biotabel[2] = 0 biotabel[3] = 1 biotabel[4] = 1 end,
                        D = function() biotabel[1] = 1 biotabel[2] = 0 biotabel[3] = 1 biotabel[4] = 1 end,
                        E = function() biotabel[1] = 0 biotabel[2] = 1 biotabel[3] = 1 biotabel[4] = 1 end,
                        F = function() biotabel[1] = 1 biotabel[2] = 1 biotabel[3] = 1 biotabel[4] = 1 end,
                    }
                    local alphatabel_run = alphatabel[temp2]
                    if(alphatabel_run)then
                        alphatabel_run()
                        GUI.DrawText(x,y,"8 Set SW","white","gray")
                        for i=0,3 do
                            GUI.DrawText(x+i,y+1,"0","white","black")
                        end
                        for i=1,4 do
                            if(biotabel[5-i]==1)then
                                GUI.DrawText(x+i+3,y+1,tostring(biotabel[5-i]),"white","lime")
                            else
                                GUI.DrawText(x+i+3,y+1,tostring(biotabel[5-i]),"white","black")
                            end
                        end
                    else
                        return nil
                    end
                end
            elseif(string.len(sign)==2)then
                local hnum = string.sub(sign,1,1)
                local lnum = string.sub(sign,2,2)
                if(tonumber(lnum))then
                    local temp1 = tonumber(lnum)
                    local biotabel = {0,0,0,0}
                    for i=1,4 do
                        biotabel[i] = temp1 % 2
                        temp1 = math.floor(temp1 / 2)
                    end
                    GUI.DrawText(x,y,"8 Set SW","white","gray")
                    for i=1,4 do
                        if(biotabel[5-i]==1)then
                            GUI.DrawText(x+i+3,y+1,tostring(biotabel[5-i]),"white","lime")
                        else
                            GUI.DrawText(x+i+3,y+1,tostring(biotabel[5-i]),"white","black")
                        end
                    end
                else
                    local temp2 = string.upper(lnum)
                    local biotabel = {0,0,0,0}
                    local alphatabel = {
                        A = function() biotabel[1] = 0 biotabel[2] = 1 biotabel[3] = 0 biotabel[4] = 1 end,
                        B = function() biotabel[1] = 1 biotabel[2] = 1 biotabel[3] = 0 biotabel[4] = 1 end,
                        C = function() biotabel[1] = 0 biotabel[2] = 0 biotabel[3] = 1 biotabel[4] = 1 end,
                        D = function() biotabel[1] = 1 biotabel[2] = 0 biotabel[3] = 1 biotabel[4] = 1 end,
                        E = function() biotabel[1] = 0 biotabel[2] = 1 biotabel[3] = 1 biotabel[4] = 1 end,
                        F = function() biotabel[1] = 1 biotabel[2] = 1 biotabel[3] = 1 biotabel[4] = 1 end,
                    }
                    local alphatabel_run = alphatabel[temp2]
                    if(alphatabel_run)then
                        alphatabel_run()
                        GUI.DrawText(x,y,"8 Set SW","white","gray")
                        for i=1,4 do
                            if(biotabel[5-i]==1)then
                                GUI.DrawText(x+i+3,y+1,tostring(biotabel[5-i]),"white","lime")
                            else
                                GUI.DrawText(x+i+3,y+1,tostring(biotabel[5-i]),"white","black")
                            end
                        end
                    else
                        return nil
                    end
                end
                if(tonumber(hnum))then
                    local temp1 = tonumber(hnum)
                    local biotabel = {0,0,0,0}
                    for i=1,4 do
                        biotabel[i] = temp1 % 2
                        temp1 = math.floor(temp1 / 2)
                    end
                    GUI.DrawText(x,y,"8 Set SW","white","gray")
                    for i=1,4 do
                        if(biotabel[5-i]==1)then
                            GUI.DrawText(x+i-1,y+1,tostring(biotabel[5-i]),"white","lime")
                        else
                            GUI.DrawText(x+i-1,y+1,tostring(biotabel[5-i]),"white","black")
                        end
                    end
                else
                    local temp2 = string.upper(hnum)
                    local biotabel = {0,0,0,0}
                    local alphatabel = {
                        A = function() biotabel[1] = 0 biotabel[2] = 1 biotabel[3] = 0 biotabel[4] = 1 end,
                        B = function() biotabel[1] = 1 biotabel[2] = 1 biotabel[3] = 0 biotabel[4] = 1 end,
                        C = function() biotabel[1] = 0 biotabel[2] = 0 biotabel[3] = 1 biotabel[4] = 1 end,
                        D = function() biotabel[1] = 1 biotabel[2] = 0 biotabel[3] = 1 biotabel[4] = 1 end,
                        E = function() biotabel[1] = 0 biotabel[2] = 1 biotabel[3] = 1 biotabel[4] = 1 end,
                        F = function() biotabel[1] = 1 biotabel[2] = 1 biotabel[3] = 1 biotabel[4] = 1 end,
                    }
                    local alphatabel_run = alphatabel[temp2]
                    if(alphatabel_run)then
                        alphatabel_run()
                        GUI.DrawText(x,y,"8 Set SW","white","gray")
                        for i=1,4 do
                            if(biotabel[5-i]==1)then
                                GUI.DrawText(x+i-1,y+1,tostring(biotabel[5-i]),"white","lime")
                            else
                                GUI.DrawText(x+i-1,y+1,tostring(biotabel[5-i]),"white","black")
                            end
                        end
                    else
                        return nil
                    end
                end
            end
        else
            return nil
        end
        term.setCursorPos(1,19)
    end
end

function GUI.DrawProgressbar(name,x,y,percent,color,typeset)
    if(string.upper(typeset)=="TRANS" or typeset==nil)then
        GUI.DrawText(x,y,name,"white","gray")
        paintutils.drawFilledBox(x+string.len(name),y,x+14+string.len(name),y,colors.black)
        if(percent>0)then
            if(color=="lime")then
                paintutils.drawFilledBox(x+string.len(name),y,x+(percent-1)+string.len(name),y,colors.lime)
            end
            if(color=="green")then
                paintutils.drawFilledBox(x+string.len(name),y,x+(percent-1)+string.len(name),y,colors.green)
            end
            if(color=="red")then
                paintutils.drawFilledBox(x+string.len(name),y,x+(percent-1)+string.len(name),y,colors.red)
            end
            if(color=="yellow")then
                paintutils.drawFilledBox(x+string.len(name),y,x+(percent-1)+string.len(name),y,colors.yellow)
            end
            if(color=="orange")then
                paintutils.drawFilledBox(x+string.len(name),y,x+(percent-1)+string.len(name),y,colors.orange)
            end
        else
        end
        term.setCursorPos(1,19)
        GUI.TermColor("white","black")
    elseif(string.upper(typeset)=="LONG")then
        local blackblock = 15-percent
        local namelen = string.len(name)
        if(percent>=0)then
            if(color=="lime")then
                for i=1,15 do
                    if(blackblock>0)then
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.black)
                        blackblock = blackblock - 1
                    else
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.lime)
                    end
                end
                for i=1,namelen do
                    GUI.DrawText(x,y+i-1,string.sub(name,i,i),"white","gray")
                end
                term.setCursorPos(1,19)
            end
            if(color=="green")then
                for i=1,15 do
                    if(blackblock>0)then
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.black)
                        blackblock = blackblock - 1
                    else
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.green)
                    end
                end
                for i=1,namelen do
                    GUI.DrawText(x,y+i-1,string.sub(name,i,i),"white","gray")
                end
                term.setCursorPos(1,19)
            end
            if(color=="red")then
                for i=1,15 do
                    if(blackblock>0)then
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.black)
                        blackblock = blackblock - 1
                    else
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.red)
                    end
                end
                for i=1,namelen do
                    GUI.DrawText(x,y+i-1,string.sub(name,i,i),"white","gray")
                end
                term.setCursorPos(1,19)
            end
            if(color=="yellow")then
                for i=1,15 do
                    if(blackblock>0)then
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.black)
                        blackblock = blackblock - 1
                    else
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.yellow)
                    end
                end
                for i=1,namelen do
                    GUI.DrawText(x,y+i-1,string.sub(name,i,i),"white","gray")
                end
                term.setCursorPos(1,19)
            end
            if(color=="orange")then
                for i=1,15 do
                    if(blackblock>0)then
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.black)
                        blackblock = blackblock - 1
                    else
                        paintutils.drawFilledBox(x+1,y+i-1,x+1,y+i-1,colors.orange)
                    end
                end
                for i=1,namelen do
                    GUI.DrawText(x,y+i-1,string.sub(name,i,i),"white","gray")
                end
                term.setCursorPos(1,19)
            end
        else
        end
    end
end

function GUI.DrawTextBar(temp,x,y,w,tcolor,bcolor)
    if(temp~=nil and type(temp)=="string")then
        local templen = string.len(temp)
        if(templen<=w)then
            local tempblankwide = w - templen
            local tempblank = ""
            for i=1,tempblankwide do
                tempblank = tempblank.." "
            end
            if(tcolor~=nil and bcolor~=nil and type(tcolor)=="string" and type(bcolor)=="string")then
                GUI.DrawText(x,y,string.format("%s%s",temp,tempblank),tcolor,bcolor)
            else
                GUI.DrawText(x,y,string.format("%s%s",temp,tempblank),"white","black")
            end
        elseif(templen>w)then
            local cutemp = string.format("%s..",string.sub(temp,1,w-2))
            if(tcolor~=nil and bcolor~=nil and type(tcolor)=="string" and type(bcolor)=="string")then
                GUI.DrawText(x,y,cutemp,tcolor,bcolor)
            else
                GUI.DrawText(x,y,cutemp,"white","black")
            end
        end
    elseif(temp==nil)then
        if(w>=5)then
            local tempblankwide = w - 5
            local tempblank = ""
            for i=1,tempblankwide do
                tempblank = tempblank.." "
            end
            if(tcolor~=nil and bcolor~=nil and type(tcolor)=="string" and type(bcolor)=="string")then
                GUI.DrawText(x,y,string.format("input%s",tempblank),tcolor,bcolor)
            else
                GUI.DrawText(x,y,string.format("input%s",tempblank),"gray","black")
            end
        elseif(w<5)then
            local tempblank = ""
            for i=1,w do
                tempblank = tempblank.." "
            end
            if(tcolor~=nil and bcolor~=nil and type(tcolor)=="string" and type(bcolor)=="string")then
                GUI.DrawText(x,y,tempblank,tcolor,bcolor)
            else
                GUI.DrawText(x,y,tempblank,"gray","black")
            end
        end
    end
end

function GUI.DrawTextBox(temp,x,y,w,h,tcolor,bcolor,linepage)
    if(type(x)=="number" and type(y)=="number" and type(w)=="number" and type(h)=="number")then
        if(temp~=nil and type(temp)=="string")then
            local templen = string.len(temp)
            local templine = math.ceil(templen / w)
            if(tcolor~=nil and bcolor~=nil and type(tcolor)=="string" and type(bcolor)=="string")then
                GUI.DrawBox(x,y,w,h,bcolor,"filled")
                if(templine<=h)then
                    for i=1,templine do
                        GUI.DrawText(x,y+(i-1),string.sub(temp,1 + w * (i - 1),w * i),tcolor,bcolor)
                    end
                elseif(templine>h)then
                    if(linepage==nil)then linepage = 1 end
                    local lastpage = templine - h + 1
                    if(linepage<=lastpage and linepage>=1)then
                        for i=1,h do
                            GUI.DrawText(x,y+(i-1),string.sub(temp,1 + w * (linepage + i - 2),w * (linepage + i - 1)),tcolor,bcolor)
                        end
                        if(h>lastpage and h / lastpage >= 1)then
                            GUI.DrawBox(x+w,y,1,h,"black","filled")
                            GUI.DrawBox(x+w,y+linepage-1,1,h - lastpage,"gray","filled")
                            GUI.DrawText(x+w,y+h-1,"V","gray","cyan")
                        end
                        --[[
                        local slider = math.ceil(templine / lastpage)
                        GUI.DrawBox(x+w,y,1,h,"black","filled")
                        GUI.DrawBox(x+w,y+linepage-1,1,slider,"gray","filled")
                        ]]--
                    else
                        GUI.DrawTextBox(temp,x,y,w,h,tcolor,bcolor,lastpage)
                    end
                end
            else
                GUI.DrawTextBox(temp,x,y,w,h,"white","black",linepage)
            end
        elseif(temp==nil)then
            if(tcolor~=nil and bcolor~=nil and type(tcolor)=="string" and type(bcolor)=="string")then
                GUI.DrawBox(x,y,w,h,bcolor,"filled")
            else
                GUI.DrawBox(x,y,w,h,"black","filled")
            end
        end
    end
end

function GUI.DrawProgramPage(label,select)
    if(type(label)=="table" and type(select)=="number")then
        local labelchk = false
        for key,value in pairs(label) do
            if(type(value)=="string")then
                labelchk = true
            else
                labelchk = false
                break
            end
        end
        if(labelchk==true)then
            GUI.DrawBox(1,2,GUI.TermWide,1,"gray","filled")
            term.setCursorPos(1,2)
            local nowX,_ = term.getCursorPos()
            local labellen = #label
            for i=1,labellen do
                if(i==select)then
                    GUI.DrawText(nowX,2,string.format(" %s ",label[i]),"black","lightblue")
                else
                    GUI.DrawText(nowX,2,string.format(" %s ",label[i]),"white","gray")
                end
                nowX,_ = term.getCursorPos()
            end
        end
    end
end

function GUI.DrawForm(num)
    IO.ScreenManage("GetTermSize")
    if(type(GUI.Form[num]["label"])=="string" and type(GUI.Form[num]["name"])=="string" and type(GUI.Form[num]["taskbutton"])=="string" and type(GUI.Form[num]["background_color"])=="string")then
        if(num==1)then
            term.clear()
            GUI.DrawBox(1,1,GUI.TermWide,GUI.TermHigh,GUI.Form[num]["background_color"],"filled")
            GUI.DrawBox(1,1,GUI.TermWide,1,"white","filled")
            GUI.DrawButton(GUI.Form[num]["taskbutton"],1,1)
            GUI.DrawText(5,1,GUI.Form[num]["name"],"black","white")
            IO.Service("SYS_Showtime")
            GUI.FormTabelLen = #GUI.Form
            if(GUI.FormTabelLen > 1 and GUI.FormTabelLen ~= 0)then
                local nowX,nowY = 2,3
                for i=2,GUI.FormTabelLen do
                    if(nowX + string.len(GUI.Form[i]["name"])<=GUI.TermWide)then
                        GUI.Form[i]["PosX"] = nowX
                        GUI.Form[i]["PosY"] = nowY
                        if(GUI.Form[i]["icon_tcolor"]~=nil)then
                            GUI.DrawButton(GUI.Form[i]["name"],nowX,nowY,GUI.Form[i]["icon_tcolor"],GUI.Form[i]["icon_bcolor"])
                        else
                            GUI.DrawButton(GUI.Form[i]["name"],nowX,nowY,"white","gray")
                        end
                        nowX,nowY = term.getCursorPos()
                        nowX = nowX + 1
                    else
                        nowY = nowY + 2
                        nowX = 2
                        GUI.Form[i]["PosX"] = nowX
                        GUI.Form[i]["PosY"] = nowY
                        if(GUI.Form[i]["icon_tcolor"]~=nil)then
                            GUI.DrawButton(GUI.Form[i]["name"],nowX,nowY,GUI.Form[i]["icon_tcolor"],GUI.Form[i]["icon_bcolor"])
                        else
                            GUI.DrawButton(GUI.Form[i]["name"],nowX,nowY,"white","gray")
                        end
                        nowX,nowY = term.getCursorPos()
                        nowX = nowX + 1
                    end
                end
            end
        else
            GUI.DrawBox(1,1,GUI.TermWide,GUI.TermHigh,GUI.Form[num]["background_color"],"filled")
            GUI.DrawBox(1,1,GUI.TermWide,1,"white","filled")
            GUI.DrawButton(GUI.Form[num]["taskbutton"],1,1)
            GUI.DrawText(5,1,GUI.Form[num]["name"],"black","white")
            IO.Service("SYS_Showtime")
            if(GUI.Form[num]["page_class"]~=nil)then
                GUI.Form[num]["page_count"] = #GUI.Form[num]["page_class"]
                local page_index_all = GUI.Form[num]["page_class"]
                if(GUI.Form[num]["page_num"]~=nil)then
                    if(GUI.Form[num]["page_num"]<=GUI.Form[num]["page_count"])then
                        local showpage = {}
                        for i=1,GUI.Form[num]["page_count"] do
                            table.insert(showpage,page_index_all[i]["page_name"])
                            if(i>1)then
                                page_index_all[i]["page_X1"] = page_index_all[i-1]["page_X2"] + 1
                                page_index_all[i]["page_X2"] = page_index_all[i]["page_X1"] + string.len(page_index_all[i]["page_name"]) + 1
                                GUI.Form[num]["page_class"] = page_index_all
                            elseif(i==1)then
                                page_index_all[i]["page_X1"] = 1
                                page_index_all[i]["page_X2"] = page_index_all[i]["page_X1"] + string.len(page_index_all[i]["page_name"]) + 1
                                GUI.Form[num]["page_class"] = page_index_all
                            end
                        end
                        GUI.DrawProgramPage(showpage,GUI.Form[num]["page_num"])
                        if(page_index_all[GUI.Form[num]["page_num"]]["box_class"]~=nil)then
                            local BoxClass = page_index_all[GUI.Form[num]["page_num"]]["box_class"]
                            page_index_all[GUI.Form[num]["page_num"]]["box_count"] = #BoxClass
                            GUI.Form[num]["page_class"] = page_index_all
                            for i=1,page_index_all[GUI.Form[num]["page_num"]]["box_count"] do
                                GUI.DrawBox(BoxClass[i][1],BoxClass[i][2],BoxClass[i][3],BoxClass[i][4],BoxClass[i][5],BoxClass[i][6])
                            end
                        end
                        if(page_index_all[GUI.Form[num]["page_num"]]["text_class"]~=nil)then
                            local TextClass = page_index_all[GUI.Form[num]["page_num"]]["text_class"]
                            page_index_all[GUI.Form[num]["page_num"]]["text_count"] = #TextClass
                            for i=1,page_index_all[GUI.Form[num]["page_num"]]["text_count"] do
                                if(TextClass[i][6]==true or nil)then
                                    GUI.DrawText(TextClass[i][2],TextClass[i][3],TextClass[i][1],TextClass[i][4],TextClass[i][5])
                                end
                            end
                        end
                        if(page_index_all[GUI.Form[num]["page_num"]]["button_class"]~=nil)then
                            local ButtonClass = page_index_all[GUI.Form[num]["page_num"]]["button_class"]
                            page_index_all[GUI.Form[num]["page_num"]]["button_count"] = #ButtonClass
                            for i=1,page_index_all[GUI.Form[num]["page_num"]]["button_count"] do
                                GUI.DrawButton(ButtonClass[i][1],ButtonClass[i][2],ButtonClass[i][3],ButtonClass[i][4],ButtonClass[i][5])
                            end
                        end
                        if(page_index_all[GUI.Form[num]["page_num"]]["switch_class"]~=nil)then
                            local SwitchClass = page_index_all[GUI.Form[num]["page_num"]]["switch_class"]
                            page_index_all[GUI.Form[num]["page_num"]]["switch_count"] = #SwitchClass
                            for i=1,page_index_all[GUI.Form[num]["page_num"]]["switch_count"] do
                                GUI.DrawSwitch(SwitchClass[i][1],SwitchClass[i][2],SwitchClass[i][3],SwitchClass[i][4])
                            end
                        end
                        if(page_index_all[GUI.Form[num]["page_num"]]["progressbar_class"]~=nil)then
                            local ProgressbarClass = page_index_all[GUI.Form[num]["page_num"]]["progressbar_class"]
                            page_index_all[GUI.Form[num]["page_num"]]["progressbar_count"] = #ProgressbarClass
                            for i=1,page_index_all[GUI.Form[num]["page_num"]]["progressbar_count"] do
                                GUI.DrawProgressbar(ProgressbarClass[i][1],ProgressbarClass[i][2],ProgressbarClass[i][3],ProgressbarClass[i][4],ProgressbarClass[i][5],ProgressbarClass[i][6])
                            end
                        end
                        if(page_index_all[GUI.Form[num]["page_num"]]["textbar_class"]~=nil)then
                            local TextBarClass = page_index_all[GUI.Form[num]["page_num"]]["textbar_class"]
                            page_index_all[GUI.Form[num]["page_num"]]["textbar_count"] = #TextBarClass
                            for i=1,page_index_all[GUI.Form[num]["page_num"]]["textbar_count"] do
                                GUI.DrawTextBar(TextBarClass[i][1],TextBarClass[i][2],TextBarClass[i][3],TextBarClass[i][4],TextBarClass[i][5],TextBarClass[i][6])
                            end
                        end
                        if(page_index_all[GUI.Form[num]["page_num"]]["textbox_class"]~=nil)then
                            local TextBoxClass = page_index_all[GUI.Form[num]["page_num"]]["textbox_class"]
                            page_index_all[GUI.Form[num]["page_num"]]["textbox_count"] = #TextBoxClass
                            for i=1,page_index_all[GUI.Form[num]["page_num"]]["textbox_count"] do
                                GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                            end
                        end
                    else
                        GUI.Form[num]["page_num"] = 1
                        GUI.DrawForm(num)
                    end
                else
                    GUI.Form[num]["page_num"] = 1
                    GUI.DrawForm(num)
                end
            end
            if(GUI.Form[num]["box_class"]~=nil)then
                local BoxClass = GUI.Form[num]["box_class"]
                GUI.Form[num]["box_count"] = #BoxClass
                for i=1,GUI.Form[num]["box_count"] do
                    GUI.DrawBox(BoxClass[i][1],BoxClass[i][2],BoxClass[i][3],BoxClass[i][4],BoxClass[i][5],BoxClass[i][6])
                end
            end
            if(GUI.Form[num]["text_class"]~=nil)then
                local TextClass = GUI.Form[num]["text_class"]
                GUI.Form[num]["text_count"] = #TextClass
                for i=1,GUI.Form[num]["text_count"] do
                    if(TextClass[i][6]==true or nil)then
                        GUI.DrawText(TextClass[i][2],TextClass[i][3],TextClass[i][1],TextClass[i][4],TextClass[i][5])
                    end
                end
            end
            if(GUI.Form[num]["button_class"]~=nil)then
                local ButtonClass = GUI.Form[num]["button_class"]
                GUI.Form[num]["button_count"] = #ButtonClass
                for i=1,GUI.Form[num]["button_count"] do
                    GUI.DrawButton(ButtonClass[i][1],ButtonClass[i][2],ButtonClass[i][3],ButtonClass[i][4],ButtonClass[i][5])
                end
            end
            if(GUI.Form[num]["switch_class"]~=nil)then
                local SwitchClass = GUI.Form[num]["switch_class"]
                GUI.Form[num]["switch_count"] = #SwitchClass
                for i=1,GUI.Form[num]["switch_count"] do
                    GUI.DrawSwitch(SwitchClass[i][1],SwitchClass[i][2],SwitchClass[i][3],SwitchClass[i][4])
                end
            end
            if(GUI.Form[num]["progressbar_class"]~=nil)then
                local ProgressbarClass = GUI.Form[num]["progressbar_class"]
                GUI.Form[num]["progressbar_count"] = #ProgressbarClass
                for i=1,GUI.Form[num]["progressbar_count"] do
                    GUI.DrawProgressbar(ProgressbarClass[i][1],ProgressbarClass[i][2],ProgressbarClass[i][3],ProgressbarClass[i][4],ProgressbarClass[i][5],ProgressbarClass[i][6])
                end
            end
            if(GUI.Form[num]["textbar_class"]~=nil)then
                local TextBarClass = GUI.Form[num]["textbar_class"]
                GUI.Form[num]["textbar_count"] = #TextBarClass
                for i=1,GUI.Form[num]["textbar_count"] do
                    GUI.DrawTextBar(TextBarClass[i][1],TextBarClass[i][2],TextBarClass[i][3],TextBarClass[i][4],TextBarClass[i][5],TextBarClass[i][6])
                end
            end
            if(GUI.Form[num]["textbox_class"]~=nil)then
                local TextBoxClass = GUI.Form[num]["textbox_class"]
                GUI.Form[num]["textbox_count"] = #TextBoxClass
                for i=1,GUI.Form[num]["textbox_count"] do
                    GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                end
            end
        end
    end
end

function GUI.DrawQuickON()
    IO.ScreenManage("GetTermSize")
    if(type(GUI.Form[IO.ProcessManage["formnum"]]["label"])=="string" and GUI.Form[IO.ProcessManage["formnum"]]["label"]=="Desktop")then
        GUI.DrawBox(1,2,16,GUI.TermHigh,"gray","filled")
        GUI.DrawBox(1,2,16,1,"lightgray","filled")
        GUI.DrawBox(1,GUI.TermHigh-2,16,4,"lightgray","filled")
        GUI.DrawText(2,2,"QuickON","white","lightgray")
        GUI.DrawText(15,2,"<","yellow","lightgray")
        GUI.DrawText(15,GUI.TermHigh-1,">","white","lightgray")
        GUI.QuickON_SysButtonLen = #GUI.QuickON_SYS
        for i=1,GUI.QuickON_SysButtonLen do
            GUI.DrawButton(GUI.QuickON_SYS[i][1],GUI.QuickON_SYS[i][2],GUI.QuickON_SYS[i][3],GUI.QuickON_SYS[i][4],GUI.QuickON_SYS[i][5])
        end
    end
end

function GUI.AccessForm(tabel)
    table.insert(GUI.Form,tabel)
end

function GUI.GetFormAccess(name)
    if(type(name)=="string")then
        for key,value in pairs(GUI.Form)do
            local findform = value
            if(findform["name"]==name)then
                return key
            end
        end
    end
end

--[[
function GUI.SetFormAttribute(form,Attribute,param)

end

function GUI.GetFormAttribute(form,Attribute)

end
]]--
function GUI.SetTextPublicAttribute(form,page,Attribute,num,param,visable)
    if(type(form)=="number" and type(num)=="number" and type(Attribute)=="string")then
        local TextClass,page_index_all
        local FuncSign = false
        if(type(page)=="string")then
            if(page=="main")then
                TextClass = GUI.Form[form]["text_class"]
                FuncSign = true
            end
        elseif(type(page)=="number")then
            page_index_all = GUI.Form[form]["page_class"]
            if(page<=#page_index_all and page>0)then
                TextClass = page_index_all[page]["text_class"]
                FuncSign = true
            end
        end
        if(FuncSign==true and TextClass~=nil)then
            local SW_ATT = {
                x = function() TextClass[num][2] = param end,
                y = function() TextClass[num][3] = param end,
                Text = function() TextClass[num][1] = param end,
                Tcolor = function() TextClass[num][4] = param end,
                Bcolor = function() TextClass[num][5] = param end,
                Visable = function() TextClass[num][6] = param end
            }
            local SW_ATT_RUN = SW_ATT[Attribute]
            if(SW_ATT_RUN)then
                SW_ATT_RUN()
                if(page=="main")then
                    GUI.Form[form]["text_class"] = TextClass
                elseif(type(page)=="number")then
                    page_index_all[page]["text_class"] = TextClass
                    GUI.Form[form]["page_class"] = page_index_all
                end
                if(visable==true or visable==nil)then
                    GUI.DrawText(TextClass[num][2],TextClass[num][3],TextClass[num][1],TextClass[num][4],TextClass[num][5],TextClass[num][6])
                end
            end
        end
    end
end

function GUI.SetTextAttribute(form,Attribute,num,param,visable)
    GUI.SetTextPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetText(form,Attribute,num,param,visable)
    GUI.SetTextPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetPageTextAttribute(form,pagenum,Attribute,num,param,visable)
    GUI.SetTextPublicAttribute(form,pagenum,Attribute,num,param,visable)
end
function GUI.SetPageText(form,pagenum,Attribute,num,param,visable)
    GUI.SetTextPublicAttribute(form,pagenum,Attribute,num,param,visable)
end

function GUI.GetTextPublicAttribute(form,page,Attribute,num)
    local TextClass,page_index_all
    local FuncSign = false
    if(type(page)=="string")then
        if(page=="main")then
            TextClass = GUI.Form[form]["text_class"]
            FuncSign = true
        end
    elseif(type(page)=="number")then
        page_index_all = GUI.Form[form]["page_class"]
        if(page<=#page_index_all and page>0)then
            TextClass = page_index_all[page]["text_class"]
            FuncSign = true
        end
    end
    if(FuncSign==true and TextClass~=nil)then
        if(Attribute=="x")then
            return TextClass[num][1]
        elseif(Attribute=="y")then
            return TextClass[num][2]
        elseif(Attribute=="Text")then
            return TextClass[num][3]
        elseif(Attribute=="Tcolor")then
            return TextClass[num][4]
        elseif(Attribute=="Bcolor")then
            return TextClass[num][5]
        elseif(Attribute=="visable")then
            return TextClass[num][6]
        end
    end
end

function GUI.GetTextAttribute(form,Attribute,num)
    return GUI.GetTextPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetText(form,Attribute,num)
    return GUI.GetTextPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetPageTextAttribute(form,pagenum,Attribute,num)
    return GUI.GetTextPublicAttribute(form,pagenum,Attribute,num)
end
function GUI.GetPageText(form,pagenum,Attribute,num)
    return GUI.GetTextPublicAttribute(form,pagenum,Attribute,num)
end

function GUI.SetButtonPublicAttribute(form,page,Attribute,num,param,visable)
    if(type(form)=="number" and type(num)=="number" and type(Attribute)=="string")then
        local ButtonClass,page_index_all
        local FuncSign = false
        if(type(page)=="string")then
            if(page=="main")then
                ButtonClass = GUI.Form[form]["button_class"]
                FuncSign = true
            end
        elseif(type(page)=="number")then
            page_index_all = GUI.Form[form]["page_class"]
            if(page<=#page_index_all and page>0)then
                ButtonClass = page_index_all[page]["button_class"]
                FuncSign = true
            end
        end
        if(FuncSign==true and ButtonClass~=nil)then
            local SW_ATT = {
                name = function() ButtonClass[num][1] = param end,
                x = function() ButtonClass[num][2] = param end,
                y = function() ButtonClass[num][3] = param end,
                Tcolor = function() ButtonClass[num][4] = param end,
                Bcolor = function() ButtonClass[num][5] = param end
            }
            local SW_ATT_RUN = SW_ATT[Attribute]
            if(SW_ATT_RUN)then
                SW_ATT_RUN()
                if(page=="main")then
                    GUI.Form[form]["button_class"] = ButtonClass
                elseif(type(page)=="number")then
                    page_index_all[page]["button_class"] = ButtonClass
                    GUI.Form[form]["page_class"] = page_index_all
                end
                if(visable==true or visable==nil)then
                    GUI.DrawButton(ButtonClass[num][1],ButtonClass[num][2],ButtonClass[num][3],ButtonClass[num][4],ButtonClass[num][5])
                end
            end
        end
    end
end

function GUI.SetButtonAttribute(form,Attribute,num,param,visable)
    GUI.SetButtonPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetButton(form,Attribute,num,param,visable)
    GUI.SetButtonPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetPageButtonAttribute(form,pagenum,Attribute,num,param,visable)
    GUI.SetButtonPublicAttribute(form,pagenum,Attribute,num,param,visable)
end
function GUI.SetPageButton(form,pagenum,Attribute,num,param,visable)
    GUI.SetButtonPublicAttribute(form,pagenum,Attribute,num,param,visable)
end

function GUI.GetButtonPublicAttribute(form,page,Attribute,num)
    local ButtonClass,page_index_all
    local FuncSign = false
    if(type(page)=="string")then
        if(page=="main")then
            ButtonClass = GUI.Form[form]["button_class"]
            FuncSign = true
        end
    elseif(type(page)=="number")then
        page_index_all = GUI.Form[form]["page_class"]
        if(page<=#page_index_all and page>0)then
            ButtonClass = page_index_all[page]["button_class"]
            FuncSign = true
        end
    end
    if(FuncSign==true and ButtonClass~=nil)then
        if(Attribute=="name")then
            return ButtonClass[num][1]
        elseif(Attribute=="x")then
            return ButtonClass[num][2]
        elseif(Attribute=="y")then
            return ButtonClass[num][3]
        elseif(Attribute=="Tcolor")then
            return ButtonClass[num][4]
        elseif(Attribute=="Bcolor")then
            return ButtonClass[num][5]
        end
    end
end

function GUI.GetButtonAttribute(form,Attribute,num)
    return GUI.GetButtonPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetButton(form,Attribute,num)
    return GUI.GetButtonPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetPageButtonAttribute(form,pagenum,Attribute,num)
    return GUI.GetButtonPublicAttribute(form,pagenum,Attribute,num)
end
function GUI.GetPageButton(form,pagenum,Attribute,num)
    return GUI.GetButtonPublicAttribute(form,pagenum,Attribute,num)
end

function GUI.SetSwitchPublicAttribute(form,page,Attribute,num,param,visable)
    if(type(form)=="number" and type(num)=="number" and type(Attribute)=="string")then
        local SwitchClass,page_index_all
        local FuncSign = false
        if(type(page)=="string")then
            if(page=="main")then
                SwitchClass = GUI.Form[form]["switch_class"]
                FuncSign = true
            end
        elseif(type(page)=="number")then
            page_index_all = GUI.Form[form]["page_class"]
            if(page<=#page_index_all and page>0)then
                SwitchClass = page_index_all[page]["switch_class"]
                FuncSign = true
            end
        end
        if(FuncSign==true and SwitchClass~=nil)then
            local SW_ATT = {
                set = function() SwitchClass[num][1] = param end,
                x = function() SwitchClass[num][2] = param end,
                y = function() SwitchClass[num][3] = param end,
                sign = function() SwitchClass[num][4] = param end,
            }
            local SW_ATT_RUN = SW_ATT[Attribute]
            if(SW_ATT_RUN)then
                SW_ATT_RUN()
                if(page=="main")then
                    GUI.Form[form]["switch_class"] = SwitchClass
                    SwitchClass = nil
                elseif(type(page)=="number")then
                    page_index_all[page]["switch_class"] = SwitchClass
                    GUI.Form[form]["page_class"] = page_index_all
                    SwitchClass = nil
                    page_index_all = nil
                end
                if(visable==true or visable==nil)then
                    GUI.DrawSwitch(SwitchClass[num][1],SwitchClass[num][2],SwitchClass[num][3],SwitchClass[num][4])
                end
            end
        end
    end
end

function GUI.SetSwitchAttribute(form,Attribute,num,param,visable)
    GUI.SetSwitchPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetSwitch(form,Attribute,num,param,visable)
    GUI.SetSwitchPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetPageSwitchAttribute(form,pagenum,Attribute,num,param,visable)
    GUI.SetSwitchPublicAttribute(form,pagenum,Attribute,num,param,visable)
end
function GUI.SetPageSwitch(form,pagenum,Attribute,num,param,visable)
    GUI.SetSwitchPublicAttribute(form,pagenum,Attribute,num,param,visable)
end


function GUI.GetSwitchPublicAttribute(form,page,Attribute,num)
    local SwitchClass,page_index_all
    local FuncSign = false
    if(type(page)=="string")then
        if(page=="main")then
            SwitchClass = GUI.Form[form]["switch_class"]
            FuncSign = true
        end
    elseif(type(page)=="number")then
        page_index_all = GUI.Form[form]["page_class"]
        if(page<=#page_index_all and page>0)then
            SwitchClass = page_index_all[page]["switch_class"]
            FuncSign = true
        end
    end
    if(FuncSign==true and SwitchClass~=nil)then
        if(Attribute=="set")then
            return SwitchClass[num][1]
        elseif(Attribute=="x")then
            return SwitchClass[num][2]
        elseif(Attribute=="y")then
            return SwitchClass[num][3]
        elseif(Attribute=="sign")then
            return SwitchClass[num][4]
        end
    end
    SwitchClass = nil
end

function GUI.GetSwitchAttribute(form,Attribute,num)
    return GUI.GetSwitchPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetSwitch(form,Attribute,num)
    return GUI.GetSwitchPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetPageSwitchAttribute(form,pagenum,Attribute,num)
    return GUI.GetSwitchPublicAttribute(form,pagenum,Attribute,num)
end
function GUI.GetPageSwitch(form,pagenum,Attribute,num)
    return GUI.GetSwitchPublicAttribute(form,pagenum,Attribute,num)
end

function GUI.SetProgressbarPublicAttribute(form,page,Attribute,num,param,visable)
    if(type(form)=="number" and type(num)=="number" and type(Attribute)=="string")then
        local ProgressbarClass,page_index_all
        local FuncSign = false
        if(type(page)=="string")then
            if(page=="main")then
                ProgressbarClass = GUI.Form[form]["progressbar_class"]
                FuncSign = true
            end
        elseif(type(page)=="number")then
            page_index_all = GUI.Form[form]["page_class"]
            if(page<=#page_index_all and page>0)then
                ProgressbarClass = page_index_all[page]["progressbar_class"]
                FuncSign = true
            end
        end
        if(FuncSign==true and ProgressbarClass~=nil)then
            local SW_ATT = {
                name = function() ProgressbarClass[num][1] = param end,
                x = function() ProgressbarClass[num][2] = param end,
                y = function() ProgressbarClass[num][3] = param end,
                percent = function() ProgressbarClass[num][4] = param end,
                color = function() ProgressbarClass[num][5] = param end,
                typeset = function() ProgressbarClass[num][6] = param end,
            }
            local SW_ATT_RUN = SW_ATT[Attribute]
            if(SW_ATT_RUN)then
                SW_ATT_RUN()
                if(page=="main")then
                    GUI.Form[form]["progressbar_class"] = ProgressbarClass
                elseif(type(page)=="number")then
                    page_index_all[page]["progressbar_class"] = ProgressbarClass
                    GUI.Form[form]["page_class"] = page_index_all
                end
                if(visable==true or visable==nil)then
                    GUI.DrawProgressbar(ProgressbarClass[num][1],ProgressbarClass[num][2],ProgressbarClass[num][3],ProgressbarClass[num][4],ProgressbarClass[num][5],ProgressbarClass[num][6])
                end
            end
        end
    end
end

function GUI.SetProgressbarAttribute(form,Attribute,num,param,visable)
    GUI.SetProgressbarPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetProgressbar(form,Attribute,num,param,visable)
    GUI.SetProgressbarPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetPageProgressbarAttribute(form,pagenum,Attribute,num,param,visable)
    GUI.SetProgressbarPublicAttribute(form,pagenum,Attribute,num,param,visable)
end
function GUI.SetPageProgressbar(form,pagenum,Attribute,num,param,visable)
    GUI.SetProgressbarPublicAttribute(form,pagenum,Attribute,num,param,visable)
end

function GUI.GetProgressbarPublicAttribute(form,page,Attribute,num)
    local ProgressbarClass,page_index_all
    local FuncSign = false
    if(type(page)=="string")then
        if(page=="main")then
            ProgressbarClass = GUI.Form[form]["progressbar_class"]
            FuncSign = true
        end
    elseif(type(page)=="number")then
        page_index_all = GUI.Form[form]["page_class"]
        if(page<=#page_index_all and page>0)then
            ProgressbarClass = page_index_all[page]["progressbar_class"]
            FuncSign = true
        end
    end
    if(FuncSign==true and ProgressbarClass~=nil)then
        if(Attribute=="name")then
            return ProgressbarClass[num][1]
        elseif(Attribute=="x")then
            return ProgressbarClass[num][2]
        elseif(Attribute=="y")then
            return ProgressbarClass[num][3]
        elseif(Attribute=="percent")then
            return ProgressbarClass[num][4]
        elseif(Attribute=="color")then
            return ProgressbarClass[num][5]
        elseif(Attribute=="typeset")then
            return ProgressbarClass[num][6]
        end
    end
end

function GUI.GetProgressbarAttribute(form,Attribute,num)
    return GUI.GetProgressbarPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetProgressbar(form,Attribute,num)
    return GUI.GetProgressbarPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetPageProgressbarAttribute(form,pagenum,Attribute,num)
    return GUI.GetProgressbarPublicAttribute(form,pagenum,Attribute,num)
end
function GUI.GetPageProgressbar(form,pagenum,Attribute,num)
    return GUI.GetProgressbarPublicAttribute(form,pagenum,Attribute,num)
end

function GUI.SetTextbarPublicAttribute(form,page,Attribute,num,param,visable)
    if(type(form)=="number" and type(num)=="number" and type(Attribute)=="string")then
        local TextbarClass,page_index_all
        local FuncSign = false
        if(type(page)=="string")then
            if(page=="main")then
                TextbarClass = GUI.Form[form]["textbar_class"]
                FuncSign = true
            end
        elseif(type(page)=="number")then
            page_index_all = GUI.Form[form]["page_class"]
            if(page<=#page_index_all and page>0)then
                TextbarClass = page_index_all[page]["textbar_class"]
                FuncSign = true
            end
        end
        if(FuncSign==true and TextbarClass~=nil)then
            local SW_ATT = {
                temp = function() TextbarClass[num][1] = param end,
                x = function() TextbarClass[num][2] = param end,
                y = function() TextbarClass[num][3] = param end,
                w = function() TextbarClass[num][4] = param end,
                tcolor = function() TextbarClass[num][5] = param end,
                bcolor = function() TextbarClass[num][6] = param end
            }
            local SW_ATT_RUN = SW_ATT[Attribute]
            if(SW_ATT_RUN)then
                SW_ATT_RUN()
                if(page=="main")then
                    GUI.Form[form]["textbar_class"] = TextbarClass
                elseif(type(page)=="number")then
                    page_index_all[page]["textbar_class"] = TextbarClass
                    GUI.Form[form]["page_class"] = page_index_all
                end
                if(visable==true or visable==nil)then
                    GUI.DrawTextBar(TextbarClass[num][1],TextbarClass[num][2],TextbarClass[num][3],TextbarClass[num][4],TextbarClass[num][5],TextbarClass[num][6])
                end
            end
        end
    end
end

function GUI.SetTextbarAttribute(form,Attribute,num,param,visable)
    GUI.SetTextbarPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetTextbar(form,Attribute,num,param,visable)
    GUI.SetTextbarPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetPageTextbarAttribute(form,pagenum,Attribute,num,param,visable)
    GUI.SetTextbarPublicAttribute(form,pagenum,Attribute,num,param,visable)
end
function GUI.SetPageTextbar(form,pagenum,Attribute,num,param,visable)
    GUI.SetTextbarPublicAttribute(form,pagenum,Attribute,num,param,visable)
end

function GUI.GetTextbarPublicAttribute(form,page,Attribute,num)
    local TextbarClass,page_index_all
    local FuncSign = false
    if(type(page)=="string")then
        if(page=="main")then
            TextbarClass = GUI.Form[form]["textbar_class"]
            FuncSign = true
        end
    elseif(type(page)=="number")then
        page_index_all = GUI.Form[form]["page_class"]
        if(page<=#page_index_all and page>0)then
            TextbarClass = page_index_all[page]["textbar_class"]
            FuncSign = true
        end
    end
    if(FuncSign==true and TextbarClass~=nil)then
        if(Attribute=="temp")then
            return TextbarClass[num][1]
        elseif(Attribute=="x")then
            return TextbarClass[num][2]
        elseif(Attribute=="y")then
            return TextbarClass[num][3]
        elseif(Attribute=="w")then
            return TextbarClass[num][4]
        elseif(Attribute=="tcolor")then
            return TextbarClass[num][5]
        elseif(Attribute=="bcolor")then
            return TextbarClass[num][6]
        end
    end
end

function GUI.GetTextbarAttribute(form,Attribute,num)
    return GUI.GetTextbarPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetTextbar(form,Attribute,num)
    return GUI.GetTextbarPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetPageTextbarAttribute(form,pagenum,Attribute,num)
    return GUI.GetTextbarPublicAttribute(form,pagenum,Attribute,num)
end
function GUI.GetPageTextbar(form,pagenum,Attribute,num)
    return GUI.GetTextbarPublicAttribute(form,pagenum,Attribute,num)
end

function GUI.SetTextboxPublicAttribute(form,page,Attribute,num,param,visable)
    if(type(form)=="number" and type(num)=="number" and type(Attribute)=="string")then
        local TextBoxClass,page_index_all
        local FuncSign = false
        if(type(page)=="string")then
            if(page=="main")then
                TextBoxClass = GUI.Form[form]["textbox_class"]
                FuncSign = true
            end
        elseif(type(page)=="number")then
            page_index_all = GUI.Form[form]["page_class"]
            if(page<=#page_index_all and page>0)then
                TextBoxClass = page_index_all[page]["textbox_class"]
                FuncSign = true
            end
        end
        if(FuncSign==true and TextBoxClass~=nil)then
            local SW_ATT = {
                temp = function() TextBoxClass[num][1] = param end,
                x = function() TextBoxClass[num][2] = param end,
                y = function() TextBoxClass[num][3] = param end,
                w = function() TextBoxClass[num][4] = param end,
                h = function() TextBoxClass[num][5] = param end,
                tcolor = function() TextBoxClass[num][6] = param end,
                bcolor = function() TextBoxClass[num][7] = param end,
                linepage = function() TextBoxClass[num][8] = param end
            }
            local SW_ATT_RUN = SW_ATT[Attribute]
            if(SW_ATT_RUN)then
                SW_ATT_RUN()
                if(page=="main")then
                    GUI.Form[form]["textbox_class"] = TextBoxClass
                elseif(type(page)=="number")then
                    page_index_all[page]["textbox_class"] = TextBoxClass
                    GUI.Form[form]["page_class"] = page_index_all
                end
                if(visable==true or visable==nil)then
                    GUI.DrawTextBox(TextBoxClass[num][1],TextBoxClass[num][2],TextBoxClass[num][3],TextBoxClass[num][4],TextBoxClass[num][5],TextBoxClass[num][6],TextBoxClass[num][7],TextBoxClass[num][8])
                end
            end
        end
    end
end

function GUI.SetTextboxAttribute(form,Attribute,num,param,visable)
    GUI.SetTextboxPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetTextbox(form,Attribute,num,param,visable)
    GUI.SetTextboxPublicAttribute(form,"main",Attribute,num,param,visable)
end
function GUI.SetPageTextboxAttribute(form,pagenum,Attribute,num,param,visable)
    GUI.SetTextboxPublicAttribute(form,pagenum,Attribute,num,param,visable)
end
function GUI.SetPageTextbox(form,pagenum,Attribute,num,param,visable)
    GUI.SetTextboxPublicAttribute(form,pagenum,Attribute,num,param,visable)
end

function GUI.GetTextboxPublicAttribute(form,page,Attribute,num)
    local TextboxClass,page_index_all
    local FuncSign = false
    if(type(page)=="string")then
        if(page=="main")then
            TextboxClass = GUI.Form[form]["textbox_class"]
            FuncSign = true
        end
    elseif(type(page)=="number")then
        page_index_all = GUI.Form[form]["page_class"]
        if(page<=#page_index_all and page>0)then
            TextboxClass = page_index_all[page]["textbox_class"]
            FuncSign = true
        end
    end
    if(FuncSign==true and TextboxClass~=nil)then
        if(Attribute=="temp")then
            return TextboxClass[num][1]
        elseif(Attribute=="x")then
            return TextboxClass[num][2]
        elseif(Attribute=="y")then
            return TextboxClass[num][3]
        elseif(Attribute=="w")then
            return TextboxClass[num][4]
        elseif(Attribute=="h")then
            return TextboxClass[num][5]
        elseif(Attribute=="tcolor")then
            return TextboxClass[num][6]
        elseif(Attribute=="bcolor")then
            return TextboxClass[num][7]
        elseif(Attribute=="linepage")then
            return TextboxClass[num][8]
        end
    end
end

function GUI.GetTextboxAttribute(form,Attribute,num)
    return GUI.GetTextboxPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetTextbox(form,Attribute,num)
    return GUI.GetTextboxPublicAttribute(form,"main",Attribute,num)
end
function GUI.GetTextboxAttribute(form,pagenum,Attribute,num)
    return GUI.GetTextboxPublicAttribute(form,pagenum,Attribute,num)
end
function GUI.GetTextbox(form,pagenum,Attribute,num)
    return GUI.GetTextboxPublicAttribute(form,pagenum,Attribute,num)
end

function IO.ScreenManage(func)
    if(type(func)=="string")then
        local functrans = string.upper(func)
        if(functrans=="GETTERMSIZE")then
            GUI.TermWide,GUI.TermHigh = term.getSize()
        end
        if(functrans=="RESIZE")then
            if(IO.ProcessManage["label"]=="lock")then
                IO.ScreenManage("lockscreen")
            else
                IO.ScreenManage("gettermsize")
                GUI.DrawForm(IO.ProcessManage["formnum"])
                GUI.QuickON_SYS[1][3] = GUI.TermHigh
                GUI.QuickON_SYS[2][3] = GUI.TermHigh
                GUI.QuickON_SYS[3][3] = GUI.TermHigh
            end
        end
        if(functrans=="LOCKSCREEN")then
            term.clear()
            IO.ProcessManage["label"] = "lock"
            GUI.DrawText(1,1,"Screen were Lock,Touch to Back","lightgray","black")
        end
    end
end

function IO.MouseClick(button,clickX,clickY)
    if(GUI.Form[IO.ProcessManage["formnum"]].mouseclick and IO.ProcessManage["label"]=="Program")then
        GUI.Form[IO.ProcessManage["formnum"]].mouseclick(button,clickX,clickY)
    end
    if(IO.ProcessManage["label"]=="lock")then
        IO.ProcessManage["label"] = "Desktop"
        GUI.DrawForm(1)
    else
        if(GUI.ShowClickPosTemp==true)then
            GUI.DrawBox(4,1,41,1,"white","filled")
            GUI.DrawText(5,1,string.format("X:%d Y:%d TW:%d TH:%d",clickX,clickY,GUI.TermWide,GUI.TermHigh),"black","white")
        end
        if(IO.ProcessManage["label"]=="Desktop" and IO.ProcessManage["event"]=="main")then
            if(button==1 and clickX>=1 and clickX<=3 and clickY==1)then
                GUI.DrawQuickON()
                IO.ProcessManage["event"] = "quickon"
                button,clickX,clickY = 0,0,0
            else
                for i=2,GUI.FormTabelLen do
                    if(button==1 and clickX>=GUI.Form[i]["PosX"] and clickX<=GUI.Form[i]["PosX"]+string.len(GUI.Form[i]["name"])-1 and clickY==GUI.Form[i]["PosY"])then
                        GUI.DrawForm(i)
                        IO.ProcessManage["label"] = GUI.Form[i]["label"]
                        if(GUI.Form[i]["page_class"]~=nil)then
                            IO.ProcessManage["event"] = "pagemain"
                            IO.ProcessManage["formnum"] = i
                        else
                            IO.ProcessManage["event"] = "main"
                            IO.ProcessManage["formnum"] = i
                        end
                        button,clickX,clickY = 0,0,0
                        if(IO.ModemSign == true)then
                            Control.Service("INIT_InputIO")
                        end
                        local forminit = GUI.Form[i]["init"]
                        if(forminit)then
                            forminit()
                        end
                    end
                end
            end
        elseif(IO.ProcessManage["label"]=="Desktop" and IO.ProcessManage["event"]=="quickon")then
            if(button==1 and clickX>=1 and clickX<=16 and clickY>=2 and clickY<=GUI.TermHigh)then
                if(button==1 and clickX==15 and clickY==2)then
                    GUI.DrawForm(1)
                    IO.ProcessManage["label"] = GUI.Form[1]["label"]
                    IO.ProcessManage["event"] = "main"
                    IO.ProcessManage["formnum"] = 1
                    button,clickX,clickY = 0,0,0
                else
                    GUI.QuickON_SysButtonLen = #GUI.QuickON_SYS
                    for i=1,GUI.QuickON_SysButtonLen do
                        if(button==1 and clickX>=GUI.QuickON_SYS[i][2] and clickX<=GUI.QuickON_SYS[i][2]+string.len(GUI.QuickON_SYS[i][1])-1 and clickY==GUI.QuickON_SYS[i][3])then
                            GUI.QuickON_SYS[i][6]()
                        end
                    end
                end
            else
                GUI.DrawForm(1)
                IO.ProcessManage["label"] = GUI.Form[1]["label"]
                IO.ProcessManage["event"] = "main"
                IO.ProcessManage["formnum"] = 1
                button,clickX,clickY = 0,0,0
            end
        end
        if(IO.ProcessManage["label"]=="Program")then
            if(button==1 and clickX>=1 and clickX<=3 and clickY==1)then
                if(GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"]~=nil)then
                    for i=1,GUI.Form[IO.ProcessManage["formnum"]]["textbar_count"] do
                        local TextBarClass = GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"]
                        if(TextBarClass[i][1]=="")then
                            IO.ProcessManage["event"] = "main"
                            TextBarClass[i][1] = nil
                            GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"] = TextBarClass
                        end
                    end
                end
                term.setCursorBlink(false)
                if(GUI.Form[IO.ProcessManage["formnum"]]["closerun"]~=nil)then
                    local FormCloseRUN = GUI.Form[IO.ProcessManage["formnum"]]["closerun"]
                    FormCloseRUN()
                end
                GUI.DrawForm(1)
                IO.ProcessManage["label"] = GUI.Form[1]["label"]
                IO.ProcessManage["event"] = "main"
                IO.ProcessManage["formnum"] = 1
                button,clickX,clickY = 0,0,0
            else
                if(GUI.Form[IO.ProcessManage["formnum"]]["page_class"]~=nil)then
                    local page_index_all = GUI.Form[IO.ProcessManage["formnum"]]["page_class"]
                    if(button==1 and clickY==2)then
                        for i=1,GUI.Form[IO.ProcessManage["formnum"]]["page_count"] do
                            if(clickX>=page_index_all[i]["page_X1"] and clickX<=page_index_all[i]["page_X2"] and IO.ProcessManage["event"]=="pagemain")then
                                GUI.Form[IO.ProcessManage["formnum"]]["page_num"] = i
                                GUI.DrawForm(IO.ProcessManage["formnum"])
                                button,clickX,clickY = 0,0,0
                            end
                        end
                    else
                        local pageselect = GUI.Form[IO.ProcessManage["formnum"]]["page_num"]
                        if(page_index_all[pageselect]["button_class"]~=nil)then
                            local ButtonClass = page_index_all[pageselect]["button_class"]
                            for i=1,#ButtonClass do
                                if(button==1 and clickX>=ButtonClass[i][2] and clickX<=ButtonClass[i][2]+string.len(ButtonClass[i][1])-1 and clickY==ButtonClass[i][3])then
                                    local ButtonAction = ButtonClass[i][6]
                                    ButtonAction()
                                    button,clickX,clickY = 0,0,0
                                end
                            end
                        end
                        if(page_index_all[pageselect]["switch_class"]~=nil)then
                            local SwitchClass = page_index_all[pageselect]["switch_class"]
                            for i=1,#SwitchClass do
                                if(string.upper(SwitchClass[i][1])=="2SET")then
                                    if(button==1 and clickX>=SwitchClass[i][2] and clickX<=SwitchClass[i][2]+4 and clickY==SwitchClass[i][3])then
                                        if(SwitchClass[i][4]==true)then
                                            SwitchClass[i][4] = false
                                            page_index_all[pageselect]["switch_class"] = SwitchClass
                                            GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                                            GUI.DrawForm(IO.ProcessManage["formnum"])
                                        elseif(SwitchClass[i][4]==false)then
                                            SwitchClass[i][4] = true
                                            page_index_all[pageselect]["switch_class"] = SwitchClass
                                            GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                                            GUI.DrawForm(IO.ProcessManage["formnum"])
                                        end
                                        if(SwitchClass[i][5]~=nil)then
                                            local SwitchAction = SwitchClass[i][5]
                                            SwitchAction()
                                            button,clickX,clickY = 0,0,0
                                        end
                                    end
                                end
                            end
                        end
                        if(page_index_all[pageselect]["textbar_class"]~=nil and IO.ProcessManage["event"]=="pagemain")then
                            local TextBarClass = page_index_all[pageselect]["textbar_class"]
                            for i=1,#TextBarClass do
                                if(button==1 and clickX>=TextBarClass[i][2] and clickX<=TextBarClass[i][2]+TextBarClass[i][4]-1 and clickY==TextBarClass[i][3])then
                                    IO.ProcessManage["event"] = "page_textbar_input"
                                    IO.ProcessManage["page_textbarnum"] = i
                                    if(TextBarClass[i][1]==nil)then
                                        TextBarClass[i][1] = ""
                                        GUI.DrawTextBar(TextBarClass[i][1],TextBarClass[i][2],TextBarClass[i][3],TextBarClass[i][4])
                                        term.setCursorPos(TextBarClass[i][2],TextBarClass[i][3])
                                        term.setCursorBlink(true)
                                        page_index_all[pageselect]["textbar_class"] = TextBarClass
                                        GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                                    else
                                        GUI.DrawTextBar(TextBarClass[i][1],TextBarClass[i][2],TextBarClass[i][3],TextBarClass[i][4])
                                        term.setCursorPos(TextBarClass[i][2],TextBarClass[i][3])
                                        term.setCursorBlink(true)
                                    end
                                end
                            end
                        elseif(page_index_all[pageselect]["textbar_class"]~=nil and IO.ProcessManage["event"]=="page_textbar_input")then
                            local TextBarClass = page_index_all[pageselect]["textbar_class"]
                            for i=1,#TextBarClass do
                                if(button==1 and clickX>=TextBarClass[i][2] and clickX<=TextBarClass[i][2]+TextBarClass[i][4]-1 and clickY==TextBarClass[i][3])then
                                else
                                    if(TextBarClass[i][1]=="")then
                                        IO.ProcessManage["event"] = "pagemain"
                                        TextBarClass[i][1] = nil
                                        page_index_all[pageselect]["textbar_class"] = TextBarClass
                                        GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                                        GUI.DrawForm(IO.ProcessManage["formnum"])
                                    end
                                    IO.ProcessManage["event"] = "pagemain"
                                    term.setCursorBlink(false)
                                end
                            end
                        end
                        if(page_index_all[pageselect]["textbox_class"]~=nil and IO.ProcessManage["event"]=="pagemain")then
                            local TextBoxClass = page_index_all[pageselect]["textbox_class"]
                            for i=1,#TextBoxClass do
                                if(button==1 and clickX>=TextBoxClass[i][2] and clickX<=TextBoxClass[i][2]+TextBoxClass[i][4]-1 and clickY>=TextBoxClass[i][3] and clickY<=TextBoxClass[i][3]+TextBoxClass[i][5]-1)then
                                    IO.ProcessManage["event"] = "page_textbox_input"
                                    IO.ProcessManage["page_textboxnum"] = i
                                    if(TextBoxClass[i][1]==nil)then
                                        TextBoxClass[i][1] = ""
                                        GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                                        term.setCursorPos(TextBoxClass[i][2],TextBoxClass[i][3]+TextBoxClass[i][5]-1)
                                        term.setCursorBlink(true)
                                        page_index_all[pageselect]["textbox_class"] = TextBoxClass
                                        GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                                    else
                                        GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                                        term.setCursorPos(TextBoxClass[i][2],TextBoxClass[i][3]+TextBoxClass[i][5]-1)
                                        term.setCursorBlink(true)
                                    end
                                end
                            end
                        elseif(page_index_all[pageselect]["textbox_class"]~=nil and IO.ProcessManage["event"]=="page_textbox_input")then
                            local TextBoxClass = page_index_all[pageselect]["textbox_class"]
                            for i=1,#TextBoxClass do
                                if(button==1 and clickX>=TextBoxClass[i][2] and clickX<=TextBoxClass[i][2]+TextBoxClass[i][4]-1 and clickY>=TextBoxClass[i][3] and clickY<=TextBoxClass[i][3]+TextBoxClass[i][5]-1)then
                                else
                                    if(TextBoxClass[i][1]=="")then
                                        IO.ProcessManage["event"] = "pagemain"
                                        TextBoxClass[i][1] = nil
                                        page_index_all[pageselect]["textbox_class"] = TextBoxClass
                                        GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                                        GUI.DrawForm(IO.ProcessManage["formnum"])
                                    end
                                    IO.ProcessManage["event"] = "pagemain"
                                    term.setCursorBlink(false)
                                end
                            end
                        end
                    end
                else
                    if(GUI.Form[IO.ProcessManage["formnum"]]["button_class"]~=nil and IO.ProcessManage["event"]=="main")then
                        for i=1,GUI.Form[IO.ProcessManage["formnum"]]["button_count"] do
                            local ButtonClass = GUI.Form[IO.ProcessManage["formnum"]]["button_class"]
                            if(button==1 and clickX>=ButtonClass[i][2] and clickX<=ButtonClass[i][2]+string.len(ButtonClass[i][1])-1 and clickY==ButtonClass[i][3])then
                                if(ButtonClass[i][6]~=nil)then
                                    local ButtonAction = ButtonClass[i][6]
                                    ButtonAction()
                                    button,clickX,clickY = 0,0,0
                                end
                            end
                        end
                    end
                    if(GUI.Form[IO.ProcessManage["formnum"]]["switch_class"]~=nil and IO.ProcessManage["event"]=="main")then
                        for i=1,GUI.Form[IO.ProcessManage["formnum"]]["switch_count"] do
                            local SwitchClass = GUI.Form[IO.ProcessManage["formnum"]]["switch_class"]
                            if(string.upper(SwitchClass[i][1])=="2SET")then
                                if(button==1 and clickX>=SwitchClass[i][2] and clickX<=SwitchClass[i][2]+4 and clickY==SwitchClass[i][3])then
                                    if(SwitchClass[i][4]==true)then
                                        SwitchClass[i][4] = false
                                        GUI.Form[IO.ProcessManage["formnum"]]["switch_class"] = SwitchClass
                                        GUI.DrawForm(IO.ProcessManage["formnum"])
                                    elseif(SwitchClass[i][4]==false)then
                                        SwitchClass[i][4] = true
                                        GUI.Form[IO.ProcessManage["formnum"]]["switch_class"] = SwitchClass
                                        GUI.DrawForm(IO.ProcessManage["formnum"])
                                    end
                                    if(SwitchClass[i][5]~=nil)then
                                        local SwitchAction = SwitchClass[i][5]
                                        SwitchAction()
                                        button,clickX,clickY = 0,0,0
                                    end
                                end
                            end
                        end
                    end
                    if(GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"]~=nil and IO.ProcessManage["event"]=="main")then
                        for i=1,GUI.Form[IO.ProcessManage["formnum"]]["textbar_count"] do
                            local TextBarClass = GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"]
                            if(button==1 and clickX>=TextBarClass[i][2] and clickX<=TextBarClass[i][2]+TextBarClass[i][4]-1 and clickY==TextBarClass[i][3])then
                                IO.ProcessManage["event"] = "textbar_input"
                                IO.ProcessManage["textbarnum"] = i
                                if(TextBarClass[i][1]==nil)then
                                    TextBarClass[i][1] = ""
                                    GUI.DrawTextBar(TextBarClass[i][1],TextBarClass[i][2],TextBarClass[i][3],TextBarClass[i][4])
                                    term.setCursorPos(TextBarClass[i][2],TextBarClass[i][3])
                                    term.setCursorBlink(true)
                                    GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"] = TextBarClass
                                else
                                    GUI.DrawTextBar(TextBarClass[i][1],TextBarClass[i][2],TextBarClass[i][3],TextBarClass[i][4])
                                    term.setCursorPos(TextBarClass[i][2],TextBarClass[i][3])
                                    term.setCursorBlink(true)
                                end
                            end
                        end
                    elseif(GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"]~=nil and IO.ProcessManage["event"]=="textbar_input")then
                        for i=1,GUI.Form[IO.ProcessManage["formnum"]]["textbar_count"] do
                            local TextBarClass = GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"]
                            if(button==1 and clickX>=TextBarClass[i][2] and clickX<=TextBarClass[i][2]+TextBarClass[i][4]-1 and clickY==TextBarClass[i][3])then
                            else
                                if(TextBarClass[i][1]=="")then
                                    IO.ProcessManage["event"] = "main"
                                    TextBarClass[i][1] = nil
                                    GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"] = TextBarClass
                                    GUI.DrawForm(IO.ProcessManage["formnum"])
                                end
                                IO.ProcessManage["event"] = "main"
                                term.setCursorBlink(false)
                            end
                        end
                    else
                    end
                    if(GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"]~=nil and IO.ProcessManage["event"]=="main")then
                        for i=1,GUI.Form[IO.ProcessManage["formnum"]]["textbox_count"] do
                            local TextBoxClass = GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"]
                            if(button==1 and clickX>=TextBoxClass[i][2] and clickX<=TextBoxClass[i][2]+TextBoxClass[i][4]-1 and clickY>=TextBoxClass[i][3] and clickY<=TextBoxClass[i][3]+TextBoxClass[i][5]-1)then
                                IO.ProcessManage["event"] = "textbox_input"
                                IO.ProcessManage["textboxnum"] = i
                                if(TextBoxClass[i][1]==nil)then
                                    TextBoxClass[i][1] = ""
                                    GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                                    term.setCursorPos(TextBoxClass[i][2],TextBoxClass[i][3]+TextBoxClass[i][5]-1)
                                    term.setCursorBlink(true)
                                    GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"] = TextBoxClass
                                else
                                    GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                                    term.setCursorPos(TextBoxClass[i][2],TextBoxClass[i][3]+TextBoxClass[i][5]-1)
                                    term.setCursorBlink(true)
                                end
                            end
                        end
                    elseif(GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"]~=nil and IO.ProcessManage["event"]=="textbox_input")then
                        for i=1,GUI.Form[IO.ProcessManage["formnum"]]["textbox_count"] do
                            local TextBoxClass = GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"]
                            if(button==1 and clickX>=TextBoxClass[i][2] and clickX<=TextBoxClass[i][2]+TextBoxClass[i][4]-1 and clickY>=TextBoxClass[i][3] and clickY<=TextBoxClass[i][3]+TextBoxClass[i][5]-1)then
                            else
                                if(TextBoxClass[i][1]=="")then
                                    IO.ProcessManage["event"] = "main"
                                    TextBoxClass[i][1] = nil
                                    GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"] = TextBoxClass
                                    GUI.DrawForm(IO.ProcessManage["formnum"])
                                end
                                IO.ProcessManage["event"] = "main"
                                term.setCursorBlink(false)
                            end
                        end
                    end
                end
            end
        end
    end
end

function IO.MouseDrag(button,dragX,dragY)
    if(GUI.Form[IO.ProcessManage["formnum"]].mouse_drag and IO.ProcessManage["label"]=="Program")then
        GUI.Form[IO.ProcessManage["formnum"]].mouse_drag(button,dragX,dragY)
    end
end

function IO.MouseScroll(dir,scrollX,scrollY)
    if(GUI.Form[IO.ProcessManage["formnum"]].mouse_scroll and IO.ProcessManage["label"]=="Program")then
        GUI.Form[IO.ProcessManage["formnum"]].mouse_scroll(dir,scrollX,scrollY)
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="main" and GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"]~=nil)then
        for i=1,GUI.Form[IO.ProcessManage["formnum"]]["textbox_count"] do
            local TextBoxClass = GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"]
            if(scrollX>=TextBoxClass[i][2] and scrollX<=TextBoxClass[i][2]+TextBoxClass[i][4] and scrollY>=TextBoxClass[i][3] and scrollY<=TextBoxClass[i][3]+TextBoxClass[i][5]-1)then
                if(TextBoxClass[i][1]~=nil)then
                    local templen = string.len(TextBoxClass[i][1])
                    local templine = math.ceil(templen / TextBoxClass[i][4])
                    local lastpage = templine - TextBoxClass[i][5] + 1
                    if(dir==1 and TextBoxClass[i][8]<lastpage)then
                        TextBoxClass[i][8] = TextBoxClass[i][8] + 1
                        GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"] = TextBoxClass
                        GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                    elseif(dir==-1 and TextBoxClass[i][8]>1)then
                        TextBoxClass[i][8] = TextBoxClass[i][8] - 1
                        GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"] = TextBoxClass
                        GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                    end
                end
            end
        end
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="pagemain")then
        local page_index_all = GUI.Form[IO.ProcessManage["formnum"]]["page_class"]
        local pageselect = GUI.Form[IO.ProcessManage["formnum"]]["page_num"]
        local TextBoxClass = page_index_all[pageselect]["textbox_class"]
        if(TextBoxClass~=nil)then
            for i=1,#TextBoxClass do
                if(TextBoxClass[i][1]~=nil)then
                    local templen = string.len(TextBoxClass[i][1])
                    local templine = math.ceil(templen / TextBoxClass[i][4])
                    local lastpage = templine - TextBoxClass[i][5] + 1
                    if(dir==1 and TextBoxClass[i][8]<lastpage)then
                        TextBoxClass[i][8] = TextBoxClass[i][8] + 1
                        page_index_all[pageselect]["textbox_class"] = TextBoxClass
                        GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                        GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                    elseif(dir==-1 and TextBoxClass[i][8]>1)then
                        TextBoxClass[i][8] = TextBoxClass[i][8] - 1
                        page_index_all[pageselect]["textbox_class"] = TextBoxClass
                        GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                        GUI.DrawTextBox(TextBoxClass[i][1],TextBoxClass[i][2],TextBoxClass[i][3],TextBoxClass[i][4],TextBoxClass[i][5],TextBoxClass[i][6],TextBoxClass[i][7],TextBoxClass[i][8])
                    end
                end
            end
        end
    end
end

function IO.MouseUp(button,upX,upY)
    if(GUI.Form[IO.ProcessManage["formnum"]].mouseup and IO.ProcessManage["label"]=="Program")then
        GUI.Form[IO.ProcessManage["formnum"]].mouseup(button,upX,upY)
    end
end

function IO.KeyPress(KeyCache)
    if(GUI.Form[IO.ProcessManage["formnum"]].keypress and IO.ProcessManage["label"]=="Program")then
        GUI.Form[IO.ProcessManage["formnum"]].keypress(KeyCache)
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="textbar_input")then
        local TextBarClass = GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"]
        if(KeyCache=="backspace" and TextBarClass[IO.ProcessManage["textbarnum"]][1]~=nil)then
            local CharLen = string.len(TextBarClass[IO.ProcessManage["textbarnum"]][1])
            if(CharLen>0)then
                TextBarClass[IO.ProcessManage["textbarnum"]][1] = string.sub(TextBarClass[IO.ProcessManage["textbarnum"]][1],1,CharLen-1)
                GUI.DrawTextBar(TextBarClass[IO.ProcessManage["textbarnum"]][1],TextBarClass[IO.ProcessManage["textbarnum"]][2],TextBarClass[IO.ProcessManage["textbarnum"]][3],TextBarClass[IO.ProcessManage["textbarnum"]][4])
                term.setCursorPos(TextBarClass[IO.ProcessManage["textbarnum"]][2],TextBarClass[IO.ProcessManage["textbarnum"]][3])
                term.setCursorBlink(true)
                GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"] = TextBarClass
            else
                TextBarClass[IO.ProcessManage["textbarnum"]][1] = ""
                term.setCursorPos(TextBarClass[IO.ProcessManage["textbarnum"]][2],TextBarClass[IO.ProcessManage["textbarnum"]][3])
                term.setCursorBlink(true)
                GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"] = TextBarClass
            end
        end
        if(KeyCache=="enter")then
            if(TextBarClass[IO.ProcessManage["textbarnum"]][1]=="")then
                IO.ProcessManage["event"] = "main"
                TextBarClass[IO.ProcessManage["textbarnum"]][1] = nil
                GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"] = TextBarClass
                GUI.DrawForm(IO.ProcessManage["formnum"])
            end
            IO.ProcessManage["event"] = "main"
            term.setCursorBlink(false)
        end
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="page_textbar_input")then
        local page_index_all = GUI.Form[IO.ProcessManage["formnum"]]["page_class"]
        local pageselect = GUI.Form[IO.ProcessManage["formnum"]]["page_num"]
        local TextBarClass = page_index_all[pageselect]["textbar_class"]
        if(KeyCache=="backspace" and TextBarClass[IO.ProcessManage["page_textbarnum"]][1]~=nil)then
            local CharLen = string.len(TextBarClass[IO.ProcessManage["page_textbarnum"]][1])
            if(CharLen>0)then
                TextBarClass[IO.ProcessManage["page_textbarnum"]][1] = string.sub(TextBarClass[IO.ProcessManage["page_textbarnum"]][1],1,CharLen-1)
                GUI.DrawTextBar(TextBarClass[IO.ProcessManage["page_textbarnum"]][1],TextBarClass[IO.ProcessManage["page_textbarnum"]][2],TextBarClass[IO.ProcessManage["page_textbarnum"]][3],TextBarClass[IO.ProcessManage["page_textbarnum"]][4])
                term.setCursorPos(TextBarClass[IO.ProcessManage["page_textbarnum"]][2],TextBarClass[IO.ProcessManage["page_textbarnum"]][3])
                term.setCursorBlink(true)
                page_index_all[pageselect]["textbar_class"] = TextBarClass
                GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
            else
                TextBarClass[IO.ProcessManage["page_textbarnum"]][1] = ""
                term.setCursorPos(TextBarClass[IO.ProcessManage["page_textbarnum"]][2],TextBarClass[IO.ProcessManage["page_textbarnum"]][3])
                term.setCursorBlink(true)
                page_index_all[pageselect]["textbar_class"] = TextBarClass
                GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
            end
        end
        if(KeyCache=="enter")then
            if(TextBarClass[IO.ProcessManage["page_textbarnum"]][1]=="")then
                IO.ProcessManage["event"] = "pagemain"
                TextBarClass[IO.ProcessManage["page_textbarnum"]][1] = nil
                page_index_all[pageselect]["textbar_class"] = TextBarClass
                GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                GUI.DrawForm(IO.ProcessManage["formnum"])
            end
            IO.ProcessManage["event"] = "pagemain"
            term.setCursorBlink(false)
        end
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="textbox_input")then
        local TextBoxClass = GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"]
        if(KeyCache=="backspace" and TextBoxClass[IO.ProcessManage["textboxnum"]][1]~=nil)then
            local CharLen = string.len(TextBoxClass[IO.ProcessManage["textboxnum"]][1])
            if(CharLen>0)then
                TextBoxClass[IO.ProcessManage["textboxnum"]][1] = string.sub(TextBoxClass[IO.ProcessManage["textboxnum"]][1],1,CharLen-1)
                GUI.DrawTextBox(TextBoxClass[IO.ProcessManage["textboxnum"]][1],TextBoxClass[IO.ProcessManage["textboxnum"]][2],TextBoxClass[IO.ProcessManage["textboxnum"]][3],TextBoxClass[IO.ProcessManage["textboxnum"]][4],TextBoxClass[IO.ProcessManage["textboxnum"]][5],TextBoxClass[IO.ProcessManage["textboxnum"]][6],TextBoxClass[IO.ProcessManage["textboxnum"]][7],TextBoxClass[IO.ProcessManage["textboxnum"]][8])
                term.setCursorPos(TextBoxClass[IO.ProcessManage["textboxnum"]][2],TextBoxClass[IO.ProcessManage["textboxnum"]][3]+TextBoxClass[IO.ProcessManage["textboxnum"]][5]-1)
                term.setCursorBlink(true)
                GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"] = TextBoxClass
            else
                TextBoxClass[IO.ProcessManage["textboxnum"]][1] = ""
                term.setCursorPos(TextBoxClass[IO.ProcessManage["textboxnum"]][2],TextBoxClass[IO.ProcessManage["textboxnum"]][3]+TextBoxClass[IO.ProcessManage["textboxnum"]][5]-1)
                term.setCursorBlink(true)
                GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"] = TextBoxClass
            end
        end
        if(KeyCache=="enter")then
            if(TextBoxClass[IO.ProcessManage["textboxnum"]][1]=="")then
                IO.ProcessManage["event"] = "main"
                TextBoxClass[IO.ProcessManage["textboxnum"]][1] = nil
                GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"] = TextBoxClass
                GUI.DrawForm(IO.ProcessManage["formnum"])
            end
            IO.ProcessManage["event"] = "main"
            term.setCursorBlink(false)
        end
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="page_textbox_input")then
        local page_index_all = GUI.Form[IO.ProcessManage["formnum"]]["page_class"]
        local pageselect = GUI.Form[IO.ProcessManage["formnum"]]["page_num"]
        local TextBoxClass = page_index_all[pageselect]["textbox_class"]
        if(KeyCache=="backspace" and TextBoxClass[IO.ProcessManage["page_textboxnum"]][1]~=nil)then
            local CharLen = string.len(TextBoxClass[IO.ProcessManage["page_textboxnum"]][1])
            if(CharLen>0)then
                TextBoxClass[IO.ProcessManage["page_textboxnum"]][1] = string.sub(TextBoxClass[IO.ProcessManage["page_textboxnum"]][1],1,CharLen-1)
                GUI.DrawTextBox(TextBoxClass[IO.ProcessManage["page_textboxnum"]][1],TextBoxClass[IO.ProcessManage["page_textboxnum"]][2],TextBoxClass[IO.ProcessManage["page_textboxnum"]][3],TextBoxClass[IO.ProcessManage["page_textboxnum"]][4],TextBoxClass[IO.ProcessManage["page_textboxnum"]][5],TextBoxClass[IO.ProcessManage["page_textboxnum"]][6],TextBoxClass[IO.ProcessManage["page_textboxnum"]][7],TextBoxClass[IO.ProcessManage["page_textboxnum"]][8])
                term.setCursorPos(TextBoxClass[IO.ProcessManage["page_textboxnum"]][2],TextBoxClass[IO.ProcessManage["page_textboxnum"]][3]+TextBoxClass[IO.ProcessManage["page_textboxnum"]][5]-1)
                term.setCursorBlink(true)
                page_index_all[pageselect]["textbox_class"] = TextBoxClass
                GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
            else
                TextBoxClass[IO.ProcessManage["page_textboxnum"]][1] = ""
                term.setCursorPos(TextBoxClass[IO.ProcessManage["page_textboxnum"]][2],TextBoxClass[IO.ProcessManage["page_textboxnum"]][3]+TextBoxClass[IO.ProcessManage["page_textboxnum"]][5]-1)
                term.setCursorBlink(true)
                page_index_all[pageselect]["textbox_class"] = TextBoxClass
                GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
            end
        end
        if(KeyCache=="enter")then
            if(TextBoxClass[IO.ProcessManage["textboxnum"]][1]=="")then
                IO.ProcessManage["event"] = "pagemain"
                TextBoxClass[IO.ProcessManage["textboxnum"]][1] = nil
                page_index_all[pageselect]["textbox_class"] = TextBoxClass
                GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                GUI.DrawForm(IO.ProcessManage["formnum"])
            end
            IO.ProcessManage["event"] = "pagemain"
            term.setCursorBlink(false)
        end
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["formnum"]==3)then
        if(KeyCache=="enter")then
            local TextBoxClass = GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"]
            Phi.Compilor(TextBoxClass[IO.ProcessManage["textboxnum"]][1])
            TextBoxClass[IO.ProcessManage["textboxnum"]][1] = ""
            GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"] = TextBoxClass
            IO.ProcessManage["event"]="main"
            GUI.DrawTextBox(TextBoxClass[IO.ProcessManage["textboxnum"]][1],TextBoxClass[IO.ProcessManage["textboxnum"]][2],TextBoxClass[IO.ProcessManage["textboxnum"]][3],TextBoxClass[IO.ProcessManage["textboxnum"]][4],TextBoxClass[IO.ProcessManage["textboxnum"]][5],TextBoxClass[IO.ProcessManage["textboxnum"]][6],TextBoxClass[IO.ProcessManage["textboxnum"]][7],TextBoxClass[IO.ProcessManage["textboxnum"]][8])
        end
    end
end

function IO.CharInput(CharCache)
    if(GUI.Form[IO.ProcessManage["formnum"]].charinput and IO.ProcessManage["label"]=="Program")then
        GUI.Form[IO.ProcessManage["formnum"]].charinput(CharCache)
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="textbar_input")then
        local TextBarClass = GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"]
        if(TextBarClass[IO.ProcessManage["textbarnum"]][1]~=nil)then
            if(TextBarClass[IO.ProcessManage["textbarnum"]][5]==nil)then
                TextBarClass[IO.ProcessManage["textbarnum"]][1] = string.format("%s%s",TextBarClass[IO.ProcessManage["textbarnum"]][1],CharCache)
                GUI.DrawTextBar(TextBarClass[IO.ProcessManage["textbarnum"]][1],TextBarClass[IO.ProcessManage["textbarnum"]][2],TextBarClass[IO.ProcessManage["textbarnum"]][3],TextBarClass[IO.ProcessManage["textbarnum"]][4])
                term.setCursorPos(TextBarClass[IO.ProcessManage["textbarnum"]][2],TextBarClass[IO.ProcessManage["textbarnum"]][3])
                term.setCursorBlink(true)
                GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"] = TextBarClass
            elseif(TextBarClass[IO.ProcessManage["textbarnum"]][5]=="onlynum")then
                if(tonumber(CharCache)~=nil)then
                    TextBarClass[IO.ProcessManage["textbarnum"]][1] = string.format("%s%s",TextBarClass[IO.ProcessManage["textbarnum"]][1],CharCache)
                    GUI.DrawTextBar(TextBarClass[IO.ProcessManage["textbarnum"]][1],TextBarClass[IO.ProcessManage["textbarnum"]][2],TextBarClass[IO.ProcessManage["textbarnum"]][3],TextBarClass[IO.ProcessManage["textbarnum"]][4])
                    term.setCursorPos(TextBarClass[IO.ProcessManage["textbarnum"]][2],TextBarClass[IO.ProcessManage["textbarnum"]][3])
                    term.setCursorBlink(true)
                    GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"] = TextBarClass
                end
            elseif(TextBarClass[IO.ProcessManage["textbarnum"]][5]=="onlytext")then
                if(tonumber(CharCache)==nil)then
                    TextBarClass[IO.ProcessManage["textbarnum"]][1] = string.format("%s%s",TextBarClass[IO.ProcessManage["textbarnum"]][1],CharCache)
                    GUI.DrawTextBar(TextBarClass[IO.ProcessManage["textbarnum"]][1],TextBarClass[IO.ProcessManage["textbarnum"]][2],TextBarClass[IO.ProcessManage["textbarnum"]][3],TextBarClass[IO.ProcessManage["textbarnum"]][4])
                    term.setCursorPos(TextBarClass[IO.ProcessManage["textbarnum"]][2],TextBarClass[IO.ProcessManage["textbarnum"]][3])
                    term.setCursorBlink(true)
                    GUI.Form[IO.ProcessManage["formnum"]]["textbar_class"] = TextBarClass
                end
            end
        end
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="page_textbar_input")then
        local page_index_all = GUI.Form[IO.ProcessManage["formnum"]]["page_class"]
        local pageselect = GUI.Form[IO.ProcessManage["formnum"]]["page_num"]
        local TextBarClass = page_index_all[pageselect]["textbar_class"]
        if(TextBarClass[IO.ProcessManage["page_textbarnum"]][1]~=nil)then
            if(TextBarClass[IO.ProcessManage["page_textbarnum"]][5]==nil)then
                TextBarClass[IO.ProcessManage["page_textbarnum"]][1] = string.format("%s%s",TextBarClass[IO.ProcessManage["page_textbarnum"]][1],CharCache)
                GUI.DrawTextBar(TextBarClass[IO.ProcessManage["page_textbarnum"]][1],TextBarClass[IO.ProcessManage["page_textbarnum"]][2],TextBarClass[IO.ProcessManage["page_textbarnum"]][3],TextBarClass[IO.ProcessManage["page_textbarnum"]][4])
                term.setCursorPos(TextBarClass[IO.ProcessManage["page_textbarnum"]][2],TextBarClass[IO.ProcessManage["page_textbarnum"]][3])
                term.setCursorBlink(true)
                page_index_all[pageselect]["textbar_class"] = TextBarClass
                GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
            elseif(TextBarClass[IO.ProcessManage["page_textbarnum"]][5]=="onlynum")then
                if(tonumber(CharCache)~=nil)then
                    TextBarClass[IO.ProcessManage["page_textbarnum"]][1] = string.format("%s%s",TextBarClass[IO.ProcessManage["page_textbarnum"]][1],CharCache)
                    GUI.DrawTextBar(TextBarClass[IO.ProcessManage["page_textbarnum"]][1],TextBarClass[IO.ProcessManage["page_textbarnum"]][2],TextBarClass[IO.ProcessManage["page_textbarnum"]][3],TextBarClass[IO.ProcessManage["page_textbarnum"]][4])
                    term.setCursorPos(TextBarClass[IO.ProcessManage["page_textbarnum"]][2],TextBarClass[IO.ProcessManage["page_textbarnum"]][3])
                    term.setCursorBlink(true)
                    page_index_all[pageselect]["textbar_class"] = TextBarClass
                    GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                end
            elseif(TextBarClass[IO.ProcessManage["page_textbarnum"]][5]=="onlytext")then
                if(tonumber(CharCache)==nil)then
                    TextBarClass[IO.ProcessManage["page_textbarnum"]][1] = string.format("%s%s",TextBarClass[IO.ProcessManage["page_textbarnum"]][1],CharCache)
                    GUI.DrawTextBar(TextBarClass[IO.ProcessManage["page_textbarnum"]][1],TextBarClass[IO.ProcessManage["page_textbarnum"]][2],TextBarClass[IO.ProcessManage["page_textbarnum"]][3],TextBarClass[IO.ProcessManage["page_textbarnum"]][4])
                    term.setCursorPos(TextBarClass[IO.ProcessManage["page_textbarnum"]][2],TextBarClass[IO.ProcessManage["page_textbarnum"]][3])
                    term.setCursorBlink(true)
                    page_index_all[pageselect]["textbar_class"] = TextBarClass
                    GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
                end
            end
        end
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="textbox_input")then
        local TextBoxClass = GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"]
        if(TextBoxClass[IO.ProcessManage["textboxnum"]][1]~=nil)then
            TextBoxClass[IO.ProcessManage["textboxnum"]][1] = string.format("%s%s",TextBoxClass[IO.ProcessManage["textboxnum"]][1],CharCache)
            GUI.DrawTextBox(TextBoxClass[IO.ProcessManage["textboxnum"]][1],TextBoxClass[IO.ProcessManage["textboxnum"]][2],TextBoxClass[IO.ProcessManage["textboxnum"]][3],TextBoxClass[IO.ProcessManage["textboxnum"]][4],TextBoxClass[IO.ProcessManage["textboxnum"]][5],TextBoxClass[IO.ProcessManage["textboxnum"]][6],TextBoxClass[IO.ProcessManage["textboxnum"]][7],TextBoxClass[IO.ProcessManage["textboxnum"]][8])
            term.setCursorPos(TextBoxClass[IO.ProcessManage["textboxnum"]][2],TextBoxClass[IO.ProcessManage["textboxnum"]][3]+TextBoxClass[IO.ProcessManage["textboxnum"]][5]-1)
            term.setCursorBlink(true)
            GUI.Form[IO.ProcessManage["formnum"]]["textbox_class"] = TextBoxClass
        end
    end
    if(IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"]=="page_textbox_input")then
        local page_index_all = GUI.Form[IO.ProcessManage["formnum"]]["page_class"]
        local pageselect = GUI.Form[IO.ProcessManage["formnum"]]["page_num"]
        local TextBoxClass = page_index_all[pageselect]["textbox_class"]
        if(TextBoxClass[IO.ProcessManage["page_textboxnum"]][1]~=nil)then
            TextBoxClass[IO.ProcessManage["page_textboxnum"]][1] = string.format("%s%s",TextBoxClass[IO.ProcessManage["page_textboxnum"]][1],CharCache)
            GUI.DrawTextBox(TextBoxClass[IO.ProcessManage["page_textboxnum"]][1],TextBoxClass[IO.ProcessManage["page_textboxnum"]][2],TextBoxClass[IO.ProcessManage["page_textboxnum"]][3],TextBoxClass[IO.ProcessManage["page_textboxnum"]][4],TextBoxClass[IO.ProcessManage["page_textboxnum"]][5],TextBoxClass[IO.ProcessManage["page_textboxnum"]][6],TextBoxClass[IO.ProcessManage["page_textboxnum"]][7],TextBoxClass[IO.ProcessManage["page_textboxnum"]][8])
            term.setCursorPos(TextBoxClass[IO.ProcessManage["page_textboxnum"]][2],TextBoxClass[IO.ProcessManage["page_textboxnum"]][3]+TextBoxClass[IO.ProcessManage["page_textboxnum"]][5]-1)
            term.setCursorBlink(true)
            page_index_all[pageselect]["textbox_class"] = TextBoxClass
            GUI.Form[IO.ProcessManage["formnum"]]["page_class"] = page_index_all
        end
    end
end

function IO.LisTimerUP(Timername)
    if(GUI.Form[IO.ProcessManage["formnum"]].timer_up and IO.ProcessManage["label"]=="Program")then
        GUI.Form[IO.ProcessManage["formnum"]].timer_up(Timername)
    end
end

function IO.Service(func,param1)
    if(func=="SYS_Showtime")then
        SYS_StartSec = os.date("%S")
        SYS_Timer = os.startTimer(60-SYS_StartSec)
        SYS_Time = os.date("%H:%M")
        GUI.DrawText(GUI.TermWide-4,1,SYS_Time,"black","white")
    end
    if(func=="REDNET_SET")then
        if(param1==true)then
            peripheral.find("modem",rednet.open)
            IO.ModemSign = true
        elseif(param1==false)then
            peripheral.find("modem",rednet.close)
            IO.ModemSifn = false
        else
        end
    end
    if(func=="REDNET_CHECK")then
        local checktbl = {"top","bottom","left","right","front","back"}
        for i=1,6 do
            if(peripheral.isPresent(checktbl[i]))then
                IO.modemchk = true
            end
        end
    end
end

function IO.FileSystem(func, param1, param2)
    if func == "LIST_FILES" then
        local path = param1 or "/"
        local files = {}
        local success, list = pcall(fs.list, path)

        if success then
            for _, name in ipairs(list) do
                local fullPath = path .. (path == "/" and "" or "/") .. name
                table.insert(files, {
                    name = name,
                    path = fullPath,
                    isDir = fs.isDir(fullPath),
                    size = fs.getSize(fullPath) or 0
                })
            end
        end
        return files

    elseif func == "READ_FILE" then
        local file = fs.open(param1, "r")
        if file then
            local content = file.readAll()
            file.close()
            return content
        end
        return nil

    elseif func == "WRITE_FILE" then
        local file = fs.open(param1, "w")
        if file then
            file.write(param2 or "")
            file.close()
            return true
        end
        return false

    elseif func == "DELETE_FILE" then
        return pcall(fs.delete, param1)
    end
end

function Control.SetIOBool(port,mode)
    if(PortSet.PowerButton == true and type(port)=="number" and PortSet.OutputIO[port]~=nil and PortSet.OutputIO[port]["check"]~=false)then
        if(mode==true)then
            peripheral.call(PortSet.OutputIO[port]["name"],"setOutput",PortSet.OutputIO[port]["side"],true)
            PortSet.OutputIO[port]["Value"] = 15
        elseif(mode==false)then
            peripheral.call(PortSet.OutputIO[port]["name"],"setOutput",PortSet.OutputIO[port]["side"],false)
            PortSet.OutputIO[port]["Value"] = 0
        end
    end
end

function Control.SetIOAna(port,val)
    if(PortSet.PowerButton == true and PortSet.OutputIO[port]~=nil and PortSet.OutputIO[port]["check"]~=false)then
        if(type(port)=="number" and type(val)=="number")then
            if(PortSet.OutputIO[port]~=nil and val>=0 and val<=15)then
                peripheral.call(PortSet.OutputIO[port]["name"],"setAnalogueOutput",PortSet.OutputIO[port]["side"],val)
                PortSet.OutputIO[port]["Value"] = val
            end
        end
    end
end

function Control.GetIOAna(port)
    if(PortSet.PowerButton == true and PortSet.InputIO[port]["check"]~=false)then
        if(type(port)=="number")then
            if(PortSet.InputIO[port]~=nil)then
                PortSet.InputIO[port]["Value"] = peripheral.call(PortSet.InputIO[port]["name"],"getAnalogueInput",PortSet.InputIO[port]["side"])
                if(PortSet.InputIO[port]["Value"]~=nil)then
                    return PortSet.InputIO[port]["Value"]
                end
            end
        end
    end
end

function Control.GetIOBool(port)
    if(type(port)=="number")then
        local portval = Control.GetIOAna(port)
        if(PortSet.BoolMode==true)then
            if(portval>0)then
                return true
            else
                return false
            end
        elseif(PortSet.BoolMode==false)then
            if(portval==15)then
                return true
            else
                return false
            end
        else
            return nil
        end
    else
        return nil
    end
end

function Control.RedstoneActive()
    if(GUI.Form[IO.ProcessManage["formnum"]].redstone and IO.ProcessManage["label"]=="Program")then
        GUI.Form[IO.ProcessManage["formnum"]].redstone()
    end
end

function Control.Service(func)
    if(func=="INIT_Count")then
        local w1,cont1 = 1,PortSet.InputIO[1]
        while cont1 ~= nil do
            w1 = w1+1
            cont1 = PortSet.InputIO[w1]
        end
        InputIO_Count = w1-1
        Control.InputIO_Count = InputIO_Count

        local w2,cont2 = 1,PortSet.OutputIO[1]
        while cont2 ~= nil do
            w2 = w2+1
            cont2 = PortSet.OutputIO[w2]
        end
        OutputIO_Count = w2-1
        Control.OutputIO_Count = OutputIO_Count
    end
    if(func=="CUTOFF_OUT")then
        for i=1,OutputIO_Count do
            Control.SetIOBool(i,false)
        end
    end
    if(func=="INIT_Check")then
        local checktbl = {"top","bottom","left","right","front","back"}
        if(InputIO_Count~=0 and InputIO_Count~=nil and PortSet.InputIO~=nil)then
            for i=1,InputIO_Count do
                local chkname1 = string.find(PortSet.InputIO[i]["name"],"redstone_relay_")
                local chkside1 = PortSet.InputIO[i]["side"]
                if(chkname1 and type(tonumber(string.sub(PortSet.InputIO[i]["name"],16)))=="number")then
                    for key,value in ipairs(checktbl) do
                        if(chkside1 == value)then
                            if(peripheral.isPresent(PortSet.InputIO[i]["name"]))then
                                PortSet.InputIO[i]["Check"] = true
                            else
                                PortSet.InputIO[i]["Check"] = false
                            end
                        end
                    end
                else
                    PortSet.InputIO[i]["Check"] = false
                end
            end
        end
        if(OutputIO_Count~=0 and OutputIO_Count~=nil and PortSet.OutputIO~=nil)then
            for i=1,OutputIO_Count do
                local chkname2 = string.find(PortSet.OutputIO[i]["name"],"redstone_relay_")
                local chkside2 = PortSet.OutputIO[i]["side"]
                if(chkname2 and type(tonumber(string.sub(PortSet.OutputIO[i]["name"],16)))=="number")then
                    for key,value in ipairs(checktbl) do
                        if(chkside2 == value)then
                            if(peripheral.isPresent(PortSet.OutputIO[i]["name"]))then
                                PortSet.OutputIO[i]["Check"] = true
                            else
                                PortSet.OutputIO[i]["Check"] = false
                            end
                        end
                    end
                else
                    PortSet.OutputIO[i]["Check"] = false
                end
            end
        end
    end
    if(func=="INIT_InputIO" and PortSet.InputIO_Count~=0)then
        for i=1,Control.InputIO_Count do
            Control.GetIOAna(i)
            if(i<=16 and Control.InputIO_Count~=nil)then
                if(PortSet.InputIO[i]["Value"]>0 and PortSet.InputIO[i]["Value"]<=15)then
                    GUI.SetButtonAttribute(4,"Bcolor",i,"orange",false)
                elseif(PortSet.InputIO[i]["Value"]==0)then
                    GUI.SetButtonAttribute(4,"Bcolor",i,"black",false)
                end
                if(IO.ProcessManage["formnum"]==4 and IO.ProcessManage["label"]=="Program" and IO.ProcessManage["event"] == "main")then
                    if(PortSet.InputIO[i]["Value"]>0 and PortSet.InputIO[i]["Value"]<=15)then
                        Control.PLCManager("DRAW_INPUTIO_LAMP",i,true)
                    elseif(PortSet.InputIO[i]["Value"]==0)then
                        Control.PLCManager("DRAW_INPUTIO_LAMP",i,false)
                    end
                end
            end
            if(PortSet.UpperID~=false and type(PortSet.UpperID)=="number")then
                rednet.send(PortSet.UpperID,string.format("BACKANA>>%s,%s",tostring(i),tostring(PortSet.InputIO[i]["Value"])))
            end
        end
    end
    if(func=="INIT_OutputIO" and OutputIO_Count~=0)then
        for i=1,OutputIO_Count do
            PortSet.OutputIO[i]["Value"] = 0
        end
    end
end

--System Software

local Caculator_Temp1,Caculator_Temp2,Caculator_Result = 0,0,0
local Caculator_Func = "Null"
local function Caculator(func,param1)
    if(GUI.GetTextbarAttribute(2,"temp",1)==nil)then
        GUI.SetTextbarAttribute(2,"temp",1,"")
    end
    if(func=="Input")then
        GUI.SetTextbarAttribute(2,"temp",1,string.format("%s%s",GUI.GetTextbarAttribute(2,"temp",1),param1))
    end
    if(func=="AC")then
        GUI.SetTextbarAttribute(2,"temp",1,"")
        Caculator_Func = "Null"
        Caculator_Temp1,Caculator_Temp2,Caculator_Result = 0,0,0
    end
    if(func=="C")then
        local temp = GUI.GetTextbarAttribute(2,"temp",1)
        temp = string.sub(temp,1,string.len(temp)-1)
        GUI.SetTextbarAttribute(2,"temp",1,temp)
    end
    if(func=="Plus")then
        Caculator_Temp1 = tonumber(GUI.GetTextbarAttribute(2,"temp",1))
        Caculator_Func = "Plus"
        GUI.SetTextbarAttribute(2,"temp",1,"")
    end
    if(func=="Sub")then
        Caculator_Temp1 = tonumber(GUI.GetTextbarAttribute(2,"temp",1))
        Caculator_Func = "Sub"
        GUI.SetTextbarAttribute(2,"temp",1,"")
    end
    if(func=="Multi")then
        Caculator_Temp1 = tonumber(GUI.GetTextbarAttribute(2,"temp",1))
        Caculator_Func = "Multi"
        GUI.SetTextbarAttribute(2,"temp",1,"")
    end
    if(func=="Div")then
        Caculator_Temp1 = tonumber(GUI.GetTextbarAttribute(2,"temp",1))
        Caculator_Func = "Div"
        GUI.SetTextbarAttribute(2,"temp",1,"")
    end
    if(func=="Obtain")then
        Caculator_Temp2 = tonumber(GUI.GetTextbarAttribute(2,"temp",1))
        if(Caculator_Func=="Plus" and Caculator_Temp2~=nil)then
            Caculator_Result = Caculator_Temp1 + Caculator_Temp2
            GUI.SetTextbarAttribute(2,"temp",1,tostring(Caculator_Result))
            Caculator_Temp1,Caculator_Temp2,Caculator_Result = 0,0,0
            Caculator_Func = "Null"
        elseif(Caculator_Func=="Sub" and Caculator_Temp2~=nil)then
            Caculator_Result = Caculator_Temp1 - Caculator_Temp2
            GUI.SetTextbarAttribute(2,"temp",1,tostring(Caculator_Result))
            Caculator_Temp1,Caculator_Temp2,Caculator_Result = 0,0,0
            Caculator_Func = "Null"
        elseif(Caculator_Func=="Multi" and Caculator_Temp2~=nil)then
            Caculator_Result = Caculator_Temp1 * Caculator_Temp2
            GUI.SetTextbarAttribute(2,"temp",1,tostring(Caculator_Result))
            Caculator_Temp1,Caculator_Temp2,Caculator_Result = 0,0,0
            Caculator_Func = "Null"
        elseif(Caculator_Func=="Div" and Caculator_Temp2~=nil)then
            Caculator_Result = Caculator_Temp1 / Caculator_Temp2
            GUI.SetTextbarAttribute(2,"temp",1,tostring(Caculator_Result))
            Caculator_Temp1,Caculator_Temp2,Caculator_Result = 0,0,0
            Caculator_Func = "Null"
        else
            GUI.SetTextbarAttribute(2,"temp",1,tostring(Caculator_Temp1))
        end
        Caculator_Func = "Null"
    end
end

GUI.Form[2] = {}
GUI.Form[2]["label"] = "Program"
GUI.Form[2]["name"] = "Calculator"
GUI.Form[2]["taskbutton"] = "close"
GUI.Form[2]["background_color"] = "lightgray"
GUI.Form[2]["icon_tcolor"] = "white"
GUI.Form[2]["icon_bcolor"] = "gray"
GUI.Form[2]["text_class"] =
{

}
GUI.Form[2]["button_class"] =
{
    {" 1 ",2,5,"white","gray",function() Caculator("Input","1") end},
    {" 2 ",6,5,"white","gray",function() Caculator("Input","2") end},
    {" 3 ",10,5,"white","gray",function() Caculator("Input","3") end},
    {" 4 ",2,7,"white","gray",function() Caculator("Input","4") end},
    {" 5 ",6,7,"white","gray",function() Caculator("Input","5") end},
    {" 6 ",10,7,"white","gray",function() Caculator("Input","6") end},
    {" 7 ",2,9,"white","gray",function() Caculator("Input","7") end},
    {" 8 ",6,9,"white","gray",function() Caculator("Input","8") end},
    {" 9 ",10,9,"white","gray",function() Caculator("Input","9") end},
    {"   0   ",2,11,"white","gray",function() Caculator("Input","0") end},
    {" . ",10,11,"white","gray",function() Caculator("Input",".") end},
    {" + ",14,5,"white","orange",function() Caculator("Plus") end},
    {" - ",14,7,"white","orange",function() Caculator("Sub") end},
    {" * ",14,9,"white","orange",function() Caculator("Multi") end},
    {" / ",14,11,"white","orange",function() Caculator("Div") end},
    {"  =  ",12,13,"white","green",function() Caculator("Obtain") end},
    {" C ",7,13,"white","blue",function() Caculator("C") end},
    {" AC ",2,13,"white","red",function() Caculator("AC") end},
    {"Exchange",18,8,"white","green",function()
        local gettemp = GUI.GetTextbarAttribute(2,"temp",2)
        if(gettemp==nil or gettemp=="")then
            GUI.SetTextbarAttribute(2,"temp",2,"00")
            GUI.SetSwitchAttribute(2,"sign",1,"00")
        else
            GUI.SetSwitchAttribute(2,"sign",1,GUI.GetTextbarAttribute(2,"temp",2))
        end
    end}
}
GUI.Form[2]["switch_class"] = {
    {"8Set",18,5,"00"}
}
GUI.Form[2]["textbar_class"] =
{
    {"",2,3,15,"onlynum"},
    {"",18,3,8}
}

Phi.FaceLine = 3
Phi.TreatEgg = 1
function Phi.Compilor(func)
    if(type(func)=="string")then
        if(func=="version")then
            Phi.FaceClass("OutputMsg","PHI_SYS","white","lime",string.format("Phineon %s Base on AlterBasic3",GUI.Form[1]["name"]))
        elseif(func=="hello")then
            Phi.FaceClass("OutputMsg","PHI_SYS","white","lime","Welcome to Phineon Logmatic system \\(0V0)/")
        elseif(func=="clear")then
            GUI.DrawBox(1,2,GUI.TermWide,GUI.TermHigh-6,"black","filled")
            Phi.FaceLine = 3
        elseif(func=="date")then
            Phi.FaceClass("OutputMsg","PHI_SYS","white","lime",os.date("%Y-%m-%d"))
        elseif(string.upper(func)=="NICE TO MEET YOU")then
            Phi.FaceClass("OutputMsg","PHI_SYS","white","lime","Nice to meet you too :)")
        elseif(func=="shutdown")then
            os.shutdown()
        elseif(func=="reboot")then
            os.reboot()
        elseif(func=="craftos")then
            term.clear()
            GUI.DrawBox(1,1,GUI.TermWide,1,"yellow","filled")
            GUI.TermColor("black","yellow")
            term.setCursorPos(2,1)
            print("Altersystem were back to CraftOS")
            IO.SYS_RUN = false
        elseif(func=="chkrdn")then
            if(IO.ModemSign==true)then
                Phi.FaceClass("OutputMsg","PHI_SYS","white","lime","Rednet is open")
            else
                Phi.FaceClass("OutputMsg","PHI_SYS","white","lime","Rednet is close")
            end
        else
            local codesign1,codesign2 = string.find(func,">>",1)
            if(codesign1~=nil and codesign2~=nil)then
                local findcode = string.upper(string.sub(func,1,codesign1-1))
                local findparam = string.upper(string.sub(func,codesign2+1,string.len(func)))
                if(findcode=="SETIOBOOL")then
                    local parasign,_ = string.find(findparam,",",1)
                    if(parasign~=nil and PortSet.OutputIO~=nil)then
                        local findio = tonumber(string.upper(string.sub(findparam,1,parasign-1)))
                        local findset = string.upper(string.sub(findparam,parasign+1))
                        if(type(findio)=="number" and type(findset)=="string" and Control.OutputIO_Count~=nil)then
                            for i=1,Control.OutputIO_Count do
                                if(findio==i and IO.ModemSign == true)then
                                    local SW_IOFUNC = {
                                        ON = function()
                                            Control.SetIOBool(findio,true)
                                            Phi.FaceClass("OUTPUTMSG","COMPILOR","white","lime",string.format("Output IO %d were set on",findio))
                                        end,
                                        OFF = function()
                                            Control.SetIOBool(findio,false)
                                            Phi.FaceClass("OUTPUTMSG","COMPILOR","white","lime",string.format("Output IO %d were set off",findio))
                                        end,
                                    }
                                    local SW_IOFUNC_RUN = SW_IOFUNC[findset]
                                    if(SW_IOFUNC_RUN)then
                                        SW_IOFUNC_RUN()
                                        break
                                    else
                                        Phi.FaceClass("CompilorError")
                                        break
                                    end
                                else
                                end
                            end
                        else
                            Phi.FaceClass("CompilorError")
                        end
                    else
                        Phi.FaceClass("CompilorError")
                    end
                else
                    Phi.FaceClass("CompilorError")
                end
            else
                Phi.FaceClass("ERROR")
            end
        end
    else
        Phi.FaceClass("ERROR")
    end
end

function Phi.FaceClass(func,msghead,htc,hbc,msgtext)
    if(string.upper(func)=="OUTPUTMSG")then
        local msgheadlen = string.len(msghead)
        local outhead = ""
        if(msgheadlen<=GUI.TermWide)then
            outhead = msghead
        else
            outhead = string.format("%s..",string.sub(msghead,1,GUI.TermWide-2))
        end
        local outhigh = math.floor(string.len(msgtext) / GUI.TermWide) + 1
        if(Phi.FaceLine + outhigh <= GUI.TermHigh-4)then
            GUI.DrawText(1,Phi.FaceLine,outhead,htc,hbc)
            GUI.DrawText(1+msgheadlen+1,Phi.FaceLine,os.date("%H:%M:%S"),"white","black")
            Phi.FaceLine = Phi.FaceLine + 1
            if(string.len(msgtext)>GUI.TermWide)then
                for i=1,math.ceil(string.len(msgtext) / GUI.TermWide) do
                    GUI.DrawText(1,Phi.FaceLine+(i-1),string.sub(msgtext,1 + GUI.TermWide * (i - 1),GUI.TermWide * i),"white","black")
                end
                Phi.FaceLine = Phi.FaceLine + 3
            else
                GUI.DrawText(1,Phi.FaceLine,msgtext,"white","black")
                Phi.FaceLine = Phi.FaceLine + 2
            end
        else
            GUI.DrawBox(1,2,GUI.TermWide,GUI.TermHigh-5,"black","filled")
            Phi.FaceLine = 3
            Phi.FaceClass(func,msghead,htc,hbc,msgtext)
        end
    end
    if(func=="ERROR")then
        if(Phi.TreatEgg<=3)then
            Phi.FaceClass("OUTPUTMSG","CODE ERROR","yellow","red","Invalid input by the user ! Enter \"help\" to view the runable programs.")
            Phi.TreatEgg = Phi.TreatEgg + 1
        else
            local egg_num = math.random(9)
            local SW_EGG = {
                [1] = function()
                    Phi.FaceClass("OUTPUTMSG","(>_<)","yellow","gray","Are you serious?")
                end,
                [2] = function()
                    Phi.FaceClass("OUTPUTMSG","A Russian programmer","yellow","red","All right,Let's get some bim bim bang bang!!!")
                end,
                [3] = function()
                    Phi.FaceClass("OUTPUTMSG","MOJANG","orange","lightgray","If you are tired,you can play Minecraft for a while.")
                end,
                [4] = function()
                    Phi.FaceClass("OUTPUTMSG","Tony Montana","black","red","Say hello to my little friend !")
                end,
                [5] = function()
                    Phi.FaceClass("OUTPUTMSG","Rick Astley","white","cyan","You know the rules and so do I")
                end,
                [6] = function()
                    Phi.FaceClass("OUTPUTMSG","Jeff & Steve","purple","brown","Hold the line love isn't always on time.")
                end,
                [7] = function()
                    Phi.FaceClass("OUTPUTMSG","Yu Mazi","white","orange","You don't need 399$,you can have it forever with only 39.9$!")
                end,
                [8] = function()
                    Phi.FaceClass("OUTPUTMSG","Glenn Quagmire","red","magenta","Giggetty-gaggety-gaggety-goo~")
                end,
                [9] = function()
                    Phi.FaceClass("OUTPUTMSG","Tiger brother","lime","lightgray","Where is my tudi?")
                    sleep(2)
                    Phi.FaceClass("OUTPUTMSG","Knife brother","lime","lightgray","I don't know!!!")
                end,
            }
            local SW_EGG_RUN = SW_EGG[egg_num]
            SW_EGG_RUN()
            Phi.TreatEgg = 1
        end
    end
    if(func=="CompilorError")then
        Phi.FaceClass("OUTPUTMSG","COMPILOR_ERROR","yellow","red","Compilation failure,IO function setting error !")
    end
end

GUI.Form[3] = {}
GUI.Form[3].label = "Program"
GUI.Form[3].name = "PhiShell"
GUI.Form[3].taskbutton = "close"
GUI.Form[3].background_color = "black"
GUI.Form[3].icon_tcolor = "white"
GUI.Form[3].icon_bcolor = "gray"
GUI.Form[3].text_class = {
    {"Code Bar",2,GUI.TermHigh-3,"black","lightgray",true}
}
GUI.Form[3].box_class = {
    --GUI.DrawBox(x,y,w,h,color,model)
    {1,GUI.TermHigh-3,GUI.TermWide,1,"lightgray","filled"}
}
GUI.Form[3].textbox_class = {
    {"",1,GUI.TermHigh-2,GUI.TermWide,3,"white","black"}
}
GUI.Form[3].closerun = function() Phi.FaceLine = 3 end

function Control.PLCManager(func,num,param)
    if(func=="DRAW_INPUTIO_LAMP")then
        if(param == true)then
            GUI.SetButtonAttribute(4,"Bcolor",num,"orange")
        elseif(param == false)then
            GUI.SetButtonAttribute(4,"Bcolor",num,"black")
        end
    end
    if(func=="DRAW_OUTPUTIO_LAMP")then
        if(param == true)then
            GUI.SetButtonAttribute(4,"Bcolor",num+16,"lime")
        elseif(param == false)then
            GUI.SetButtonAttribute(4,"Bcolor",num+16,"black")
        end
    end
    if(func=="SetIOBoolOut")then
        if(Control.OutputIO_Count~=nil)then
            if(num<=Control.OutputIO_Count and num>0)then
                if(PortSet.OutputIO[num]["Value"]==0)then
                    Control.SetIOBool(num,true)
                    Control.PLCManager("DRAW_OUTPUTIO_LAMP",num,true)
                elseif(PortSet.OutputIO[num]["Value"]>0 and PortSet.OutputIO[num]["Value"]<=15)then
                    Control.SetIOBool(num,false)
                    Control.PLCManager("DRAW_OUTPUTIO_LAMP",num,false)
                end
            end
        end
    end
    if(func=="OutputIO_INFO")then
        if(Control.OutputIO_Count~=nil)then
            if(num<=Control.OutputIO_Count and num>0)then
                GUI.SetTextAttribute(4,"Text",4,string.format("IO Number:%d",num))
                GUI.SetTextAttribute(4,"Text",5,string.format("Value:%d",PortSet.OutputIO[num]["Value"]))
            end
        end
    end
    if(func=="InputIO_INFO")then
        if(Control.OutputIO_Count~=nil)then
            if(num<=Control.InputIO_Count and num>0)then
                GUI.SetTextAttribute(4,"Text",4,string.format("IO Number:%d",num))
                GUI.SetTextAttribute(4,"Text",5,string.format("Value:%d",PortSet.InputIO[num]["Value"]))
            end
        end
    end
end

local funchange = "input"

GUI.Form[4] = {}
GUI.Form[4].label = "Program"
GUI.Form[4].name = "PLC Automation"
GUI.Form[4].taskbutton = "close"
GUI.Form[4].background_color = "lightgray"
GUI.Form[4].icon_tcolor = "white"
GUI.Form[4].icon_bcolor = "blue"
GUI.Form[4].box_class = {
    {1,2,GUI.TermWide,5,"gray","filled"},
    {1,8,GUI.TermWide,5,"gray","filled"}
}
GUI.Form[4].button_class = {
    {"01",3,5,"white","black",function() Control.PLCManager("InputIO_INFO",1) end},
    {"02",6,5,"white","black",function() Control.PLCManager("InputIO_INFO",2) end},
    {"03",9,5,"white","black",function() Control.PLCManager("InputIO_INFO",3) end},
    {"04",12,5,"white","black",function() Control.PLCManager("InputIO_INFO",4) end},
    {"05",15,5,"white","black",function() Control.PLCManager("InputIO_INFO",5) end},
    {"06",18,5,"white","black",function() Control.PLCManager("InputIO_INFO",6) end},
    {"07",21,5,"white","black",function() Control.PLCManager("InputIO_INFO",7) end},
    {"08",24,5,"white","black",function() Control.PLCManager("InputIO_INFO",8) end},
    {"09",27,5,"white","black",function() Control.PLCManager("InputIO_INFO",9) end},
    {"10",30,5,"white","black",function() Control.PLCManager("InputIO_INFO",10) end},
    {"11",33,5,"white","black",function() Control.PLCManager("InputIO_INFO",11) end},
    {"12",36,5,"white","black",function() Control.PLCManager("InputIO_INFO",12) end},
    {"13",39,5,"white","black",function() Control.PLCManager("InputIO_INFO",13) end},
    {"14",42,5,"white","black",function() Control.PLCManager("InputIO_INFO",14) end},
    {"15",45,5,"white","black",function() Control.PLCManager("InputIO_INFO",15) end},
    {"16",48,5,"white","black",function() Control.PLCManager("InputIO_INFO",16) end},
    {"01",3,11,"white","black",function() Control.PLCManager("SetIOBoolOut",1) Control.PLCManager("OutputIO_INFO",1) end},
    {"02",6,11,"white","black",function() Control.PLCManager("SetIOBoolOut",2) Control.PLCManager("OutputIO_INFO",2) end},
    {"03",9,11,"white","black",function() Control.PLCManager("SetIOBoolOut",3) Control.PLCManager("OutputIO_INFO",3) end},
    {"04",12,11,"white","black",function() Control.PLCManager("SetIOBoolOut",4) Control.PLCManager("OutputIO_INFO",4) end},
    {"05",15,11,"white","black",function() Control.PLCManager("SetIOBoolOut",5) Control.PLCManager("OutputIO_INFO",5) end},
    {"06",18,11,"white","black",function() Control.PLCManager("SetIOBoolOut",6) Control.PLCManager("OutputIO_INFO",6) end},
    {"07",21,11,"white","black",function() Control.PLCManager("SetIOBoolOut",7) Control.PLCManager("OutputIO_INFO",7) end},
    {"08",24,11,"white","black",function() Control.PLCManager("SetIOBoolOut",8) Control.PLCManager("OutputIO_INFO",8) end},
    {"09",27,11,"white","black",function() Control.PLCManager("SetIOBoolOut",9) Control.PLCManager("OutputIO_INFO",9) end},
    {"10",30,11,"white","black",function() Control.PLCManager("SetIOBoolOut",10) Control.PLCManager("OutputIO_INFO",10) end},
    {"11",33,11,"white","black",function() Control.PLCManager("SetIOBoolOut",11) Control.PLCManager("OutputIO_INFO",11) end},
    {"12",36,11,"white","black",function() Control.PLCManager("SetIOBoolOut",12) Control.PLCManager("OutputIO_INFO",12) end},
    {"13",39,11,"white","black",function() Control.PLCManager("SetIOBoolOut",13) Control.PLCManager("OutputIO_INFO",13) end},
    {"14",42,11,"white","black",function() Control.PLCManager("SetIOBoolOut",14) Control.PLCManager("OutputIO_INFO",14) end},
    {"15",45,11,"white","black",function() Control.PLCManager("SetIOBoolOut",15) Control.PLCManager("OutputIO_INFO",15) end},
    {"16",48,11,"white","black",function() Control.PLCManager("SetIOBoolOut",16) Control.PLCManager("OutputIO_INFO",16) end},
    {"OK",44,14,"white","green",function()
        if(funchange=="input")then
            Control.PLCManager("InputIO_INFO",tonumber(GUI.GetTextbarAttribute(4,"temp",1)))
        elseif(funchange=="output")then
            Control.PLCManager("OutputIO_INFO",tonumber(GUI.GetTextbarAttribute(4,"temp",1)))
        end
    end},
    {"Input",24,16,"gray","orange",function()
        funchange = "input"
        GUI.SetButtonAttribute(4,"Tcolor",34,"gray")
        GUI.SetButtonAttribute(4,"Tcolor",35,"white")
    end},
    {"Output",30,16,"white","lime",function()
        funchange = "output"
        GUI.SetButtonAttribute(4,"Tcolor",34,"white")
        GUI.SetButtonAttribute(4,"Tcolor",35,"gray")
    end},
    {"Program Build on ESP40",24,18,"white","cyan",function() GUI.DrawText(3,7,"Minecraft is colorful because of you","lime","lightgray") end},
}
GUI.Form[4].text_class = {
    {"Input IO",3,3,"white","gray",true},
    {"Output IO",3,9,"white","gray",true},
    {"IO Information",3,14,"white","blue",true},
    {"IO Number:0",3,16,"white","lightgray",true},
    {"Value:0",3,18,"white","lightgray",true},
    {"Check IO:",24,14,"white","lightgray",true},
}
GUI.Form[4].textbar_class = {
    {nil,33,14,10,"onlynum"},
}
GUI.Form[4].textbox_class = {

}
GUI.Form[4]["init"] = function()
    if(Control.OutputIO_Count~=nil and Control.InputIO_Count~=nil)then
        for i=1,Control.OutputIO_Count do
            if(i<=16)then
                if(PortSet.OutputIO[i]["Value"]<=15 and PortSet.OutputIO[i]["Value"]>0)then
                    Control.PLCManager("DRAW_OUTPUTIO_LAMP",i,true)
                elseif(PortSet.OutputIO[i]["Value"]==0)then
                    Control.PLCManager("DRAW_OUTPUTIO_LAMP",i,false)
                end
            else
                break
            end
        end
    end
end
