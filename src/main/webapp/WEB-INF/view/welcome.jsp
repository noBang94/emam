<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.NoticeVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.WeatherVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/view/common/gnb.jsp"/>

<%
  MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
  List<NoticeVO> noticeList = (List<NoticeVO>) request.getAttribute("noticeList");
  String wSky = (String) request.getAttribute("wSky");
  String wPty = (String) request.getAttribute("wPty");
  String wT1h = (String) request.getAttribute("wT1h");
  int iSky = Integer.parseInt(wSky);
  int iPty = Integer.parseInt(wPty);
  int iT1h = Integer.parseInt(wT1h);
  List<String> realtimeKeywords = (List<String>) request.getAttribute("realtimeKeywords");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Charm:wght@400;700&family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
        rel="stylesheet">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>

  <style>
    :root {
      --primary-color: #64B5F6;
      --primary-hover: #90CAF9;
      --text-color: #333;
      --text-light: #666;
      --background-color: #f8fafc;
      --card-background: #fff;
      --border-color: #e2e8f0;
      --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
      --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      --radius: 0.5rem;
      --transition: all 0.2s ease;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: linear-gradient(to bottom, #e0f2fe, #ffffff);
      color: var(--text-color);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      padding: 1.5rem;
    }

    .main-container {
      width: 100%;
      max-width: 1200px;
      display: flex;
      flex-direction: column;
      align-items: center;
      min-height: 100vh;
      flex: 1;
    }

    .main-content {
      text-align: center;
      margin-top: 2rem;
      padding-top: 2rem;
      margin-bottom: 4rem;
      width: 100%;

    }

    .welcome-message {
      font-family: 'Charm', cursive;
      font-size: 2rem;
      font-weight: 700;
      color: var(--primary-color);
      margin-bottom: 1.5rem;
      letter-spacing: 0.05em;
    }

    .clock {
      font-size: 4.5rem;
      font-weight: 700;
      margin-bottom: 1.5rem;
      color: var(--text-color);
    }

    .date {
      font-size: 1.25rem;
      color: var(--text-light);
      margin-bottom: 2rem;
    }

    .weather-container {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      background-color: var(--card-background);
      border-radius: 9999px;
      padding: 0.75rem 1.5rem;
      box-shadow: var(--shadow-md);
    }

    .weather-container img {
      width: 40px;
      height: 40px;
      margin-right: 0.75rem;
    }

    .temperature {
      font-size: 1.25rem;
      font-weight: 500;
    }

    .cards-container {
      display: grid;
      grid-template-columns: repeat(1, 1fr);
      gap: 1.5rem;
      width: 100%;
      margin-bottom: 2.5rem;
    }

    @media (min-width: 768px) {
      .cards-container {
        grid-template-columns: repeat(3, 1fr);
      }
    }

    .card {
      background-color: var(--card-background);
      border-radius: var(--radius);
      box-shadow: var(--shadow-md);
      overflow: hidden;
      transition: var(--transition);
    }

    .card:hover {
      box-shadow: var(--shadow-lg);
      transform: translateY(-2px);
    }

    .card-header {
      padding: 1rem 1.5rem;
      border-bottom: 1px solid var(--border-color);
    }

    .card-header h2 {
      font-size: 1.25rem;
      font-weight: 600;
      color: var(--primary-color);
    }

    .card-content {
      padding: 1rem 1.5rem;
    }

    .notice-list ul {
      list-style: none;
      max-height: 130px;
      overflow-y: auto;
      padding: 3px;
    }

    .notice-list li {
      padding: 0.75rem 0.5rem;
      border-bottom: 1px solid var(--border-color);
      cursor: pointer;
      transition: var(--transition);
      font-size: 0.875rem;
    }

    .notice-list li:last-child {
      border-bottom: none;
    }

    .notice-list li:hover {
      background-color: rgba(0, 0, 0, 0.03);
    }

    .profile-block {
      cursor: pointer;
    }

    .profile-info {
      display: flex;
      justify-content: space-between;
      margin-bottom: 0.75rem;
      font-size: 0.875rem;
    }

    .profile-info-label {
      font-weight: 500;
    }

    .action-buttons {
      position: fixed;
      bottom: 1.5rem;
      right: 1.5rem;
      display: flex;
      gap: 0.5rem;
    }

    .btn {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      background-color: var(--primary-color);
      color: white;
      border: none;
      border-radius: var(--radius);
      padding: 0.5rem 1rem;
      font-size: 0.875rem;
      font-weight: 500;
      cursor: pointer;
      box-shadow: var(--shadow-sm);
      transition: var(--transition);
    }

    .btn:hover {
      background-color: var(--primary-hover);
    }

    .btn-icon {
      font-size: 1rem;
    }

    ::-webkit-scrollbar {
      width: 6px;
    }

    ::-webkit-scrollbar-track {
      background: #f1f1f1;
      border-radius: 10px;
    }

    ::-webkit-scrollbar-thumb {
      background: #c1c1c1;
      border-radius: 10px;
    }

    ::-webkit-scrollbar-thumb:hover {
      background: #a8a8a8;
    }
  </style>
</head>
<body>
<div class="main-container">
  <div class="main-content">
    <h1 class="welcome-message" id="welcomeMessage">
      <% if (loginMember != null) { %>
      <%= loginMember.getMem_nickname() %>, Welcome to our page!
      <% } else { %>
      환영합니다!
      <% } %>
    </h1>

    <div class="clock" id="time"></div>

    <div class="date" id="today"></div>

    <div class="weather-container">
      <img src="../.././images/weather_1_0.png" id="weatherImg" alt="Weather">
      <span class="temperature"><%=iT1h%>℃</span>
    </div>
  </div>

  <div class="cards-container">
    <div class="card notice-list">
      <div class="card-header">
        <h2>공지사항</h2>
      </div>
      <div class="card-content">
        <ul id="noticeList">
          <% if (noticeList != null && !noticeList.isEmpty()) { %>
          <% for (NoticeVO notice : noticeList) { %>
          <li onclick="viewNotice('<%= notice.getNotice_index() %>')">
            <%= notice.getNotice_title() %>
          </li>
          <% } %>
          <% } else { %>
          <li>등록된 공지사항이 없습니다.</li>
          <% } %>
        </ul>
      </div>
    </div>

    <div class="card additional-info-block">
      <div class="card-header">
        <h2>추가 정보</h2>
      </div>
      <div class="card-content">
        <ul>
          <li>가져올 수 없습니다.</li>
        </ul>
      </div>
    </div>

    <div class="card profile-block" onclick="goToProfile()">
      <div class="card-header">
        <h2>내 프로필</h2>
      </div>
      <div class="card-content">
        <% if (loginMember != null) { %>
        <div class="profile-info">
          <span class="profile-info-label">아이디:</span>
          <span><%= loginMember.getMem_id() %></span>
        </div>
        <div class="profile-info">
          <span class="profile-info-label">이름:</span>
          <span><%= loginMember.getMem_name() %></span>
        </div>
        <div class="profile-info">
          <span class="profile-info-label">닉네임:</span>
          <span><%= loginMember.getMem_nickname() %></span>
        </div>
        <% } else { %>
        <p class="text-center">로그인이 필요합니다.</p>
        <% } %>
      </div>
    </div>
  </div>

  <div class="action-buttons">
    <button onclick="location.href='<%=request.getContextPath()%>/chat'" class="btn btn-chat">
      <span class="btn-icon">💬</span>
      <span>채팅</span>
    </button>
  </div>
</div>

<script>
  function updateClock() {
    const now = new Date();
    const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
    const dayOfWeek = daysOfWeek[now.getDay()];
    const year = now.getFullYear();
    const month = (now.getMonth() + 1).toString().padStart(2, '0');
    const day = now.getDate().toString().padStart(2, '0');
    const hours = now.getHours();
    const minutes = now.getMinutes().toString().padStart(2, '0');
    const seconds = now.getSeconds().toString().padStart(2, '0');

    let ampm = 'AM';
    let displayHours = hours;

    if (hours >= 12) {
      ampm = 'PM';
      displayHours = hours % 12;
      if (displayHours === 0) {
        displayHours = 12;
      }
    }

    const todayString = year + '년 ' + month + '월 ' + day + '일 ' + dayOfWeek + '요일';
    const timeString = displayHours + ' : ' + minutes + ' : ' + seconds + ' ' + ampm;

    document.getElementById('today').textContent = todayString;
    document.getElementById('time').textContent = timeString;
  }

  updateClock();
  setInterval(updateClock, 1000);

  function viewNotice(noticeIndex) {
    location.href = "<%=request.getContextPath()%>/notice/noticeDetail.do?noticeIndex=" + noticeIndex;
  }

  function goToProfile() {
    location.href = "<%=request.getContextPath()%>/profile/profile.do";
  }

  $(function () {
    if ($('.notice-list ul li').length <= 5) {
      $('.notice-list ul').css('overflow-y', 'hidden');
    }

    switch (<%=iSky%>) {
      case 1 :
        switch (<%=iPty%>) {
          case 0 :
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_1_0.png");
            break;
        }
        break;
      case 2 :
      case 3 :
        switch (<%=iPty%>) {
          case 0 :
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_2_0.png");
            break;
          case 1 :
          case 5 :
          case 2 :
          case 6 :
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_2_1.png");
            break;
          case 3 :
          case 7 :
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_3_2.png");
            break;
        }
        break;
      case 4 :
        switch (<%=iPty%>) {
          case 0 :
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_3_0.png");
            break;
          case 1 :
          case 5 :
          case 2 :
          case 6 :
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_3_1.png");
            break;
          case 3 :
          case 7 :
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_3_2.png");
            break;
        }
        break;
    }

    //컨텐츠 외 클릭시 게시글 화면으로 이동
    $("body").on('click', function (e) {
      if (!$(e.target).closest('.gnb').length &&
          !$(e.target).closest('.notice-list').length &&
          !$(e.target).closest('.additional-info-block').length &&
          !$(e.target).closest('.profile-block').length &&
          !$(e.target).closest('.action-buttons').length
      ) {
        window.location.href = '/post/postList.do';
      }
    });
  });
</script>
</body>
</html>