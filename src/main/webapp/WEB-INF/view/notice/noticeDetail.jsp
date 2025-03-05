<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.or.ddit.emam.vo.NoticeVO" %>
<%
  NoticeVO noticeVO = (NoticeVO) request.getAttribute("noticeVO");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>공지사항</title>

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
    .notice-content-box {
      border: 1px solid #ccc;
      padding: 10px;
    }
  </style>

  <script>
    $(function(){
      $("#listBtn").on("click", function(){
        window.location.href = "<%=request.getContextPath() %>/notice/notice.do";
      });
    });

    function navigateNotice(offset) {
      let currentIndex = <%= noticeVO != null ? noticeVO.getNotice_index() : -1 %>;
      let targetIndex = currentIndex + offset;

      $.ajax({
        url: "<%=request.getContextPath() %>/notice/noticeDetail.do",
        type: "get",
        data: { noticeIndex: targetIndex },
        success: function (response) {
          if(response !== "null" && response !== "") {
            window.location.href = "<%=request.getContextPath() %>/notice/noticeDetail.do?noticeIndex=" + targetIndex;
          } else {
            if(offset === -1) {
              alert("이전 글이 없습니다.");
            } else {
              alert("다음 글이 없습니다.");
            }
          }
        },
      });
    }
  </script>
</head>
<body>
<div class="notice-form-container">
  <h2>공지사항</h2>
  <form action="<%=request.getContextPath() %>/notice/noticeDetail.do" method="get">
    <div class="notice-content-box">
      <div class="notice-title-box">
        <h3 style="font-weight: bold;"><%= noticeVO.getNotice_title() %></h3>
      </div>
      <div class="form-group">
        <p>작성일: <%= noticeVO.getNotice_date() %></p>
      </div>
      <div class="form-group">
        <label for="noticeCon">내용: </label>
        <textarea class="form-control" id="noticeCon" name="noticeCon" readonly><%= noticeVO.getNotice_con() %></textarea>
      </div>
    </div>
    <div class="btn-container">
      <button type="button" class="btn btn-primary" onclick="navigateNotice(-1)">이전글</button>
      <button type="button" class="btn btn-tertiary" id="listBtn">목록으로</button>
      <button type="button" class="btn btn-secondary" onclick="navigateNotice(1)">다음글</button>
    </div>
  </form>
</div>
</body>
</html>