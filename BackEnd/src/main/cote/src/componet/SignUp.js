import api from '../config/axiosSetup';
import React, { useEffect, useState } from 'react';

function SignUp(){

    const [id , setId] = useState('');
    const [password, setPassword] = useState('');

    const loginTry = async (e) =>{
        e.preventDefault();

        try{
            const response = await api.post("/signUp",{id,password})

            if(response.status == 200){
                alert("회원가입 !!");
            }
            
        }
        catch(err){
            if(err.status === 404){
                alert("없는회원이거나 , 비밀번호가 틀립니다.")
            }else{
                alert("에러!!")
            }
        }
    }


    return (
        <header>
          <div>
            <form onSubmit={loginTry}>
                <div>
                    
                    <label>ID</label>
                    <input type='id' value={id} onChange={(e) => {setId(e.target.value)}}></input>
                </div>
                <div>
                    <label>PW</label>
                    <input type='password' value={password} onChange={(e) => {setPassword(e.target.value)}}></input>
                </div>
                
                <button type='submit'>Login</button>
            </form>
            
          </div>
        </header>
      );

}

export default SignUp;