const { json } = require("body-parser");
const { runQuery } = require("../database/databaseConnection");
const { generalResponse } = require("../helper");
const {
  createTokenForPassword,
  createTokenForLogin,
  getDataFromToken,
} = require("../middleware/jwtToken");
const {
  validateUser,
  validateLogin,
  validateContent,
  validateUserRegistration,
} = require("../middleware/validation");
const bcrypt = require("bcrypt");
const { date } = require("joi");

exports.index = async (req, res) => {
  try {
    res.render("registrationPage");
  } catch (error) {
    console.log(error);
  }
};

exports.createToken = async (req, res) => {
  try {
    let values = JSON.parse(JSON.stringify(req.body));
    const fileDetails = req.file;
    let filePath;
    let insertQueryUserDetails; 
    if (fileDetails) {
      filePath = fileDetails.path;
      values.image = fileDetails.mimetype  ;
      insertQueryUserDetails = `insert into user_detail (first_name,last_name,contact_no,email,user_time_zone,user_image) values('${values.fname}','${values.lname}','${values.contact}','${values.email}','${values.timeZone}','${filePath}');`;
      const userValidation = await validateUser(values);
      if (userValidation.error) {
        const message = userValidation.error.details[0]["message"];
        return res.json(generalResponse(0, message));
      }
    } else {
      insertQueryUserDetails = `insert into user_detail (first_name,last_name,contact_no,email,user_time_zone) values('${values.fname}','${values.lname}','${values.contact}','${values.email}','${values.timeZone}');`;
      const userValidation = await validateUserRegistration(values);
      if (userValidation.error) {
        const message = userValidation.error.details[0]["message"];
        return res.json(generalResponse(0, message));
      }
    }


    const result = await runQuery(insertQueryUserDetails);

    const id = result.insertId;
    const user = {
      name: `${values.fname} ${values.lname}`,
      email: values.email,
      contact: values.contact,
      purpose: `Email validation`,
    };
    const createToken = await createTokenForPassword(user);
    const data = { token: createToken, id: id };
    const message = "successfully created account!";
    res.json(generalResponse(1, message, data));
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something error while setting password"));
  }
};

exports.registrationPassword = async (req, res) => {
  try {
    const password = req.body.password;
    const id = req.body.id;
    const hashPassword = await bcrypt.hash(password, 10);
    const insertPassword = `update user_detail set password = '${hashPassword}',is_deleted = 0 where user_id =${id};`;
    const result = await runQuery(insertPassword);
    res.json(generalResponse(1, "Password Set Successfully"));
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something error while setting password"));
  }
};

exports.validateLogIn = async (req, res) => {
  try {
    const values = req.body;
    const user = JSON.parse(JSON.stringify(req.body));

    const joivalidate = await validateLogin(user);
    if (joivalidate.error) {
      return res.json(generalResponse(0, "all fields are required"));
    }

    const email = values.email;
    const plainPassword = values.password;
    const Query = `select * from user_detail where email = '${email}'`;

    const result = await runQuery(Query);
    if (result.length == 0) {
      return res.json(generalResponse(0, "Creditinal Invalid"));
    }
    const users = {
      name: `${result[0]["first_name"]}  ${result[0]["last_name"]}`,
      email: `${result[0]["email"]}`,
      contact: `${result[0]["contact_no"]}`,
    };

    const hashPassword = result[0]["password"];
    const check = await bcrypt.compare(plainPassword, hashPassword);

    if (check) {
      const token = await createTokenForLogin(users);
      const data = { jwtToken: token };
      return res.json(generalResponse(1, "Successfully Logged", data));
    } else {
      res.json(generalResponse(0, "Creditinal Invalid"));
    }
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "there is some error please try again later!"));
  }
};

exports.verificationToken = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const result = await runQuery(
      `select * from user_detail where email = '${getData.email}';`
    );
    // console.log(result[0]);

    res.json(generalResponse(1, "Valid Token", { Result: result[0] }));
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "Something went wrong"));
  }
};

exports.dashboard = async (req, res) => {
  res.render("dashboard");
};

exports.listingAllUser = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const query = `select * from user_detail where is_deleted = '0'and not email = '${getData.email}' and email not in (select following_id from followers where  user_id ='${getData.email}' and is_active_follower = 1)`;
    const result = await runQuery(query);
    // console.log(result);
    return res.json(
      generalResponse(1, "fetch Data succesfully", { Result: result })
    );
  } catch (error) {
    console.log(error);
    return res.json(generalResponse(0, "while fetching something went wrong!"));
  }
};

exports.followUser = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const followerUser = req.body.email;
    const queryForchecking = `select * from followers where user_id ='${userEmail}' and following_id ='${followerUser}';`;
    const ResultOFChecking = await runQuery(queryForchecking);
    if (ResultOFChecking.length != 0) {
      const QueryForUpdate = `update  followers
          set is_active_follower = 1 
          where user_id = '${userEmail}' and following_id ='${followerUser}';`;
      const QueryForUpdateResult = await runQuery(QueryForUpdate);
      return res.json(
        generalResponse(1, "you have follow the user Successfully")
      );
    }

    const query = `insert into followers (user_id,following_id) values ('${userEmail}','${followerUser}') `;
    const result = await runQuery(query);
    res.json(generalResponse(1, "you have follow the user Successfully"));
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.unfollowUser = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const followerUser = req.body.email;
    const query = `update  followers
  set is_active_follower = 0 
  where user_id = '${userEmail}' and following_id ='${followerUser}'; `;
    const result = await runQuery(query);
    res.json(generalResponse(1, "you have unfollow the user Successfully"));
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.countFollowersFollowing = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const queryForFollowing = `select count(*) from followers where user_id = '${userEmail}' and is_active_follower = 1 ;`;
    const queryForFollower = `select count(*) from followers where following_id = '${userEmail}'and is_active_follower = 1 ;`;

    const resultForFollowing = await runQuery(queryForFollowing);
    const resultForFollower = await runQuery(queryForFollower);
    res.json(
      generalResponse(1, "countSuccessfull", {
        following: resultForFollowing[0]["count(*)"],
        followers: resultForFollower[0]["count(*)"],
      })
    );
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.createTweet = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const content = req.body.content;
    const contentValidation = await validateContent({ content: content });
    if (contentValidation.error) {
      const message = contentValidation.error.details[0]["message"];
      return res.json(generalResponse(0, message));
    }
    const insertQuery = `insert into tweets (email,content) values ('${userEmail}',"${content}");`;
    const resultInsertQuery = await runQuery(insertQuery);
    res.json(generalResponse(1, "tweet published Successfully"));
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.listTweet = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const query = `select * from tweets ORDER BY tweet_created_at DESC;`;
    const result = await runQuery(query);
    const result1 = await runQuery(
      `select * from like_tweets where user_id ='${userEmail}';`
    );
    const checkLike = new Array(result.length).fill(0);
    const reTweetResult = await runQuery(
      `select * from tweets where is_retweeted = 1;`
    );
    const retweet = new Array(result.length).fill(0);
    for (let i = 0; i < result1.length; i++) {
      if (result1[i]["is_liked"] == 1) {
        checkLike[result1[i]["post_id"]] = 1;
      }
    }  
    res.json(
      generalResponse(1, "tweet Listed", {
        Result: result,
        checkLike: checkLike,
      })
    );
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.showprofile = async (req, res) => {
  res.render("profile");
};

exports.getProfileData = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const queryForProfileData = `select * from user_detail where email = '${userEmail}';`;
    const queryForFollowing = `select count(*) from followers where user_id = '${userEmail}' and is_active_follower = 1 ;`;
    const queryForFollower = `select count(*) from followers where following_id = '${userEmail}'and is_active_follower = 1 ;`;

    const resultForProfileData = await runQuery(queryForProfileData);
    const resultForFollowing = await runQuery(queryForFollowing);
    const resultForFollower = await runQuery(queryForFollower);
    res.json(
      generalResponse(1, "countSuccessfull", {
        profileData: resultForProfileData[0],
        following: resultForFollowing[0]["count(*)"],
        followers: resultForFollower[0]["count(*)"],
      })
    );
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.seeAllFollowing = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const queryForFollowing = `select * from followers where user_id = '${userEmail}' and is_active_follower = 1 ;`;
    const resultForAllProfile = await runQuery(`select * from user_detail;`);
    const resultForFollowing = await runQuery(queryForFollowing);
    const resultForGroup =await runQuery(`select * from group_details where group_member_name='${userEmail}'`)
    console.log(resultForGroup);
    res.json(
      generalResponse(1, "all following user fetch", {
        Result: resultForFollowing,
        allResult: resultForAllProfile,
        groupResult:resultForGroup
      })
    );
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.seeAllFollowers = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const queryForFollowers = `select * from followers where following_id = '${userEmail}' and is_active_follower = 1 ;`;
    const resultForFollowers = await runQuery(queryForFollowers);
    const resultForAllProfile = await runQuery(`select * from user_detail;`);

    res.json(
      generalResponse(1, "all following user fetch", {
        Result: resultForFollowers,
        allResult: resultForAllProfile,
      })
    );
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.likeTweets = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const postId = req.body.postId;
    const queryForchecking = `select * from like_tweets where user_id ='${userEmail}' and post_id ='${postId}';`;
    const ResultOFChecking = await runQuery(queryForchecking);

    //updating
    if (ResultOFChecking.length != 0) {
      const QueryForUpdate = `update  like_tweets
        set  	is_liked  = 1 
        where user_id = '${userEmail}' and post_id ='${postId}';`;
      const QueryForUpdateResult = await runQuery(QueryForUpdate);
      const resultCount = await runQuery(
        `UPDATE tweets SET like_count  = like_count  + 1 WHERE id ='${postId}';`
      );
      const countLike = await runQuery(
        `select like_count from tweets where id='${postId}'`
      );
      const count = countLike[0]["like_count"];
      return res.json(
        generalResponse(1, "you have like the tweet Successfully", {
          count: count,
        })
      );
    }
    //first time like
    const insertQueryForLike = `insert into like_tweets (user_id ,post_id) values ('${userEmail}','${postId}')`;
    const resultForLike = await runQuery(insertQueryForLike);
    const resultCount = await runQuery(
      `UPDATE tweets SET like_count  = like_count  + 1 WHERE id ='${postId}';`
    );
    // console.log(resultCount);
    const countLike = await runQuery(
      `select like_count from tweets where id='${postId}'`
    );
    const count = countLike[0]["like_count"];
    res.json(
      generalResponse(1, "you have like the tweet Successfully", {
        count: count,
      })
    );
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.unLikeTweets = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const postId = req.body.postId;
    const QueryForUpdate = `update  like_tweets
        set  	is_liked  = 0 
        where user_id = '${userEmail}' and post_id ='${postId}';`;
    const QueryForUpdateResult = await runQuery(QueryForUpdate);
    const resultCount = await runQuery(
      `UPDATE tweets SET like_count  = like_count  - 1 WHERE id ='${postId}';`
    );
    const countLike = await runQuery(
      `select like_count from tweets where id='${postId}'`
    );
    const count = countLike[0]["like_count"];
    return res.json(
      generalResponse(1, "you have unlike the tweet Successfully", {
        count: count,
      })
    );
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.reTweet = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const postId = req.body.postId;
    const retweetContent =req.body.retweetContent;
    // console.log(retweetContent);
    const insertQuery = `insert into tweets (email,content,is_retweeted,main_tweet_id ) values ('${userEmail}','${retweetContent}',1,'${postId}');`;
    const resultInsertQuery = await runQuery(insertQuery);
    return res.json(generalResponse(1, "you have successfully retweeted"));
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.seeProfilePost = async (req, res) => {
  try {
    const token = req.headers.authorization;
    const getData = await getDataFromToken(token);
    const userEmail = getData.email;
    const query = `select * from tweets where email ="${userEmail}"ORDER BY tweet_created_at DESC;`;
    const result = await runQuery(query);
    const result1 = await runQuery(
      `select * from like_tweets where user_id ='${userEmail}';`
    );
    const checkLike = new Array(result.length).fill(0);
    const allPost = await runQuery(
      `select * from tweets ORDER BY tweet_created_at DESC;`
    );

    // const retweet = new Array(result.length).fill(0);
    for (let i = 0; i < result1.length; i++) {
      if (result1[i]["is_liked"] == 1) {
        checkLike[result1[i]["post_id"]] = 1;
      }
    }
    res.json(
      generalResponse(1, "tweet Listed", {
        Result: result,
        checkLike: checkLike,
        allpost: allPost,
      })
    );
  } catch (error) {
    console.log(error);
    res.json(generalResponse(0, "something went wrong"));
  }
};

exports.editUserDetail = async(req,res)=>{
try {
  let values = JSON.parse(JSON.stringify(req.body));
  const fileDetails = req.file;
  let filePath;
  let updateQueryUserDetails; 
  if (fileDetails) {
    filePath = fileDetails.path;
    values.image = fileDetails.mimetype  
    updateQueryUserDetails = 
    `update user_detail
    set first_name = '${values.fname}',
    last_name = '${values.lname}',
    contact_no ='${values.contact}',
    user_image = '${filePath}' 
    where email = '${values.email}';`;
    const userValidation = await validateUser(values);
    if (userValidation.error) {
      const message = userValidation.error.details[0]["message"];
      return res.json(generalResponse(0, message));
    }
  } else {
    updateQueryUserDetails = 
    `update user_detail
    set first_name = '${values.fname}',
    last_name = '${values.lname}',
    contact_no ='${values.contact}'
    where email = '${values.email}';`;
    const userValidation = await validateUserRegistration(values);
    if (userValidation.error) {
      const message = userValidation.error.details[0]["message"];
      return res.json(generalResponse(0, message));
    }
  }
  const result =await runQuery(updateQueryUserDetails);
  res.json(generalResponse(1,"Update succesfully"));
} catch (error) {
  console.log(error);
    res.json(generalResponse(0, "something went wrong"));
}
}

exports.getchats = async (req,res)=>{
  try {
    const userName = JSON.parse(JSON.stringify(req.body.userName))
    const getData = req.headers.authorization;
    const token = await getDataFromToken(getData);
    const chatType = JSON.parse(JSON.stringify(req.body.chatType))
console.log(chatType);
    let chatId;
    if(chatType=="group"){
      chatId = userName;
    }
   else if(token.email.length>=userName.length){
      chatId = `${token.email}-${userName}`;
    }
    else{
      chatId=`${userName}-${token.email}`
    }
    const selectChats = `select * from chats where chat_socket_id = '${chatId}'`;
    const resultOfSelectChats = await runQuery(selectChats);
    res.send(generalResponse(1,"chats fetch succesfully",{chats:resultOfSelectChats,email:token.email}))
  } catch (error) {
    console.log(error);
  }
}
exports.createGroup=async(req,res)=>{
  try {
    userDetails = JSON.parse(JSON.stringify(req.body))
    emailArray = userDetails.email;
    const getData = req.headers.authorization;
    const token = await getDataFromToken(getData);
    const date =new Date().getTime();
    groupId = `${token.email}-${date}`;
    emailArray.push(token.email);
    for(let i=0;i<emailArray.length;i++){
      insertQuery = `insert into group_details(group_name,group_member_name,group_socket_id)
      values
      ('${groupId}','${emailArray[i]}','${groupId}')`;
      await runQuery(insertQuery);
    }
    res.send(generalResponse(1,"group Created succesfully"))
  } catch (error) {
    console.log(error);
  }
}