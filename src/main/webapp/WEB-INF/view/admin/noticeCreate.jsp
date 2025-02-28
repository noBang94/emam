<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.or.ddit.emam.vo.NoticeVO" %>
<%
  NoticeVO noticeVO = (NoticeVO) request.getAttribute("noticeVO");
  String mode = (String) request.getAttribute("mode");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title><%= "update".equals(mode) ? "공지사항 수정" : "공지사항 작성" %></title>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f4f4;
    }
    .notice-form-container {
      width: 80%;
      margin: 50px auto;
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .form-group {
      margin-bottom: 20px;
    }
    label {
      font-weight: bold;
    }
    textarea {
      resize: vertical;
    }
    .btn-container {
      text-align: center;
      margin-top: 20px;
    }
  </style>

  <script>
    $(function(){
      $("#cancelBtn").on("click", function(){
        window.location.href = "<%=request.getContextPath() %>/admin/noticeList.do";
      });
    });
  </script>
</head>
<body>

<div class="notice-form-container">
  <h2><%= "update".equals(mode) ? "공지사항 수정" : "공지사항 작성" %></h2>
  <form action="<%=request.getContextPath() %>/admin/noticeUpdate.do" method="post">
    <% if ("update".equals(mode)) { %>
    <input type="hidden" name="noticeIndex" value="<%= noticeVO.getNotice_index() %>">
    <input type="hidden" name="mode" value="update">
    <% } %>
    <div class="form-group">
      <label for="noticeTitle">제목</label>
      <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" value="<%= "update".equals(mode) ? noticeVO.getNotice_title() : "" %>" required>
    </div>
    <div class="form-group">
      <label for="noticeCon">내용</label>
      <textarea class="form-control" id="noticeCon" name="noticeCon" rows="10" required><%= "update".equals(mode) ? noticeVO.getNotice_con() : "" %></textarea>
    </div>
    <div class="btn-container">
      <button type="submit" class="btn btn-primary"><%= "update".equals(mode) ? "수정 완료" : "작성 완료" %></button>
      <button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
    </div>
  </form>
</div>
</body>
</html>