#include <ESP8266WiFi.h>
#include "DHT.h"
#define DHTPIN 14

#define DHTTYPE DHT11   // DHT 11
//#define DHTTYPE DHT22   // DHT 22  (AM2302), AM2321
//#define DHTTYPE DHT21   // DHT 21 (AM2301)

const char* ssid = "your ssid";
const char* password = "your pass";

DHT dht(DHTPIN, DHTTYPE);
WiFiServer server(80);

void setup(){
  
Serial.begin(115200);
delay(10);

Serial.println("DHTxx test!");
dht.begin();

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
  
delay(1000);  

float h = dht.readHumidity(); 
float t = dht.readTemperature();
float f = dht.readTemperature(true);
  
if (isnan(h) || isnan(t) || isnan(f)) {
Serial.println("Failed to read from DHT sensor!");
return;
  }

float hif = dht.computeHeatIndex(f, h);
float hic = dht.computeHeatIndex(t, h, false);
  
WiFiClient client = server.available();
if (!client) {
return;
}
Serial.println("new client");

client.println("HTTP/1.1 200 OK");
client.println("Content-Type: text/html");
client.println("");

client.println("<meta http-equiv=\"refresh\" content=\"3\">");
client.println("<!DOCTYPE html>");
client.println("<html xmlns='http://www.w3.org/1999/xhtml'>");
client.println("<head>\n<meta charset='UTF-8'>");
client.println("<title>ESP8266 Temperature & Humidity DHT11 Sensor</title>");
client.println("</head>\n<body>");
client.println("<H2>ESP8266 & DHT11 Sensor</H2>");
client.println("<H3>Humidity / Temperature</H3>");
client.println("<pre>");
client.print("Humidity: "); 
client.print((float)h); client.println("%");
client.print("Temperature (Celsius): "); 
client.print((float)t); client.println("°C");
client.print("Temperature (Fahrenheit): ");
client.print((float)f); client.println("°F");
client.print("HeatIndex (Celsius): "); 
client.print((float)hic); client.println("°C");
client.print("HeatIndex (Fahrenheit): ");
client.print((float)hif); client.println("°F");
client.println("</pre>");
client.print("</body>\n</html>");
}
