require("miner");
local connectionUrl = ""; -- your websocket server url here
local args = {...}
local name = args[1]; 
local job = args[2];
activeWebSocket = nil;
wsError = nil ; 
function Main()
    while true do 
      print("checking websocket connection")
        if (wsError ~= nil) then 
          print("error detected: " + wsError)
            wsError = nil; 
            activeWebSocket = nil
        end 
        if (activeWebSocket == nil) then
            print("websocket not detected starting connection attempt.")
            AttemptConnection()
        end
        if not pcall(WaitForMessage) then 
            activeWebSocket = nil
            end
    end  
end 
 
function WaitForMessage()
    local message = activeWebSocket.receive()
    if (message ~= nil) then
        ResponseHandler(message)
    end 
end 
function AttemptConnection()
    while true do 
        print("attempting to connect to websocket")
        activeWebSocket, wsError = http.websocket(connectionUrl);
        if (activeWebSocket and not wsError) then 
            return activeWebSocket;
        end 
        print("failed to connect. Trying again in 60 secs.")
        Sleep(60);
    end 
end 
function ResponseHandler(message)
print(message)
     args = DecryptMessage(message);
    print(args)
    if (args["Target"] == "UpdateInfo") then  
        local message = {}
        message["Target"] = "UpdateInfo";
        message["Name"] = name;
        message["Job"] = job
        message["CurrentlyWorking"] = false;
        PrepareMessageAndSend(message)
    end
    if (args["Command"] == "MineArea") then 
        MineArea(args["Length"],args["Height"],args["Width"],args["GoUp"],args["GoRight"])
    end
end 

function PrepareMessageAndSend(args)
     activeWebSocket.send(textutils.serialiseJSON(args))
end 

function DecryptMessage(message)
    return  textutils.unserialiseJSON(message)
end 
function Sleep(seconds)
    os.sleep(seconds)
end 
Main() 
