<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>문의하기</title>
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>

<%
  //세션 로그인 값
  MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
%>
  <script>
    $(function (){
      //등록 버튼 클릭 이벤트
      $('#insertBtn').on('click', function (){
        //제목과 본문 내용이 입력되었는지 확인하기
        const title = $("#title").val();
        const con = $("#con").val();
        if (title.length === 0 || con.length === 0) {
          alert("제목과 본문의 내용을 작성해주세요.");
          return;
        }

        //작성된 모든 값 가져오기
        const formData = $("#mainForm").serializeJSON();
        console.log(formData);
        fetch(`<%=request.getContextPath()%>/inquiry/inquiryWrite.do`, {
          method: 'post',
          headers: {'Content-Type': 'application/json;charset=utf-8'},
          body: JSON.stringify(formData)
        })
                .then(response => {
                  if(response.ok) {
                    return response.json();
                  }else {
                    throw new Error(`${response.status} ${response.statusText}`);
                  }
                })
                .then(data => {
                  if(data.result>0){
                    window.location.href="inquiryList.jsp";
                  }else {
                    alert("문의 등록 중 오류가 발생했습니다.");
                  }
                });
      });

      //취소 버튼 클릭 이벤트
      $('#resetBtn').on('click', function (){
        //작업내용이 모두 초기화된다는 알림을 띄운 후에 이전 화면으로 돌아가기
        alert("취소 시 작성한 내용이 모두 초기화됩니다.");
        window.history.go(-1);
      });
    });
  </script>
</head>
<body>
<h3>문의하기</h3>
<div id="main">
  <form id="mainForm" action="<%=request.getContextPath()%>/inquiry/inquiryWrite.do">
    <input type="hidden" id="id" name="id" value="<%=loginMember.getMem_id()%>">
    <table class="mainTable">
      <tr>
        <td>문의 제목</td>
        <td>
          <input type="text" id="title" name="title">
        </td>
      </tr>
      <tr>
        <td>문의 내용</td>
        <td>
          <input type="text" id="con" name="con">
        </td>
      </tr>
      <tr>
        <td>사진 첨부</td>
        <td>사진 넣기...</td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="radio" name="ispublic" value="true" checked>공개
          <input type="radio" name="ispublic" value="false">비공개
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" id="insertBtn" value="등록">
          <input type="button" id="resetBtn" value="취소">
        </td>
      </tr>
    </table>
  </form>
</div>

</body>
</html>
