import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowRight } from 'react-bootstrap-icons';
import { Button, Modal } from 'react-bootstrap';

const ViewPurchasesButton = () => {
    const [show, setShow] = useState(false);
    const [plateNumber, setPlateNumber] = useState("");
    const navigate = useNavigate();

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

    const handleSubmit = () => {
        navigate('/viewreservations', { state: { plateNumber } });
    };

    return (
        <div className="OrderButtonLanding">
            <div className="d-flex justify-content-start m-5 px-5">
            <button type="submit" className="btn orderNowButton rounded-pill p-5 btn-primary d-flex align-items-center justify-content-center" onClick={handleShow}>
                    <ArrowRight color="white" size={48} />
                    <span>View Reservations</span>
            </button>
            </div>
            <div className="line-separator my-5"></div>

            <Modal show={show} onHide={handleClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Enter Plate Number</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <input type="text" value={plateNumber} onChange={e => setPlateNumber(e.target.value)} placeholder="Enter Plate Number" />
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleClose}>
                        Close
                    </Button>
                    <Button variant="primary" onClick={handleSubmit}>
                        Submit
                    </Button>
                </Modal.Footer>
            </Modal>
        </div>
    );
}

export default ViewPurchasesButton;
