import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import Form from 'react-bootstrap/Form';
import { useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import axios from 'axios';

function MakeReservationModal(props) {
  const navigate = useNavigate();
  const [towers, setTowers] = useState([]);

  useEffect(() => {
    const fetchTower = async () => {
      try {
        const response = await axios.post('http://localhost:3500/basic/gettowers', {
          branchid: props.branchId
        });
        const towerIds = response.data.map(tower => tower.TowerID);
        setTowers(towerIds);
        console.log(towerIds);
      } catch (error) {
        console.error(error);
      }
    }
  
    fetchTower();
  }, [props.branchId]);

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log(props.branchId);
  };

  return (
    <Modal
      {...props}
      size="lg"
      aria-labelledby="contained-modal-title-vcenter"
      centered
    >
      <Modal.Header closeButton>
        <Modal.Title id="contained-modal-title-vcenter">
          Make A Reservation
        </Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form onSubmit={handleSubmit}>
          <Form.Group controlId="tower">
            <Form.Label>Tower</Form.Label>
            <Form.Control as="select">
              {towers.map(tower => 
                <option key={tower}>{tower}</option>
              )}
            </Form.Control>
          </Form.Group>
          <Form.Group controlId="plate">
            <Form.Label>Plate#</Form.Label>
            <Form.Control type="text" />
          </Form.Group>
          <Form.Group controlId="entrygate">
            <Form.Label>Entry Gate</Form.Label>
            <Form.Control type="text" />
          </Form.Group>
          <Form.Group controlId="weightClass">
            <Form.Label>Weight Class</Form.Label>
            <Form.Control as="select">
              {['A', 'B', 'C'].map(option => 
                <option key={option}>{option}</option>
              )}
            </Form.Control>
          </Form.Group>
          <Button variant="primary" type="submit" className='px-5 py-1 my-3 rounded-pill'>
            Submit
          </Button>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button onClick={props.onHide}>Close</Button>
      </Modal.Footer>
    </Modal>
  );
}

export default MakeReservationModal;
