#include <ESP8266WiFi.h>
 
const char* ssid = "your ssid";
const char* password = "your pass";
 
int led = 2;
int value = LOW;
WiFiServer server(80);

void setup(){
  
Serial.begin(115200);
delay(10);
pinMode(led, OUTPUT);
digitalWrite(led, LOW);

Serial.println();
Serial.println();
Serial.print("Connecting to ");
Serial.println(ssid);

WiFi.begin(ssid, password);
while (WiFi.status() != WL_CONNECTED) {
delay(500);
Serial.print(".");
}
Serial.println("");
Serial.println("WiFi connected");

server.begin();
Serial.println("Server started");
Serial.print("Use this URL to connect: ");
Serial.print("http://");
Serial.print(WiFi.localIP());
Serial.println("/");

}

void loop() {
  
WiFiClient client = server.available();
if (!client) {
return;
}
Serial.println("new client");

client.println("HTTP/1.1 200 OK");
client.println("Content-Type: text/html");
client.println("");

client.println("<!DOCTYPE HTML>");
client.println("<html>");
client.println("<head>");
client.println("<title>First Project</title>");
client.println("<meta charset=\"utf-8\">");
client.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
client.println("<link rel=\"stylesheet\" href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css\">");
client.println("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js\"></script>");
client.println("<script src=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js\"></script>");
client.println("</head>");

client.println("<body>");
client.println("<div class=\"container\">");
client.print("<h1>ESP8266 Web Server</h1>");
client.print("<p class=\"text-danger\">on-off Button:</p>"); 
client.print("<a href=\"/LED=ON\" class=\"btn btn-success\" role=\"button\">ON</a>");
client.print("<a href=\"/LED=OFF\" class=\"btn btn-danger\" role=\"button\">OFF</a>");
client.print("<br><br>");

client.println("Led pin is now: ");
if(value == HIGH) {
client.print("On");
} else {
client.print("Off");
}

client.println("</div>");
client.println("</body>");
client.println("</html>");

while(!client.available()){
delay(1);
}

String request = client.readStringUntil('\r');
Serial.println(request);
client.flush();

if (request.indexOf('/LED=ON') != -1) {
digitalWrite(led, HIGH);
value = HIGH;
}
if (request.indexOf('/LED=OFF') != -1) {
digitalWrite(led, LOW);
value = LOW;
}

delay(1);
Serial.println("Client disonnected");
Serial.println("");

}
