import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Spinner } from 'react-bootstrap';

const ParkingLots = () => {
    const [lots, setLots] = useState([]);
    const [loading, setLoading] = useState(true);

    setLots([
        { name: 'Lot 1' },
        { name: 'Lot 2' },
        { name: 'Lot 3' },
        { name: 'Lot 4' },
        { name: 'Lot 5' },
        { name: 'Lot 6' },
    ]); //demo array
    

    const handleClick = () => {
        // logic to head to the reservation page
    }

    useEffect(() => {
        // fn to fetch data from the backend
    }, []);

    if (loading) {
        return (
            <div className="d-flex justify-content-center">
                <Spinner animation="border" role="status" className='p-4 m-5'>
                </Spinner>
            </div>
        );
    }

    return (
        <div className="container m-4">
            <div className="row justify-content-center">
                {lots.map((lot, index) => (
                    <div className="col-lg-3 col-md-6 mx-4 my-4" key={index}>
                        <div className="card text-center border-dark bg-light py-4" style={{width: "18rem", borderRadius: "20px"}}>
                            <div className="card-body">
                                <h4 className="card-title p-3">{lot.name}</h4>
                                <button onClick={handleClick} className="btn btn-primary mb-2 rounded-pill"> Reserve a spot </button>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}

export default ParkingLots;



