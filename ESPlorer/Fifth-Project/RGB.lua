wifi.setmode(wifi.STATION)
wifi.sta.config("your ssid","your pass")
print(wifi.sta.getip())

r=2
g=3
b=4

gpio.mode(r,gpio.OUTPUT)
gpio.mode(g,gpio.OUTPUT)
gpio.mode(b,gpio.OUTPUT)
pwm.setup(r,1000,1023)
pwm.setup(g,1000,1023)
pwm.setup(b,1000,1023)
pwm.start(r)
pwm.start(g)
pwm.start(b)

function off()
pwm.setduty(r,1023)
pwm.setduty(g,1023)
pwm.setduty(b,1023)
end

function red()
pwm.setduty(r,0)
pwm.setduty(g,1023)
pwm.setduty(b,1023)
end

function green()
pwm.setduty(r,1023)
pwm.setduty(g,0)
pwm.setduty(b,1023)
end

function blue()
pwm.setduty(r,1023)
pwm.setduty(g,1023)
pwm.setduty(b,0)
end

function white()
pwm.setduty(r,0)
pwm.setduty(g,0)
pwm.setduty(b,0)
end

function yellow()
pwm.setduty(r,0)
pwm.setduty(g,0)
pwm.setduty(b,1023)
end

function aqua()
pwm.setduty(r,1023)
pwm.setduty(g,0)
pwm.setduty(b,0)
end

function pink()
pwm.setduty(r,0)
pwm.setduty(g,1023)
pwm.setduty(b,0)
end

function orange()
pwm.setduty(r,0)
pwm.setduty(g,433)
pwm.setduty(b,1023)
end

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
        buf = buf.."<h1>ِRGB controller</h1>";
        buf = buf.."<form role=\"form\">";
        buf = buf.."<div class=\"radio\">";
        buf = buf.."<label><input type=\"radio\" name=\"color\" value=\"off\" onclick=\"this.form.submit()\">off</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"color\" value=\"red\" onclick=\"this.form.submit()\">red</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"color\" value=\"green\" onclick=\"this.form.submit()\">green</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"color\" value=\"blue\" onclick=\"this.form.submit()\">blue</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"color\" value=\"white\" onclick=\"this.form.submit()\">white</input>";
        buf = buf.."</label></div>";
        buf = buf.."<div class=\"radio\">";
        buf = buf.."<label><input type=\"radio\" name=\"color\" value=\"yellow\" onclick=\"this.form.submit()\">yellow</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"color\" value=\"pink\" onclick=\"this.form.submit()\">pink</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"color\" value=\"orange\" onclick=\"this.form.submit()\">orange</input>";
        buf = buf.."<label><label><input type=\"radio\" name=\"color\" value=\"aqua\" onclick=\"this.form.submit()\">aqua</input>";     
        buf = buf.."</label></div>";
        buf = buf.."</form>";
        buf = buf.."</div>";
        buf = buf.."</html>"

if(_GET.color == "off")then
              off()
elseif(_GET.color == "red")then
              red()
elseif(_GET.color == "green")then
              green()          
elseif(_GET.color == "blue")then
              blue()
elseif(_GET.color == "white")then
              white()          
elseif(_GET.color == "yellow")then
              yellow()
elseif(_GET.color == "pink")then
              pink()          
elseif(_GET.color == "orange")then
              orange()
elseif(_GET.color == "aqua")then
              aqua()                                    
end

        client:send(buf)
        client:close()
        
collectgarbage()
end)
end)
