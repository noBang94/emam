<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원가입</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <style>
    :root {
      --primary-color: #64B5F6;
      --primary-hover: #90CAF9;
      --secondary-color: #64B5F6;
      --secondary-hover: #90CAF9;
      --text-color: #333;
      --background-color: #f5f7fa;
      --card-background: #fff;
      --border-color: #e2e8f0;
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      --radius: 0.5rem;
      --transition: all 0.3s ease;
    }

    body {
      padding: 0;
      margin: 0;
      background-color: var(--background-color);
      color: var(--text-color);
      font-family: 'Noto Sans KR', sans-serif;
      min-height: 100vh;
    }

    .join-page {
      display: flex;
      min-height: 100vh;
      width: 100%;
    }

    .join-form-container {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    .image-container {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #EBF5FE;
      overflow: hidden;
    }

    .image-container img {
      max-width: 85%;
      height: auto;
      object-fit: contain;
    }

    h2 {
      text-align: center;
      margin: 0 0 20px;
      font-size: 28px;
      font-weight: 700;
      color: var(--primary-color);
    }

    .join-container {
      width: 100%;
      max-width: 450px;
      padding: 25px;
      background-color: var(--card-background);
      border-radius: 12px;
      box-shadow: var(--shadow-lg);
    }

    .form-group {
      margin-bottom: 15px;
    }

    .form-group label {
      color: var(--text-color);
      font-weight: 500;
      font-size: 14px;
      margin-bottom: 5px;
      display: block;
    }

    .form-control {
      height: 40px;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      padding: 8px 12px;
      font-size: 14px;
      transition: var(--transition);
      box-shadow: none;
    }

    .form-control:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(100, 181, 246, 0.2);
    }

    .btn {
      height: 40px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      font-size: 14px;
      font-weight: 500;
      border-radius: 6px;
      border: none;
      cursor: pointer;
      transition: var(--transition);
      color: white;
    }

    .btn-sm {
      height: 32px;
      padding: 0 10px;
      font-size: 13px;
    }

    .btn-primary {
      width: 100%;
      background-color: var(--primary-color);
    }

    .btn-primary:hover {
      background-color: var(--primary-hover);
    }

    .btn-success, .btn-info {
      background-color: var(--secondary-color);
    }

    .btn-success:hover, .btn-info:hover {
      background-color: var(--secondary-hover);
    }

    .unvis {
      display: none;
    }

    .unvis.view {
      display: inline-flex;
    }

    .status-message {
      margin-top: 5px;
      font-size: 12px;
    }

    .radio-inline {
      margin-right: 15px;
      font-weight: normal;
    }

    .button-container {
      display: flex;
      gap: 8px;
      margin-top: 8px;
    }

    .input-group-btn .btn {
      margin-left: 5px;
    }

    /* Responsive adjustments */
    @media (max-width: 992px) {
      .join-page {
        flex-direction: column-reverse;
      }

      .join-form-container, .image-container {
        flex: none;
        width: 100%;
      }

      .image-container {
        height: 200px;
      }

      .join-container {
        margin-bottom: 40px;
      }
    }

    @media (max-width: 576px) {
      .join-container {
        padding: 20px;
      }

      .image-container {
        height: 150px;
      }
    }
  </style>

  <script>
    $(function(){
      // 입력값 판단을 위한 정규식들
      let replaceNotInt = /[^0-9]/gi; // 숫자가 아닌 정규식
      let replaceNotEng = /[^a-zA-Z]/gi; // 영어가 아닌 정규식
      let replaceNotIntEng = /[^a-zA-Z0-9]/gi; // 숫자와 영어가 아닌 정규식
      let replaceNotFullKorean = /[ㄱ-ㅎㅏ-ㅣ]/gi; // 완성형 아닌 한글 정규식
      let replaceNotKorean = /[^가-힣]/gi; // 한글이 아닌 정규식
      let replaceNotKorean2 = /[^ㄱ-ㅎㅏ-ㅣ가-힣]/gi;

      // input 입력값 제한
      // 인증번호 - 숫자만 입력하도록 제한
      $("#authCode").on("keyup", function () {
        $(this).val($(this).val().replace(replaceNotInt,""));
      });

      // 비밀번호 - 숫자와 영어만 입력하도록 제한
      $("#mem_pw").on("keyup", function () {
        $(this).val($(this).val().replace(replaceNotIntEng,""));
      });

      // 닉네임 - 숫자와 영어만 입력하도록 제한
      $("#mem_nickname").on("keyup", function () {
        $(this).val($(this).val().replace(replaceNotIntEng,""));
      });

      // 이름 - 완성형 한글만 입력하도록 제한 (한글 자음이나 모음만, 혹은 한글 아닌 문자가 입력되는 것을 막음)
      $("#mem_name").on("focusout", function () {
        let x = $(this).val();
        if(x.length > 0) {
          if(x.match(replaceNotKorean2)) {
            x = x.replace(replaceNotKorean2, "");
          }
          $(this).val(x);
        }
      }).on("keyup", function () {
        $(this).val($(this).val().replace(replaceNotKorean, ""));
      });

      // 전화번호 - 숫자만 입력하도록 제한
      $("#mem_phone").on("keyup", function () {
        $(this).val($(this).val().replace(replaceNotInt,""));
      });

      // 회원가입 버튼 클릭 이벤트
      $('#send').on('click', () => {
        const formData = {
          mem_id: $('#mem_id').val(),
          mem_name: $('#mem_name').val(),
          mem_phone: $('#mem_phone').val(),
          mem_pw: $('#mem_pw').val(),
          mem_mail: $('#mem_mail').val(),
          mem_bir: $('#mem_bir').val(),
          zipcode: $('#zipcode').val(),
          mem_addr: $('#mem_addr').val(),
          mem_gen: $("input[name='mem_gen']:checked").val(),
          mem_nickname: $("#mem_nickname").val()
        };

        $.ajax({
          url: '<%=request.getContextPath() %>/member/memberInsert.do',
          type: 'post',
          data: formData,
          dataType: 'json',
          success: function(result) {
            if (result && result.flag) {
              $('#joinspan').html(result.flag).css('color', 'red');
              if (result.redirectUrl) {
                window.location.href = result.redirectUrl;
              }
            } else {
              $('#joinspan').html('회원 가입에 실패했습니다.').css('color', 'red');
            }
          },
          error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', status, error);
            $('#joinspan').html('서버 오류가 발생했습니다. 관리자에게 문의해주세요.').css('color', 'red');
          }
        });
      });

      // 우편번호 검색 버튼 클릭 이벤트
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
        const idvalue = $('#mem_id').val();
        if(idvalue.trim() === "") {
          $('#idspan').html("이메일을 입력해주세요.").css('color', 'red');
          return;
        }

        let email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i; // 이메일 형식 검증
        if(!email_regex.test(idvalue.trim())){
          $('#idspan').html("이메일 형식이 아닙니다.").css('color', 'red');
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
                    $('#emailAuthBtn').removeClass('unvis').addClass('view');
                    $('#idspan').html(result.flag).css('color', 'green');
                  }
                })
                .catch(err => console.log(err));
      });

      // 이메일 인증 버튼 클릭 이벤트
      $('#emailAuthBtn').on('click', function() {
        const email = $('#mem_id').val();
        if (!email) {
          $('#idspan').html("이메일을 입력해주세요.").css('color', 'red');
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
                    $('#idspan').html("인증 메일이 발송되었습니다. 이메일을 확인하고 인증 번호를 입력해주세요.").css('color', 'green');
                    $('#authCodeInput').show(); // 인증 번호 입력 필드 표시
                  } else {
                    $('#idspan').html("인증 메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.").css('color', 'red');
                  }
                })
                .catch(err => console.log(err));
      });

      // 인증 번호 확인 버튼 클릭 이벤트
      $('#authCodeCheckBtn').on('click', function() {
        const email = $('#mem_id').val();
        const authCode = $('#authCode').val();

        if(authCode.trim() === "") {
          $('#authCodeMsg').html("인증번호를 입력해주세요.").css('color', 'red');
          return;
        }

        fetch('<%=request.getContextPath() %>/member/emailAuthCodeCheck.do?email=' + email + '&authCode=' + authCode)
                .then(res => {
                  if (res.ok) return res.json();
                  else throw new Error(res.statusText);
                })
                .then(result => {
                  if (result.success) {
                    $('#authCodeMsg').html("이메일 인증이 완료되었습니다.").css('color', 'green');
                    $('#emailAuthBtn').prop('disabled', true); // 인증 버튼 비활성화
                    $('#authCodeCheckBtn').prop('disabled', true); // 인증 번호 확인 버튼 비활성화
                    $('#authCode').prop('disabled', true); // 인증 번호 입력 필드 비활성화
                  } else {
                    $('#authCodeMsg').html("이메일 인증에 실패했습니다. 다시 입력해주세요.").css('color', 'red');
                  }
                })
                .catch(err => console.log(err));
      });

      // 닉네임 중복 확인 버튼 클릭 이벤트
      $('#nicknameCheckBtn').on('click', function() {
        const nickname = $('#mem_nickname').val();

        if (nickname.trim() === "") {
          $('#nicknameCheckMsg').html("닉네임을 입력해주세요.").css('color', 'red');
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
<div class="join-page">
  <div class="join-form-container">
    <h2>회원가입</h2>
    <div class="join-container">
      <form onsubmit="return false;">
        <div class="form-group">
          <label for="mem_id">아이디</label>
          <div class="input-group">
            <input type="email" name="mem_id" class="form-control" id="mem_id" placeholder="이메일 입력">
            <span class="input-group-btn">
              <button id="idcheck" type="button" class="btn btn-success">중복확인</button>
              <button id="emailAuthBtn" type="button" class="btn btn-info unvis">인증</button>
            </span>
          </div>
          <div class="status-message">
            <span id="idspan"></span>
          </div>
        </div>

        <div class="form-group" id="authCodeInput" style="display: none;">
          <label for="authCode">인증 번호</label>
          <div class="input-group">
            <input type="text" name="authCode" class="form-control" id="authCode" placeholder="인증 번호 입력">
            <span class="input-group-btn">
              <button id="authCodeCheckBtn" type="button" class="btn btn-success">확인</button>
            </span>
          </div>
          <div class="status-message">
            <span id="authCodeMsg"></span>
          </div>
        </div>

        <div class="form-group">
          <label for="mem_pw">비밀번호</label>
          <input type="password" name="mem_pw" class="form-control" id="mem_pw" placeholder="비밀번호 입력">
        </div>

        <div class="form-group">
          <label for="mem_nickname">닉네임</label>
          <div class="input-group">
            <input type="text" name="mem_nickname" class="form-control" id="mem_nickname" placeholder="닉네임 입력">
            <span class="input-group-btn">
              <button id="nicknameCheckBtn" type="button" class="btn btn-success">중복확인</button>
            </span>
          </div>
          <div class="status-message">
            <span id="nicknameCheckMsg"></span>
          </div>
        </div>

        <div class="form-group">
          <label for="mem_name">이름</label>
          <input type="text" name="mem_name" class="form-control" id="mem_name" placeholder="이름 입력">
        </div>

        <div class="row">
          <div class="col-sm-6">
            <div class="form-group">
              <label for="mem_addr">주소</label>
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
                <option value="강원특별자치도">강원특별자치도</option>
                <option value="충청북도">충청북도</option>
                <option value="충청남도">충청남도</option>
                <option value="전북특별자치도">전북특별자치도</option>
                <option value="전라남도">전라남도</option>
                <option value="경상북도">경상북도</option>
                <option value="경상남도">경상남도</option>
                <option value="제주특별자치도">제주특별자치도</option>
              </select>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="form-group">
              <label for="mem_phone">전화번호</label>
              <input type="text" name="mem_phone" class="form-control" id="mem_phone" placeholder="전화번호" maxlength="13">
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-sm-6">
            <div class="form-group">
              <label for="mem_bir">생년월일</label>
              <input type="date" name="mem_bir" class="form-control" id="mem_bir">
            </div>
          </div>
          <div class="col-sm-6">
            <div class="form-group">
              <label>성별</label>
              <div style="display: flex; align-items: center; height: 40px;">
                <label class="radio-inline" style="margin-top: 0;">
                  <input type="radio" name="mem_gen" value="M" checked> 남자
                </label>
                <label class="radio-inline" style="margin-top: 0;">
                  <input type="radio" name="mem_gen" value="F"> 여자
                </label>
              </div>
            </div>
          </div>
        </div>

        <div class="form-group">
          <button id="send" type="button" class="btn btn-primary">가입하기</button>
          <div class="status-message">
            <span id="joinspan"></span>
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class="image-container">
    <img src="../../../images/emam_login.png" alt="로고">
  </div>
</div>
</body>
</html>

