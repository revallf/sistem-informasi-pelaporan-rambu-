-- Tabel untuk admin
CREATE TABLE login_admin (
    id_admin SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Jika ingin menambah admin ubah '4DM1N' dan 'S14PJ4L4N' menjadi username dan password yang diinginkan
INSERT INTO login_admin(username, password) 
	values ('4DM1N', 'S14PJ4L4N');
