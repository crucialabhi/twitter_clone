const mysql = require("mysql2");
const dotenv = require("dotenv").config();

const hostname = process.env.HOSTNAME;
const user =process.env.DATABASE_USER;
const password =process.env.PASSWORD;
const database =process.env.DATABASE;

var con = mysql.createConnection({
    host: hostname,
    user: user,
    password: password,
    database: database,
  });

con.connect(function (err) {
    if (err) throw err;
  });
  
runQuery = (query) => {
    return new Promise((resolve, reject) => {
      con.query(query, (err, result) => {
        if (err) {
          return reject(err);
        }
        resolve(result);
      });
    });
  };

module.exports = {con,runQuery};

