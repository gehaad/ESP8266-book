led=4
c=0
x=0

gpio.mode(led,gpio.OUTPUT)
pwm.setup(led,1000,0)
pwm.start(led)

for x=0,2,1 do

for c=0,1023,1 do

pwm.setduty(led,c)
tmr.delay(1000)
end

for c=1023,0,-1 do

pwm.setduty(led,c)
tmr.delay(1000)
end

end
