<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.InquiryVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/view/common/gnb.jsp"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>문의하기</title>
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
      margin-top: 60px;
    }

    h3 {
      color: #333;
      margin-bottom: 20px;
      font-size: 24px;
      font-weight: 700;
      padding-bottom: 10px;
      border-bottom: 2px solid #4a90e2;
      display: flex;
      align-items: center;
    }

    h3 i {
      margin-right: 10px;
    }

    #main {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      padding: 20px;
      max-width: 800px;
      margin: 0 auto;
    }

    .mainTable {
      width: 100%;
      border-collapse: collapse;
    }

    .mainTable td {
      padding: 12px;
      border-bottom: 1px solid #eee;
    }

    .mainTable td:first-child {
      width: 120px;
      font-weight: 500;
      color: #555;
    }

    input[type="text"] {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
      outline: none;
    }

    input[type="text"]:focus {
      border-color: #4a90e2;
      box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
    }

    textarea {
      width: 100%;
      min-height: 200px;
      padding: 10px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
      resize: vertical;
      outline: none;
    }

    textarea:focus {
      border-color: #4a90e2;
      box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
    }

    .radio-group {
      display: flex;
      gap: 20px;
      margin: 10px 0;
    }

    .radio-option {
      display: flex;
      align-items: center;
      cursor: pointer;
    }

    input[type="radio"] {
      margin-right: 8px;
      cursor: pointer;
      width: 16px;
      height: 16px;
    }

    .button-group {
      display: flex;
      justify-content: center;
      gap: 10px;
      margin-top: 10px;
    }

    input[type="button"] {
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      font-weight: 500;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    #updateBtn {
      background-color: #64B5F6;
      color: white;
    }

    #updateBtn:hover {
      background-color: #90CAF9;
    }

    #resetBtn {
      background-color: #f44336;
      color: white;
    }

    #resetBtn:hover {
      background-color: #ef5350;
    }
  </style>

  <%
    //세션 로그인 값
    MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");

    //기존에 작성한 문의내용 값
    InquiryVO inquiryVo = (InquiryVO)request.getAttribute("inquiryVo");
  %>
  <script>
    $(function (){
      //기존에 선택한 공개여부에 따라 공개여부 선택값(라디오버튼 설정값) 가져와 적용하기
      $('input:radio[name="inquiry_ispublic"]:input[value="<%=inquiryVo.getInquiry_ispublic()%>"]').attr("checked", true);

      //수정 버튼 클릭 이벤트
      $('#updateBtn').on('click', function (){
        //제목과 본문 내용이 입력되었는지 확인하기
        const title = $("#title").val();
        const con = $("#con").val();
        if (title.length === 0 || con.length === 0) {
          alert("제목과 본문의 내용을 작성해주세요.");
          return;
        }

        //작성된 모든 값 가져오기
        const formData = $("#mainForm").serializeJSON();

        fetch(`<%=request.getContextPath()%>/inquiry/inquiryUpdate.do`, {
          method: 'post',
          headers: {'Content-Type': 'application/json;charset=utf-8'},
          body: JSON.stringify(formData)
        })
                .then(response => {
                  if(response.ok) {
                    return response.json();
                  }else {
                    throw new Error(`${response.status}`);
                  }
                })
                .then(data => {
                  if(data.result>0){
                    location.href="<%=request.getContextPath()%>/inquiry/inquiryList.do";
                  }else {
                    alert("문의 수정 중 오류가 발생했습니다.");
                  }
                })
                .catch(error => {
                  console.log(error);
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
<h3><i class="fas fa-edit"></i> 문의 수정하기</h3>
<div id="main">
  <form id="mainForm" action="<%=request.getContextPath()%>/inquiry/inquiryUpdate.do">
    <input type="hidden" name="mem_id" value="<%=loginMember.getMem_id()%>">
    <input type="hidden" name="inquiry_index" value="<%=inquiryVo.getInquiry_index()%>">
    <table class="mainTable">
      <tr>
        <td>문의 제목</td>
        <td>
          <input type="text" id="title" name="inquiry_title" value="<%=inquiryVo.getInquiry_title()%>" placeholder="제목을 입력하세요">
        </td>
      </tr>
      <tr>
        <td>문의 내용</td>
        <td>
          <textarea id="con" name="inquiry_con" placeholder="문의 내용을 상세히 입력해주세요"><%=inquiryVo.getInquiry_con()%></textarea>
        </td>
      </tr>
      <tr>
        <td>공개 여부</td>
        <td>
          <div class="radio-group">
            <label class="radio-option">
              <input type="radio" name="inquiry_ispublic" value="1"> 공개
            </label>
            <label class="radio-option">
              <input type="radio" name="inquiry_ispublic" value="0"> 비공개
            </label>
          </div>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <div class="button-group">
            <input type="button" id="updateBtn" value="수정">
            <input type="button" id="resetBtn" value="취소">
          </div>
        </td>
      </tr>
    </table>
  </form>
</div>
</body>
</html>

