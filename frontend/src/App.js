import './App.css';
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import LandingPage from './LandingPage/LandingPage';
import "bootstrap/dist/css/bootstrap.min.css";
import EnterPassword from './Home/EnterPassword';
import SelectParkingLot from './Home/SelectParkingLot';
import Viewreservations from './Home/ViewReservations';
import ManagementHome from './Manager/ManagementHome';
import ManageEmployees from './Manager/ManageEmployees';

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

      <Routes>
        <Route path="/viewreservations" element={<Viewreservations />} />
      </Routes>

      <Routes>
        <Route path="/managementpanel" element={<ManagementHome />} />
      </Routes>

      <Routes>
        <Route path="/manageemployees" element={<ManageEmployees />} />
      </Routes>
    </Router>
  );
}

export default App;
