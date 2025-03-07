<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>웹 채팅</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    .chat-container {
      display: flex;
      justify-content: space-between;
      width: 900px;
      height: 900px;
      margin: 70px auto 0;
    }
    .chat-box {
      width: 700px;
    }
    .user-list {
      width: 180px;
      border-left: 1px solid #ccc;
      padding: 10px;
      overflow-y: auto;
      max-height: 850px;
    }
    .user-list h5 {
      text-align: center;
    }
    #chatArea {
      height: 700px;
      overflow-y: auto;
      border: 1px solid #ccc;
      padding: 10px;
      font-size: 16px;
      background-color: #f9f9f9;
      display: flex;
      flex-direction: column; /* 새로운 메시지가 아래로 추가되도록 설정 */
    }
    #messageInput {
      font-size: 16px;
    }
    .message {
      padding: 8px 12px;
      margin: 5px 0;
      border-radius: 8px;
      max-width: 70%;
      clear: both;
      display: inline-block;
    }
    .my-message {
      background-color: #007bff;
      color: white;
      align-self: flex-end;
    }
    .other-message {
      background-color: #e5e5e5;
      color: black;
      align-self: flex-start;
    }
    .system-message {
      text-align: center;
      color: gray;
      font-weight: bold;
    }
  </style>
</head>
<body>

<div class="chat-container">
  <div class="chat-box">
    <div class="card">
      <div class="card-header">
        웹 채팅 - <span id="username"></span>
      </div>
      <div class="card-body">
        <div id="chatArea">
          <div id="systemMessage" class="system-message">시스템: 채팅 서버에 연결되었습니다.</div>
        </div>
        <div class="input-group mt-3">
          <input type="text" id="messageInput" class="form-control" placeholder="메시지를 입력하세요..." onkeydown="handleKeyDown(event)">
          <div class="input-group-append">
            <button class="btn btn-primary" onclick="sendMessage()">전송</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="user-list">
    <h5>접속자 목록</h5>
    <ul id="userList"></ul>
  </div>
</div>

<script>
  let username = '';

  fetch('<%= request.getContextPath() %>/chat/user')
          .then(response => {
            if (!response.ok) {
              window.location.href = '<%= request.getContextPath() %>/member/loginMember.do';
              throw new Error('로그인이 필요합니다.');
            }
            return response.json();
          })
          .then(data => {
            username = data.mem_nickname;
            document.getElementById('username').textContent = username;
            socket.send("JOIN:" + username);
          })
          .catch(error => console.error('Error:', error));

  const chatArea = document.getElementById('chatArea');
  const messageInput = document.getElementById('messageInput');
  const userListElement = document.getElementById('userList');
  const systemMessageDiv = document.getElementById("systemMessage");

  const socket = new WebSocket('ws://localhost:8080/chat-ws');

  socket.onopen = () => {
    console.log("Connected to chat server.");
  };

  socket.onmessage = (event) => {
    try {
      const message = event.data;
      if (message.startsWith("USERLIST:")) {
        updateUserList(message.substring(9).split(","));
      } else {
        displayMessage(message);
      }
    } catch (error) {
      console.error("Error handling message:", error);
    }
  };

  socket.onclose = () => {
    systemMessageDiv.textContent = "시스템: 채팅 서버 연결이 끊어졌습니다.";
  };

  socket.onerror = (error) => {
    console.error('WebSocket Error:', error);
    alert('웹소켓 연결 중 오류가 발생했습니다.');
  };

  function sendMessage() {
    const message = messageInput.value.trim();
    if (message === '') return;

    socket.send(username + ': ' + message);
    messageInput.value = '';
  }

  function displayMessage(message) {
    const messageDiv = document.createElement("div");

    if (message.startsWith(username + ":")) {
      messageDiv.className = "message my-message";
      message = message.replace(username + ":", "나:");
    } else {
      messageDiv.className = "message other-message";
    }

    messageDiv.textContent = message;
    chatArea.appendChild(messageDiv);
    chatArea.scrollTop = chatArea.scrollHeight;
  }

  function updateUserList(users) {
    userListElement.innerHTML = "";
    users.forEach(user => {
      if (user.trim() !== "") {
        const li = document.createElement("li");
        li.textContent = user;
        userListElement.appendChild(li);
      }
    });
  }

  let isComposing = false;
  messageInput.addEventListener('compositionstart', () => isComposing = true);
  messageInput.addEventListener('compositionend', () => isComposing = false);

  function handleKeyDown(event) {
    if (event.key === 'Enter' && !isComposing) {
      event.preventDefault();
      sendMessage();
    }
  }
</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>