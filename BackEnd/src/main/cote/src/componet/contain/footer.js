import React from 'react';

function Footer() {
  return (
    <footer style={styles.footer}>
      <p>&copy; 2024 My Simple React App. All rights reserved.</p>
    </footer>
  );
}

const styles = {
  footer: {
    backgroundColor: '#f1f1f1',
    color: '#333',
    padding: '10px',
    textAlign: 'center',
    marginTop: '20px',
  },
};

export default Footer;
