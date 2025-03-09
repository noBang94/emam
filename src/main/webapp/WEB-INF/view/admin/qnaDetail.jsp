<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.or.ddit.emam.vo.InquiryVO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>문의 상세</title>

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
      max-width: 900px;
      margin: 40px auto;
      padding: 0 20px;
      position: relative;
      z-index: 1;
    }

    .inquiry-detail-container {
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

    .inquiry-detail-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 5px;
      background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-darker) 100%);
    }

    .inquiry-detail-container h2 {
      color: var(--text-color);
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 25px;
      padding-bottom: 15px;
      border-bottom: 1px solid var(--border-color);
      display: flex;
      align-items: center;
    }

    .inquiry-detail-container h2::before {
      content: "\f075";
      font-family: "Font Awesome 5 Free";
      font-weight: 900;
      margin-right: 12px;
      font-size: 20px;
      color: var(--primary-color);
    }

    .detail-info {
      margin-bottom: 20px;
    }

    .detail-info strong {
      font-weight: 600;
      color: var(--text-color);
      display: inline-block;
      width: 100px;
    }

    .detail-content {
      background-color: var(--background-color);
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 30px;
    }

    .comment-section {
      margin-top: 30px;
      border-top: 1px solid var(--border-color);
      padding-top: 20px;
    }

    .comment-form textarea {
      border: 1px solid var(--border-color);
      border-radius: 8px;
      padding: 12px 15px;
      width: 100%;
      margin-bottom: 15px;
    }

    .comment-item {
      background-color: var(--background-color);
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 15px;
    }

    .btn-container {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
      margin-top: 20px;
    }

    .btn {
      padding: 10px 20px;
      border-radius: 8px;
      font-weight: 500;
      transition: var(--transition);
    }

    .btn-primary {
      background-color: var(--primary-color);
      color: white;
      border: none;
    }

    .btn-primary:hover {
      background-color: var(--primary-dark);
    }

    .btn-secondary {
      background-color: var(--secondary-color);
      color: white;
      border: none;
    }

    .btn-secondary:hover {
      background-color: var(--secondary-dark);
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

    @media (max-width: 768px) {
      .container-wrapper {
        padding: 0 15px;
        margin: 30px auto;
      }

      .inquiry-detail-container {
        padding: 20px;
      }

      .btn-container {
        flex-direction: column;
      }

      .btn {
        width: 100%;
        margin-bottom: 10px;
      }
    }
  </style>
</head>
<body>
<div class="page-wrapper">
  <div class="bg-gradient-1"></div>
  <div class="bg-gradient-2"></div>
  <div class="bg-gradient-3"></div>

  <div class="top-bar">
    <h2>문의 상세</h2>
    <a href="<%=request.getContextPath() %>/admin/qnaList.do" class="back-btn"><i class="fas fa-arrow-left"></i> 목록으로</a>
  </div>

  <div class="container-wrapper">
    <div class="inquiry-detail-container">
      <%
        InquiryVO inquiry = (InquiryVO) request.getAttribute("inquiry");
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (inquiry != null) {
      %>
      <h2><%= inquiry.getInquiry_title() %></h2>
      <div class="detail-info"><strong>작성자:</strong> <%= inquiry.getMem_id() %></div>
      <div class="detail-info"><strong>작성일:</strong> <%= inquiry.getInquiry_date() %></div>
      <div class="detail-info">
        <strong>공개 여부:</strong>
        <span class="label <%= inquiry.getInquiry_ispublic() == 1 ? "label-success" : "label-default" %>">
          <%= inquiry.getInquiry_ispublic() == 1 ? "공개" : "비공개" %>
        </span>
      </div>
      <div class="detail-content">
        <strong>문의 내용:</strong><br>
        <%= inquiry.getInquiry_con() %>
      </div>

      <div class="comment-section">
        <h3>댓글</h3>
        <form action="<%=request.getContextPath() %>/admin/qnaComment.do" method="post">
          <input type="hidden" name="inquiryIndex" value="<%= inquiry.getInquiry_index() %>">
          <div class="form-group">
            <textarea class="form-control" name="commentContent" rows="3" placeholder="댓글을 입력하세요."></textarea>
          </div>
          <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> 댓글 등록</button>
        </form>

        <%
          String commentContent = inquiry.getInquiry_comment();
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
          if (commentContent != null && !commentContent.isEmpty()) {
        %>
        <div class="comment-item">
          <strong>관리자:</strong> <%= commentContent %>
          <% if (inquiry.getInquiry_comment_date() != null) { %>
          <span class="comment-date"><%= sdf.format(inquiry.getInquiry_comment_date()) %></span>
          <% } %>
        </div>
        <%
        } else {
        %>
        <p class="text-muted">댓글이 없습니다.</p>
        <%
          }
        %>
      </div>

      <%
      } else if (errorMessage != null) {
      %>
      <div class="alert alert-danger"><%= errorMessage %></div>
      <%
      } else {
      %>
      <div class="alert alert-danger">문의 정보를 찾을 수 없습니다.</div>
      <%
        }
      %>
    </div>
  </div>

  <div class="wave-container">
    <div class="wave"></div>
    <div class="wave"></div>
  </div>
</div>
</body>
</html>