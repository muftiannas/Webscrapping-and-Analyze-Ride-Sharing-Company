#Anda bekerja sebagai seorang analis untuk Zuber, sebuah perusahaan berbagi tumpangan (ride-sharing) baru yang diluncurkan di Chicago. Tugas Anda adalah untuk menemukan pola pada informasi yang tersedia. 
#Anda ingin memahami preferensi penumpang dan dampak faktor eksternal terhadap perjalanan.
#Anda akan mempelajari basis data, menganalisis data dari kompetitor, dan menguji hipotesis tentang pengaruh cuaca terhadap frekuensi perjalanan.
#Pada tugas kali ini, Anda akan menyelesaikan langkah pertama dari proyek.

import pandas as pd
import requests
from bs4 import BeautifulSoup

URL = 'https://code.s3.yandex.net/data-analyst-eng/chicago_weather_2017.html' 
req = requests.get(URL)
soup = BeautifulSoup(req.text, 'lxml')

#print(req.text, 'lxml')

#-------------------------------------------------------------------------------

web_table = soup.find("table",attrs={"id": "weather_records"})

#Untuk dataframe Kolom
web_table_head = []
for row in  web_table.find_all('th'):
    web_table_head.append(row.text)

#print(web_table_head)

#-------------------------------------------------------------------------------

#Untuk dataframe Baris
web_table_data = []
for row in  web_table.find_all('tr'):
    if not row.find_all('th'):
        web_table_data.append([element.text for element in row.find_all('td')])

#print(web_table_data)

#-------------------------------------------------------------------------------

#Membuat dataframe
weather_records = pd.DataFrame(web_table_data, columns=web_table_head)
print(weather_records)




