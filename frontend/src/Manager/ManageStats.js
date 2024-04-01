import { Button, Card, ListGroup } from "react-bootstrap";
import { useNavigate } from 'react-router-dom';
import HomeNavbar from "../Home/HomeNavBar";

const ManageStats = () => {
    const navigate = useNavigate();
    const outlets = [
        { id: 'O001', clientname: 'Outlet A', parkingCap: 100, filledSpots: 50 },
        { id: 'O002', clientname: 'Outlet B', parkingCap: 200, filledSpots: 100 },
        { id: 'O003', clientname: 'Outlet C', parkingCap: 150, filledSpots: 75 },
        { id: 'O004', clientname: 'Outlet D', parkingCap: 300, filledSpots: 150 },
        { id: 'O005', clientname: 'Outlet E', parkingCap: 250, filledSpots: 125 },
    ];

    const handleCardClick = (id) => {
        navigate('/outlet', { state: { id } });
    };

    return (
        <div className="ManageEmp">
            <HomeNavbar sticky = "top" exact/>
            <h2 className="m-5" style={{color: "black", fontWeight: "bold"}}> Statistics Per Outlet </h2>
            <div className="line-separator mb-5" style={{borderTop: "2px solid black", width: "90%", marginLeft: "5%", marginRight: "5%"}}></div>
            <div className="d-flex flex-column align-items-center">
                {outlets.map(outlet => (
                    <Card style={{ width: '100%', marginBottom: '10px', transition: 'transform .2s', cursor: 'pointer' }} key={outlet.id} onClick={() => handleCardClick(outlet.id)}
                        onMouseOver={(e) => e.currentTarget.style.transform = 'scale(1.02)'}
                        onMouseOut={(e) => e.currentTarget.style.transform = 'scale(1)'}
                        onMouseDown={(e) => e.currentTarget.style.transform = 'scale(0.98)'}
                        onMouseUp={(e) => e.currentTarget.style.transform = 'scale(1)'}
                    >
                        <Card.Body>
                            <Card.Title>{outlet.clientname}</Card.Title>
                            <ListGroup variant="flush">
                                <ListGroup.Item>BranchId: {outlet.id}</ListGroup.Item>
                                <ListGroup.Item>Parking Cap: {outlet.parkingCap}</ListGroup.Item>
                                <ListGroup.Item>Filled Spots: {outlet.filledSpots}</ListGroup.Item>
                            </ListGroup>
                        </Card.Body>
                    </Card>
                ))}
            </div>
        </div>
    );
}
 
export default ManageStats;