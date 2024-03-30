import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import HomeNavbar from './HomeNavBar';

function EnterPassword() {
    const navigate = useNavigate();
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');

    const savedPassword = '1234';

    const handleSubmit = (event) => {
        event.preventDefault();
        if (password === savedPassword) {
            navigate('/'); // navigate to home page
        } else {
            setError('Incorrect password');
        }
    };

    return (
        <div className='enterpass'>
            <HomeNavbar sticky="top" exact />
            <div className="container d-flex justify-content-center align-items-center vh-100">
                <div className="text-center">
                    <h2 className="fw-bold">Enter Password</h2>
                    <form onSubmit={handleSubmit}>
                        <input 
                            type="password" 
                            placeholder="Password" 
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            className="form-control mb-3 rounded-pill"
                        />
                        <button className="btn btn-primary rounded-pill px-4 py-1" type="submit">Submit</button>
                    </form>
                    {error && <p>{error}</p>}
                </div>
            </div>
        </div>
    );
}

export default EnterPassword;
