local miner = require("Miner");
local http = require("http")
local connectionUrl = ""; 
local name = args[1]; 
local job = args[2];
local activeWebSocket;
local textutils = require("textutils")
local wsError; 
function Main()
    while true do 
        if (wsError ~= nil) then 
            wsError = nil; 
            activeWebSocket = nil
        end 
        if (activeWebSocket == nil) then
            AttemptConnection()
        end 
        ResponseHandler(activeWebSocket.recieve())
    end 
end 


function AttemptConnection()
    while true do 
        activeWebSocket, wsError = http.websocket(connectionUrl);
        if (activeWebSocket and !wsError) then 
            return activeWebSocket;
        end 
        os.time().sleep(60);
    end 
end 
function ResponseHandler(message)
    local args = DecryptMessage(message);
    if (args["target"] == "UpdateInfo") then  
        local message = {}
        message["target"] = "UpdateInfo";
        message["name"] = name;
        message["Job"] = job
        message["currentlyWorking"] = false;
        PrepareMessageAndSend(message)
    end
    if (args["target"] == "MineArea") then 
        MineArea(args["length"],args["height"],args["width"],args["goUp"],args["goRight"])
    end
end 

function PrepareMessageAndSend(args)
     activeWebSocket.send(textutils.serialiseJSON(args))
end 

function DecryptMessage(message)
    return textutils.DecryptMessage(message)
end 
Main()