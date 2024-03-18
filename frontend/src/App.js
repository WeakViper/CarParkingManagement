import './App.css';
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import LandingPage from './LandingPage/LandingPage';
import "bootstrap/dist/css/bootstrap.min.css";
import EnterPassword from './Home/EnterPassword';
import SelectParkingLot from './Home/SelectParkingLot';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<LandingPage />} />
      </Routes> 

      <Routes>
        <Route path="/enterpassword" element={<EnterPassword />} />
      </Routes>  

      <Routes>
        <Route path="/selectlot" element={<SelectParkingLot />} />
      </Routes>      
    </Router>
  );
}

export default App;
