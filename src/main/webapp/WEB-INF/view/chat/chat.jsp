<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>웹 채팅</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

  <style>
    :root {
      --primary-color: #64B5F6;
      --primary-light: #90CAF9;
      --primary-lighter: #BBDEFB;
      --primary-dark: #42A5F5;
      --primary-darker: #1E88E5;
      --accent-color: #4FC3F7;
      --secondary-color: #7986CB;
      --secondary-light: #9FA8DA;
      --secondary-dark: #5C6BC0;
      --tertiary-color: #4DD0E1;
      --text-color: #333;
      --text-light: #666;
      --background-color: #EBF5FE;
      --card-background: #fff;
      --border-color: #e2e8f0;
      --danger-color: #F08E95;
      --danger-hover: #E57373;
      --success-color: #81C784;
      --warning-color: #FFD54F;
      --info-color: #4DD0E1;
      --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
      --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
      --radius: 0.5rem;
      --transition: all 0.3s ease;
    }

    body {
      padding: 0;
      margin: 0;
      color: var(--text-color);
      font-family: 'Noto Sans KR', sans-serif;
      min-height: 100vh;
      position: relative;
      background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
    }

    body::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%2364b5f6' fill-opacity='0.15'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
      z-index: -1;
      opacity: 0.7;
    }

    .page-wrapper {
      position: relative;
      min-height: 100vh;
      overflow: hidden;
      padding-bottom: 50px;
      /* gnb 아래로 내리기 위해 상단 패딩 추가 */
      padding-top: 100px;
    }

    .bg-gradient-1 {
      position: absolute;
      width: 600px;
      height: 600px;
      border-radius: 50%;
      background: radial-gradient(circle, rgba(79, 195, 247, 0.2) 0%, rgba(79, 195, 247, 0) 70%);
      top: -300px;
      right: -200px;
      z-index: -1;
    }

    .bg-gradient-2 {
      position: absolute;
      width: 500px;
      height: 500px;
      border-radius: 50%;
      background: radial-gradient(circle, rgba(121, 134, 203, 0.2) 0%, rgba(121, 134, 203, 0) 70%);
      bottom: -200px;
      left: -100px;
      z-index: -1;
    }

    .bg-gradient-3 {
      position: absolute;
      width: 400px;
      height: 400px;
      border-radius: 50%;
      background: radial-gradient(circle, rgba(77, 208, 225, 0.15) 0%, rgba(77, 208, 225, 0) 70%);
      top: 30%;
      left: 10%;
      z-index: -1;
    }

    .chat-container {
      display: flex;
      justify-content: space-between;
      width: 90%;
      max-width: 1100px;
      margin: 0 auto;
      position: relative;
      z-index: 1;
    }

    .chat-box {
      width: 75%;
      transition: var(--transition);
    }

    .card {
      border: none;
      border-radius: 16px;
      box-shadow: var(--shadow-lg);
      background-color: rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(5px);
      overflow: hidden;
      position: relative;
      border: 1px solid rgba(100, 181, 246, 0.2);
    }

    .card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-darker) 100%);
    }

    .card-header {
      background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
      color: white;
      font-weight: 600;
      padding: 15px 20px;
      border: none;
      display: flex;
      align-items: center;
    }

    .card-header::before {
      content: "\f075";
      font-family: "Font Awesome 5 Free";
      font-weight: 900;
      margin-right: 12px;
      font-size: 18px;
    }

    .card-body {
      padding: 20px;
    }

    #chatArea {
      height: 550px;
      overflow-y: auto;
      padding: 15px;
      font-size: 15px;
      background-color: rgba(249, 249, 249, 0.8);
      display: flex;
      flex-direction: column;
      border-radius: 12px;
      border: 1px solid var(--border-color);
      box-shadow: var(--shadow-sm) inset;
    }

    #chatArea::-webkit-scrollbar {
      width: 8px;
    }

    #chatArea::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 10px;
    }

    #chatArea::-webkit-scrollbar-thumb {
      background: var(--primary-light);
      border-radius: 10px;
    }

    #chatArea::-webkit-scrollbar-thumb:hover {
      background: var(--primary-color);
    }

    .message {
      padding: 10px 15px;
      margin: 5px 0;
      border-radius: 18px;
      max-width: 70%;
      clear: both;
      display: inline-block;
      word-break: break-word;
      box-shadow: var(--shadow-sm);
      position: relative;
      animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .my-message {
      background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
      color: white;
      align-self: flex-end;
      border-bottom-right-radius: 5px;
    }

    .my-message::after {
      content: '';
      position: absolute;
      bottom: 0;
      right: -8px;
      width: 15px;
      height: 15px;
      background: var(--primary-darker);
      border-bottom-left-radius: 15px;
      z-index: -1;
    }

    .other-message {
      background: white;
      color: var(--text-color);
      align-self: flex-start;
      border-bottom-left-radius: 5px;
      border: 1px solid var(--border-color);
    }

    .other-message::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: -8px;
      width: 15px;
      height: 15px;
      background: white;
      border-bottom-right-radius: 15px;
      border-left: 1px solid var(--border-color);
      border-bottom: 1px solid var(--border-color);
      z-index: -1;
    }

    .system-message {
      text-align: center;
      color: var(--text-light);
      font-weight: 500;
      margin: 10px 0;
      padding: 8px 15px;
      background-color: rgba(0, 0, 0, 0.05);
      border-radius: 20px;
      align-self: center;
      font-size: 13px;
      max-width: 80%;
    }

    .input-group {
      margin-top: 15px;
      box-shadow: var(--shadow-md);
      border-radius: 12px;
      overflow: hidden;
    }

    #messageInput {
      font-size: 15px;
      padding: 12px 15px;
      border: 1px solid var(--border-color);
      border-right: none;
      transition: var(--transition);
    }

    #messageInput:focus {
      box-shadow: none;
      border-color: var(--primary-color);
    }

    .btn-primary {
      background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
      color: white;
      border: none;
      padding: 0 20px;
      font-weight: 500;
      transition: var(--transition);
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .user-list {
      width: 23%;
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 16px;
      box-shadow: var(--shadow-lg);
      padding: 20px;
      overflow-y: auto;
      max-height: 650px;
      position: relative;
      border: 1px solid rgba(100, 181, 246, 0.2);
      backdrop-filter: blur(5px);
    }

    .user-list::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 4px;
      background: linear-gradient(90deg, var(--secondary-color) 0%, var(--secondary-dark) 100%);
    }

    .user-list h5 {
      text-align: center;
      color: var(--primary-darker);
      font-weight: 600;
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 2px solid var(--primary-lighter);
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .user-list h5::before {
      content: "\f500";
      font-family: "Font Awesome 5 Free";
      font-weight: 900;
      margin-right: 8px;
      font-size: 16px;
    }

    #userList {
      list-style-type: none;
      padding: 0;
    }

    #userList li {
      padding: 10px 15px;
      margin-bottom: 8px;
      background-color: white;
      border-radius: 8px;
      box-shadow: var(--shadow-sm);
      transition: var(--transition);
      display: flex;
      align-items: center;
      font-size: 14px;
    }

    #userList li::before {
      content: "\f007";
      font-family: "Font Awesome 5 Free";
      font-weight: 900;
      margin-right: 8px;
      color: var(--primary-color);
    }

    #userList li:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
      background-color: var(--primary-lighter);
    }

    .wave-container {
      position: absolute;
      width: 100%;
      bottom: 0;
      left: 0;
      height: 120px;
      overflow: hidden;
      z-index: -1;
    }

    .wave {
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 80px;
      background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%2364B5F6" fill-opacity="0.2" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
      background-size: 1440px 80px;
      animation: wave 20s linear infinite;
    }

    .wave:nth-child(2) {
      bottom: 0;
      animation: wave 15s linear reverse infinite;
      opacity: 0.7;
      background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%237986CB" fill-opacity="0.2" d="M0,64L48,80C96,96,192,128,288,128C384,128,480,96,576,90.7C672,85,768,107,864,144C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
    }

    @keyframes wave {
      0% {
        background-position-x: 0;
      }
      100% {
        background-position-x: 1440px;
      }
    }

    @media (max-width: 992px) {
      .chat-container {
        flex-direction: column;
        width: 95%;
      }

      .chat-box {
        width: 100%;
        margin-bottom: 20px;
      }

      .user-list {
        width: 100%;
        max-height: 300px;
      }

      #chatArea {
        height: 450px;
      }
    }

    @media (max-width: 576px) {
      .card-header, .card-body {
        padding: 15px;
      }

      #chatArea {
        height: 400px;
        padding: 10px;
      }

      .message {
        max-width: 85%;
      }
    }
  </style>
</head>
<body>

<div class="page-wrapper">
  <div class="bg-gradient-1"></div>
  <div class="bg-gradient-2"></div>
  <div class="bg-gradient-3"></div>

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
          <div class="input-group">
            <input type="text" id="messageInput" class="form-control" placeholder="메시지를 입력하세요..." onkeydown="handleKeyDown(event)">
            <div class="input-group-append">
              <button class="btn btn-primary" onclick="sendMessage()"><i class="fas fa-paper-plane mr-1"></i> 전송</button>
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

  <div class="wave-container">
    <div class="wave"></div>
    <div class="wave"></div>
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

  const socket = new WebSocket('ws://192.168.35.42:8080/chat-ws');

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
    const disconnectMessage = document.createElement("div");
    disconnectMessage.className = "system-message";
    disconnectMessage.textContent = "시스템: 채팅 서버 연결이 끊어졌습니다.";
    chatArea.appendChild(disconnectMessage);
    chatArea.scrollTop = chatArea.scrollHeight;
  };

  socket.onerror = (error) => {
    console.error('WebSocket Error:', error);
    const errorMessage = document.createElement("div");
    errorMessage.className = "system-message";
    errorMessage.textContent = "시스템: 웹소켓 연결 중 오류가 발생했습니다.";
    chatArea.appendChild(errorMessage);
    chatArea.scrollTop = chatArea.scrollHeight;
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
      // "나:" 접두사를 제거하고 메시지 내용만 표시
      message = message.replace(username + ":", "").trim();
    } else if (message.startsWith("시스템:")) {
      messageDiv.className = "system-message";
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