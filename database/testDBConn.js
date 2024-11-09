// testConnection.js
const connection = require('./db');  // Import the MySQL connection from db.js

// Query the database to check the connection

connection.query('INSERT INTO Carts VALUES (1, 4, 30000)', (err, results, fields) => {
  if (err) {
    console.error('Error executing query:', err);
    return;
  }
  console.log('Database insert test successful:', results);
});


connection.query('SELECT * FROM Carts', (err, results, fields) => {
  if (err) {
    console.error('Error executing query:', err);
    return;
  }
  console.log('Database Select test successful:', results);
});

// Close the connection once done
connection.end();
