import api from '../config/axiosSetup';
import React, { useEffect, useState } from 'react';

function UserList(){

    const [user , setUser] = useState([]);
    const [errorMsg, setErrorMsg] = useState('');

    
    useEffect(()=>{
        api
        .get("/getUserInfo")// spring End Point
        .then((response) =>{
            setUser(response.data);
        })
        .catch((err) =>{
            if(err.message ===! undefined){
                setErrorMsg(err.message);
                console.log(err.message);
            }
        })

    },[]);

    return (
        <header>
          <div>
            <ul>
                {user.map((user,index) => (
                    <li key={index}> 
                    사용자 ID : {user.USR_ID}<br/>
                    사용자 ID : {user.NAME}
                    </li>
                ))}
            </ul>
          </div>
        </header>
      );

}

export default UserList;