PortSet = {}
PortSet.InputIO = {}
PortSet.OutputIO = {}
PortSet.UpperID = false --false:disable Upper,or input upper id for connect to hmi
PortSet.BoolMode = true --true:anavalue>0 = true,0 is false,false:anavalue==15 = true,other value is false
PortSet.PowerButton = true --default is true if you want start with off.

PortSet.OutputIO[1] = {}
PortSet.OutputIO[1].name = "redstone_relay_4"
PortSet.OutputIO[1].side = "back"

PortSet.InputIO[1] = {}
PortSet.InputIO[1].name = "redstone_relay_5"
PortSet.InputIO[1].side = "back"
