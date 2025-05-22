const multer = require("multer");
// const { validateUser } = require("../validations/signup.validations");
const { returnStatement, generalResponse } = require("../helper");
const { validateUser } = require("./validation");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    return cb(null, "./public/uploads");
  },
  filename: function (req, file, cb) {
    return cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const fileSizeLimit = (err, req, res, next) => {
  if (err) {
    console.log(err)
    return res.json(generalResponse(0, 'file is too large. Max =1MB'));
  } else {
    console.log("i m in filesize limit");
    next()
  }
}
var upload = multer({
  storage: storage,
  limits: { fileSize: 100000 * 1024 }, // 1MB
  
  // fileFilter: async (req, file, cb) => {
          
  //   const values = JSON.parse(JSON.stringify(req.body));
  
    
  //   const user = {
  //     fname: values.fname,
  //     lname: values.lname,
  //     email: values.email,
  //     contact: values.contact,
  //     timeZone:values.timeZone,
  //     image: file.mimetype,
  //   };

  //   const response = await validateUser(user);
  //   if (response.error) {
  //       console.log(response);
  //       req.ValidateError = response.error.details[0]['message'];
  //       return cb(null,false,req.ValidateError)
  //     }
  //   cb(null, true);
  // },
}).single("profileImage");

var Upload = multer({storage:storage});
module.exports = {Upload,upload,fileSizeLimit};
