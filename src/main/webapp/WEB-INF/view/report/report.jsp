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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>신고하기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>

    <style>
        :root {
            --primary-color: #64B5F6;
            --primary-hover: #90CAF9;
            --danger-color: #ef5350;
            --danger-hover: #e57373;
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

        .report-container {
            width: 90%;
            max-width: 800px;
            margin: 80px auto 40px;
            background-color: var(--card-background);
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            transition: var(--transition);
        }

        .report-header {
            background-color: var(--danger-color);
            color: white;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .report-header h2 {
            margin: 0;
            font-size: 24px;
            font-weight: 700;
        }

        .report-content {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-color);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            font-size: 15px;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(100, 181, 246, 0.2);
            outline: none;
        }

        .form-control[readonly] {
            background-color: #f9fafc;
            cursor: not-allowed;
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }

        .btn {
            padding: 12px 25px;
            font-size: 16px;
            font-weight: 500;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }

        .btn-danger {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-danger:hover {
            background-color: var(--danger-hover);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-container {
            text-align: center;
            margin-top: 30px;
        }

        /* 반응형 스타일 */
        @media (max-width: 768px) {
            .report-container {
                width: 95%;
                margin-top: 70px;
            }

            .report-header {
                padding: 15px 20px;
            }

            .report-content {
                padding: 20px;
            }

            .form-group label {
                margin-bottom: 5px;
            }

            .form-control {
                padding: 10px;
            }

            .btn {
                width: 100%;
                padding: 10px;
            }
        }
    </style>

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
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<div class="report-container">
    <div class="report-header">
        <h2>신고하기</h2>
    </div>

    <div class="report-content">
        <form id="reportForm" method="post" action="<%=request.getContextPath()%>/report.do">
            <div class="form-group">
                <label for="fromId">신고자명</label>
                <input type="text" class="form-control" id="fromId" name="fromId" value="<%=memId%>" readonly/>
            </div>

            <div class="form-group">
                <label for="toId">신고대상</label>
                <input type="text" class="form-control" id="toId" name="toId" required value="<%=tmemVo.getMem_id()%>"/>
            </div>

            <div class="form-group">
                <label for="reportType">신고유형</label>
                <select class="form-control" id="reportType" name="reportType" required>
                    <option value="1" <%= "1".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>욕설/비방</option>
                    <option value="2" <%= "2".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>음란물</option>
                    <option value="3" <%= "3".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>스팸/광고</option>
                    <option value="4" <%= "4".equals(reportVOForForm.getReportType()) ? "selected" : "" %>>기타</option>
                </select>
            </div>

            <div class="form-group">
                <label for="content">신고내역</label>
                <textarea class="form-control" id="content" name="content" rows="10" placeholder="신고 내용을 상세히 작성해주세요."></textarea>
            </div>

            <div class="btn-container">
                <button type="submit" class="btn btn-danger">신고하기</button>
            </div>
        </form>
    </div>
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

