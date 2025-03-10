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
  <title>공지사항 상세</title>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>
    :root {
      --primary-color: #64B5F6;
      --primary-hover: #90CAF9;
      --secondary-color: #64B5F6;
      --secondary-hover: #90CAF9;
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

    .notice-detail-container {
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

    .notice-title {
      margin-bottom: 20px;
      padding-bottom: 15px;
      border-bottom: 1px solid var(--border-color);
    }

    .notice-title h3 {
      font-size: 22px;
      font-weight: 700;
      color: var(--text-color);
      margin: 0 0 10px 0;
    }

    .notice-date {
      font-size: 14px;
      color: var(--text-light);
      display: block;
      margin-bottom: 5px;
    }

    .notice-body {
      margin-top: 25px;
      margin-bottom: 30px;
    }

    .notice-body textarea {
      width: 100%;
      min-height: 300px;
      padding: 15px;
      border: 1px solid var(--border-color);
      border-radius: var(--radius);
      background-color: #f9fafc;
      color: var(--text-color);
      font-size: 15px;
      line-height: 1.6;
      resize: none;
    }

    .notice-body textarea:focus {
      outline: none;
    }

    .btn-container {
      display: flex;
      justify-content: center;
      gap: 15px;
      margin-top: 30px;
    }

    .btn {
      padding: 10px 20px;
      font-size: 15px;
      font-weight: 500;
      border: none;
      border-radius: var(--radius);
      cursor: pointer;
      transition: var(--transition);
    }

    .btn-primary {
      background-color: var(--primary-color);
      color: white;
    }

    .btn-primary:hover {
      background-color: var(--primary-hover);
      transform: translateY(-2px);
    }

    .btn-secondary {
      background-color: var(--secondary-color);
      color: white;
    }

    .btn-secondary:hover {
      background-color: var(--secondary-hover);
      transform: translateY(-2px);
    }

    .btn-tertiary {
      background-color: #6c757d;
      color: white;
    }

    .btn-tertiary:hover {
      background-color: #5a6268;
      transform: translateY(-2px);
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
      .notice-detail-container {
        width: 95%;
        margin-top: 70px;
      }

      .notice-header {
        padding: 15px 20px;
      }

      .notice-content {
        padding: 20px;
      }

      .btn-container {
        flex-direction: column;
        gap: 10px;
      }

      .btn {
        width: 100%;
      }
    }
  </style>

  <script>
    $(function() {
      $("#listBtn").on("click", function () {
        window.location.href = "<%=request.getContextPath() %>/notice/notice.do";
      });

      // textarea 내용에 따라 높이 자동 조절
      function adjustTextareaHeight() {
        const textarea = document.getElementById('noticeCon');
        textarea.style.height = 'auto';
        textarea.style.height = (textarea.scrollHeight) + 'px';
      }

      // 페이지 로드 시 textarea 높이 자동 조절
      adjustTextareaHeight();

      // 창 크기 변경 시 textarea 높이 재조절
      $(window).resize(function() {
        adjustTextareaHeight();
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
        error: function(xhr, status, error) {
          console.error("Error navigating to notice:", error);
          alert("공지사항을 불러오는 중 오류가 발생했습니다.");
        }
      });
    }
  </script>
</head>
<body>
<!-- GNB 인클루드 -->
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<div class="notice-detail-container">
  <div class="notice-header">
    <h2>공지사항</h2>
  </div>

  <div class="notice-content">
    <div class="notice-title">
      <h3><%= noticeVO.getNotice_title() %></h3>
      <span class="notice-date">작성일: <%= noticeVO.getNotice_date() %></span>
    </div>

    <div class="notice-body">
      <textarea id="noticeCon" readonly><%= noticeVO.getNotice_con() %></textarea>
    </div>

    <div class="btn-container">
      <button type="button" class="btn btn-primary" onclick="navigateNotice(-1)">이전글</button>
      <button type="button" class="btn btn-tertiary" id="listBtn">목록으로</button>
      <button type="button" class="btn btn-secondary" onclick="navigateNotice(1)">다음글</button>
    </div>
  </div>
</div>
</body>
</html>

