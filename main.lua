local miner = require("Miner");
local os = require("os")
local http = require("http")

function Main()
    while true do 
        if (!ws) then
            AttemptConnection("")
        end 
        ws.recieve()
    end 
end 


function AttemptConnection(connectionUrl)
    while true do 
        local ws, wsError = http.websocket(connectionUrl);
        if (ws and !wsError) then 
            return ws;
        end 
        os.time().sleep(60);
    end 
end 
