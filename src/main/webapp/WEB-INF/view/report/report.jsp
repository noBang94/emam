<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.ReportVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- **ReportVO 객체 request scope 에서 가져오기 (Controller에서 실패 시 전달)** --%>
<%
    ReportVO reportVOForForm = (ReportVO) request.getAttribute("reportVO");
    if (reportVOForForm == null) {
        reportVOForForm = new ReportVO(); // null 인 경우, 새로운 ReportVO 객체 생성 (초기화)
    }
%>
<html>
<head>
    <title>신고</title>

    <%-- Bootstrap 3 CSS 파일을 CDN을 통해 가져와 스타일을 적용합니다. --%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    <%-- jQuery 라이브러리를 CDN 또는 로컬 경로에서 가져옵니다. --%>
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>

    <%-- Bootstrap 3 JavaScript 라이브러리를 CDN 또는 로컬 경로에서 가져옵니다. --%>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <%-- jquery.serializejson.min.js 라이브러리를 CDN 또는 로컬 경로에서 가져옵니다. --%>
    <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>

    <style>
        /* 모달 창의 modal-body에 스크롤을 표시하기 위한 CSS 스타일을 정의합니다. */
        .modal-body {
            overflow: auto;
        }
    </style>
    <script>
        window.onload = function() {
            var message = "${popupMessage}";
            var redirectToInitial = "${redirectToInitial}";
            if (message != "") {
                alert(message);
                if (redirectToInitial == "true") {
                    window.location.href = "<%=request.getContextPath()%>/initialReport.do";
                }
                // redirectToInitial 값이 "false" 이거나 없을 경우, 아무 동작 안함 (현재 페이지 유지)
            }
        }
    </script>
</head>
<%
    MemberVO memVo = (MemberVO)session.getAttribute("loginMember");
    String memId= memVo.getMem_id();

    String toId = request.getParameter("toId");


%>
<body>


<div class="container mt-3">



    <h2>신고하기</h2>
    <table class="table table-borderless">
        <form method="post" name="reportForm" action="<%=request.getContextPath() %>/report.do" enctype="multipart/form-data">
            <tr class="row">
                <td class="col-md-3">신고자명</td>
                <td class="col-md-9">
                    <input type="text" class="form form-control" id="reportFromid" name="fromid" value="<%=memId%>" readonly/></td>
            </tr>

            <tr class="row">
                <td class="col-md-3">신고대상</td>
                <td class="col-md-9"><input type="text" class="form form-control" id="reportToid" name="toid" value="<%=reportVOForForm.getToId()%>"/></td> <%-- **value 값 설정: reportVOForForm 사용** --%>
            </tr>
            <tr class="row">
                <td class="col-md-3">신고유형</td>
                <td class="col-md-9">
                    <select class="form form-control" id="type" name="reportType" >
                        <option value="1" <%= "1".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>욕설/비방</option> <%-- **selected 속성 설정: reportVOForForm 사용** --%>
                        <option value="2" <%= "2".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>음란물</option>
                        <option value="3" <%= "3".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>스팸/광고</option>
                        <option value="4" <%= "4".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>기타</option>
                    </select>
                </td>
            </tr>
            <tr class="row">
                <td class="col-md-3">신고내역</td>
                <td class="col-md-9">
                    <textarea class="form form-control" name="content" id="reportContent" rows="10"><%=reportVOForForm.getReportContent()%></textarea> <%-- **textarea 내용 설정: reportVOForForm 사용** --%>
                </td>
            </tr>
            <tr class="row">
                <td class="col-md-3">첨부파일</td>
                <td class="col-md-9">
                    <label for="reportPhoto" class="btn btn-primary">
                        첨부
                    </label>
                    <input type="file" id="reportPhoto" name="reportPhoto" style=""/>


                </td>
            </tr>
            <tr class="row">
                <td colspan="2" style="text-align: center">
                    <button type="submit" class="btn btn-danger" id="reportBtn">신고하기</button>
                </td>
            </tr>
        </form>
    </table>

</div>



<script>
    $(function() {


        // reportBtn 버튼 클릭 이벤트 핸들러를 정의합니다.


    });
</script>
</body>
</html>