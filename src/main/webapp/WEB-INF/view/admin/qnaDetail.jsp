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
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f4f4;
    }
    .detail-container {
      width: 80%;
      margin: 50px auto;
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .detail-title {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .detail-info {
      margin-bottom: 15px;
    }
    .detail-info strong {
      display: inline-block;
      width: 100px;
      font-weight: bold;
    }
    .detail-content {
      margin-top: 20px;
      border-top: 1px solid #ddd;
      padding-top: 20px;
    }
    .comment-container {
      margin-top: 30px;
      border-top: 1px solid #ddd;
      padding-top: 20px;
    }
    .comment-item {
      background-color: #f9f9f9;
      padding: 15px;
      border-radius: 5px;
      margin-bottom: 10px;
      border: 1px solid #eee;
    }
    .comment-item strong {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .comment-date {
      font-size: 0.8em;
      color: #888;
      margin-top: 5px;
      display: block;
    }
  </style>
</head>
<body>

<div class="detail-container">
  <%
    InquiryVO inquiry = (InquiryVO) request.getAttribute("inquiry");
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (inquiry != null) {
  %>
  <div class="detail-title"><%= inquiry.getInquiry_title() %></div>
  <div class="detail-info"><strong>작성자:</strong> <%= inquiry.getMem_id() %></div>
  <div class="detail-info"><strong>작성일:</strong> <%= inquiry.getInquiry_date() %></div>
  <div class="detail-info"><strong>공개 여부:</strong> <%= inquiry.getInquiry_ispublic() == 1 ? "공개" : "비공개" %></div>
  <div class="detail-content"><strong>문의 내용:</strong><br><%= inquiry.getInquiry_con() %></div>

  <div class="comment-container">
    <h3>댓글</h3>
    <form action="<%=request.getContextPath() %>/admin/qnaComment.do" method="post">
      <input type="hidden" name="inquiryIndex" value="<%= inquiry.getInquiry_index() %>">
      <div class="form-group">
        <textarea class="form-control" name="commentContent" rows="3" placeholder="댓글을 입력하세요."></textarea>
      </div>
      <button type="submit" class="btn btn-primary">댓글 등록</button>
    </form>

    <%
      String commentContent = inquiry.getInquiry_comment(); // 댓글 내용을 inquiry_comment에서 가져옴
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
    <p>댓글이 없습니다.</p>
    <%
      }
    %>
  </div>

  <%
  } else if (errorMessage != null) {
  %>
  <p class="text-danger"><%= errorMessage %></p>
  <%
  } else {
  %>
  <p class="text-danger">문의 정보를 찾을 수 없습니다.</p>
  <%
    }
  %>
  <a href="<%=request.getContextPath() %>/admin/qnaList.do" class="btn btn-secondary">목록으로</a>
</div>

</body>
</html>