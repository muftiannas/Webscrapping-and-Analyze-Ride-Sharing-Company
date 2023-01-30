
--Urutan menurun = DESC
--Urutan naik    = ASC


--EDA
-------------------------------------------------------------------------------------Exploraatif Data Analytics------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Soal No 1
--Tampilkan kolom company_name. Temukan jumlah perjalanan taksi untuk setiap perusahaan taksi pada tanggal 15-16 November 2017. 
--Kemudian namakan kolom yang dihasilkan dengan trips_amount dan tampilkan juga kolom tersebut. Urutkan hasilnya berdasarkan kolom trips_amount dalam urutan menurun.

SELECT
    cabs.company_name AS company_name,
    COUNT(trips.trip_id) AS trips_amount
FROM
    cabs
    INNER JOIN trips on trips.cab_id = cabs.cab_id
WHERE
    trips.start_ts::date BETWEEN '2017-11-15' AND '2017-11-16'
GROUP BY
    cabs.company_name
ORDER BY
    trips_amount DESC


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Soal No 2
--Temukan jumlah perjalanan untuk setiap perusahaan taksi yang namanya memiliki unsur kata "Yellow" atau "Blue" pada tanggal 1-7 November 2017. 
--Namai variabel yang dihasilkan dengan trips_amount. Kelompokan hasilnya berdasarkan kolom company_name.

SELECT
    cabs.company_name AS company_name,
    COUNT(trips.trip_id) AS trips_amount
FROM
    cabs
    INNER JOIN trips ON trips.cab_id = cabs.cab_id
WHERE
    trips.start_ts::date BETWEEN '2017-11-01' AND '2017-11-07'
    AND cabs.company_name LIKE '%Yellow%'
GROUP BY
    cabs.company_name
UNION
SELECT
    cabs.company_name AS company_name,
    COUNT(trips.trip_id) AS trips_amount
FROM
    cabs
    INNER JOIN trips ON trips.cab_id = cabs.cab_id
WHERE
    trips.start_ts::date BETWEEN '2017-11-01' AND '2017-11-07'
        AND cabs.company_name LIKE '%Blue%'
GROUP BY
    cabs.company_name


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Soal No 3
--Untuk tanggal 1-7 November 2017, perusahaan taksi yang paling populer adalah Flash Cab dan Taxi Affiliation Services. 
--Temukan jumlah perjalanan untuk kedua perusahaan dan namai variabel yang dihasilkan dengan trips_amount. Gabungkan perjalanan dari semua perusahaan lainnya dalam satu kelompok: "Other".
--Kelompokkan data berdasarkan nama perusahaan taksi. Namai kolom yang memuat nama perusahaan taksi dengan company. Urutkan hasil yang Anda dapatkan dalam urutan menurun berdasarkan trips_amount.

SELECT
    CASE 
        WHEN cabs.company_name = 'Flash Cab' THEN 'Flash Cab'
        WHEN cabs.company_name = 'Taxi Affiliation Services' THEN 'Taxi Affiliation Services'
        ELSE 'Other'
    END AS company,
    COUNT(trips.trip_id) AS trips_amount
FROM
    cabs
    INNER JOIN trips ON trips.cab_id = cabs.cab_id
WHERE
    trips.start_ts::date BETWEEN '2017-11-01' AND '2017-11-07'
GROUP BY
    company
ORDER BY
    trips_amount DESC


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Soal No 4
--Ambil data tentang ID wilayah O'Hare dan Loop dari tabel neighborhoods.

SELECT
    neighborhoods.neighborhood_id AS neighborhood_id,
    neighborhoods.name AS name
FROM
    neighborhoods
WHERE
    neighborhoods.name LIKE '%Hare%' OR neighborhoods.name LIKE 'Loop'


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Soal No 5
--Untuk setiap jam, ambil catatan kondisi cuaca dari tabel weather_records. Dengan menggunakan operator CASE, bagi semua jam menjadi dua kelompok: 
--Bad jika kolom description berisi kata rain atau storm, dan Good untuk sisanya yang tidak memuat kedua kata tersebut. Namai kolom yang dihasilkan dengan weather_conditions. 
--Tabel akhir harus memuat dua kolom: tanggal dan jam (ts), serta weather_conditions.

SELECT
    weather_records.ts AS ts,
    CASE
        WHEN weather_records.description LIKE '%rain%'
            OR weather_records.description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
    END AS weather_conditions
 FROM
     weather_records


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Soal No 6
--Ambil dari tabel trips semua perjalanan yang dimulai di Loop (pickup_location_id: 50) pada hari Sabtu dan berakhir di O'Hare (dropoff_location_id: 63). 
--Dapatkan kondisi cuaca untuk setiap perjalanan. Gunakan metode yang Anda terapkan di tugas sebelumnya. Serta, ambil juga durasi untuk setiap perjalanan. Abaikan perjalanan yang data kondisi cuacanya tidak tersedia.
--Kolom-kolom pada tabel seharusnya ditampilkan dalam urutan berikut:
--start_ts
--weather_conditions
--duration_seconds
--Urutkan berdasarkan trip_id.

SELECT
    trips.start_ts,
    CASE
        WHEN weather_records.description LIKE '%rain%'
            OR weather_records.description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
    END AS weather_conditions,
    trips.duration_seconds AS duration_seconds
 FROM
     trips 
     INNER JOIN weather_records ON trips.start_ts = weather_records.ts
WHERE
    trips.pickup_location_id = 50
    AND trips.dropoff_location_id = 63
    AND EXTRACT(DOW from trips.start_ts) = 6
ORDER BY
    trips.trip_id

    
