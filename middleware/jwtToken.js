const dotenv = require("dotenv").config();
const secretKey = process.env.JWT_SECRET_TOKEN;
const jwt = require("jsonwebtoken");
const { generalResponse } = require("../helper");

exports.createTokenForPassword = async (user) => {
  return new Promise((resolve, reject) => {
    try {
      
      const token = jwt.sign(user, secretKey, { expiresIn: "1h" });
      return resolve(token);
    } catch (error) {
      console.log(error);
      return reject(error);
    }
  });
};

exports.createTokenForLogin = async (user) => {
  return new Promise((resolve, reject) => {
    try {
      const token = jwt.sign(user, secretKey, { expiresIn: "1h" });
      return resolve(token);
    } catch (error) {
      console.log(error);
      return reject(error);
    }
  });
};

exports.validateEmailToken = async (req, res) => {
  try {
    const token = req.headers.authorization;
    if (!token) {
      return res.json(
        generalResponse(
          0,
          "your session for creating password has been expired"
        )
      );
    }
    jwt.verify(token, secretKey, (err, decoded) => {
      if (err) {
        return res.json(
          generalResponse(
            0,
            "your session for creating password has been expired"
          )
        );
      } else {
        return res.json(generalResponse(1, "Valid Token"));
      }
    });
  } catch (error) {
    console.log(error);
  }
};

exports.validateToken = async (req, res, next) => {
  const token = req.headers.authorization; 
  if (!token) {
    return res.json(generalResponse(0, "your session has been expired"));
  }
  jwt.verify(token, secretKey, (err, decoded) => {
    if (err) {    
      return res.json(generalResponse(0, "your session has been expired"));
    }
    next();
  });
};

exports.getDataFromToken = async(token)=>{
try {
  return jwt.verify(token,secretKey);
} catch (error) {
  console.log(error);
  return error;
}
}