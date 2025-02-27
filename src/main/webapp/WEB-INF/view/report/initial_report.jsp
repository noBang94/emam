<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>초기 화면</title>
  <%-- Bootstrap 3 CSS 파일을 CDN을 통해 가져와 스타일을 적용합니다. --%>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <style>
    body {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh; /* 화면 전체 높이 */
      margin: 0;
    }
  </style>
</head>
<body>
<button id="reportButton" class="btn btn-primary btn-lg">신고</button>

<script>
  document.getElementById('reportButton').addEventListener('click', function() {
    window.location.href = '<%=request.getContextPath()%>/report.do';
  });
</script>
</body>
</html>