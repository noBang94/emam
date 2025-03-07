<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>웹 채팅</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    .container {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 600px; /* 채팅창 너비 유지 */
      height: 800px; /* 채팅창 높이 증가 */
    }
    #chatArea {
      height: 600px; /* 채팅 영역 높이 증가 */
      resize: none;
    }
  </style>
</head>
<body>
<div class="container mt-5">
  <div class="card">
    <div class="card-header">
      웹 채팅 - <span id="username"></span>
    </div>
    <div class="card-body">
      <textarea id="chatArea" class="form-control mb-3" readonly></textarea>
      <div class="input-group">
        <input type="text" id="messageInput" class="form-control" placeholder="메시지를 입력하세요..." onkeydown="handleKeyDown(event)">
        <div class="input-group-append">
          <button class="btn btn-primary" onclick="sendMessage()">전송</button>
        </div>
      </div>
    </div>
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
          })
          .catch(error => {
            console.error('Error:', error);
          });

  const chatArea = document.getElementById('chatArea');
  const messageInput = document.getElementById('messageInput');
  const socket = new WebSocket('ws://localhost:8080/chat-ws');

  socket.onopen = (event) => {
    chatArea.value += '채팅 서버에 연결되었습니다.\n';
  };

  socket.onmessage = (event) => {
    try {
      const message = event.data;
      chatArea.value += message + '\n';
      chatArea.scrollTop = chatArea.scrollHeight;
    } catch (error) {
      console.error("Error handling message:", error);
    }
  };

  socket.onclose = (event) => {
    chatArea.value += '채팅 서버 연결이 끊어졌습니다.\n';
  };

  socket.onerror = (error) => {
    console.error('WebSocket Error:', error);
    alert('웹소켓 연결 중 오류가 발생했습니다.');
  };

  function sendMessage() {
    const message = messageInput.value;
    if (message.trim() === '') return;

    chatArea.value += '나: ' + message + '\n';
    chatArea.scrollTop = chatArea.scrollHeight;
    socket.send(username + ': ' + message);
    messageInput.value = '';
  }

  let isComposing = false; // IME 조합 중 여부

  messageInput.addEventListener('compositionstart', () => {
    isComposing = true;
  });

  messageInput.addEventListener('compositionend', () => {
    isComposing = false;
  });

  function handleKeyDown(event) {
    if (event.key === 'Enter' && !isComposing) {
      event.preventDefault();
      sendMessage();
    }
  }

  socket.addEventListener('error', (event) => {
    console.error('WebSocket send Error:', event);
    alert('메시지 전송 중 오류가 발생했습니다.');
  });
</script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
