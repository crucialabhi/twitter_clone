const express = require("express");
const app  = express();
const userRoutes = require("./routes/user.Routes")
const { getDataFromToken } = require("./middleware/jwtToken");
const { runQuery } = require("./database/databaseConnection");
const http = require('http').Server(app);
const io = require('socket.io')(http);
const port = 5000;



app.use("/", userRoutes)

io.on('connection', (socket) => {
  
  socket.on('join',async (data)=>{
    userName = data.userName;
    token = await getDataFromToken(data.token);
    msg = data.msg;
    let chatId;
    if(token.email.length>=userName.length){
      chatId = `${token.email}-${userName}`;
    }
    else{
      chatId=`${userName}-${token.email}`
    }


    socket.join(chatId)
  })
  socket.on('group-join',(data)=>{
    chatId = data.userName;
    socket.join(chatId);
  })

  socket.on('chat-message', async(data) => {
    chatType = data.chatType;
    userName = data.userName;
    token = await getDataFromToken(data.token);
    msg = data.msg;
    let chatId;
    if(chatType=="group"){
      chatId = userName
    }
    else if(token.email.length>=userName.length){
        chatId = `${token.email}-${userName}`;
      }
    else{
        chatId=`${userName}-${token.email}`
      }
    
   try {
    const insertMessage =`insert into chats (chat_content,chat_socket_id,chat_sender)values('${msg}','${chatId}','${token.email}')`;
    const result = await runQuery(insertMessage);
    io.to(chatId).emit('chat-message',{msg,userName,mainUser:token.email})
   } catch (error) {
    console.log(error);
   }
  });

  socket.on('disconnect',()=>{
      console.log("socket disconnected");
  })
});

http.listen(port, function () {
  console.log('listening on *:',port);
});

