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
      padding: 15px 30px;
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
      font-size: 24px;
      font-weight: 600;
      display: flex;
      align-items: center;
    }

    .top-bar h2::before {
      content: "\f075";
      font-family: "Font Awesome 5 Free";
      font-weight: 900;
      margin-right: 12px;
      font-size: 20px;
    }

    .back-btn {
      background-color: white;
      color: var(--primary-darker);
      border: none;
      padding: 8px 20px;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 500;
      transition: var(--transition);
      box-shadow: var(--shadow-sm);
      display: flex;
      align-items: center;
    }

    .back-btn i {
      margin-right: 8px;
    }

    .back-btn:hover {
      background-color: #f8f9fa;
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .container-wrapper {
      max-width: 1200px;
      margin: 40px auto;
      padding: 0 20px;
      position: relative;
      z-index: 1;
    }

    .notice-list-container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 16px;
      box-shadow: var(--shadow-lg);
      padding: 30px;
      margin-bottom: 40px;
      border: 1px solid rgba(100, 181, 246, 0.2);
      position: relative;
      overflow: hidden;
      backdrop-filter: blur(5px);
    }

    .notice-list-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 5px;
      background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-darker) 100%);
    }

    .action-container {
      margin-bottom: 25px;
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
    }

    .search-form label {
      margin-right: 15px;
      font-weight: 500;
      color: var(--text-color);
      white-space: nowrap;
    }

    .search-form input[type="text"] {
      height: 40px;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      padding: 8px 15px;
      font-size: 14px;
      transition: var(--transition);
      box-shadow: none;
      width: 250px;
    }

    .search-form input[type="text"]:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(100, 181, 246, 0.2);
    }

    .search-btn {
      background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
      color: white;
      border: none;
      height: 40px;
      padding: 0 20px;
      border-radius: 8px;
      margin-left: 10px;
      cursor: pointer;
      font-weight: 500;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .search-btn i {
      margin-right: 8px;
    }

    .search-btn:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .create-btn {
      background: linear-gradient(135deg, var(--success-color) 0%, #4CAF50 100%);
      color: white;
      border: none;
      height: 40px;
      padding: 0 20px;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 500;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .create-btn i {
      margin-right: 8px;
    }

    .create-btn:hover {
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
      margin-bottom: 25px;
    }

    .table thead th {
      background: linear-gradient(135deg, var(--primary-lighter) 0%, var(--primary-light) 100%);
      color: var(--text-color);
      font-weight: 600;
      padding: 15px;
      text-align: left;
      border: none;
      font-size: 15px;
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
      padding: 15px;
      border-top: 1px solid var(--border-color);
      vertical-align: middle;
      font-size: 14px;
    }

    .empty-message {
      text-align: center;
      padding: 30px;
      color: var(--text-light);
      font-style: italic;
    }

    .pagination-container {
      display: flex;
      justify-content: center;
      margin-top: 30px;
    }

    .pagination {
      display: flex;
      list-style: none;
      padding: 0;
      margin: 0;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: var(--shadow-sm);
    }

    .pagination li {
      margin: 0;
    }

    .pagination li a {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 40px;
      height: 40px;
      background-color: white;
      color: var(--text-color);
      text-decoration: none;
      border: 1px solid var(--border-color);
      border-right: none;
      transition: var(--transition);
    }

    .pagination li:last-child a {
      border-right: 1px solid var(--border-color);
    }

    .pagination li.active a {
      background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
      color: white;
      border-color: var(--primary-color);
    }

    .pagination li a:hover:not(.active) {
      background-color: var(--primary-lighter);
    }

    .wave-container {
      position: absolute;
      width: 100%;
      bottom: 0;
      left: 0;
      height: 150px;
      overflow: hidden;
      z-index: -1;
    }

    .wave {
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 100px;
      background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%2364B5F6" fill-opacity="0.2" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
      background-size: 1440px 100px;
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
      .container-wrapper {
        padding: 0 15px;
        margin: 30px auto;
      }

      .notice-list-container {
        padding: 20px;
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

      .create-btn {
        width: 100%;
      }
    }

    @media (max-width: 768px) {
      .top-bar {
        padding: 15px 20px;
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

      .search-btn {
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
    });

    function deleteNotice(noticeIndex) {
      if (confirm("정말로 삭제하시겠습니까?")) {
        location.href = "<%=request.getContextPath() %>/admin/noticeDelete.do?noticeIndex=" + noticeIndex;
      }
    }

    function showNoticeDetail(noticeIndex) {
      location.href = "<%=request.getContextPath()%>/admin/noticeUpdate.do?noticeIndex=" + noticeIndex;
    }
  </script>
</head>
<body>
<div class="page-wrapper">
  <div class="bg-gradient-1"></div>
  <div class="bg-gradient-2"></div>
  <div class="bg-gradient-3"></div>

  <div class="top-bar">
    <h2>공지사항 관리</h2>
    <button id="backBtn" class="back-btn"><i class="fas fa-arrow-left"></i> 뒤로가기</button>
  </div>

  <div class="container-wrapper">
    <div class="notice-list-container">
      <div class="action-container">
        <form action="<%=request.getContextPath()%>/admin/noticeList.do" method="get" class="search-form">
          <div class="form-group">
            <label for="searchTitle">제목 검색 :</label>
            <input type="text" class="form-control" id="searchTitle" name="searchTitle" value="<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "" %>" placeholder="검색할 제목을 입력하세요">
            <button type="submit" class="search-btn"><i class="fas fa-search"></i> 검색</button>
          </div>
        </form>
        <a href="<%=request.getContextPath()%>/admin/noticeCreate.do" class="create-btn"><i class="fas fa-plus"></i> 공지사항 작성</a>
      </div>

      <div class="table-responsive">
        <table class="table">
          <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>내용</th>
            <th>작성일</th>
          </tr>
          </thead>
          <tbody>
          <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            List<NoticeVO> noticeList = (List<NoticeVO>) request.getAttribute("noticeList");
            if (errorMessage == null && noticeList != null && !(noticeList.isEmpty())) {
              for (NoticeVO notice : noticeList) {
          %>
          <tr onclick="showNoticeDetail('<%= notice.getNotice_index() %>')" style="cursor: pointer;">
            <td><%= notice.getNotice_index() %></td>
            <td><%= notice.getNotice_title() %></td>
            <td><%= notice.getNotice_con() %></td>
            <td><%= notice.getNotice_date() %></td>
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

      <div class="pagination-container">
        <ul class="pagination">
          <%
            int currentPage = (Integer) request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 1;
            int totalPages = (Integer) request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
            int startPage = Math.max(1, currentPage - 5);
            int endPage = Math.min(totalPages, currentPage + 5);

            if (currentPage > 1) {
          %>
          <li><a href="<%=request.getContextPath() %>/admin/noticeList.do?page=<%= currentPage - 1 %>&searchTitle=<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "" %>">&laquo;</a></li>
          <%
            }

            for (int i = startPage; i <= endPage; i++) {
          %>
          <li <%= currentPage == i ? "class='active'" : "" %>><a href="<%=request.getContextPath() %>/admin/noticeList.do?page=<%= i %>&searchTitle=<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "" %>"><%= i %></a></li>
          <%
            }

            if (currentPage < totalPages) {
          %>
          <li><a href="<%=request.getContextPath() %>/admin/noticeList.do?page=<%= currentPage + 1 %>&searchTitle=<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "" %>">&raquo;</a></li>
          <%
            }
          %>
        </ul>
      </div>
    </div>
  </div>

  <div class="wave-container">
    <div class="wave"></div>
    <div class="wave"></div>
  </div>
</div>
</body>
</html>