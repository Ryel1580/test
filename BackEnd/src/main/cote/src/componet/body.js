import { Link } from "react-router-dom";

function Body() {
    return (
    <main style={styles.body}>
        <Link to = 'Login'>
            <button className='Login'>Login</button>
        </Link>
        <Link to = 'SignUP'>
            <button className='SignUP'>Sign Up</button>
        </Link>
        <div>
            <button className='GetInfo'>Get User Info</button>
        </div>  
        <Link to = 'UserList'>
            <button className='UpdateInfo' >Update User Info</button>
        </Link>
    </main>
  );
}

const styles = {
  body: {
    padding: '20px',
    textAlign: 'center',
    fontSize: '18px',
  },
};



export default Body;
