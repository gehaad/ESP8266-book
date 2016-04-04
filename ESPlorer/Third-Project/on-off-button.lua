wifi.setmode(wifi.STATION)
wifi.sta.config("your ssid","your pass")
print(wifi.sta.getip())

led = 4
gpio.mode(led, gpio.OUTPUT)

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)

local buf = "";
        buf = buf.."HTTP/1.1 200 OK\n\n"
local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
end

local _GET = {}
if (vars ~= nil)then
for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
end
end
        buf = buf.."<!DOCTYPE HTML>"
        buf = buf.."<html><head>";
        buf = buf.."<meta charset=\"utf-8\">";
        buf = buf.."<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">";
        buf = buf.."<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">";
        buf = buf.."<script src=\"https://code.jquery.com/jquery-2.1.3.min.js\"></script>";
        buf = buf.."<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css\">";
        buf = buf.."</head><div class=\"container\">";
        buf = buf.."<h1>ِESP8266 Web Server</h1>";
        buf = buf.."<h2>led pin</h2>";
        buf = buf.."<div class=\"row\">";
        buf = buf.."<div class=\"col-md-2\"><a href=\"?pin=ON\" class=\"btn btn-block btn-lg btn-primary\" role=\"button\">ON</a></div>";
        buf = buf.."<div class=\"col-md-2\"><a href=\"?pin=OFF\" class=\"btn btn-block btn-lg btn-warning\" role=\"button\">OFF</a></div>";
        buf = buf.."</div></div>";
        buf = buf.."</html>"

if(_GET.pin == "ON")then
              gpio.write(led, gpio.HIGH);
elseif(_GET.pin == "OFF")then
              gpio.write(led, gpio.LOW);
end
        client:send(buf);
        client:close();
        
collectgarbage();
end)
end)
