import HomeNavbar from "../Home/HomeNavBar";
import { useNavigate } from "react-router-dom";
import { Modal, Button, Form } from 'react-bootstrap';
import { useState } from "react";

const ManagementHome = () => {
    const navigate = useNavigate();
    const [show, setShow] = useState(false);
    const [minAmount, setMinAmount] = useState('');

    const handleClose1 = () => setShow(false);
    const handleShow1 = () => setShow(true);
    const handleInputChange1 = (event) => {
        setMinAmount(event.target.value);
    }

    const handleSubmit1 = (event) => {
        event.preventDefault();
        navigate('/methodamount', { state: { amount: minAmount } });
        handleClose1();
    }


    const handleEmployees = () => {
        navigate('/manageemployees');
    }

    const handleStats = () => {
        navigate('/managebranches');
    }

    const BusiestExit = () => {
        navigate('/busiestgate');
    }

    const EntriesByPlate = () => {
        navigate('/countbyplate');
    }

    const MethodTotal = () => {
        handleShow1();
    }

    const GateTotal = () => {
        navigate('/branchslots')
    }
    
    const SupportedGates = () => {
        navigate('/supportedgates')
    }

    const ProjectOnTable = () => {
        navigate('/projectontable')
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
                    <button className="btn btn-primary rounded-pill px-5 py-3" onClick={BusiestExit}>Busiest Exit</button>
                    <button className="btn btn-primary rounded-pill px-5 py-3" onClick={EntriesByPlate}>Entries By Plate#</button>
                </div>

                <div className="d-flex justify-content-around w-50 m-5">
                    <button className="btn btn-primary rounded-pill px-5 py-3" onClick={MethodTotal}>Total By Method</button>
                    <button className="btn btn-primary rounded-pill px-5 py-3" onClick={GateTotal}>Slots Per Client</button>
                </div>
                <div className="d-flex justify-content-around w-50">
                    <button className="btn btn-primary rounded-pill px-5 py-3" onClick={SupportedGates}>Gates With All Payment Methods</button>
                </div>
                <div className="d-flex justify-content-around w-50">
                    <button className="btn btn-primary rounded-pill px-5 m-5 py-3" onClick={ProjectOnTable}>Project On Any Table</button>
                </div>
            </div>
            <Modal show={show} onHide={handleClose1}>
                <Modal.Header closeButton>
                    <Modal.Title>Enter Minimum Amount</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Form onSubmit={handleSubmit1}>
                        <Form.Group controlId="formMinAmount" className="pb-3">
                            <Form.Label>Minimum Amount 1</Form.Label>
                            <Form.Control type="number" value={minAmount} onChange={handleInputChange1} />
                        </Form.Group>
                        <Button variant="primary" type="submit">Submit</Button>
                    </Form>
                </Modal.Body>
            </Modal>
        </div>
    );
}
 
export default ManagementHome;
