<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.InquiryVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.PageVO" %>
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
            $(document).on('click', '.row', function() { //변경
                const num = $(this).data("num"); //선택한 문의글<tr>이 가진 data-num(inquiry_index)를 가져와 num에 저장 //변경
                $("#viewNum").val(num);
                $("#viewForm").submit();
            });
        });
    </script>
</head>
<body>
<h3>문의</h3>

<nav class="navbar1">
    <div class="container">
        <form id="searchForm" action="<%=request.getContextPath()%>/inquiry/inquiryList.do">
            <input type="hidden" id="page" name="page" value="<%=pageVo.getCurrentPage()%>">
            <input type="text" id="sword" name="sword" placeholder="제목 검색 키워드 입력" value="<%=sword%>">
            <input type="button" id="searchBtn" value="검색">
            <p>내 문의만 보기</p>
            <input type="checkbox" id="myInquiry" name="myInquiry" value="<%=loginMember.getMem_id()%>">
        </form>
        <input type="button" id="writeBtn" value="문의하기" onclick="location.href='<%=request.getContextPath()%>/inquiry/inquiryWrite.do'">
    </div>
</nav>

<div id="result">
    <table class="resultTable">
        <tr>
            <th>번호</th>
            <th>문의자</th>
            <th colspan="2">문의제목</th>
            <th>작성일시</th>
            <th>처리상태</th>
        </tr>

        <%
            if(inquiryList==null || inquiryList.size()==0){
        %>
        <tr>
            <td colspan="6" style="text-align: center;">조건에 일치하는 문의글이 없습니다.</td>
        </tr>
        <%
        }else {
            for(InquiryVO vo : inquiryList){
        %>
        <tr class="row" data-num="<%=vo.getInquiry_index()%>">
            <td><%=vo.getInquiry_index()%></td>
            <td><%=vo.getMem_id()%></td>
            <td><%=vo.getInquiry_title()%></td>
            <td>
                <%
                    if(vo.getInquiry_ispublic()==0){
                %>
                ︎   <img height="20" width="20" src="../../.././images/lock.png">
                <%
                    }
                %>
            </td>
            <td><%=vo.getInquiry_date()%></td>
            <td>
                <%
                    if(vo.getInquiry_comment()==null){
                %>
                <p>답변대기</p>
                <%
                }else{
                %>
                <p>답변완료</p>
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
            <td colspan="5">
                <div id="pagingArea">
                    <ul class="pagination">
                        <%
                            //이전
                            if(pageVo.getStartPage()>1){
                        %>
                        <li class="page-item"><a id="prev" class="page-link">이전</a></li>
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
                        <li class="page-item"><a id="next" class="page-link">다음</a></li>
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