const express = require("express");
const router = express();
const { index, createToken, registrationPassword, validateLogIn, verificationToken, dashboard, listingAllUser, followUser, unfollowUser, count, countFollowersFollowing, createTweet, listTweet, showprofile, getProfileData, seeAllFollowers, seeAllFollowing, likeTweets, unLikeTweets, reTweet, seeProfilePost, editUserDetail, getchats, createGroup } = require("../controller/user.controller");
const { Upload, upload, fileSizeLimit } = require("../middleware/multer");
const { validateEmail } = require("../middleware/emailValidation");
const path = require('path')
router.use("/public", express.static("public"));
router.set("view engine", "ejs");
const bodyParser = require('body-parser');
const { validateEmailToken, validateToken } = require("../middleware/jwtToken");
const { profile } = require("console");
const { validateEmailToken2 } = require("../middleware/validation");
router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json());


router.get('/',index);
router.post('/createTokenForPassword',upload,fileSizeLimit,createToken)
router.post('/validateEmail',validateEmail);
router.post('/validateEmailToken',validateEmailToken)
router.post('/registrationPassword',validateToken,registrationPassword)
router.post('/validateLogIn',Upload.none(),validateLogIn)
router.post('/verificationToken',validateToken,verificationToken)
router.post('/listingAllUser',validateToken,listingAllUser)
router.all('/dashboard',dashboard);
router.post('/followUser',validateToken,followUser);
router.post('/unfollowUser',validateToken,unfollowUser);
router.post('/countFollowersFollowing',validateToken,countFollowersFollowing);
router.post('/createTweet',validateToken,createTweet)
router.post('/listTweet',validateToken,listTweet)
router.all('/showprofile',showprofile)
router.post('/getProfileData',validateToken,getProfileData)
router.post('/seeAllFollowers',validateToken,seeAllFollowers)
router.post('/seeAllFollowing',validateToken,seeAllFollowing)
router.post('/likeTweets',validateToken,likeTweets)
router.post('/unLikeTweets',validateToken,unLikeTweets)
router.post('/reTweet',validateToken,reTweet)
router.post('/seeProfilePost',validateToken,seeProfilePost)
router.post('/editUserDetail',upload,fileSizeLimit,validateToken,editUserDetail)
router.post('/getchats',validateToken,getchats)
router.post('/createGroup',Upload.none(),createGroup)


router.get('/personal-chat',async(req,res)=>{
    res.render('chat');
})


router.all('/registrationValidation',async(req,res)=>{
    res.render('registrationValidation');
})
router.all('/setPassword',async(req,res)=>{
    res.render('setPassword');
})
router.all('/loginPage',async(req,res)=>{
    res.render('loginPage');
})











module.exports = router;