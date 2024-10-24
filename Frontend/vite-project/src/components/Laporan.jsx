import React from 'react';
import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import { Carousel, NavLink } from 'react-bootstrap';
import './Laporan.css';
import logo from '../assets/logonew.png';       
import { Link } from 'react-router-dom';
import { useNavigate } from 'react-router-dom';

const Laporan = () => {
  const navigate = useNavigate()
  
  return (
    <div>
      {/* Navbar */}
      <nav className="navbar">
            <div className="container">
              <div className="navbar-logo"></div>
              <img src={logo} alt="Logo" className='logo' />
              <ul className="nav-links">
              <NavLink
                to="/"
                className={({ isActive}) => isActive ? 'nav-link active' : 'nav-link'}>
                <li onClick={() => navigate('/')} ><a href="#home">Beranda</a></li>
                    
              </NavLink>
              <NavLink
                to="/"
                className={({ isActive}) => isActive ? 'nav-link active' : 'nav-link'}>
                <li onClick={() => navigate('/Laporpage')}><a href="#about">Laporan</a></li>
              </NavLink>
              <NavLink
                to="/"
                className={({ isActive}) => isActive ? 'nav-link active' : 'nav-link'}>
                <li onClick={() => navigate('/StatusLaporPage')}><a href="#services">Status Pelaporan</a></li>
              </NavLink>
              
              </ul>
            </div> 
          </nav>

          <form className="form-laporan">
      <div className="form-group">
        <label>Tanggal</label>
        <input type="date" className="form-control" />
      </div>

      <div className="form-group">
        <label>Lokasi (Desa, Kota, Provinsi)</label>
        <input type="text" className="form-control" placeholder="Lokasi" />
      </div>

      <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
        <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked></input>
        <label class="btn btn-outline-warning" for="btnradio1">Usulan</label>

        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off"></input>
        <label class="btn btn-outline-warning" for="btnradio2">Perbaikan</label>
      </div>

      <div className="form-group">
        <label>Nama Pelapor</label>
        <input type="text" className="form-control" placeholder="Nama Pelapor" />
      </div>

      <div className="form-group">
        <label>Nomor Whatsapp</label>
        <input type="text" className="form-control" placeholder="Nomor Whatsapp" />
      </div>

      <div className="form-group">
        <label>Deskripsi Laporan</label>
        <textarea className="form-control" placeholder="Deskripsi Laporan"></textarea>
      </div>

      <div className="form-group">
        <label>Upload Bukti</label>
        <input type="file" className="form-control" />
      </div>

      <div className="form-group">
        <button type="submit" className="btn btn-primary">Laporkan</button>
      </div>
    </form>
    </div>
  )
}

export default Laporan;