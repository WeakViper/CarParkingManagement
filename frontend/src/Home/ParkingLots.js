import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Spinner } from 'react-bootstrap';

const ParkingLots = () => {
    const [branches, setBranches] = useState([]);
    const [loading, setLoading] = useState(true);
    const [modalShow, setModalShow] = useState(false);

    useEffect(() => {
        const getBranches = async () => {
            try {
                const response = await axios.post('http://localhost:3500/basic/getbranches');
                console.log(response.data);
                const branchIds = response.data.map(branch => branch.BranchID);
                setBranches(branchIds);
                console.log(branchIds);
            } catch (error) {
                console.error(error);
                console.log("Error in getBranches");
            }
        }
        getBranches();
        setLoading(false);
    }, []);

    const [selectedBranch, setSelectedBranch] = useState(null);

    const handleClick = (branchName) => {
        setSelectedBranch(branchName);
        setModalShow(true);
    }

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
                {branches.map((branch, index) => (
                    <div className="col-lg-3 col-md-6 mx-4 my-4" key={index}>
                        <div className="card text-center border-dark bg-light py-4" style={{width: "18rem", borderRadius: "20px"}}>
                            <div className="card-body">
                                <h4 className="card-title p-3">{branch}</h4>
                                <button onClick={() => handleClick(branch)} className="btn btn-primary mb-2 rounded-pill"> Reserve a spot </button>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}

export default ParkingLots;
