<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.ReportVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ReportVO reportVOForForm = (ReportVO) request.getAttribute("reportVO");
    if (reportVOForForm == null) {
        reportVOForForm = new ReportVO();
    }
    MemberVO tmemVo = (MemberVO) request.getAttribute("memVo");
%>
<html>
<head>
    <title>신고</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>
    <style>.modal-body { overflow: auto; }</style>
    <script>
        window.onload = function() {
            const message = "${popupMessage}";
            if (message) {
                alert(message);
            }
        }
    </script>
</head>
<%
    MemberVO memVo = (MemberVO) session.getAttribute("loginMember");
    if (memVo == null) {
        response.sendRedirect(request.getContextPath() + "/member/loginMember.do");
    return;
    }
    String memId = memVo.getMem_id();
%>
<body>
<div class="container mt-3">
    <h2>신고하기</h2>
    <table class="table table-borderless">
        <form id="reportForm" method="post" action="<%=request.getContextPath()%>/report.do">
            <tr class="row">
                <td class="col-md-3">신고자명</td>
                <td class="col-md-9"><input type="text" class="form-control" name="fromId" value="<%=memId%>" readonly/></td>
            </tr>
            <tr class="row">
                <td class="col-md-3">신고대상</td>
                <td class="col-md-9"><input type="text" class="form-control" name="toId" value="<%=tmemVo.getMem_id()%>" required/></td>
            </tr>
            <tr class="row">
                <td class="col-md-3">신고유형</td>
                <td class="col-md-9">
                    <select class="form-control" name="reportType" required>
                        <option value="1" <%= "1".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>욕설/비방</option>
                        <option value="2" <%= "2".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>음란물</option>
                        <option value="3" <%= "3".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>스팸/광고</option>
                        <option value="4" <%= "4".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>기타</option>
                    </select>
                </td>
            </tr>
            <tr class="row">
                <td class="col-md-3">신고내역</td>
                <td class="col-md-9"><textarea class="form-control" name="content" rows="10"></textarea></td>
            </tr>
            <tr class="row">
                <td colspan="2" style="text-align: center"><button type="submit" class="btn btn-danger">신고하기</button></td>
            </tr>
        </form>
    </table>
</div>
<script>
    $(function() {
        $("#reportForm").on("submit", function(event) {
            if (!$("input[name='toId']").val() || $("textarea[name='content']").val() === "") {
                alert("신고 대상과 신고 내역을 모두 입력해주세요.");
                event.preventDefault();
                return;
            }
            $.ajax({
                url: "<%=request.getContextPath()%>/report.do",
                type: "post",
                data: $(this).serialize(),
                dataType: "json",
                success: function(response) {
                    if (response && response.message) {
                        alert(response.message);
                        if (response.success && response.redirectUrl) {
                            window.location.href = response.redirectUrl;
                        }
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 요청 실패:", status, error);
                    try {
                        const errorResponse = JSON.parse(xhr.responseText);
                        alert(errorResponse.message);
                    } catch (e) {
                        alert("신고 처리 중 오류가 발생했습니다. 관리자에게 문의해주세요.");
                    }
                }
            });
            event.preventDefault();
        });
    });
</script>
</body>
</html>