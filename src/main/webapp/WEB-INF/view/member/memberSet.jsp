<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>개인 정보 수정</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>
  <style>
    :root {
      --primary-color: #64B5F6;
      --primary-hover: #90CAF9;
      --secondary-color: #64B5F6;
      --text-color: #333;
      --text-light: #666;
      --background-color: #f5f7fa;
      --card-background: #fff;
      --border-color: #e2e8f0;
      --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
      --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      --radius: 0.5rem;
      --transition: all 0.3s ease;
    }

    body {
      padding: 0;
      margin: 0;
      background: linear-gradient(to bottom, #e0f2fe, #ffffff);
      color: var(--text-color);
      font-family: 'Noto Sans KR', sans-serif;
      min-height: 100vh;
      margin-top: 60px;
    }

    /* 메인 컨테이너 스타일 */
    .update-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 20px 20px 0 20px;
      min-height: calc(100vh - 60px); /* GNB 높이 제외 */
    }

    h2 {
      text-align: center;
      margin: 0 0 30px;
      font-size: 31px !important;
      font-weight: 700;
      color: var(--primary-color);
      letter-spacing: -0.5px;
    }

    .form-container {
      width: 100%;
      max-width: 600px;
      padding: 35px 40px;
      background-color: var(--card-background);
      border-radius: 12px;
      box-shadow: var(--shadow-lg);
      position: relative;
      transition: var(--transition);
      margin: 20px 0 0 0;
    }

    .form-container:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      color: var(--text-color);
      font-weight: 500;
      font-size: 15px;
      margin-bottom: 8px;
      display: block;
    }

    .form-control {
      height: 48px;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      padding: 10px 15px;
      font-size: 16px;
      transition: var(--transition);
      box-shadow: none;
    }

    .form-control:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(100, 181, 246, 0.2);
    }

    .btn {
      height: 33.99px;
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
      background-color: var(--primary-color);
    }

    .btn:hover {
      background-color: var(--primary-hover); /* 모든 버튼 호버 색상 변경 */
      transform: translateY(-2px);
    }

    .password-buttons {
      display: flex;
      gap: 8px;
      margin-top: 8px;
    }

    .radio-inline {
      margin-right: 15px;
      font-weight: normal;
    }

    .status-message {
      margin-top: 5px;
      font-size: 12px;
    }
    .checkbox-inline+.checkbox-inline, .radio-inline+.radio-inline{
      margin-left:0 !important;
    }
    .gen-warp{
      display: flex;

    }

    #nicknameCheckMsg {
      display: block;
      margin-top: 5px;
      font-size: 12px;
    }

    .submit-button {
      width: 100%;
      height: 48px;
      font-size: 16px;
      margin-top: 10px;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
      .form-container {
        padding: 25px;
      }

      h2 {
        font-size: 28px;
        margin-bottom: 20px;
      }
    }
  </style>
  <script>
    $(function(){
      //입력값 판단을 위한 정규식들
      let replaceNotInt = /[^0-9]/gi; //숫자가 아닌 정규식
      let replaceNotEng = /[^a-zA-Z]/gi; //영어가 아닌 정규식
      let replaceNotIntEng = /[^a-zA-Z0-9]/gi; //숫자와 영어가 아닌 정규식
      let replaceNotFullKorean = /[ㄱ-ㅎㅏ-ㅣ]/gi; //완성형 아닌 한글 정규식
      let replaceNotKorean = /[^가-힣]/gi; //한글이 아닌 정규식
      let replaceNotKorean2 = /[^ㄱ-ㅎㅏ-ㅣ가-힣]/gi;

      //input 입력값 제한
      //비밀번호 - 숫자와 영어만 입력하도록 제한
      $("#mem_pw").on("keyup", function () { $(this).val($(this).val().replace(replaceNotIntEng,"") );});
      //닉네임 - 숫자와 ??어만 입력하도록 제한
      $("#mem_nickname").on("keyup", function () { $(this).val($(this).val().replace(replaceNotIntEng,"") );});
      //전화번호 - 숫자만 입력하도록 제한
      $("#mem_phone").on("keyup", function () { $(this).val($(this).val().replace(replaceNotInt,"") );});

      // 기존 회원 정보 불러오기
      $.ajax({
        url: '<%=request.getContextPath() %>/member/memberset.do',
        type: 'post',
        data: { action: 'getMemberInfo' },
        dataType: 'json',
        success: function(member) {
          $('#mem_id').val(member.mem_id);
          $('#mem_pw').val(member.mem_pw);
          $('#mem_nickname').val(member.mem_nickname);
          $('#mem_name').val(member.mem_name);
          $('#mem_addr').val(member.mem_addr);
          $('#mem_phone').val(member.mem_phone);
          if (member.mem_bir) {
            let date = new Date(member.mem_bir);
            let year = date.getFullYear();
            let month = ('0' + (date.getMonth() + 1)).slice(-2);
            let day = ('0' + date.getDate()).slice(-2);
            let formattedBirth = year + '-' + month + '-' + day;
            $('#mem_bir').val(formattedBirth);
          }
          $("input[name='mem_gen'][value='" + member.mem_gen + "']").prop('checked', true);
          $("input[name='mem_gen']").prop('disabled', true);
        },
        error: function(xhr, status, error) {
          console.error('회원 정보 불러오기 실패:', status, error);
          alert('회원 정보를 불러오는 데 실패했습니다.');
        }
      });

      // 회원 정보 수정
      function updateMember() {
        if ($('#mem_nickname').val().trim() === '') {
          alert('닉네임을 입력해주세요.');
          $('#mem_nickname').focus();
          return false;
        }

        const formData = {
          mem_id: $('#mem_id').val(),
          mem_nickname: $('#mem_nickname').val(),
          mem_addr: $('#mem_addr').val(),
          mem_phone: $('#mem_phone').val(),
          action: 'updateMember'
        };

        $.ajax({
          url: '<%=request.getContextPath() %>/member/memberset.do',
          type: 'post',
          data: formData,
          dataType: 'json',
          success: function(result) {
            if (result && result.flag === 'success') {
              alert('개인 정보가 수정되었습니다.');
              window.location.href = '<%=request.getContextPath() %>/post/postList.do';
            } else {
              alert('개인 정보 수정에 실패했습니다.');
            }
          },
          error: function(xhr, status, error) {
            console.error('개인 정보 수정 실패:', status, error);
            alert('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
          }
        });
      }

      // 닉네임 중복 확인
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

      // 비밀번호 표시/숨김 토글 버튼 클릭 이벤트 핸들러
      $('#togglePasswordBtn').on('click', function() {
        const passwordField = $('#mem_pw');
        const passwordFieldType = passwordField.attr('type');

        if (passwordFieldType === 'password') {
          passwordField.attr('type', 'text');
          $(this).text('숨기기');
        } else {
          passwordField.attr('type', 'password');
          $(this).text('보기');
        }
      });

      // 비밀번호 변경
      $('#changePasswordBtn').on('click', function() {
        $('#mem_pw').prop('readonly', false).attr('type', 'text');
        $('#changePasswordConfirmBtn').show(); // 비밀번호 변경 완료 버튼 표시
        $('#changePasswordBtn').hide(); // 비밀번호 변경 버튼 숨김
        $('#togglePasswordBtn').hide();
      });

      // 비밀번호 변경 완료 버튼 클릭 이벤트
      $('#changePasswordConfirmBtn').on('click', function() {
        const newPassword = $('#mem_pw').val();

        if (newPassword.trim() === "") {
          alert("새 비밀번호를 입력해주세요.");
          return;
        }

        const formData = {
          mem_id: $('#mem_id').val(),
          mem_pw: newPassword,
          action: 'changePassword'
        };

        $.ajax({
          url: '<%=request.getContextPath() %>/member/memberset.do',
          type: 'post',
          data: formData,
          dataType: 'json',
          success: function(result) {
            if (result && result.flag === 'success') {
              alert('비밀번호가 변경되었습니다.');
              $('#mem_pw').val(''); // 비밀번호 입력 필드 초기화
            } else {
              alert('비밀번호 변경에 실패했습니다.');
            }
          },
          error: function(xhr, status, error) {
            console.error('비밀번호 변경 실패:', status, error);
            alert('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
          },
          complete: function() {
            $('#mem_pw').prop('readonly', true).attr('type', 'password');
            $('#changePasswordConfirmBtn').hide();
            $('#changePasswordBtn').show();
            $('#togglePasswordBtn').show(); // 보기/숨기기 버튼 표시
          }
        });
      });

      // 이벤트 핸들러
      $('#send').on('click', updateMember);

      // 페이지 로딩 시 비밀번호 입력 필드 읽기 전용 설정 및 비밀번호 변경 완료 버튼 숨김
      $('#mem_pw').prop('readonly', true);
      $('#changePasswordConfirmBtn').hide();
    });
  </script>
</head>
<body>
<!-- GNB 인클루드 -->
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<!-- 메인 컨텐츠 -->
<div class="update-container">
  <h2>개인 정보 수정</h2>

  <div class="form-container">
    <form onsubmit="return false;">
      <div class="form-group">
        <label for="mem_id">아이디</label>
        <input type="email" name="mem_id" class="form-control" id="mem_id" readonly>
      </div>

      <div class="form-group">
        <label for="mem_pw">비밀번호</label>
        <input type="password" name="mem_pw" class="form-control" id="mem_pw" placeholder="비밀번호 입력">
        <div class="password-buttons">
          <button type="button" class="btn btn-primary" id="changePasswordBtn">비밀번호 변경</button>
          <button type="button" class="btn btn-primary" id="togglePasswordBtn">보기</button>
          <button type="button" class="btn btn-primary" id="changePasswordConfirmBtn">변경 확인</button>
        </div>
      </div>

      <div class="form-group">
        <label for="mem_nickname">닉네임</label>
        <div class="input-group">
          <input type="text" name="mem_nickname" class="form-control" id="mem_nickname" placeholder="닉네임 입력">
          <span class="input-group-btn">
            <button id="nicknameCheckBtn" type="button" class="btn btn-primary">중복확인</button>
          </span>
        </div>
        <span id="nicknameCheckMsg"></span>
      </div>

      <div class="form-group">
        <label for="mem_name">이름</label>
        <input type="text" name="mem_name" class="form-control" id="mem_name" readonly>
      </div>

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

      <div class="form-group">
        <label for="mem_phone">전화번호</label>
        <input type="text" name="mem_phone" class="form-control" id="mem_phone" placeholder="전화번호 입력" maxlength="13">
      </div>

      <div class="form-group">
        <label for="mem_bir">생년월일</label>
        <input type="date" name="mem_bir" class="form-control" id="mem_bir" readonly>
      </div>

      <div class="form-group">
        <label>성별</label>
        <div class="gen-warp">
          <label class="radio-inline">
            <input type="radio" name="mem_gen" value="M"> 남자
          </label>
          <label class="radio-inline">
            <input type="radio" name="mem_gen" value="F"> 여자
          </label>
        </div>
      </div>

      <div class="form-group">
        <button type="button" class="btn btn-primary submit-button" id="send">수정 완료</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>