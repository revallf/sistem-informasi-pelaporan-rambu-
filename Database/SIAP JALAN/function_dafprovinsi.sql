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