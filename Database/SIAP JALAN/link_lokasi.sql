--Tabel untuk menyimpan link Gmap dari user
CREATE TABLE link_lokasi (
	id_linklokasi SERIAL PRIMARY KEY,
	id_laporan SERIAL REFERENCES buat_laporan(id_laporan),
	link_gmap VARCHAR(255) UNIQUE
);