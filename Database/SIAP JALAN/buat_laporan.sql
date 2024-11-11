-- Tabel untuk membuat laporan
CREATE TABLE buat_laporan (
    id_laporan SERIAL PRIMARY KEY,
    nama_lapor VARCHAR(100) NOT NULL,
	nomor_whatsapp VARCHAR(15),
    tanggal DATE,
    jenis_laporan jenis_laporan_type[] DEFAULT '{}', -- Array untuk checkbox
    deskripsi_laporan TEXT,
	link_gmap varchar(255) UNIQUE,
	id_lokasi SERIAL REFERENCES lokasi(id_lokasi),
    nama_provinsi VARCHAR(20),
    nama_kabkota VARCHAR(20),
    nama_desalurah VARCHAR(40),
	foto_lapor bytea
);
