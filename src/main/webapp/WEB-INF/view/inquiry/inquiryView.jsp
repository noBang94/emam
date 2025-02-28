<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.PageVO" %>
<%@ page import="kr.or.ddit.emam.vo.InquiryVO" %>
<%@ page import="java.util.List" %>
<<<<<<< Updated upstream
=======
<%@ page import="kr.or.ddit.emam.inquiry.service.IInquiryService" %>
<%@ page import="kr.or.ddit.emam.inquiry.service.InquiryServiceImpl" %>
>>>>>>> Stashed changes
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

<%
  //세션 로그인 값
  MemberVO loginMemberVo = (MemberVO)session.getAttribute("loginMember");

  //컨트롤러에서 자료 받기
  InquiryVO inquiryVo = (InquiryVO)request.getAttribute("inquiryVo");
  //InquiryproVO inquiryproVo = (InquiryproVO)request.getAttribute("inquiryproVo");

  //IInquiryService inquiryService = InquiryServiceImpl.getInstance();

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
<h3>문의</h3>

<%--<jsp:include page="/"/>--%>

<div id="result">
<%
  if(inquiryVo==null){
%>
<%
  }else {
%>
  <table class="resultTable">
    <tr>
      <td><%=inquiryVo.getInquiry_index()%></td>
      <td><%=inquiryVo.getInquiry_date()%>></td>
      <td>문의처리여부...</td>
    </tr>
    <tr>
      <td colspan="2"><%=inquiryVo.getInquiry_title()%></td>
      <td><%=inquiryVo.getMemberVo().getMem_id()%></td>
    </tr>
    <tr>
      <td colspan="3"><%=inquiryVo.getInquiry_con()%></td>
    </tr>
    <tr>
       <td colspan="3"><%=inquiryVo.getInquiry_photo()%></td>
    </tr>
    <tr>
      <td colspan="3" style="text-align: center;">
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
  } //else if문 종료
%>
      </td>
    </tr>
    <tr>
      <td colspan="3">문의 답변</td>
    </tr>
    <tr>
<%
  if(inquiryVo.getInquiry_comment()==null){
%>
      <td colspan="3">아직 답변이 처리되지 않은 문의입니다.</td>
<%
  }else{
%>
      <td colspan="3"><%=inquiryVo.getInquiry_comment() %></td>
<%
  }
%>
    </tr>
  </table>
</div>

  <!-- 게시글 수정 폼 -->
  <form action="<%=request.getContextPath()%>/inquiry/inquiryUpdate.do" method="get" id="updateForm">
    <input type="hidden" name="num" id="updateNum">
  </form>
</body>
</html>