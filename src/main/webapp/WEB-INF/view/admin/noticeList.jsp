<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.NoticeVO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>공지사항 관리</title>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f4f4;
    }
    .top-bar {
      background-color: #343a40;
      color: white;
      padding: 15px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .top-bar h2 {
      margin: 0;
      font-size: 24px;
    }
    .top-bar .back-btn {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    .top-bar .back-btn:hover {
      background-color: #0056b3;
    }
    .notice-list-container {
      width: 80%;
      margin: 50px auto;
    }
    .pagination-container {
      text-align: center;
      margin-top: 20px;
    }
    .action-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    .search-form {
      display: flex;
      align-items: flex-start;
    }
    .search-form .form-group {
      margin-right: 10px;
      display: flex;
    }
    .search-container .form-group {
      display: flex;
      align-items: center;
    }
    .search-container label {
      margin-right: 10px;
      white-space: nowrap;
    }
    .search-container input[type="text"] {
      padding: 8px 12px;
      border: 1px solid #ced4da;
      border-radius: 4px;
    }
    .search-container .btn-primary {
      margin-left: 10px;
    }
    .create-btn-container {
      margin-bottom: 20px;
      text-align: right;
    }
    .create-btn-container .btn-success {
      padding: 8px 15px;
    }
  </style>

  <script>
    $(function(){
      $("#backBtn").on("click", function(){
        window.location.href = "<%=request.getContextPath() %>/admin/adminMain.do";
      });
    });

    function deleteNotice(noticeIndex) {
      if (confirm("정말로 삭제하시겠습니까?")) {
        location.href = "<%=request.getContextPath() %>/admin/noticeDelete.do?noticeIndex=" + noticeIndex;
      }
    }
  </script>
</head>
<body>

<div class="top-bar">
  <h2>공지사항 관리</h2>
  <button id="backBtn" class="btn back-btn">뒤로가기</button>
</div>

<div class="notice-list-container">
  <div class="action-container">
    <form action="<%=request.getContextPath()%>/admin/noticeList.do" method="get" class="search-form">
      <div class="form-group">
        <label for="searchTitle" style="width: 90px">제목 검색 :</label>
        <input type="text" class="form-control" id="searchTitle" name="searchTitle" value="<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "" %>">
      </div>
      <button type="submit" class="btn btn-primary">검색</button>
    </form>
    <a href="<%=request.getContextPath()%>/admin/noticeCreate.do" class="btn btn-success">공지사항 작성</a>
  </div>

  <table class="table table-bordered table-hover">
    <thead>
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>내용</th>
      <th>작성일</th>
      <th>수정/삭제</th>
    </tr>
    </thead>
    <tbody>
    <%
      String errorMessage = (String) request.getAttribute("errorMessage");
      List<NoticeVO> noticeList = (List<NoticeVO>) request.getAttribute("noticeList");
      if (errorMessage == null && noticeList != null && !(noticeList.isEmpty())) {
        for (NoticeVO notice : noticeList) {
    %>
    <tr>
      <td><%= notice.getNotice_index() %></td>
      <td><%= notice.getNotice_title() %></td>
      <td><%= notice.getNotice_con() %></td>
      <td><%= notice.getNotice_date() %></td>
      <td>
        <a href="<%=request.getContextPath()%>/admin/noticeUpdate.do?noticeIndex=<%= notice.getNotice_index() %>" class="btn btn-primary btn-sm">수정</a>
        <button type="button" class="btn btn-danger btn-sm" onclick="deleteNotice('<%= notice.getNotice_index() %>')">삭제</button>
      </td>
    </tr>
    <%
      }
    } else if (errorMessage != null) {
    %>
    <tr>
      <td colspan="4" class="empty-message">
        <%= errorMessage %>
      </td>
    </tr>
    <%
    } else {
    %>
    <tr>
      <td colspan="4" class="empty-message">공지사항 목록이 없습니다.</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>
</body>
</html>