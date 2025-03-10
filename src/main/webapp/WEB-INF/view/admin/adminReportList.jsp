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
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    :root {
      --primary-color: #64B5F6;
      --primary-light: #90CAF9;
      --primary-lighter: #BBDEFB;
      --primary-dark: #42A5F5;
      --primary-darker: #1E88E5;
      --accent-color: #4FC3F7;
      --secondary-color: #7986CB;
      --secondary-light: #9FA8DA;
      --secondary-dark: #5C6BC0;
      --tertiary-color: #4DD0E1;
      --text-color: #333;
      --text-light: #666;
      --background-color: #EBF5FE;
      --card-background: #fff;
      --border-color: #e2e8f0;
      --danger-color: #F08E95;
      --danger-hover: #E57373;
      --success-color: #81C784;
      --warning-color: #FFD54F;
      --info-color: #4DD0E1;
      --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
      --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
      --radius: 0.5rem;
      --transition: all 0.3s ease;
    }

    body {
      padding: 0;
      margin: 0;
      color: var(--text-color);
      font-family: 'Noto Sans KR', sans-serif;
      min-height: 100vh;
      position: relative;
      background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
    }

    body::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%2364b5f6' fill-opacity='0.15'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
      z-index: -1;
      opacity: 0.7;
    }

    .page-wrapper {
      position: relative;
      min-height: 100vh;
      overflow: hidden;
    }

    .bg-gradient-1 {
      position: absolute;
      width: 600px;
      height: 600px;
      border-radius: 50%;
      background: radial-gradient(circle, rgba(79, 195, 247, 0.2) 0%, rgba(79, 195, 247, 0) 70%);
      top: -300px;
      right: -200px;
      z-index: -1;
    }

    .bg-gradient-2 {
      position: absolute;
      width: 500px;
      height: 500px;
      border-radius: 50%;
      background: radial-gradient(circle, rgba(121, 134, 203, 0.2) 0%, rgba(121, 134, 203, 0) 70%);
      bottom: -200px;
      left: -100px;
      z-index: -1;
    }

    .bg-gradient-3 {
      position: absolute;
      width: 400px;
      height: 400px;
      border-radius: 50%;
      background: radial-gradient(circle, rgba(77, 208, 225, 0.15) 0%, rgba(77, 208, 225, 0) 70%);
      top: 30%;
      left: 10%;
      z-index: -1;
    }

    .top-bar {
      background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
      color: white;
      padding: 12px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .top-bar h2 {
      margin: 0;
      font-size: 22px;
      font-weight: 600;
      display: flex;
      align-items: center;
    }

    .top-bar h2::before {
      content: "\f3ed";
      font-family: "Font Awesome 5 Free";
      font-weight: 900;
      margin-right: 12px;
      font-size: 18px;
    }

    .button-container {
      display: flex;
      align-items: center;
    }

    .back-btn, .logout-btn {
      background-color: white;
      color: var(--primary-darker);
      border: none;
      padding: 6px 15px;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 500;
      transition: var(--transition);
      box-shadow: var(--shadow-sm);
      display: flex;
      align-items: center;
      margin-left: 10px;
      font-size: 13px;
    }

    .back-btn i, .logout-btn i {
      margin-right: 6px;
    }

    .back-btn:hover, .logout-btn:hover {
      background-color: #f8f9fa;
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .logout-btn {
      color: #dc3545;
    }

    .report-list-container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 12px;
      box-shadow: var(--shadow-lg);
      padding: 20px;
      margin: 30px auto;
      width: 90%;
      max-width: 1000px;
      border: 1px solid rgba(100, 181, 246, 0.2);
      position: relative;
      overflow: hidden;
      backdrop-filter: blur(5px);
    }

    .report-list-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-darker) 100%);
    }

    .action-container {
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .search-form {
      display: flex;
      align-items: center;
    }

    .search-form .form-group {
      display: flex;
      align-items: center;
      margin-bottom: 0;
      margin-right: 10px;
    }

    .search-form label {
      margin-right: 10px;
      font-weight: 500;
      color: var(--text-color);
      white-space: nowrap;
      width: 100px;
    }

    .search-form input[type="text"] {
      height: 36px;
      border: 1px solid var(--border-color);
      border-radius: 6px;
      padding: 6px 12px;
      font-size: 13px;
      transition: var(--transition);
      box-shadow: none;
    }

    .search-form input[type="text"]:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(100, 181, 246, 0.2);
    }

    .btn-primary {
      background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
      color: white;
      border: none;
      height: 36px;
      padding: 0 15px;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 500;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 13px;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .table {
      border-collapse: separate;
      border-spacing: 0;
      width: 100%;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: var(--shadow-sm);
      margin-bottom: 20px;
      font-size: 13px;
    }

    .table thead th {
      background: linear-gradient(135deg, var(--primary-lighter) 0%, var(--primary-light) 100%);
      color: var(--text-color);
      font-weight: 600;
      padding: 12px;
      text-align: left;
      border: none;
      font-size: 14px;
    }

    .table tbody tr {
      background-color: white;
      transition: var(--transition);
      cursor: pointer;
    }

    .table tbody tr:hover {
      background-color: rgba(100, 181, 246, 0.05);
    }

    .table tbody td {
      padding: 10px 12px;
      border-top: 1px solid var(--border-color);
      vertical-align: middle;
    }

    .empty-message {
      text-align: center;
      padding: 20px;
      color: var(--text-light);
      font-style: italic;
    }

    .wave-container {
      position: absolute;
      width: 100%;
      bottom: 0;
      left: 0;
      height: 120px;
      overflow: hidden;
      z-index: -1;
    }

    .wave {
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 80px;
      background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%2364B5F6" fill-opacity="0.2" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
      background-size: 1440px 80px;
      animation: wave 20s linear infinite;
    }

    .wave:nth-child(2) {
      bottom: 0;
      animation: wave 15s linear reverse infinite;
      opacity: 0.7;
      background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%237986CB" fill-opacity="0.2" d="M0,64L48,80C96,96,192,128,288,128C384,128,480,96,576,90.7C672,85,768,107,864,144C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
    }

    @keyframes wave {
      0% {
        background-position-x: 0;
      }
      100% {
        background-position-x: 1440px;
      }
    }

    @media (max-width: 992px) {
      .report-list-container {
        width: 95%;
        padding: 15px;
      }

      .action-container {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
      }

      .search-form {
        width: 100%;
      }

      .search-form .form-group {
        width: 100%;
      }

      .search-form input[type="text"] {
        width: 100%;
      }
    }

    @media (max-width: 768px) {
      .top-bar {
        padding: 10px 15px;
      }

      .table-responsive {
        border: none;
      }

      .search-form {
        flex-direction: column;
        align-items: flex-start;
      }

      .search-form .form-group {
        margin-bottom: 15px;
      }

      .btn-primary {
        width: 100%;
        margin-left: 0;
      }
    }
  </style>

  <script>
    $(function(){
      $("#backBtn").on("click", function(){
        window.location.href = "<%=request.getContextPath() %>/admin/adminMain.do";
      });
      $("#logoutBtn").on("click", function(){
        window.location.href = "<%=request.getContextPath() %>/admin/adminLogout.do";
      });
    });

    function showReportDetail(reportId) {
      window.location.href = "<%=request.getContextPath()%>/admin/processReport.do?reportId=" + reportId;
    }
  </script>
</head>
<body>
<div class="page-wrapper">
  <div class="bg-gradient-1"></div>
  <div class="bg-gradient-2"></div>
  <div class="bg-gradient-3"></div>

  <div class="top-bar">
    <h2>신고 관리</h2>
    <div class="button-container">
      <button id="backBtn" class="back-btn"><i class="fas fa-arrow-left"></i> 뒤로가기</button>
      <button id="logoutBtn" class="logout-btn"><i class="fas fa-sign-out-alt"></i> 로그아웃</button>
    </div>
  </div>

  <div class="report-list-container">
    <div class="action-container">
      <form action="<%=request.getContextPath()%>/admin/reportList.do" method="get" class="search-form">
        <div class="form-group">
          <label for="searchTitle">신고자 검색 :</label>
          <input type="text" class="form-control" id="searchTitle" name="searchTitle" value="<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "" %>" placeholder="검색할 신고자명을 입력하세요">
          <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> 검색</button>
        </div>
      </form>
    </div>

    <div class="table-responsive">
      <table class="table">
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
          <td style="color: <%= report.getReportProdate() == null ? "red" : "inherit" %>;">
            <%= report.getReportProdate() == null ? "미처리" : report.getReportProdate() %>
          </td>
          <td style="color: <%= "N".equals(report.getReportStatus()) ? "red" : "inherit" %>;">
            <%= "Y".equals(report.getReportStatus()) ? "처리 완료" : "미처리" %>
          </td>
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
  </div>

  <div class="wave-container">
    <div class="wave"></div>
    <div class="wave"></div>
  </div>
</div>
</body>
</html>