import React from 'react';
import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import { Carousel, NavLink } from 'react-bootstrap';
import './Beranda.css';
import logo from '../assets/logonew.png';       
import { Link } from 'react-router-dom';
import { useNavigate } from 'react-router-dom';

const Beranda = () => {
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

          {/* Carousel Section */}
          <section className="carousel-section">
            <Carousel>
              <Carousel.Item>
                <img
                  className="d-block w-100"
                  src="image/beranda2.png"
                  alt="First slide"
                />
                <Carousel.Caption>
                  <h3></h3>
                  <p></p>
                </Carousel.Caption>
              </Carousel.Item>
              <Carousel.Item>
                <img
                  className="d-block w-100"
                  src="image/beranda.png"
                  alt="Second slide"
                />
                <Carousel.Caption>
                  <h3></h3>
                  <p></p>
                </Carousel.Caption>
              </Carousel.Item>
              <Carousel.Item>
                <img
                  className="d-block w-100"
                  src="image/beranda2.png"
                  alt="Third slide"
                />
                <Carousel.Caption>
                  <h3></h3>
                  <p></p>
                </Carousel.Caption>
              </Carousel.Item>
            </Carousel>
          </section>

          

        </div>
    
    
  );
};

export default Beranda;
