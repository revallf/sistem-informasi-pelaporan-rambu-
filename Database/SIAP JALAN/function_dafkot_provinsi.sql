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