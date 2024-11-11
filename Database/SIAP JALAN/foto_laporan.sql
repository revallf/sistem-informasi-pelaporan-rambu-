-- Tabel untuk foto bukti
CREATE TABLE foto_laporan (
    id_fotolapor SERIAL PRIMARY KEY,
    id_laporan INTEGER REFERENCES buat_laporan(id_laporan),
    foto_lapor bytea
);
