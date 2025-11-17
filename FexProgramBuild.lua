require("FexCore")
require("FexIO")
Program = {}
GUI.ShowClickPosTemp = false

local temp1 = 0
local function showpgb(percent)
    if(percent>=0 and percent<=4)then
        GUI.SetProgressbarAttribute(GUI.GetFormAccess("my App"),"percent",1,percent,false)
        GUI.SetProgressbarAttribute(GUI.GetFormAccess("my App"),"color",1,"red",true)
    elseif(percent>=5 and percent<=11)then
        GUI.SetProgressbarAttribute(GUI.GetFormAccess("my App"),"percent",1,percent,false)
        GUI.SetProgressbarAttribute(GUI.GetFormAccess("my App"),"color",1,"orange",true)
    elseif(percent>=12 and percent<=15)then
        GUI.SetProgressbarAttribute(GUI.GetFormAccess("my App"),"percent",1,percent,false)
        GUI.SetProgressbarAttribute(GUI.GetFormAccess("my App"),"color",1,"lime",true)
    end
end

local testapp = {}
testapp.label = "Program"
testapp.name = "my App"
testapp.background_color = "lightgray"
testapp.icon_tcolor = "white"
testapp.icon_bcolor = "red"
testapp.taskbutton = "close"
testapp.text_class = {
    {"Hello world !",2,3,"white","lightgray",true},
    {"Nice to meet you !",2,5,"blue","lightgray",true}
}
testapp.button_class = {
    {"Click here",21,3,"white","green",function()
        GUI.SetTextAttribute(GUI.GetFormAccess("my App"),"Tcolor",1,"pink",true)
        GUI.SetButtonAttribute(GUI.GetFormAccess("my App"),"Tcolor",1,"black",true)
        GUI.SetButtonAttribute(GUI.GetFormAccess("my App"),"Bcolor",1,"gray",true)
    end},
    {" - ",23,7,"white","gray",function()
        temp1 = temp1 - 1
        if(temp1>=0 and temp1<=15)then
            showpgb(temp1)
        elseif(temp1<0)then
            temp1 = 0
            showpgb(temp1)
        end
    end},
    {" + ",27,7,"white","gray",function()
        temp1 = temp1 + 1
        if(temp1>=0 and temp1<=15)then
            showpgb(temp1)
        elseif(temp1>15)then
            temp1 = 15
            showpgb(temp1)
        end
    end},
}
testapp.switch_class = {
    {"2Set",21,5,true,function()
        if(GUI.GetSwitchAttribute(GUI.GetFormAccess("my App"),"sign",1)==true)then
            GUI.SetTextAttribute(GUI.GetFormAccess("my App"),"Tcolor",2,"blue",true)
        elseif(GUI.GetSwitchAttribute(GUI.GetFormAccess("my App"),"sign",1)==false)then
            GUI.SetTextAttribute(GUI.GetFormAccess("my App"),"Tcolor",2,"red",true)
        end
    end},
}
testapp.progressbar_class = {
    {"PGBar",2,7,temp1,"lime","Trans"}
}
testapp.textbar_class = {
    {nil,2,9,28}
}
testapp.textbox_class = {
    {"hello world",2,11,20,8,"black","white",1}
}
testapp.keypress = function(key)
    if(key=="enter")then
        GUI.SetTextAttribute(GUI.GetFormAccess("my App"),"Tcolor",1,"magenta",true)
    end
end

local app2 = {}
app2.label = "Program"
app2.name = "(0v0)"
app2.background_color = "yellow"
app2.icon_tcolor = "black"
app2.icon_bcolor = "yellow"
app2.taskbutton = "close"
app2.button_class = {
    {"Click Me",2,3,"magenta","orange",function()
        GUI.SetButtonAttribute(GUI.GetFormAccess("(0v0)"),"x",1,math.random(1,GUI.TermWide - string.len(GUI.GetButtonAttribute(GUI.GetFormAccess("(0v0)"),"name",1))),false)
        GUI.SetButtonAttribute(GUI.GetFormAccess("(0v0)"),"y",1,math.random(2,GUI.TermHigh),false)
        GUI.DrawForm(GUI.GetFormAccess("(0v0)"))
    end}
}


local app3 = {}
app3.label = "Program"
app3.name = "A Program"
app3.background_color = "lightgray"
app3.icon_tcolor = "black"
app3.icon_bcolor = "magenta"
app3.taskbutton = "close"
app3.page_class = {
    [1] = {
        page_name = "Main",
        box_class = {
            {1,5,GUI.TermWide,1,"white","filled"},
        },
        button_class = {
            {"Click Me",2,7,"magenta","gray",function()
                GUI.SetPageTextAttribute(GUI.GetFormAccess("Dingzhen"),1,"Tcolor",2,"pink",true)
                GUI.SetPageButtonAttribute(GUI.GetFormAccess("Dingzhen"),1,"Bcolor",1,"pink",true)
            end}
        },
        switch_class = {
            {"2Set",2,5,true,function()
                if(GUI.GetPageSwitch(GUI.GetFormAccess("Dingzhen"),1,"sign",1)==true)then
                    GUI.SetPageText(GUI.GetFormAccess("Dingzhen"),1,"Tcolor",1,"green",true)
                elseif(GUI.GetPageSwitch(GUI.GetFormAccess("Dingzhen"),1,"sign",1)==false)then
                    GUI.SetPageText(GUI.GetFormAccess("Dingzhen"),1,"Tcolor",1,"red",true)
                end
            end},
        },
        text_class = {
            {"Hello World!!!",2,3,"white","lightgray",true},
            {"Nice to meet you!!",2,4,"red","lightgray",true},
        },
        textbar_class = {
            {nil,2,9,28}
        }
    },
    [2] = {
        page_name = "Info",
        text_class = {
            {"Phineon Logmatic FEX 0.2.6",2,4,"white","lightgray",true},
        },
        textbox_class = {
            {"No one s born being good at all things. You become good at things through hard work. You re not a varsity athlete the first time you play a new sport.",2,6,20,6,"white","black",1}
        }
    },
    [3] = {
        page_name = "BimBam",
        text_class = {
            {"Hello World I'm Gay",2,4,"magenta","pink",true},
        },
        textbar_class = {
            {nil,2,6,18}
        },
        switch_class = {
            {"2Set",2,9,true}
        },
    }
}
app3.page_num = 1

function Program.INIT()
    GUI.AccessForm(testapp)
    GUI.AccessForm(app2)
    GUI.AccessForm(app3)
end
