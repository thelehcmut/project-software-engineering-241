require('dotenv').config();  // Load environment variables from .env file

const mysql = require('mysql');

// Create a connection to the MySQL database using environment variables
const connection = mysql.createConnection({
  host: process.env.DB_HOST,      // Get the host from environment variables
  user: process.env.DB_USER,      // Get the user from environment variables
  password: process.env.DB_PASSWORD, // Get the password from environment variables
  database: process.env.DB_NAME   // Get the database name from environment variables
});

// Connect to the database
connection.connect((err) => {
  if (err) {
    console.error('error connecting to database:', err.stack);
    return;
  }
  console.log('connected to MySQL database as id ' + connection.threadId);
});

module.exports = connection;  // Export the connection to use elsewhere
