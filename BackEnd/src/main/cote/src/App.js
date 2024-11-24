import './App.css';
import Header from './componet/contain/header'; // Header 컴포넌트 import
import Body from './componet/body';     // Body 컴포넌트 import
import Footer from './componet/contain/footer'; // Footer 컴포넌트 import
import { BrowserRouter, Route, Routes } from "react-router-dom";
import UserList from './componet/UserList';
import Login from './componet/Login';
import SignUp from './componet/SignUp';


function App() {
  return (
    <BrowserRouter>
      <Header />
        <Routes>
            <Route exact path='/' Component={Body}></Route>
            <Route exact path='/UserList' Component={UserList}></Route>
            <Route exact path='/Login' Component={Login}></Route>
            <Route exact path='/SignUp' Component={SignUp}></Route>
        </Routes>
        {/* 프롭스 예제 */}
         {/* <Login id = "test"/> */}
      <Footer />
    </BrowserRouter>
  );
}

export default App;
