-- Function untuk mendapatkan daftar desa berdasarkan kota
CREATE OR REPLACE FUNCTION get_desalurah(p_kode_kabkota VARCHAR)
RETURNS TABLE (kode_desalurah VARCHAR, nama_desalurah VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT DISTINCT l.kode_desalurah, l.nama_desalurah 
    FROM lokasi l
    WHERE l.kode_kabkota = p_kode_kabkota
    ORDER BY l.nama_desalurah;
END;
$$ LANGUAGE plpgsql;