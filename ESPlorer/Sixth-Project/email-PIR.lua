wifi.setmode(wifi.STATION)
wifi.sta.config("your ssid","your pass")
pin = 4   
gpio.mode(pin, gpio.INT)

function onChange ()
    
    print('Motion Detected')
    conn = nil
    conn=net.createConnection(net.TCP, 0)
    conn:on("receive", function(conn, payload) end)
    conn:connect(80,"maker.ifttt.com")
    conn:on("connection", function(conn, payload)
        conn:send("POST /trigger/motion_detected/with/key/YOUR_API_KEY HTTP/1.1\r\nHost: maker.ifttt.com\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n") end)
    conn:close()
    print('Email Sent')
end
gpio.trig(pin, 'up', onChange)
