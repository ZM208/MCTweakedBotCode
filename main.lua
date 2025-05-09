local miner = require("Miner");
local http = require("http")
local connectionUrl = ""; 
local name = args[1]; 
local activeWebSocket;
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
    if (message == "UpdateInfo") then  

    end
end 

function PrepareMessage()

end 

function DecryptMessage()

end 
Main()