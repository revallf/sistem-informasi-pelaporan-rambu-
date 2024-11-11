-- Tabel untuk identitas pelapor
CREATE TABLE identitas_lapor (
    id_identitas SERIAL PRIMARY KEY,
	id_laporan SERIAL REFERENCES buat_laporan(id_laporan),
    nama_lapor VARCHAR(100) NOT NULL,
    nomor_whatsapp VARCHAR(15)
);