-- Membuat tabel untuk menyimpan data lokasi dari CSV
CREATE TABLE lokasi (
    id_lokasi SERIAL PRIMARY KEY,
    kode_provinsi VARCHAR(100),
    nama_provinsi VARCHAR(100),
    kode_kabkota VARCHAR(100),
    nama_kabkota VARCHAR(100),
    kode_desalurah VARCHAR(100),
    nama_desalurah VARCHAR(100)
);

-- Import data dari CSV bisa menggunakan fitur import di pgAdmin 4
-- atau menggunakan perintah COPY:
COPY lokasi(kode_provinsi, nama_provinsi, kode_kabkota, nama_kabkota, kode_desalurah, nama_desalurah) 
FROM 'E:\DOCUMENTS\lokasisiapjalan.csv'
DELIMITER ';' CSV HEADER;

CREATE TYPE jenis_laporan_type AS ENUM ('usulan', 'perbaikan');
CREATE TYPE status_laporan_type AS ENUM ('verifikasi', 'tindak_lanjut', 'selesai');

-- Tabel untuk admin
CREATE TABLE login_admin (
    id_admin SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Tabel untuk identitas pelapor
CREATE TABLE identitas_lapor (
    id_identitas SERIAL PRIMARY KEY,
    nama_lapor VARCHAR(100) NOT NULL,
    nomor_whatsapp VARCHAR(15)
);

-- Tabel untuk membuat laporan
CREATE TABLE buat_laporan (
    id_laporan SERIAL PRIMARY KEY,
	id_identitas INTEGER REFERENCES identitas_lapor(id_identitas),
    nama_lapor VARCHAR(100) NOT NULL,
	nomor_whatsapp VARCHAR(15),
    tanggal DATE,
    jenis_laporan jenis_laporan_type[] DEFAULT '{}', -- Array untuk checkbox
    deskripsi_laporan TEXT,
	link_gmap varchar(255),
	id_lokasi SERIAL REFERENCES lokasi(id_lokasi),
    nama_provinsi VARCHAR(20),
    nama_kabkota VARCHAR(20),
    nama_desalurah VARCHAR(40),
	foto_lapor bytea
);

-- Tabel untuk foto bukti
CREATE TABLE foto_laporan (
    id_fotolapor SERIAL PRIMARY KEY,
    id_laporan INTEGER REFERENCES buat_laporan(id_laporan),
    foto_lapor bytea
);

-- Tabel untuk foto tindak lanjut
CREATE TABLE foto_tinlan (
    id_fototinjut SERIAL PRIMARY KEY,
    id_laporan INTEGER REFERENCES buat_laporan(id_laporan),
    foto_tinjut bytea
);

-- Tabel untuk foto selesai
CREATE TABLE foto_kelar (
    id_fotoselesai SERIAL PRIMARY KEY,
    id_laporan INTEGER REFERENCES buat_laporan(id_laporan),
    foto_selesai bytea
);

-- Tabel untuk menampilkan laporan-laporan yang telah dibuat
CREATE TABLE hasil_laporan (
    id_hasil SERIAL PRIMARY KEY,
	id_laporan SERIAL REFERENCES buat_laporan(id_laporan),
	id_identitas INTEGER REFERENCES identitas_lapor(id_identitas),
    nama_lapor VARCHAR(100) NOT NULL,
    tanggal DATE,
    jenis_laporan jenis_laporan_type,
	status_laporan status_laporan_type,
    deskripsi_laporan TEXT,
	link_gmap varchar(255),
	id_lokasi SERIAL REFERENCES lokasi(id_lokasi),
    nama_provinsi VARCHAR(20),
    nama_kabkota VARCHAR(20),
    nama_desalurah VARCHAR(40),
	id_fotolapor integer REFERENCES foto_laporan(id_fotolapor),
	foto_lapor bytea,
	id_fototinjut integer REFERENCES foto_tinlan(id_fototinjut),
	foto_tinjut bytea,
	id_fotoselesai integer REFERENCES foto_kelar(id_fotoselesai),
	foto_selesai bytea
);

-- Tabel untuk menampilkan laporan-laporan yang telah dibuat dari sisi admin
CREATE TABLE hasil_laporan_admin (
    id_hasil SERIAL PRIMARY KEY,
	id_admin SERIAL REFERENCES login_admin(id_admin),
	id_laporan SERIAL REFERENCES buat_laporan(id_laporan),
	id_identitas INTEGER REFERENCES identitas_lapor(id_identitas),
    nama_lapor VARCHAR(100) NOT NULL,
	nomor_whatsapp VARCHAR(15),
    tanggal DATE,
    jenis_laporan jenis_laporan_type,
	status_laporan status_laporan_type,
    deskripsi_laporan TEXT,
	link_gmap varchar(255),
	id_lokasi SERIAL REFERENCES lokasi(id_lokasi),
    nama_provinsi VARCHAR(20),
    nama_kabkota VARCHAR(20),
    nama_desalurah VARCHAR(40),
	id_fotolapor integer REFERENCES foto_laporan(id_fotolapor),
	foto_lapor bytea,
	id_fototinjut integer REFERENCES foto_tinlan(id_fototinjut),
	foto_tinjut bytea,
	id_fotoselesai integer REFERENCES foto_kelar(id_fotoselesai),
	foto_selesai bytea
);

-- view untuk mempermudah pengambilan data
CREATE VIEW view_laporan AS
SELECT 
    bl.id_laporan,
	bl.id_identitas,
    il.nama_lapor,
    il.nomor_whatsapp,
    bl.tanggal,
    bl.jenis_laporan,
	bl.link_gmap,
	bl.id_lokasi,
    lh.nama_provinsi,
    lh.nama_kabkota,
    lh.nama_desalurah,
    bl.deskripsi_laporan,
    fl.foto_lapor
FROM buat_laporan bl
JOIN identitas_lapor il ON bl.id_identitas = il.id_identitas
JOIN lokasi lh ON 
    bl.nama_provinsi = lh.nama_provinsi AND
    bl.nama_kabkota = lh.nama_kabkota AND
    bl.nama_desalurah = lh.nama_desalurah
JOIN foto_laporan fl ON fl.foto_lapor = fl.foto_lapor
;

-- Function untuk mendapatkan daftar provinsi
CREATE OR REPLACE FUNCTION get_provinsi()
RETURNS TABLE (kode_provinsi VARCHAR, nama_provinsi VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT l.kode_provinsi, l.nama_provinsi 
    FROM lokasi l
    ORDER BY l.nama_provinsi;
END;
$$ LANGUAGE plpgsql;

-- Function untuk mendapatkan daftar kota berdasarkan provinsi
CREATE OR REPLACE FUNCTION get_kabkota(p_kode_provinsi VARCHAR)
RETURNS TABLE (kode_kabkota VARCHAR, nama_kabkota VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT l.kode_kabkota, l.nama_kabkota 
    FROM lokasi l
    WHERE l.kode_provinsi = p_kode_provinsi
    ORDER BY l.nama_kabkota;
END;
$$ LANGUAGE plpgsql;

-- Function untuk mendapatkan daftar desa berdasarkan kota
CREATE OR REPLACE FUNCTION get_desalurah(p_kode_kabkota VARCHAR)
RETURNS TABLE (kode_desalurah VARCHAR, nama_desalurah VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT l.kode_desalurah, l.nama_desalurah 
    FROM lokasi l
    WHERE l.kode_kabkota = p_kode_kabkota
    ORDER BY l.nama_desalurah;
END;
$$ LANGUAGE plpgsql;