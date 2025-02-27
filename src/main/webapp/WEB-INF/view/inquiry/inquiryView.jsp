<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.PageInquiryVO" %>
<%@ page import="kr.or.ddit.emam.vo.InquiryVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.InquiryproVO" %>
<%@ page import="kr.or.ddit.emam.inquiry.service.IInquiryService" %>
<%@ page import="kr.or.ddit.emam.inquiry.service.InquiryServiceImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>문의 보기</title>

<%
  //세션 로그인 값
  MemberVO loginMemberVo = (MemberVO)session.getAttribute("loginMember");

  //컨트롤러에서 자료 받기
  InquiryVO inquiryVo = (InquiryVO)request.getAttribute("inquiryVo");
  InquiryproVO inquiryproVo = (InquiryproVO)request.getAttribute("inquiryproVo");

  IInquiryService inquiryService = InquiryServiceImpl.getInstance();

%>

  <script>
    $(function (){
<%
      //만약 선택한 문의글이 내가 작성하지 않은 비공개글이면 알림창을 띄우고, 뒤로가기한다.
      if(!inquiryVo.getMem_id().equals(loginMemberVo.getMem_id()) && !inquiryVo.getInquiry_ispublic()){
%>
        alert("해당 문의글은 비공개 상태입니다.");
        window.history.go(-1);
<%
      }
%>
    });

    //삭제하기 버튼 클릭 이벤트
    $("#deleteBtn").on("click", function(){
      const num = $(this).data("num");
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

  </script>
</head>
<body>
<h3>문의</h3>

<jsp:include page="/"/>

<div id="result">
<%
  if(inquiryVo==null){
%>
  <script>history.go(-1);</script>
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
%>
          <input type="button" data-num="<%=inquiryVo.getInquiry_index() %>" id="updateBtn" value="수정" onclick="location.href="<%=request.getContextPath()%>/inquiry/inquiryUpdate.do">
          <input type="button" data-num="<%=inquiryVo.getInquiry_index() %>" id="deleteBtn" value="삭제">
<%
    } //if문 종료
  } //else if문 종료
%>
      </td>
    </tr>
  </table>
</div>

</body>
</html>
