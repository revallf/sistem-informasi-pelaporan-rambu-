import React from 'react';
import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import { Carousel, NavLink } from 'react-bootstrap';
import './StatusLapor.css';
import logo from '../assets/logonew.png';       
import { Link } from 'react-router-dom';
import { useNavigate } from 'react-router-dom';

const StatusPelaporan = () => {
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

          <div className="search-container">
        <input type="text" className="search-input" placeholder="Pencarian..." />
        <button className="search-button">Cari</button>
      </div>

      <table className="status-table">
        <thead>
          <tr>
            <th>No</th>
            <th>Nama</th>
            <th>TGL</th>
            <th>Jenis</th>
            <th>Desa</th>
            <th>Lokasi</th>
            <th>Isi Laporan</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {/* Data status laporan akan ditampilkan di sini */}
        </tbody>
      </table>
    </div>
  )
}

export default StatusPelaporan;