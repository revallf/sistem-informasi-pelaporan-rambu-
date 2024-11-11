-- Membuat tabel untuk menyimpan data lokasi dari CSV
CREATE TABLE lokasi (
    id_lokasi SERIAL PRIMARY KEY,
    kode_provinsi VARCHAR(20),
    nama_provinsi VARCHAR(30),
    kode_kabkota VARCHAR(20),
    nama_kabkota VARCHAR(50),
    kode_desalurah VARCHAR(20),
    nama_desalurah VARCHAR(50)
);

-- Import data dari CSV bisa menggunakan fitur import di pgAdmin 4
-- atau menggunakan perintah COPY:
COPY lokasi(kode_provinsi, nama_provinsi, kode_kabkota, nama_kabkota, kode_desalurah, nama_desalurah) 
FROM 'E:\SIAP JALAN\lokasisiapjalan.csv'
DELIMITER ';' CSV HEADER;