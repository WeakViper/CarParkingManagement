import React, { useState, useEffect } from 'react';
import HomeNavbar from "../Home/HomeNavBar";
import { Card, ListGroup, Button } from 'react-bootstrap';
import AddEmployeesButton from './AddEmployeesButton';

const ManageEmployees = () => {
    const [employees, setEmployees] = useState([]);

    // Function to generate a random employee
    const generateRandomEmployee = (id) => {
        const names = ['John Doe', 'Jane Smith', 'Emma Johnson', 'Michael Brown', 'Emily Davis'];
        const phones = ['123-456-7890', '234-567-8901', '345-678-9012', '456-789-0123', '567-890-1234'];
        const emails = ['john@example.com', 'jane@example.com', 'emma@example.com', 'michael@example.com', 'emily@example.com'];

        const randomIndex = Math.floor(Math.random() * names.length);

        return {
            id: id,
            name: names[randomIndex],
            phone: phones[randomIndex],
            email: emails[randomIndex]
        };
    }

    // Function to delete an employee
    const deleteEmployee = (id) => {
        setEmployees(employees.filter(employee => employee.id !== id));
    }

    // Generate a list of random employees on component mount
    useEffect(() => {
        const newEmployees = Array.from({ length: 10 }, (_, i) => generateRandomEmployee(i + 1));
        setEmployees(newEmployees);
    }, []);

    return (
        <div className="ManageEmp">
            <HomeNavbar sticky = "top" exact/>
            <h2 className="m-5" style={{color: "black", fontWeight: "bold"}}> Manage Employees </h2>
            <div className="line-separator mb-5" style={{borderTop: "2px solid black", width: "90%", marginLeft: "5%", marginRight: "5%"}}></div>
            <AddEmployeesButton />
            <div className="d-flex flex-column align-items-center">
                {employees.map(employee => (
                    <Card style={{ width: '100%', marginBottom: '10px' }} key={employee.id}>
                        <Card.Body>
                            <Card.Title>{employee.name}</Card.Title>
                            <ListGroup variant="flush">
                                <ListGroup.Item>ID: {employee.id}</ListGroup.Item>
                                <ListGroup.Item>Phone: {employee.phone}</ListGroup.Item>
                                <ListGroup.Item>Email: {employee.email}</ListGroup.Item>
                            </ListGroup>
                            <Button variant="danger" onClick={() => deleteEmployee(employee.id)}>Delete</Button>
                        </Card.Body>
                    </Card>
                ))}
            </div>
        </div>
    );
}

export default ManageEmployees;
