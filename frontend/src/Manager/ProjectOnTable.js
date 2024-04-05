import HomeNavbar from "../Home/HomeNavBar";
import { useState, useEffect } from 'react';
import { Form, Button } from 'react-bootstrap';
import axios from 'axios';

const ProjectOnTable = () => {
    const [tables, setTables] = useState([]);
    const [selectedTable, setSelectedTable] = useState('');

    useEffect(() => {
        axios.post('http://localhost:3500/basic/alltables')
            .then(response => {
                setTables(response.data.map(table => table.Tables_in_cpms_db));
            })
            .catch(error => {
                console.error(`Error fetching data: ${error}`);
            });
    }, []);

    const handleSubmitTables = (event) => {
        event.preventDefault();
        console.log(selectedTable);
    };
    
    return (
        <div className="Project">
            <HomeNavbar sticky = "top" exact/>
            <h2 className="m-5" style={{color: "black", fontWeight: "bold"}}> Select Table To Project On </h2>
            <div className="line-separator mb-5" style={{borderTop: "2px solid black", width: "90%", marginLeft: "5%", marginRight: "5%"}}></div>
            <Form onSubmit={handleSubmitTables}>
        <Form.Group controlId="tableSelect mx-5 p-2">
        <Form.Label>Select Table</Form.Label>
        <Form.Control as="select" name="tableSelect" onChange={event => setSelectedTable(event.target.value)}>
            {tables.map((table, index) => (
                <option key={index} value={table}>{table}</option>
            ))}
        </Form.Control>
        </Form.Group>
            <Button variant="primary m-3 px-3" type="submit">
                Submit
            </Button>
        </Form>
        </div>
    );
}
 
export default ProjectOnTable;