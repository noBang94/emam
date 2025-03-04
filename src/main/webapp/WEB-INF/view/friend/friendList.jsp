<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>친구 목록</title>
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>

<%
  //세션 로그인 값
  MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");

  //컨트롤러에서 자료 받기
  List<MemberVO> friendList =(List<MemberVO>)request.getAttribute("friendList");
  int totalFriend = (Integer)request.getAttribute("totalFriend");
%>

  <script>
    $(function (){

    });
  </script>
</head>
<body>
<h3>친구 목록</h3>
<p>전체 친구 수 <%=totalFriend%></p>
<div id="result">
  <table class="resultTable">
    <tr>
      <th>친구 아이디</th>
      <th>친구 닉네임</th>
    </tr>
<%
  if(friendList==null || friendList.size()==0){
%>
    <tr>
      <td colspan="2" style="text-align: center;">등록된 친구가 없습니다.</td>
    </tr>
<%
  }else {
    for(MemberVO vo : friendList){
%>
    <tr class="row">
      <td><%=vo.getMem_id()%></td>
      <td><%=vo.getMem_nickname()%></td>
    </tr>
<%
    } //for문 종료
  } //if else문 종료
%>

  </table>
</div>
</body>
</html>