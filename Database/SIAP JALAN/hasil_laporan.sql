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
	id_linklokasi SERIAL REFERENCES link_lokasi(id_linklokasi),
	link_gmap varchar(255) UNIQUE,
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
