require("miner");
local connectionUrl = ""; 
local args = {...}
local name = args[1]; 
local job = args[2];
local activeWebSocket;
local wsError; 

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
        ResponseHandler(activeWebSocket.recieve())
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
        os.sleep(60);
    end 
end 
function ResponseHandler(message)
    print("recieved message from server")
    local args = DecryptMessage(message);
    if (args["target"] == "UpdateInfo") then  
        print("UpdateInfo detected sending update response")
        local message = {}
        message["target"] = "UpdateInfo";
        message["name"] = name;
        message["Job"] = job
        message["currentlyWorking"] = false;
        PrepareMessageAndSend(message)
        print("sent update response")
    end
    if (args["target"] == "MineArea") then 
        print("minearea detected executing minearea")
        MineArea(args["length"],args["height"],args["width"],args["goUp"],args["goRight"])
    end
end 

function PrepareMessageAndSend(args)
    print("preparing message.")
    activeWebSocket.send(textutils.serialiseJSON(args))
    print("sent message")
end 

function DecryptMessage(message)
    print("decrypting response message.")
    return textutils.DecryptMessage(message)
end 

Main()