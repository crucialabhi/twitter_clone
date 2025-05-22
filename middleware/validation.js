const Joi = require("joi");

exports.validateUser = async (user) =>{ 
    const JoiSchema = Joi.object({
      fname: Joi.string().min(4).messages({
        'string.empty': `First name can't be empty`,
        'string.min':`First name should be greater than 4`
      }).required(),
  
      lname: Joi.string().min(4).messages({
        'string.empty': `Last name can't be empty`,
        'string.min':`Last name should be greater than 4`
      }).required(),
  
      email: Joi.string().email().messages({'string.email': `Give proper email in the xyz@gmail.com format`}).required(),
        
      contact: Joi.string().regex(/^[0-9]{10}$/).messages({'string.pattern.base': `Phone number must have 10 digits.`}).required(),

      timeZone:Joi.string().required(),

      image : Joi.string().pattern(/(image\/png|image\/jpg|image\/jpeg)/).required(),
    }).options({ abortEarly: false });
  
    return JoiSchema.validate(user);
  }
exports.validateUserRegistration = async (user) =>{
  
    
      const JoiSchema = Joi.object({
        fname: Joi.string().min(4).messages({
          'string.empty': `First name can't be empty`,
          'string.min':`First name should be greater than 4`
        }).required(),
    
        lname: Joi.string().min(4).messages({
          'string.empty': `Last name can't be empty`,
          'string.min':`Last name should be greater than 4`
        }).required(),
    
        email: Joi.string().email().messages({'string.email': `Give proper email in the xyz@gmail.com format`}).required(),
          
        contact: Joi.string().regex(/^[0-9]{10}$/).messages({'string.pattern.base': `Phone number must have 10 digits.`}).required(),
  
        timeZone:Joi.string().required(),
  
        // image : Joi.string().pattern(/(image\/png|image\/jpg|image\/jpeg)/).required(),
      }).options({ abortEarly: false });
    
      return JoiSchema.validate(user);
}


exports.validateLogin=async(user)=>{
  const JoiSchema = Joi.object({
    email: Joi.string().required(),
    password: Joi.string().required(),
  }).options({ abortEarly: false });

  return JoiSchema.validate(user);
}

exports.validateEmail = async (email) => {
  const JoiSchema = Joi.object({
    email: Joi.string().email().messages({'string.email': `Give proper email in the xyz@gmail.com format`}).required(),
  }).options({ abortEarly: false });

  return JoiSchema.validate(email);
}

exports.validateContent = async (content) => {
  const JoiSchema = Joi.object({
    content: Joi.string().messages({'string.empty': `Your tweet is empty`}).required(),
  }).options({ abortEarly: false });

  return JoiSchema.validate(content);
}
