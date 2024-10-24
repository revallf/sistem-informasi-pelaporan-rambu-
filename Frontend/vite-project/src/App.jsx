import React from 'react';
import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import { Carousel, NavLink } from 'react-bootstrap';
import './App.css';
import logo from './assets/logonew.png';
import Beranda from './components/Beranda';
import Laporan from './components/Laporan';
import StatusPelaporan from './components/StatusPelaporan';
import Home from './Pages/Home'
import Laporpage from './Pages/Laporpage';
import StatusLaporPage from './Pages/StatusLaporPage';



const App = () => {
  return (
    <Router>
      <Routes>
        <Route path='/' element={<Home/>}> </Route>
        <Route path='/Laporpage' element={<Laporpage/>}> </Route>
        <Route path='/StatusLaporPage' element={<StatusLaporPage/>}> </Route>
      </Routes>
    </Router>
  );
};

export default App;
