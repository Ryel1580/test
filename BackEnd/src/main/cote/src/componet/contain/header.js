import React from 'react';


function Header() {
  
    
  
    return (
    <header style={styles.header}>
      <div>
        <h1>My Simple React App</h1>
      </div>
    </header>
  );
}

const styles = {
  header: {
    backgroundColor: '#282c34',
    color: 'white',
    padding: '10px',
    textAlign: 'center',
  },
};

export default Header;
