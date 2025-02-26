<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원가입</title>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

  <style>
    h2 { margin-left: 20%; }
    #result { border: 1px dotted gray; padding: 10px; margin: 5px; }
    .unvis{display: none;}
    .unvis.view{display: inline;}

  </style>

  <script>
    $(function(){
      $('#send').on('click', () => {
        const vid = $('#mem_id').val();
        const vname = $('#mem_name').val();
        const vhp = $('#mem_phone').val();
        const vpass = $('#mem_pw').val();
        const vmail = $('#mem_mail').val();
        const vbir = $('#mem_bir').val();
        const vzip = $('#zipcode').val();
        const vadd1 = $('#mem_addr').val();
        const vgen = $("input[name='mem_gen']:checked").val();
        const vnickname = $("#mem_nickname").val();

        const vdata1 = "mem_id=" + vid + "&mem_name=" + vname + "&mem_pw=" + vpass +
                "&mem_phone=" + vhp + "&mem_bir=" + vbir + "&mem_mail=" + vmail +
                "&mem_addr=" + vadd1 + "&mem_gen=" + vgen + "&mem_nickname=" + vnickname;

        fetch('<%=request.getContextPath() %>/member/memberInsert.do', {
          method: 'post',
          headers: { "Content-type": "application/x-www-form-urlencoded" },
          body: vdata1
        })
                .then(res => {
                  if(res.ok) return res.json();
                  else throw new Error(res.statusText)
                })
                .then(result => {
                  $('#joinspan').html(result.flag).css('color', 'red');
                })
                .catch(err => console.log(err));
      });

      $('#zipbtn').on('click', function(){
        new daum.Postcode({
          oncomplete: function(data) {
            let addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
            $("#zipcode").val(data.zonecode);
            $("#mem_addr").val(addr);
            $("#addr2").focus();
          }
        }).open();
      });

      // 아이디 중복확인 버튼 클릭 이벤트
      $('#idcheck').on('click', function(){
        idvalue = $('#mem_id').val();
        if($(".form-control").val().trim() === "") {
          alert("이메일을 입력해주세요.");
          return;
        }

        let email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i; // 이메일 형식 검증
        if(!email_regex.test($(".form-control").val().trim())){
          alert("이메일 형식이 아닙니다.")
          return;
        }
        fetch('<%=request.getContextPath() %>/member/memberIdCheck.do?id=' + idvalue)
                .then(res => {
                  if (res.ok) return res.json();
                  else throw new Error(res.statusText)
                })
                .then(result => {
                  $('#idspan').html(result.flag).css('color', 'red');
                  if (result.flag === "사용 가능한 아이디입니다.이메일 인증을 완료해주세요.") {
                    $('#emailAuthBtnContainer').show(); // 사용 가능하면 활성화
                    $(".unvis").addClass("view")
                    $('#idspan').html(result.flag).css('color', 'green');
                  }
                })
                .catch(err => console.log(err));
      });

      // 이메일 인증 버튼 클릭 이벤트
      $('#emailAuthBtn').on('click', function() {
        const email = $('#mem_id').val();
        if (!email) {
          alert('이메일을 입력해주세요.');
          return;
        }

        // 이메일 인증 요청
        fetch('<%=request.getContextPath() %>/member/emailAuth.do?email=' + email)
                .then(res => {
                  if (res.ok) return res.json();
                  else throw new Error(res.statusText);
                })
                .then(result => {
                  if (result.success) {
                    alert('인증 메일이 발송되었습니다. 이메일을 확인하고 인증 번호를 입력해주세요.');
                    $('#authCodeInput').show(); // 인증 번호 입력 필드 표시
                  } else {
                    alert('인증 메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.');
                  }
                })
                .catch(err => console.log(err));
      });

      // 인증 번호 확인 버튼 클릭 이벤트
      $('#authCodeCheckBtn').on('click', function() {
        const email = $('#mem_id').val();
        const authCode = $('#authCode').val();

        if(authCode.trim() === "") {
          alert("인증번호를 입력해주세요.");
          return;
        }

        fetch('<%=request.getContextPath() %>/member/emailAuthCodeCheck.do?email=' + email + '&authCode=' + authCode)
                .then(res => {
                  if (res.ok) return res.json();
                  else throw new Error(res.statusText);
                })
                .then(result => {
                  if (result.success) {
                    alert('이메일 인증이 완료되었습니다.');
                    $('#emailAuthBtn').prop('disabled', true); // 인증 버튼 비활성화
                    $('#authCodeCheckBtn').prop('disabled', true); // 인증 번호 확인 버튼 비활성화
                    $('#authCode').prop('disabled', true); // 인증 번호 입력 필드 비활성화
                  } else {
                    alert('이메일 인증에 실패했습니다. 다시 입력해주세요.');
                  }
                })
                .catch(err => console.log(err));
      });

      // 닉네임 중복 확인 버튼 클릭 이벤트
      $('#nicknameCheckBtn').on('click', function() {
        const nickname = $('#mem_nickname').val();

        if (nickname.trim() === "") {
          alert("닉네임을 입력해주세요.");
          return;
        }

        fetch('<%=request.getContextPath() %>/member/nicknameCheck.do?nickname=' + nickname)
                .then(res => {
                  if (res.ok) return res.json();
                  else throw new Error(res.statusText);
                })
                .then(result => {
                  $('#nicknameCheckMsg').html(result.message).css('color', result.available ? 'green' : 'red');
                })
                .catch(err => console.log(err));
      });

    });
  </script>
</head>
<body>
<br><br>
<h2>회원가입</h2>
<br><br>

<form class="form-horizontal" onsubmit="return false;">
  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_id">아이디</label>
    <div class="col-sm-3">
      <input type="email" name="mem_id" class="form-control" id="mem_id" placeholder="이메일 입력 ex) your_email@gmail.com">
    </div>
    <div id="emailAuthBtnContainer" style="">
      <input id="idcheck" type="button" class="btn btn-success btn-sm" value="아이디 중복확인">
      <input id="emailAuthBtn" type="button" class="btn btn-info btn-sm s unvis" value="이메일 인증">
      <span id="idspan"></span>
    </div>
  </div>

  <div class="form-group" id="authCodeInput" style="display: none;">
    <label class="control-label col-sm-2" for="authCode">인증 번호</label>
    <div class="col-sm-2">
      <input type="text" name="authCode" class="form-control" id="authCode" placeholder="인증 번호 입력">
    </div>
    <input id="authCodeCheckBtn" type="button" class="btn btn-success btn-sm" value="인증 번호 확인">
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_pw">비밀번호</label>
    <div class="col-sm-2">
      <input type="password" name="mem_pw" class="form-control" id="mem_pw" placeholder="비밀번호 입력">
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_nickname">닉네임</label>
    <div class="col-sm-2">
      <input type="text" name="mem_nickname" class="form-control" id="mem_nickname" placeholder="닉네임 입력">
    </div>
    <div class="col-sm-3">
      <input id="nicknameCheckBtn" type="button" class="btn btn-success btn-sm" value="중복확인">
      <span id="nicknameCheckMsg"></span>
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_name">이름</label>
    <div class="col-sm-2">
      <input type="text" name="mem_name" class="form-control" id="mem_name" placeholder="이름 입력">
    </div>
  </div>


  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_addr">주소</label>
    <div class="col-sm-3">
      <select name="mem_addr" class="form-control" id="mem_addr">
        <option value="">선택하세요</option>
        <option value="서울특별시">서울특별시</option>
        <option value="부산광역시">부산광역시</option>
        <option value="대구광역시">대구광역시</option>
        <option value="인천광역시">인천광역시</option>
        <option value="광주광역시">광주광역시</option>
        <option value="대전광역시">대전광역시</option>
        <option value="울산광역시">울산광역시</option>
        <option value="세종특별자치시">세종특별자치시</option>
        <option value="경기도">경기도</option>
        <option value="강원도">강원도</option>
        <option value="충청북도">충청북도</option>
        <option value="충청남도">충청남도</option>
        <option value="전라북도">전라북도</option>
        <option value="전라남도">전라남도</option>
        <option value="경상북도">경상북도</option>
        <option value="경상남도">경상남도</option>
        <option value="제주특별자치도">제주특별자치도</option>
      </select>
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_phone">전화번호</label>
    <div class="col-sm-2">
      <input type="text" name="mem_phone" class="form-control" id="mem_phone" placeholder="전화번호 입력">
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_bir">생년월일</label>
    <div class="col-sm-2">
      <input type="date" name="mem_bir" class="form-control" id="mem_bir">
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2">성별</label>
    <div class="col-sm-10">
      <label class="radio-inline">
        <input type="radio" name="mem_gen" value="M" checked> 남자
      </label>
      <label class="radio-inline">
        <input type="radio" name="mem_gen" value="F"> 여자
      </label>
    </div>
  </div>

    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <button id="send" type="button" class="btn btn-primary btn-lg">가입하기</button>
        <span id="joinspan"></span>
      </div>
    </div>
    </form>
</body>
</html>

