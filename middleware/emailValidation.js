
const { generalResponse } = require("../helper");
const { validateEmail } = require("./validation");

exports.validateEmail = async (req, res) => {
   try {
    const email = req.body.email;
    const emailValidation = await validateEmail({email:email})
    if (emailValidation.error) {
      const message = emailValidation.error.details[0]["message"];
      return res.json(generalResponse(0, message));
    }
    const query = `select * from user_detail where email = '${email}'`;
    const result = await runQuery(query);
    if (result.length == 0) {
      return res.json(generalResponse(1, "user id not exist"));
    }
    res.json(generalResponse(0, "user id exist"));
   } catch (error) {
    console.log(error);
    return res.json(generalResponse(0, "Something went wrong"));
   }
  };