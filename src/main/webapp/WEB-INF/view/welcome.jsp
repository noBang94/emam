<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
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
  %>

  <script>
    $(function () {

    })

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
  로고/날짜/시간/날씨 영역
</div>

<div class="mainArea">
  <div class="main" id="noticeArea">
    공지사항 영역
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
</div>
</body>
</html>
