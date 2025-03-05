<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.NoticeVO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Welcom</title>
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script
          src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script
          src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>

  <%
    MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
    List<NoticeVO> noticeList = (List<NoticeVO>) request.getAttribute("noticeList");
    String wSky = (String) request.getAttribute("wSky");
    String wPty = (String) request.getAttribute("wPty");
    String wT1h = (String) request.getAttribute("wT1h");
    int iSky = Integer.parseInt(wSky);
    int iPty = Integer.parseInt(wPty);
    int iT1h = Integer.parseInt(wT1h);
  %>

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

      const todayString = year + "년 " + month + "월 " + day + "일 " + dayOfWeek + "요일";
      const timeString = displayHours + " : " + minutes + " : " + seconds + " " + ampm;
      document.getElementById('today').textContent = todayString;
      document.getElementById('time').textContent = timeString;
    }

    setInterval(updateClock, 1000);
    updateClock();

    function viewNotice(noticeIndex) {
      location.href = "<%=request.getContextPath()%>/notice/noticeDetail.do?noticeIndex=" + noticeIndex;
    }
  </script>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: white;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      min-height: 100vh;
      position: relative;
    }

    .top-bar {
      background-color: #343a40;
      color: white;
      width: 100%;
      padding: 10px 20px;
      position: fixed;
      top: 0;
      left: 0;
      z-index: 10;
      box-sizing: border-box;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .top-bar .welcome {
      font-size: 18px;
    }

    .top-bar .logout-btn {
      background-color: #dc3545;
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .top-bar .logout-btn:hover {
      background-color: #c82333;
    }

    .main-content {
      text-align: center;
      position: absolute;
      top: 40%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 5;
    }

    .clock {
      font-size: 80px;
      font-weight: bold;
      position: relative;
    }

    .greeting {
      font-size: 30px;
      margin-top: 20px;
    }

    .tasks {
      position: absolute;
      bottom: 20px;
      right: 20px;
    }

    .tasks button {
      margin-left: 10px;
      padding: 8px 15px;
      border-radius: 5px;
      border: none;
      background-color: #007bff;
      color: white;
      cursor: pointer;
    }

    .tasks button:hover {
      background-color: #0056b3;
    }

    .notice-list {
      position: absolute;
      top: 65%; /* 공지사항 위치 조정 */
      left: 50%;
      transform: translate(-50%, -50%);
      background-color: white;
      border: 1px solid #ddd;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      text-align: center;
      width: 300px;
      z-index: 4;
    }

    .notice-list h2 {
      font-size: 24px;
      margin-bottom: 20px;
    }

    .notice-list ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    .notice-list li {
      padding: 10px 0;
      border-bottom: 1px solid #eee;
      cursor: pointer;
      font-size: 16px;
    }

    .notice-list li:last-child {
      border-bottom: none;
    }

    img#weatherImg {
      height: 20px;
      width: 20px;
    }
  </style>
</head>
<body>

<div class="top-bar">
  <div class="welcome">
    <% if (loginMember != null) { %>
    <%= loginMember.getMem_id() %>님, 환영합니다!
    <% } else { %>
    로그인이 필요합니다.
    <% } %>
  </div>
  <button class="logout-btn"
          onclick="location.href='<%=request.getContextPath()%>/member/logout.do'">
    로그아웃
  </button>
</div>

<div class="main-content">
  <div class="clock" id="time"></div>
  <div class="greeting" id="today"></div>
  <img src="" id="weatherImg"><%=iT1h%>℃
</div>

<div class="tasks">
  <input type="button" value="문의"
         onclick="location.href='<%=request.getContextPath()%>/inquiry/inquiryList.do'">
  <input type="button" value=신고"
         onclick="location.href='<%=request.getContextPath()%>/report.do'">
  <input type="button" value="친구목록"
         onclick="location.href='<%=request.getContextPath()%>/friend/friendList.do'">
</div>

<div class="notice-list">
  <h2>공지사항</h2>
  <ul>
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

<script>
  $(function () {
    //날씨에 따른 날씨이미지 변경
    switch (<%=iSky%>){
      case 1 : //구름없음
        switch (<%=iPty%>){
          case 0 : //눈비없음
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_1_0.png");
            break;
        }
        break;
      case 2 :
      case 3 : //구름조금
        switch (<%=iPty%>){
          case 0 : //눈비없음
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_2_0.png");
            break;
          case 1 : //비
          case 5 : //약간 비
          case 2 : //비/눈
          case 6 : //약간 비/눈
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_2_1.png");
            break;
          case 3 : //눈
          case 7 : //약간 눈
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_3_2.png");
            break;
        }
        break;
      case 4 : //구름많음
        switch (<%=iPty%>){
          case 0 : //눈비없음
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_3_0.png");
            break;
          case 1 : //비
          case 5 : //약간 비
          case 2 : //비/눈
          case 6 : //약간 비/눈
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_3_1.png");
            break;
          case 3 : //눈
          case 7 : //약간 눈
            document.getElementById("weatherImg").setAttribute("src", "../.././images/weather_3_2.png");
            break;
        }
        break;
    }
  });
</script>
</body>
</html>