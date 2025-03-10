<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.InquiryVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.PageVO" %>
<jsp:include page="/WEB-INF/view/common/gnb.jsp"/>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>문의</title>
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
            background-color: #f8f9fa;
            color: #333;
            margin-top: 60px; /* 상단 GNB 높이만큼 여백 */
            padding: 20px;
        }

        .page-title {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title i {
            font-size: 24px;
            color: #64B5F6;
            margin-right: 10px;
        }

        h3 {
            color: #333;
            font-size: 24px;
            font-weight: 700;
            margin: 0;
        }

        .search-container {
            background-color: #fff;
            border-radius: 4px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .search-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        #searchForm {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        input[type="text"] {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 250px;
            font-size: 14px;
            outline: none;
        }

        input[type="text"]:focus {
            border-color: #64B5F6;
        }

        .btn-search {
            background-color: #64B5F6;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 8px 15px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
        }

        .btn-search:hover {
            background-color: #90CAF9;
        }

        .btn-write {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 8px 15px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
        }

        .btn-write:hover {
            background-color: #66BB6A;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
        }

        .checkbox-container p {
            margin: 0 8px 0 0;
            font-size: 14px;
            color: #555;
        }

        input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
            accent-color: #64B5F6;
        }

        .inquiry-table-container {
            background-color: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .inquiry-table {
            width: 100%;
            border-collapse: collapse;
        }

        .inquiry-table th {
            background-color: #f8f9fa;
            padding: 12px 15px;
            text-align: left;
            font-weight: 500;
            color: #555;
            border-bottom: 1px solid #ddd;
            font-size: 14px;
        }

        .inquiry-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            color: #333;
            font-size: 14px;
        }

        .inquiry-row {
            cursor: pointer;
            transition: background-color 0.1s;
        }

        .inquiry-row:hover {
            background-color: #f8f9fa;
        }

        .empty-result {
            text-align: center;
            padding: 30px 0;
            color: #777;
            font-size: 15px;
        }

        #pagingArea {
            margin: 20px 0;
            display: flex;
            justify-content: center;
        }

        .pagination {
            display: flex;
            list-style: none;
            gap: 5px;
        }

        .page-item {
            display: inline-block;
        }

        .page-link {
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 32px;
            height: 32px;
            border-radius: 4px;
            background-color: #fff;
            color: #555;
            text-decoration: none;
            cursor: pointer;
            border: 1px solid #ddd;
            transition: all 0.2s;
            font-size: 14px;
            padding: 0 8px;
        }

        .page-link:hover {
            background-color: #f1f5f9;
            border-color: #64B5F6;
        }

        .page-item.active .page-link {
            background-color: #64B5F6;
            color: white;
            border-color: #64B5F6;
        }

        #prev, #next {
            width: auto;
            padding: 0 10px;
        }

        .status-waiting {
            display: inline-block;
            padding: 6px 12px;
            background-color: #FFF3CD;
            color: #856404;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .status-complete {
            display: inline-block;
            padding: 6px 12px;
            background-color: #D4EDDA;
            color: #155724;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .lock-icon {
            color: #777;
            font-size: 14px;
            margin-left: 5px;
        }

        @media (max-width: 768px) {
            .search-flex {
                flex-direction: column;
                align-items: flex-start;
            }

            #searchForm {
                width: 100%;
            }

            input[type="text"] {
                width: 100%;
            }

            .btn-write {
                width: 100%;
            }

            .inquiry-table th:nth-child(2),
            .inquiry-table td:nth-child(2) {
                display: none;
            }
        }
    </style>

    <%
        //세션 로그인 값
        MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");

        //컨트롤러에서 자료 받기
        List<InquiryVO> inquiryList = (List<InquiryVO>)request.getAttribute("inquiryList");
        PageVO pageVo = (PageVO)request.getAttribute("pageVo");
        String sword = (String)request.getAttribute("sword");
        sword = sword == null ? "" : sword;
        String myInquiry = request.getParameter("myInquiry");
    %>

    <script>
        $(function (){
            //기존의 체크박스(내 문의 보기) 값 가져오기
            if(<%=myInquiry != null && myInquiry.equals(loginMember.getMem_id())%>) {
                $('#myInquiry').attr("checked", true);
            }

            //검색하기 버튼 클릭 이벤트
            $('#searchBtn').on('click', function(){
                $("#page").val(1);
                $("#searchForm").submit();
            });

            //엔터키 검색 이벤트
            $('#sword').on('keypress', function(e){
                if(e.which === 13) {
                    e.preventDefault();
                    $("#page").val(1);
                    $("#searchForm").submit();
                }
            });

            //내 문의 보기 체크박스 클릭 이벤트
            $('#myInquiry').on('click', function (){
                $("#page").val(1);
                $("#searchForm").submit();
            });

            //페이지번호 클릭 이벤트
            $(document).on('click', '.pageno', function(){
                $("#page").val( parseInt($(this).text()));
                $("#searchForm").submit();
            });

            //이전 번호 클릭 이벤트
            $(document).on('click', '#prev', function(){
                $("#page").val( parseInt($('.pageno').first().text()) - 1);
                $("#searchForm").submit();
            });

            //다음 번호 클릭 이벤트
            $(document).on('click', '#next', function(){
                $("#page").val( parseInt($('.pageno').last().text()) + 1);
                $("#searchForm").submit();
            });

            //문의 내용 보기 이벤트
            $(document).on('click', '.inquiry-row', function() {
                const num = $(this).data("num");
                const isPrivate = $(this).data("private") === 0; // 0 means private in your code
                const author = $(this).data("author");
                const currentUser = "<%=loginMember.getMem_id()%>";

                // 비공개 글이고 작성자가 현재 사용자가 아니면 접근 불가
                if(isPrivate && author !== currentUser) {
                    alert("비공개 문의글은 작성자만 확인할 수 있습니다.");
                    return false;
                }

                $("#viewNum").val(num);
                $("#viewForm").submit();
            });
        });
    </script>
</head>
<body>
<div class="page-title">
    <i class="fas fa-question-circle"></i>
    <h3>문의</h3>
</div>

<div class="search-container">
    <div class="search-flex">
        <form id="searchForm" action="<%=request.getContextPath()%>/inquiry/inquiryList.do">
            <input type="hidden" id="page" name="page" value="<%=pageVo.getCurrentPage()%>">
            <input type="text" id="sword" name="sword" placeholder="제목 검색 키워드 입력" value="<%=sword%>">
            <input type="button" id="searchBtn" class="btn-search" value="검색">
            <div class="checkbox-container">
                <p>내 문의만 보기</p>
                <input type="checkbox" id="myInquiry" name="myInquiry" value="<%=loginMember.getMem_id()%>">
            </div>
        </form>
        <input type="button" id="writeBtn" class="btn-write" value="문의하기" onclick="location.href='<%=request.getContextPath()%>/inquiry/inquiryWrite.do'">
    </div>
</div>

<div class="inquiry-table-container">
    <table class="inquiry-table">
        <tr>
            <th width="8%">번호</th>
            <th width="15%">문의자</th>
            <th colspan="2" width="40%">문의제목</th>
            <th width="20%">작성일시</th>
            <th width="15%">처리상태</th>
        </tr>

        <%
            if(inquiryList==null || inquiryList.size()==0){
        %>
        <tr>
            <td colspan="6" class="empty-result">
                조건에 일치하는 문의글이 없습니다.
            </td>
        </tr>
        <%
        }else {
            for(InquiryVO vo : inquiryList){
        %>
        <tr class="inquiry-row" data-num="<%=vo.getInquiry_index()%>" data-private="<%=vo.getInquiry_ispublic()%>" data-author="<%=vo.getMem_id()%>">
            <td><%=vo.getInquiry_index()%></td>
            <td><%=vo.getMem_id()%></td>
            <td><%=vo.getInquiry_title()%></td>
            <td>
                <%
                    if(vo.getInquiry_ispublic()==0){
                %>
                <i class="fas fa-lock lock-icon"></i>
                <%
                    }
                %>
            </td>
            <td><%=vo.getInquiry_date()%></td>
            <td>
                <%
                    if(vo.getInquiry_comment()==null){
                %>
                <span class="status-waiting">답변대기</span>
                <%
                }else{
                %>
                <span class="status-complete">답변완료</span>
                <%
                    }
                %>
            </td>
        </tr>
        <%
                } //for문 종료
            } //if else문 종료
        %>
        <tr>
            <td colspan="6">
                <div id="pagingArea">
                    <ul class="pagination">
                        <%
                            //이전
                            if(pageVo.getStartPage()>1){
                        %>
                        <li class="page-item"><a id="prev" class="page-link"><i class="fas fa-chevron-left"></i> 이전</a></li>
                        <%
                            } //if문 종료

                            //페이지 번호
                            for(int i=pageVo.getStartPage(); i<=pageVo.getEndPage(); i++){
                                if(i==pageVo.getCurrentPage()){ //현재 페이지
                        %>
                        <li class="page-item active"><a class="page-link pageno"><%=i%></a></li>
                        <%
                        }else{
                        %>
                        <li class="page-item"><a class="page-link pageno"><%=i%></a></li>
                        <%
                                } //if else문 종료
                            } //for문 종료

                            //다음
                            if(pageVo.getEndPage()<pageVo.getTotalPage()){
                        %>
                        <li class="page-item"><a id="next" class="page-link">다음 <i class="fas fa-chevron-right"></i></a></li>
                        <%
                            } //if문 종료
                        %>
                    </ul>
                </div>
            </td>
        </tr>
    </table>
</div>

<form action="<%=request.getContextPath()%>/inquiry/inquiryView.do" method="get" id="viewForm">
    <input type="hidden" name="num" id="viewNum">
</form>

</body>
</html>