import React from 'react';
import { useNavigate } from 'react-router-dom';
import HomeNavbar from './HomeNavBar';

function EnterPassword() {
    const navigate = useNavigate();

    const handleSubmit = () => {
        navigate('/');
    }
    return (
        <div className='enterpass'>
            <HomeNavbar sticky="top" exact />
            <div className="container d-flex justify-content-center align-items-center vh-100">
                <div className="text-center">
                    <h2 className="fw-bold">Enter Password</h2>
                    <input 
                        type="password" 
                        placeholder="Password" 
                        className="form-control mb-3 rounded-pill"
                        onClick={(event) => event.target.focus()}
                    />
                    <button className="btn btn-primary rounded-pill px-4 py-1" onClick={handleSubmit}>Submit</button>
                </div>
            </div>
        </div>
    );
}

export default EnterPassword;

