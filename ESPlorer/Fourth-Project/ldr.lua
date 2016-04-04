wifi.setmode(wifi.STATION)
wifi.sta.config("your ssid","your pass")
print(wifi.sta.getip())
tmr.delay(1000000)

ldr_value=0
percent_light=0
percent_dark=0
bimb=1

function ldr()
ldr_value = adc.read(0)
percent_light = ldr_value*(100/1024)
percent_dark = 100 - percent_light
end

tmr.alarm(1,5000, 1, function() 
ldr() bimb=bimb+1 
if bimb==5 then bimb=0 wifi.sta.connect() print("Reconnect")
end 
end)

srv=net.createServer(net.TCP) srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
   
conn:send('HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n\
        <!DOCTYPE HTML>\
        <html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"></head>\
        <meta http-equiv="X-UA-Compatible" content="IE=edge">\
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">\
        <meta http-equiv="refresh" content="6">\
        </head><div class="container">\
        <h1>Sensor Data</h1></br><div class="row">\
        <div class="col-md-4"><div class="panel panel-primary"><div class="panel-heading"><h3 class="panel-title">ldr value</h3>\
        </div><div class="panel-body">\
        <div class="form-group form-group-lg"><input type="text" class="form-control" value="'..ldr_value..'">\
        </div></div></div></div>\
        <div class="col-md-4"><div class="panel panel-success"><div class="panel-heading"><h3 class="panel-title">the percentage</h3>\
        </div><div class="panel-body">\
        <div class="form-group form-group-lg"><input type="text" class="form-control" value="light percent = '..percent_light..' %">\
        <input type="text" class="form-control" value="dark percent = '..percent_dark..' %">\
        </div></div></div></div></div></div></html>')
    conn:on("sent",function(conn) conn:close() end)
    end)
end)
