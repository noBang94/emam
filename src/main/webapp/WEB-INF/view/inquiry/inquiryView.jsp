<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.InquiryVO" %>
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>문의 보기</title>
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }

        body {
            background-color: #f0f7ff;
            color: #333;
            padding: 20px;
        }

        h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: 700;
            padding-bottom: 10px;
            border-bottom: 2px solid #4a90e2;
        }

        #result {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 25px;
            max-width: 900px;
            margin: 0 auto;
        }

        .resultTable {
            width: 100%;
            border-collapse: collapse;
        }

        .resultTable tr:not(:last-child) {
            border-bottom: 1px solid #eee;
        }

        .resultTable td {
            padding: 15px;
            vertical-align: top;
        }

        .header-row {
            background-color: #f8fafd;
        }

        .header-row td {
            font-size: 14px;
            color: #666;
        }

        .title-row td {
            font-size: 18px;
            font-weight: 500;
        }

        .content-row td {
            padding: 25px 15px;
            line-height: 1.6;
            white-space: pre-line;
        }

        .answer-header {
            background-color: #f0f7ff;
            font-weight: 500;
            color: #4a90e2;
        }

        .answer-content {
            padding: 20px 15px;
            background-color: #f8fafd;
            line-height: 1.6;
            white-space: pre-line;
        }

        .no-answer {
            color: #888;
            font-style: italic;
            text-align: center;
            padding: 20px !important;
        }

        .button-row {
            text-align: center;
            padding: 20px 15px;
        }

        input[type="button"] {
            padding: 8px 20px;
            border: none;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
            margin: 0 5px;
        }

        input[type="button"][value="뒤로가기"] {
            background-color: #f5f5f5;
            color: #555;
            border: 1px solid #ddd;
        }

        input[type="button"][value="뒤로가기"]:hover {
            background-color: #e9e9e9;
        }

        input[type="button"][value="수정"] {
            background-color: #4a90e2;
            color: white;
        }

        input[type="button"][value="수정"]:hover {
            background-color: #3a7bc8;
        }

        input[type="button"][value="삭제"] {
            background-color: #e74c3c;
            color: white;
        }

        input[type="button"][value="삭제"]:hover {
            background-color: #c0392b;
        }

        .status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-waiting {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-complete {
            background-color: #d4edda;
            color: #155724;
        }

        .inquiry-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .inquiry-id {
            font-weight: 500;
        }

        .inquiry-date {
            color: #777;
            font-size: 14px;
        }

        @media (max-width: 600px) {
            .resultTable td {
                padding: 10px;
            }

            .title-row td {
                font-size: 16px;
            }

            input[type="button"] {
                padding: 8px 15px;
                margin-bottom: 5px;
            }
        }
    </style>

    <%
        //세션 로그인 값
        MemberVO loginMemberVo = (MemberVO)session.getAttribute("loginMember");

        //컨트롤러에서 자료 받기
        InquiryVO inquiryVo = (InquiryVO)request.getAttribute("inquiryVo");
    %>

    <script>
        $(function (){
            <%
                  //만약 선택한 문의글이 내가 작성하지 않은 비공개글이면 알림창을 띄우고, 뒤로가기한다.
                  if(!inquiryVo.getMem_id().equals(loginMemberVo.getMem_id()) && inquiryVo.getInquiry_ispublic()==0){
            %>
            alert("해당 문의글은 비공개 상태입니다.");
            window.history.go(-1);
            <%
                  }

            %>

            //수정하기 버튼 클릭 이벤트
            $("#updateBtn").on("click", function (){
                const num = $(this).data("num");
                $("#updateNum").val(num);
                $("#updateForm").submit();
            });

            //삭제하기 버튼 클릭 이벤트
            $("#deleteBtn").on("click", function (){
                const num = $(this).data("num");
                if(!confirm('삭제 시 복구가 불가능합니다. \n정말로 삭제하시겠습니까?')){
                    return false;
                }
                $.ajax({
                    url : `<%=request.getContextPath()%>/inquiry/inquiryDelete.do`,
                    type : 'get',
                    data : {"num" : num},
                    success : function(data){
                        if(data.result>0){
                            location.href = "<%=request.getContextPath()%>/inquiry/inquiryList.do";
                        }else{
                            alert("문의글 삭제 중에 오류가 발생했습니다.");
                        }
                    },
                    error : function(xhr){
                        alert("상태 : " + xhr.status)
                    },
                    dataType : 'json'
                });
            });
        });

    </script>
</head>
<body>
<h3><i class="fas fa-question-circle"></i> 문의 상세보기</h3>

<div id="result">
    <%
        if(inquiryVo==null){
    %>
    <div class="no-data">문의 정보를 불러올 수 없습니다.</div>
    <%
    }else {
    %>
    <table class="resultTable">
        <tr class="header-row">
            <td width="15%">문의번호: <%=inquiryVo.getInquiry_index()%></td>
            <td width="55%"><%=inquiryVo.getInquiry_date()%></td>
            <td width="30%" style="text-align: right;">
                <%
                    if(inquiryVo.getInquiry_comment()==null){
                %>
                <span class="status status-waiting"><i class="fas fa-clock"></i> 답변대기</span>
                <%
                }else{
                %>
                <span class="status status-complete"><i class="fas fa-check-circle"></i> 답변완료</span>
                <%
                    }
                %>
            </td>
        </tr>
        <tr class="title-row">
            <td colspan="2">
                <%
                    if(inquiryVo.getInquiry_ispublic()==0){
                %>
                <i class="fas fa-lock" style="color: #888; margin-right: 5px;"></i>
                <%
                    }
                %>
                <%=inquiryVo.getInquiry_title()%>
            </td>
            <td style="text-align: right;">
                <span class="inquiry-id"><%=inquiryVo.getMemberVo().getMem_id()%></span>
            </td>
        </tr>
        <tr class="content-row">
            <td colspan="3"><%=inquiryVo.getInquiry_con()%></td>
        </tr>
        <tr class="button-row">
            <td colspan="3">
                <input type="button" value="뒤로가기" onClick="history.go(-1)">
                <%
                    //로그인한 회원의 계정과 문의작성자 계정이 같으면 수정, 삭제버튼을 출력
                    if(loginMemberVo!=null && inquiryVo.getMem_id().equals(loginMemberVo.getMem_id())){
                        //문의답변이 처리되지 않았을 때에만 수정버튼을 출력
                        if(inquiryVo.getInquiry_comment()==null){
                %>
                <input type="button" data-num="<%=inquiryVo.getInquiry_index() %>" id="updateBtn" value="수정">
                <%
                    } //if문 종료
                %>
                <input type="button" data-num="<%=inquiryVo.getInquiry_index() %>" id="deleteBtn" value="삭제">
                <%
                    } //if문 종료
                %>
            </td>
        </tr>
        <tr>
            <td colspan="3" class="answer-header">
                <i class="fas fa-comment-dots"></i> 문의 답변
            </td>
        </tr>
        <%
            if(inquiryVo.getInquiry_comment()==null){
        %>
        <tr>
            <td colspan="3" class="no-answer">아직 답변이 처리되지 않은 문의입니다.</td>
        </tr>
        <%
        }else{
        %>
        <tr>
            <td colspan="3" class="answer-content"><%=inquiryVo.getInquiry_comment() %></td>
        </tr>
        <%
            }
        %>
    </table>
    <%
        } //else if문 종료
    %>
</div>

<!-- 게시글 수정 폼 -->
<form action="<%=request.getContextPath()%>/inquiry/inquiryUpdate.do" method="get" id="updateForm">
    <input type="hidden" name="num" id="updateNum">
</form>
</body>
</html>