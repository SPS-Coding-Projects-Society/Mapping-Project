#Get API key by signing up to this site: https://home.openweathermap.org/ and then going to API keys, copying the API key and assigning it to the variable key

import pyowm  # pip install pyowm

k = 1 #Set key
owm = pyowm.OWM(k)

observation = owm.weather_at_place('London,UK') #set weather observation in london

w = observation.get_weather() #get weather data

temp = w.get_temperature('celsius') #current temperature in celsius
wind = w.get_wind()

status = w.get_status().lower()  #general weather status
d_status = w.get_detailed_status().lower()  #slightly more detailed weather status

print(f'Wind: {wind}')
print(f'Temperature: {temp}')
print(f'Basic status: {status}')
print(f'Detailed status: {d_status}')
