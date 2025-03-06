<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.NoticeVO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Charm:wght@400;700&display=swap" rel="stylesheet">
  <title>Welcome</title>
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

    function goToProfile() {
      location.href = "<%=request.getContextPath()%>/profile.do"; // 프로필 페이지 URL로 변경
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

    .main-content {
      text-align: center;
      position: absolute;
      top: 35%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 5;
    }

    .clock {
      font-size: 90px;
      font-weight: bold;
      position: relative;
      display: inline-block;
      white-space: nowrap; /* 추가 */
      margin-top:40px;
    }

    .greeting {
      font-size: 30px;
      display: inline-block;
      margin: 30px 20px 0 20px;
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

    .notice-profile-container {
      position: absolute;
      top: 65%;
      left: 50%;
      transform: translate(-50%, -50%);
      display: flex;
      justify-content: center;
      width: 960px; /* 세 블록의 너비를 합쳐서 설정 */
    }

    .notice-list, .profile-block, .additional-info-block {
      background-color: white;
      border: 1px solid #ddd;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      text-align: center;
      width: 350px;
      margin: 0 10px; /* 블록 사이 간격 */
      z-index: 4;
    }

    .notice-list h2, .profile-block h2, .additional-info-block h2 {
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


    .profile-block p {
      margin-bottom: 10px;
      line-height: 1.5;
      cursor: pointer;
    }

    .profile-block {
      border-left: 1px solid #ddd;
      padding-left: 30px;
      cursor: pointer;
    }

    .additional-info-block {
      border-left: 1px solid #ddd;
      padding-left: 30px;
    }

    img#weatherImg {
      height: auto;
      max-height: 40px; /* 최대 높이 조정 */
      width: auto;
      max-width: 40px; /* 최대 너비 조정 */
      position: relative;
      top: 5px; /* 이미지 위치 조정 */
      margin-right: 5px;
    }

    .welcome-message {
      font-size: 32px;
      font-family: "Charm", cursive;
      margin-top: 5px;
      margin-bottom: 20px;
      font-weight: bold;
      color: #333;
      display: block;
      position: relative;
      top: -5px;
      letter-spacing: 2px;
      white-space: nowrap; /* 추가 */
    }

  </style>
</head>
<body>
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
<div class="main-content">
  <div class="welcome-message">
    <% if (loginMember != null) { %>
    <%= loginMember.getMem_id() %>, Welcome to our page!
    <% } else { %>
    환영합니다!
    <% } %>
  </div>
  <div class="clock" id="time"></div>
  <div class="greeting" id="today"></div>

</div>

<div class="tasks">
  <input type="button" value="신고"
         onclick="location.href='<%=request.getContextPath()%>/report.do'">
</div>

<div class="notice-profile-container">
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
  <div class="additional-info-block">
    <h2>추가 정보</h2>
    <p>여기에 추가 정보를 표시합니다.</p>
    <p></p>
  </div>
  <div class="profile-block" onclick="goToProfile()">
    <h2>내 프로필</h2>
    <% if (loginMember != null) { %>
    <p>아이디: <%= loginMember.getMem_id() %></p>
    <p>이름: <%= loginMember.getMem_name() %></p>
    <p>닉네임: <%= loginMember.getMem_nickname() %></p>
    <% } else { %>
    <p>로그인이 필요합니다.</p>
    <% } %>
  </div>
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