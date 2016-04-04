led=4
x=0
gpio.mode(led,gpio.OUTPUT)
tmr.alarm(0,1000,1,function()
if x==0 then
        x=1
        gpio.write(led,gpio.HIGH)
else
        x=0
        gpio.write(led,gpio.LOW)
end
end)
