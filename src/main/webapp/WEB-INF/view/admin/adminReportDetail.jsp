<%@ page import="kr.or.ddit.emam.vo.ReportVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ReportVO reportVO = (ReportVO) request.getAttribute("reportVO");
  if (reportVO == null) {
    reportVO = new ReportVO();
  }
%>
<html>
<head>
  <title>신고 상세</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script>
    function processReport(reportId) {
      if (confirm("접수하시겠습니까?")) {
        $.ajax({
          url: "<%=request.getContextPath()%>/admin/processReport.do",
          type: "POST",
          data: {reportId: reportId,
          reportStatus: "N"
        },
          success: function(response) {
            if (response === "success") {
              alert("접수가 완료되었습니다.");
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
<div class="container mt-3">
  <h2>신고 상세</h2>
  <table class="table table-bordered">
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
      <td><%= reportVO.getReportProdate() %></td>
    </tr>
    <tr>
      <td>처리 상태</td>
      <td><%= reportVO.getReportStatus().equals("Y") ? "처리 완료" : "미처리" %></td>
    </tr>
    <tr>
      <td>첨부 파일</td>
      <td>
        <% if (reportVO.getReportPhoto() != null && !reportVO.getReportPhoto().isEmpty()) { %>
        <img src="<%=request.getContextPath()%>/upload/<%= reportVO.getReportPhoto() %>" alt="첨부 이미지" style="max-width: 300px; max-height: 300px;">
        <% } else { %>
        첨부된 파일이 없습니다.
        <% } %>
      </td>
    </tr>
  </table>
  <div style="text-align: center; margin-top: 20px;">
    <button type="button" class="btn btn-success" onclick="processReport('<%= reportVO.getReportId() %>')">접수</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/admin/reportList.do'">취소</button>
  </div>
</div>
</body>
</html>