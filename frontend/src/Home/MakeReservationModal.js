import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import Form from 'react-bootstrap/Form';
import { useNavigate } from 'react-router-dom';

function MakeReservationModal(props) {
  const navigate = useNavigate();

  const handleSubmit = (event) => {
    event.preventDefault();
    //logic to make res with backend.
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
              {['Tower1', 'Tower2', 'Tower3', 'Tower4', 'Tower5'].map(tower => 
                <option key={tower}>{tower}</option>
              )}
            </Form.Control>
          </Form.Group>
          <Form.Group controlId="zone">
            <Form.Label>Zone</Form.Label>
            <Form.Control as="select">
              {['Zone1', 'Zone2', 'Zone3', 'Zone4', 'Zone5', 'Zone6', 'Zone7', 'Zone8', 'Zone9'].map(zone => 
                <option key={zone}>{zone}</option>
              )}
            </Form.Control>
          </Form.Group>
          <Form.Group controlId="plate">
            <Form.Label>Plate#</Form.Label>
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
