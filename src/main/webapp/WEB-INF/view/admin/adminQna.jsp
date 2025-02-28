<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.InquiryVO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>문의 관리</title>

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
    .inquiry-list-container {
      width: 80%;
      margin: 50px auto;
    }
    .search-container {
      margin-bottom: 20px;
      display: flex;
      justify-content: flex-end;
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
    .inquiry-title-link {
      cursor: pointer;
      color: blue;
      text-decoration: underline;
    }
    .unprocessed {
      color: red;
      font-weight: bold;
    }
  </style>

  <script>
    $(function(){
      $("#logoutBtn").on("click", function(){
        window.location.href = "<%=request.getContextPath() %>/admin/adminLogout.do";
      });
    });

    function showInquiryDetail(inquiryIndex) {
      window.location.href = "<%=request.getContextPath() %>/admin/qnaDetail.do?inquiryIndex=" + inquiryIndex;
    }
  </script>
</head>
<body>

<div class="top-bar">
  <h2>문의 관리</h2>
  <button id="logoutBtn" class="btn logout-btn">로그아웃</button>
</div>

<div class="inquiry-list-container">
  <div class="search-container">
    <form action="<%=request.getContextPath() %>/admin/qnaList.do" method="get" class="form-inline">
      <div class="form-group">
        <label for="searchTitle">제목 검색:</label>
        <input type="text" class="form-control" id="searchTitle" name="searchTitle" value="<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "" %>">
      </div>
      <button type="submit" class="btn btn-primary">검색</button>
    </form>
  </div>

  <table class="table table-bordered table-hover">
    <thead>
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>처리 상태</th>
    </tr>
    </thead>
    <tbody>
    <%
      String errorMessage = (String) request.getAttribute("errorMessage");
      List<InquiryVO> inquiryList = (List<InquiryVO>) request.getAttribute("inquiryList");
      if (errorMessage == null && inquiryList != null && !inquiryList.isEmpty()) {
        for (InquiryVO inquiry : inquiryList) {
    %>
    <tr>
      <td><%= inquiry.getInquiry_index() %></td>
      <td><span class="inquiry-title-link" onclick="showInquiryDetail('<%= inquiry.getInquiry_index() %>')"><%= inquiry.getInquiry_title() %></span></td>
      <td><%= inquiry.getMem_id() %></td>
      <td><%= inquiry.getInquiry_date() %></td>
      <td>
        <%
          String comment = inquiry.getInquiry_comment();
          if (comment != null && !comment.trim().isEmpty()) {
        %>
        처리 완료
        <% } else { %>
        <span class="unprocessed">미처리</span>
        <% } %>
      </td>
    </tr>
    <%
      }
    } else if (errorMessage != null) {
    %>
    <tr>
      <td colspan="5" class="empty-message">
        <%= errorMessage %>
      </td>
    </tr>
    <%
    } else {
    %>
    <tr>
      <td colspan="5" class="empty-message">문의 목록이 없습니다.</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>

</body>
</html>