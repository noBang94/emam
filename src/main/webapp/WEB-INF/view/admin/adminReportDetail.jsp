<%@ page import="kr.or.ddit.emam.vo.ReportVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ReportVO reportVO = (ReportVO) request.getAttribute("reportVO");
  if (reportVO == null) {
    reportVO = new ReportVO();
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>신고 상세</title>

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

    .report-detail-container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 12px;
      box-shadow: var(--shadow-lg);
      padding: 25px;
      margin: 40px auto;
      width: 90%;
      max-width: 800px;
      border: 1px solid rgba(100, 181, 246, 0.2);
      position: relative;
      overflow: hidden;
      backdrop-filter: blur(5px);
    }

    .report-detail-container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-darker) 100%);
    }

    .report-detail-container h2 {
      color: var(--primary-darker);
      font-size: 24px;
      margin-bottom: 20px;
      font-weight: 600;
      display: flex;
      align-items: center;
    }

    .report-detail-container h2::before {
      content: "\f2bb";
      font-family: "Font Awesome 5 Free";
      font-weight: 900;
      margin-right: 12px;
      font-size: 20px;
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

    .table > tbody > tr > td:first-child {
      background: linear-gradient(135deg, var(--primary-lighter) 0%, var(--primary-light) 100%);
      color: var(--text-color);
      font-weight: 600;
      width: 25%;
      border-right: 1px solid var(--border-color);
    }

    .table > tbody > tr > td {
      padding: 12px 15px;
      border-top: 1px solid var(--border-color);
      vertical-align: middle;
      font-size: 14px;
      background-color: white;
    }

    .table > tbody > tr:first-child > td {
      border-top: none;
    }

    .button-container {
      text-align: center;
      margin-top: 25px;
      display: flex;
      justify-content: center;
      gap: 15px;
    }

    .btn-success {
      background: linear-gradient(135deg, var(--success-color) 0%, #4CAF50 100%);
      color: white;
      border: none;
      padding: 8px 25px;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 500;
      transition: var(--transition);
      box-shadow: var(--shadow-sm);
      display: inline-flex;
      align-items: center;
      justify-content: center;
    }

    .btn-success i {
      margin-right: 8px;
    }

    .btn-success:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
      background: linear-gradient(135deg, #4CAF50 0%, #388E3C 100%);
    }

    .btn-secondary {
      background: linear-gradient(135deg, #B0BEC5 0%, #78909C 100%);
      color: white;
      border: none;
      padding: 8px 25px;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 500;
      transition: var(--transition);
      box-shadow: var(--shadow-sm);
      display: inline-flex;
      align-items: center;
      justify-content: center;
    }

    .btn-secondary i {
      margin-right: 8px;
    }

    .btn-secondary:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
      background: linear-gradient(135deg, #90A4AE 0%, #607D8B 100%);
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

    @media (max-width: 768px) {
      .report-detail-container {
        width: 95%;
        padding: 20px;
        margin: 20px auto;
      }

      .table > tbody > tr > td:first-child {
        width: 35%;
      }

      .button-container {
        flex-direction: column;
        gap: 10px;
      }

      .btn-success, .btn-secondary {
        width: 100%;
      }
    }
  </style>

  <script>
    function processReport(reportId) {
      if (confirm("접수하시겠습니까?")) {
        $.ajax({
          url: "<%=request.getContextPath()%>/admin/processReport.do",
          type: "POST",
          data: {
            reportId: reportId,
            reportStatus: "N"
          },
          success: function(response) {
            if (response === "success") {
              alert("접수가 완료되었습니다.");
              // Hide the process button after successful processing
              $("#processButton").hide();
              // Update the status display without page refresh
              $("#statusDisplay").text("처리 완료");
              window.location.href = "<%=request.getContextPath()%>/admin/reportList.do";
            } else {
              alert("접수에 실패했습니다.");
            }
          },
          error: function() {
            alert("서버 오류가 발생했습니다.");
          }
        });
      }
    }
  </script>
</head>
<body>
<div class="page-wrapper">
  <div class="bg-gradient-1"></div>
  <div class="bg-gradient-2"></div>
  <div class="bg-gradient-3"></div>

  <div class="top-bar">
    <h2>신고 상세</h2>
  </div>

  <div class="report-detail-container">
    <h2>신고 상세 정보</h2>

    <table class="table">
      <tbody>
      <tr>
        <td>번호</td>
        <td><%= reportVO.getReportId() %></td>
      </tr>
      <tr>
        <td>신고자명</td>
        <td><%= reportVO.getFromId() %></td>
      </tr>
      <tr>
        <td>신고대상</td>
        <td><%= reportVO.getToId() %></td>
      </tr>
      <tr>
        <td>신고유형</td>
        <td>
          <%
            String reportType = reportVO.getReportType();
            switch (reportType) {
              case "1":
                out.print("욕설/비방");
                break;
              case "2":
                out.print("음란물");
                break;
              case "3":
                out.print("스팸/광고");
                break;
              case "4":
                out.print("기타");
                break;
              default:
                out.print("알 수 없음");
                break;
            }
          %>
        </td>
      </tr>
      <tr>
        <td>신고내역</td>
        <td><%= reportVO.getReportContent() %></td>
      </tr>
      <tr>
        <td>신고일</td>
        <td><%= reportVO.getReportDate() %></td>
      </tr>
      <tr>
        <td>처리 날짜</td>
        <td><%= reportVO.getReportProdate() != null ? reportVO.getReportProdate() : "미처리" %></td>
      </tr>
      <tr>
        <td>처리 상태</td>
        <td id="statusDisplay"><%= reportVO.getReportStatus().equals("Y") ? "처리 완료" : "미처리" %></td>
      </tr>
      </tbody>
    </table>

    <div class="button-container">
      <% if (!reportVO.getReportStatus().equals("Y")) { %>
      <button id="processButton" type="button" class="btn btn-success" onclick="processReport('<%= reportVO.getReportId() %>')">
        <i class="fas fa-check-circle"></i> 접수
      </button>
      <% } %>
      <button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/admin/reportList.do'">
        <i class="fas fa-times-circle"></i> 취소
      </button>
    </div>
  </div>

  <div class="wave-container">
    <div class="wave"></div>
    <div class="wave"></div>
  </div>
</div>
</body>
</html>