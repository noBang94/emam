<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.NoticeVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.WeatherVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>welcom</title>
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>

  <%
    //세션 로그인 값
    MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");

    //컨트롤러에서 자료 받기
    List<NoticeVO> noticeList = (List<NoticeVO>) request.getAttribute("noticeList");
    String wSky = (String) request.getAttribute("wSky");

  %>

  <script>
    //일시 구하기
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

    // 매 초마다 시계 업데이트
    setInterval(updateClock, 1000);

    // 페이지 로드 시에도 시계 업데이트
    updateClock();

    $(function () {
      $(document).on('click', '.row', function() {
        const num = $(this).data("num"); //선택한 글<td>이 가진 data-num(index)를 가져와 num에 저장
        $("#viewNum").val(num);
        $("#viewForm").submit();
      });
    });

  </script>
  <style>
    div.main {
      height: 200px;
      width: 200px;
      border: 1px solid black;
    }

  </style>
</head>
<body>
<div class="topArea">
  <div>

  </div>
    <div id="today">Loading...</div>
    <div id="weather"><%=wSky%></div>
    <div id="time">Loading...</div>
</div>

<div class="mainArea">
  <div class="main" id="noticeArea">
    <p>공지사항</p>
    <table>
<%
  if(noticeList != null){
    for(NoticeVO noticeVo : noticeList){
%>
      <tr class="row" data-num="<%=noticeVo.getNotice_index()%>">
        <td><%=noticeVo.getNotice_date()%></td>
        <td><%=noticeVo.getNotice_title()%></td>
      </tr>
<%
    }
  }
%>
    </table>
  </div>
  <div class="main" id="notificationArea">
    알림 영역
  </div>
  <div class="main" id="profileArea">
    프로필 영역
    <div id="profilePhoto" style="border-radius: 50%">
      프로필 사진 영역
    </div>
      <% if (loginMember != null) { %>
        계정ID : <p><%=loginMember.getMem_id()%></p>
      <% } else { %>
        <p>로그인 정보가 없습니다.</p>
      <% } %>
  </div>
  <!-- 테스트용 -->
  <input type="button" value="문의" onclick="location.href='<%=request.getContextPath()%>/inquiry/inquiryList.do'">
</div>

<!-- 공지사항 View 폼 -->
<form action="<%=request.getContextPath()%>/notice/noticeView.do" method="get" id="viewForm">
  <input type="hidden" name="num" id="viewNum">
</form>

</body>
</html>
