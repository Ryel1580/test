import api from '../config/axiosSetup';
import React, { useEffect, useState } from 'react';

function Login(props){

    const [id , setId] = useState('');
    const [password, setPassword] = useState('');
    console.log(props);

    const loginTry = async (e) =>{
        e.preventDefault();

        try{
            const response = await api.post("/login",{id,password})

            if(response.status == 200){
                alert("로그인 성공 !!");
            }
            else{
                alert("로그인 실패 !!")
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
            {/* props 예제 */}
            <label>Props ID</label>
                <div>{props.id}</div>   
          </div>
        </header>
      );

}

export default Login;