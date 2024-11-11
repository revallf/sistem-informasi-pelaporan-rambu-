-- Tabel untuk foto selesai
CREATE TABLE foto_kelar (
    id_fotoselesai SERIAL PRIMARY KEY,
    id_laporan INTEGER REFERENCES buat_laporan(id_laporan),
    foto_selesai bytea
);