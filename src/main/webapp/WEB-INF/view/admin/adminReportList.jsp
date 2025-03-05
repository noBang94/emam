<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.ReportVO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>신고 관리</title>

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
    .report-list-container {
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
  </style>

  <script>
    $(function(){
      $("#backBtn").on("click", function(){
        window.location.href = "<%=request.getContextPath() %>/admin/adminMain.do";
      });
    });

    function showReportDetail(reportId) {
      window.location.href = "<%=request.getContextPath()%>/admin/processReport.do?reportId=" + reportId;
    }
  </script>
</head>
<body>

<div class="top-bar">
  <h2>신고 관리</h2>
  <button id="backBtn" class="btn back-btn">뒤로가기</button>
</div>

<div class="report-list-container">
  <div class="action-container">
    <form action="<%=request.getContextPath()%>/admin/reportList.do" method="get" class="search-form">
      <div class="form-group">
        <label for="searchTitle" style="width: 130px">신고자 검색 :</label>
        <input type="text" class="form-control" id="searchTitle" name="searchTitle" value="<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "" %>">
      </div>
      <button type="submit" class="btn btn-primary">검색</button>
    </form>
  </div>

  <table class="table table-bordered table-hover">
    <thead>
    <tr>
      <th>번호</th>
      <th>신고자명</th>
      <th>신고 대상</th>
      <th>신고 유형</th>
      <th>신고 내역</th>
      <th>신고일</th>
      <th>처리 날짜</th>
      <th>처리 상태</th>
    </tr>
    </thead>
    <tbody>
    <%
      String errorMessage = (String) request.getAttribute("errorMessage");
      List<ReportVO> reportList = (List<ReportVO>) request.getAttribute("reportList");
      if (errorMessage == null && reportList != null && !(reportList.isEmpty())) {
        for (ReportVO report : reportList) {
          if(report == null) {
            continue;
          }
    %>
    <tr onclick="showReportDetail('<%= report.getReportId() %>')" style="cursor: pointer;">
      <td><%= report.getReportId() %></td>
      <td><%= report.getFromId() %></td>
      <td><%= report.getToId() %></td>
      <td><%= report.getReportType() %></td>
      <td><%= report.getReportContent() %></td>
      <td><%= report.getReportDate() %></td>
      <td><%= report.getReportProdate() == null ? "미처리" : report.getReportProdate() %></td>
      <td><%= "Y".equals(report.getReportStatus()) ? "처리 완료" : "미처리" %></td>
    </tr>
    <%
      }
    } else if (errorMessage != null) {
    %>
    <tr>
      <td colspan="8" class="empty-message">
        <%= errorMessage %>
      </td>
    </tr>
    <%
    } else {
    %>
    <tr>
      <td colspan="8" class="empty-message">신고 게시글 목록이 없습니다.</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>
</body>
</html>