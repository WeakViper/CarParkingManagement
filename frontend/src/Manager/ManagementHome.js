import HomeNavbar from "../Home/HomeNavBar";
import { useNavigate } from "react-router-dom";

const ManagementHome = () => {
    const navigate = useNavigate();
    const handleEmployees = () => {
        navigate('/manageemployees');
    }

    const handleStats = () => {
        navigate('/managebranches');
    }

    return (
        <div className="management-home">
            <HomeNavbar sticky = "top" exact/>
            <h2 className="m-5" style={{color: "black", fontWeight: "bold"}}> Management Panel </h2>
            <div className="line-separator mb-5" style={{borderTop: "2px solid black", width: "90%", marginLeft: "5%", marginRight: "5%"}}></div>
            
            <div className="d-flex flex-column align-items-center">
                <div className="d-flex justify-content-around w-50 mb-5">
                    <button className="btn btn-primary rounded-pill px-5 py-3" onClick={handleEmployees}>Manage Employees</button>
                    <button className="btn btn-primary rounded-pill px-5 py-3" onClick={handleStats}>Manage Branches</button>
                </div>
                <div className="d-flex justify-content-around w-50">
                    <button className="btn btn-primary rounded-pill px-5 py-3">Button 3</button>
                    <button className="btn btn-primary rounded-pill px-5 py-3">Button 4</button>
                </div>
            </div>
        </div>
    );
}
 
export default ManagementHome;
