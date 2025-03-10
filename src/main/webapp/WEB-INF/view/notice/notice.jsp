<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.NoticeVO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>공지사항</title>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    :root {
      --primary-color: #64B5F6;
      --primary-hover: #90CAF9;
      --text-color: #333;
      --text-light: #666;
      --background-color: #f8fafc;
      --card-background: #fff;
      --border-color: #e2e8f0;
      --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
      --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      --radius: 0.5rem;
      --transition: all 0.2s ease;
    }

    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: linear-gradient(to bottom, #e0f2fe, #ffffff);
      color: var(--text-color);
      min-height: 100vh;
      margin-top: 60px;
      padding-bottom: 40px;
    }

    .notice-container {
      width: 90%;
      max-width: 1000px;
      margin: 80px auto 40px; /* 상단 여백 증가 */
      background-color: var(--card-background);
      border-radius: var(--radius);
      box-shadow: var(--shadow-lg);
      overflow: hidden;
      transition: var(--transition);
    }

    .notice-header {
      background-color: var(--primary-color);
      color: white;
      padding: 20px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .notice-header h2 {
      margin: 0;
      font-size: 24px;
      font-weight: 700;
    }

    .notice-content {
      padding: 30px;
    }

    .search-container {
      margin-bottom: 25px;
      display: flex;
      align-items: center;
      background-color: rgba(255, 255, 255, 0.8);
      border-radius: var(--radius);
      padding: 15px;
      box-shadow: var(--shadow-sm);
    }

    .search-form {
      display: flex;
      width: 100%;
      align-items: center;
    }

    .search-form .form-group {
      margin: 0;
      flex-grow: 1;
      display: flex;
      align-items: center;
    }

    .search-form label {
      margin-right: 15px;
      font-weight: 500;
      color: var(--text-color);
      white-space: nowrap;
    }

    .search-form input[type="text"] {
      flex-grow: 1;
      padding: 10px 15px;
      border: 1px solid var(--border-color);
      border-radius: var(--radius);
      font-size: 14px;
      transition: var(--transition);
    }

    .search-form input[type="text"]:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(100, 181, 246, 0.2);
      outline: none;
    }

    .search-form .btn-primary {
      background-color: var(--primary-color);
      border: none;
      padding: 10px 20px;
      margin-left: 15px;
      border-radius: var(--radius);
      font-weight: 500;
      transition: var(--transition);
    }

    .search-form .btn-primary:hover {
      background-color: var(--primary-hover);
      transform: translateY(-2px);
    }

    .notice-table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      border-radius: var(--radius);
      overflow: hidden;
      box-shadow: var(--shadow-md);
    }

    .notice-table thead th {
      background-color: #f1f5f9;
      color: var(--text-color);
      font-weight: 600;
      padding: 15px;
      text-align: center;
      border-bottom: 2px solid var(--border-color);
    }

    .notice-table tbody td {
      padding: 15px;
      border-bottom: 1px solid var(--border-color);
      text-align: center;
      transition: var(--transition);
      white-space: nowrap; /* 한 줄로 표시 */
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .notice-table tbody td.text-left {
      text-align: left;
      white-space: normal; /* 제목은 여러 줄 가능 */
    }

    .notice-table tbody tr:last-child td {
      border-bottom: none;
    }

    .notice-table tbody tr:hover td {
      background-color: rgba(100, 181, 246, 0.05);
    }

    .notice-table tbody td a {
      color: var(--text-color);
      text-decoration: none;
      transition: var(--transition);
      display: block;
      font-weight: 500;
    }

    .notice-table tbody td a:hover {
      color: var(--primary-color);
    }

    .empty-message {
      text-align: center;
      padding: 30px;
      color: var(--text-light);
      font-style: italic;
    }

    /* 페이지네이션 스타일 */
    .pagination-container {
      display: flex;
      justify-content: center;
      margin-top: 30px;
    }

    .pagination {
      display: inline-flex;
      background-color: white;
      border-radius: var(--radius);
      box-shadow: var(--shadow-md);
      overflow: hidden;
    }

    .pagination > li > a,
    .pagination > li > span {
      color: var(--text-color);
      border: none;
      margin: 0;
      transition: var(--transition);
      font-weight: 500;
      padding: 10px 15px;
    }

    .pagination > li > a:hover,
    .pagination > li > span:hover {
      background-color: rgba(100, 181, 246, 0.1);
      color: var(--primary-color);
    }

    .pagination > .active > a,
    .pagination > .active > span {
      background-color: var(--primary-color);
      color: white;
    }

    .pagination > .active > a:hover,
    .pagination > .active > span:hover {
      background-color: var(--primary-hover);
    }

    .pagination > .disabled > a,
    .pagination > .disabled > span {
      color: #ccc;
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
      .notice-container {
        width: 95%;
        margin-top: 70px;
      }

      .notice-header {
        padding: 15px 20px;
      }

      .notice-content {
        padding: 20px;
      }

      .search-container {
        flex-direction: column;
        align-items: stretch;
      }

      .search-form {
        flex-direction: column;
      }

      .search-form .form-group {
        margin-bottom: 10px;
      }

      .search-form label {
        margin-bottom: 5px;
        display: block;
      }

      .search-form .btn-primary {
        margin-left: 0;
        width: 100%;
      }

      .notice-table thead th:nth-child(1) {
        width: 60px;
      }

      .pagination > li > a,
      .pagination > li > span {
        padding: 8px 12px;
      }
    }
  </style>
</head>
<body>
<!-- GNB 인클루드 -->
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<div class="notice-container">
  <div class="notice-header">
    <h2>공지사항</h2>
  </div>

  <div class="notice-content">
    <div class="search-container">
      <form action="<%=request.getContextPath()%>/notice/notice.do" method="get" class="search-form">
        <div class="form-group">
          <label for="searchTitle">제목 검색</label>
          <input type="text" class="form-control" id="searchTitle" name="searchTitle"
                 value="<%= request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "" %>"
                 placeholder="검색어를 입력하세요">
        </div>
        <button type="submit" class="btn btn-primary">검색</button>
      </form>
    </div>

    <table class="notice-table">
      <thead>
      <tr>
        <th width="10%">번호</th>
        <th width="70%">제목</th>
        <th width="20%">작성일</th>
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
        <td class="text-left">
          <a href="<%=request.getContextPath()%>/notice/noticeDetail.do?noticeIndex=<%= notice.getNotice_index() %>">
            <%= notice.getNotice_title() %>
          </a>
        </td>
        <td><%= notice.getNotice_date() %></td>
      </tr>
      <%
        }
      } else if (errorMessage != null) {
      %>
      <tr>
        <td colspan="3" class="empty-message">
          <%= errorMessage %>
        </td>
      </tr>
      <%
      } else {
      %>
      <tr>
        <td colspan="3" class="empty-message">공지사항 목록이 없습니다.</td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="pagination-container">
      <ul class="pagination">
        <%
          // 페이지네이션 변수 설정
          int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
          int totalPages = request.getAttribute("totalPages") != null ? (Integer)request.getAttribute("totalPages") : 1;

          // 표시할 페이지 범위 계산
          int startPage = Math.max(1, currentPage - 2);
          int endPage = Math.min(totalPages, currentPage + 2);

          // 이전 페이지 링크
          if (currentPage > 1) {
        %>
        <li>
          <a href="<%=request.getContextPath()%>/notice/notice.do?page=<%= currentPage - 1 %><%= request.getParameter("searchTitle") != null ? "&searchTitle=" + request.getParameter("searchTitle") : "" %>" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
        <% } else { %>
        <li class="disabled">
          <span aria-hidden="true">&laquo;</span>
        </li>
        <% } %>

        <!-- 페이지 번호 -->
        <% for (int i = startPage; i <= endPage; i++) { %>
        <li class="<%= i == currentPage ? "active" : "" %>">
          <a href="<%=request.getContextPath()%>/notice/notice.do?page=<%= i %><%= request.getParameter("searchTitle") != null ? "&searchTitle=" + request.getParameter("searchTitle") : "" %>">
            <%= i %>
          </a>
        </li>
        <% } %>

        <!-- 다음 페이지 링크 -->
        <% if (currentPage < totalPages) { %>
        <li>
          <a href="<%=request.getContextPath()%>/notice/notice.do?page=<%= currentPage + 1 %><%= request.getParameter("searchTitle") != null ? "&searchTitle=" + request.getParameter("searchTitle") : "" %>" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
        <% } else { %>
        <li class="disabled">
          <span aria-hidden="true">&raquo;</span>
        </li>
        <% } %>
      </ul>
    </div>
  </div>
</div>

<script>
  $(function() {
    // 검색 입력 필드에 포커스가 있을 때 엔터키 처리
    $("#searchTitle").keypress(function(e) {
      if (e.which === 13) {
        e.preventDefault();
        $(this).closest("form").submit();
      }
    });

    // 날짜 형식 통일 (필요한 경우)
    $(".notice-table tbody td:last-child").each(function() {
      var dateText = $(this).text().trim();
      if(dateText.length > 10) {
        // 날짜 형식이 길 경우 YYYY-MM-DD 형식으로 변환
        var date = new Date(dateText);
        if(!isNaN(date.getTime())) {
          var formattedDate = date.getFullYear() + '-' +
                  ('0' + (date.getMonth() + 1)).slice(-2) + '-' +
                  ('0' + date.getDate()).slice(-2);
          $(this).text(formattedDate);
        }
      }
    });
  });
</script>
</body>
</html>

