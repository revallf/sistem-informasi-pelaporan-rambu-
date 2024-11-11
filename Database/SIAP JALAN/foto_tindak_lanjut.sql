-- Tabel untuk foto tindak lanjut
CREATE TABLE foto_tinlan (
    id_fototinjut SERIAL PRIMARY KEY,
    id_laporan INTEGER REFERENCES buat_laporan(id_laporan),
    foto_tinjut bytea
);