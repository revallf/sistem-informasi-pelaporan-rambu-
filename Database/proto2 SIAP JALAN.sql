-- Membuat tipe enum untuk status laporan
CREATE TYPE status_enum AS ENUM ('Proses', 'Verifikasi', 'Tindak Lanjut', 'Selesai');

-- Membuat tipe enum untuk jenis laporan  
CREATE TYPE jenis_enum AS ENUM ('Usulan', 'Perbaikan');

-- Membuat tabel untuk provinsi
CREATE TABLE lokasi_provinsi (
    id_provinsi SERIAL PRIMARY KEY,
    nama_provinsi VARCHAR(100) NOT NULL
);

-- Membuat tabel untuk kota
CREATE TABLE lokasi_kota (
    id_kota SERIAL PRIMARY KEY, 
    id_provinsi INTEGER REFERENCES lokasi_provinsi(id_provinsi),
    nama_kota VARCHAR(100) NOT NULL
);

-- Membuat tabel untuk desa
CREATE TABLE lokasi_desa (
    id_desa SERIAL PRIMARY KEY,
    id_kota INTEGER REFERENCES lokasi_kota(id_kota),
    nama_desa VARCHAR(100) NOT NULL
);

-- Membuat tabel pelapor
CREATE TABLE identitas_lapor (
    id_identitas INTEGER PRIMARY KEY,
    nama_lapor VARCHAR(50) NOT NULL,
    no_whatsapp VARCHAR(15) NOT NULL
);

-- Membuat tabel admin
CREATE TABLE login_admin (
    id_admin INTEGER PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Membuat tabel laporan
CREATE TABLE buat_laporan (
    id_lapor SERIAL PRIMARY KEY,
    id_identitas INTEGER REFERENCES identitas_lapor(id_identitas),
    tanggal DATE NOT NULL DEFAULT CURRENT_DATE,
    jenis_laporan jenis_enum NOT NULL,
    id_provinsi INTEGER REFERENCES lokasi_provinsi(id_provinsi),
    id_kota INTEGER REFERENCES lokasi_kota(id_kota),
    id_desa INTEGER REFERENCES lokasi_desa(id_desa),
    lokasi_maps TEXT,
    deskripsi TEXT NOT NULL,
    status status_enum DEFAULT 'Proses',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Membuat tabel foto bukti
CREATE TABLE foto_lapor (
    id_foto SERIAL PRIMARY KEY,
    id_lapor INTEGER REFERENCES buat_laporan(id_lapor),
    jenis_bukti VARCHAR(20) CHECK (jenis_bukti IN ('Tindak Lanjut', 'Selesai')),
    url_foto TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger untuk mengupdate updated_at saat ada perubahan
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_buat_laporan_updated_at
    BEFORE UPDATE
    ON buat_laporan
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data provinsi
INSERT INTO lokasi_provinsi (nama_provinsi) VALUES 
('Jawa Barat'),
('DKI Jakarta'),
('Jawa Tengah');

-- Insert sample data kota
INSERT INTO lokasi_kota (id_provinsi, nama_kota) VALUES 
(1, 'Bandung'),
(1, 'Bogor'),
(2, 'Jakarta Selatan');

-- Insert sample data desa
INSERT INTO lokasi_desa (id_kota, nama_desa) VALUES 
(1, 'Babakan'),
(1, 'Cicurug'),
(2, 'Cikereteg');

-- Insert sample admin
INSERT INTO login_admin (id_admin, username, password) VALUES
(1, 'admin', 'admin123'); -- Dalam implementasi nyata gunakan password yang di-hash

-- Insert sample pelapor
INSERT INTO identitas_lapor (id_identitas, nama_lapor, no_whatsapp) VALUES
(1, 'Jajang', '087835768397'),
(2, 'Mput', '084327856487'),
(3, 'Acep', '084324868787');

-- Insert sample laporan
INSERT INTO buat_laporan (
    id_identitas, 
    tanggal, 
    jenis_laporan,
    id_provinsi,
    id_kota,
    id_desa,
    lokasi_maps,
    deskripsi,
    status
) VALUES
(1, '2024-05-24', 'Usulan', 1, 1, 1, 'https://maps.app', 'Tidak ada Rambu pada tikunngan tajam ini, sangat membahayakan', 'Selesai'),
(2, '2024-05-14', 'Perbaikan', 1, 1, 2, 'https://maps.app', 'Tidak ada Rambu pada tikunngan tajam ini', 'Verifikasi'),
(3, '2024-08-28', 'Usulan', 1, 2, 3, 'https://maps.app', 'Tidak ada Rambu pada tikunngan tajam ini', 'Proses');

-- Query untuk menampilkan daftar laporan (foto 3 & 6)
SELECT 
    b.id_lapor,
    i.nama_lapor,
    b.tanggal,
    i.no_whatsapp,
    b.jenis_laporan,
    d.nama_desa,
    b.lokasi_maps,
    b.deskripsi,
    b.status
FROM buat_laporan b
JOIN identitas_lapor i ON b.id_identitas = i.id_identitas
JOIN lokasi_desa d ON b.id_desa = d.id_desa
ORDER BY b.tanggal DESC;

-- Query untuk detail laporan (foto 4 & 7)
SELECT 
    b.id_lapor,
    i.nama_lapor,
    b.tanggal,
    d.nama_desa,
    b.lokasi_maps,
    b.deskripsi,
    b.status,
    f.url_foto,
    f.jenis_bukti
FROM buat_laporan b
JOIN identitas_lapor i ON b.id_identitas = i.id_identitas
JOIN lokasi_desa d ON b.id_desa = d.id_desa
LEFT JOIN foto_lapor f ON b.id_lapor = f.id_lapor
WHERE b.id_lapor = [id_laporan];