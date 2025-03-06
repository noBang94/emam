<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>개인 정보 수정</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>
  <style>
    form.form-horizontal {
      width: 100%;
      max-width: 600px;
      margin: 20px auto;
      text-align: center;
    }

    .form-group {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      margin-bottom: 10px;

    }

    .btn-custom {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 10px 20px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 16px;
      border-radius: 5px;
      cursor: pointer;
    }

    .btn-custom:hover {
      background-color: #0056b3;
      color: white;
    }

    .password-buttons {
      display: flex;
      align-items: center;
      margin-left: 5px;
    }

    .form-group label {
      width: 100px;
    }

  </style>
  <script>
    $(function(){
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
          $('#mem_name').val(member.mem_nickname);
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
<br><br>
<div class="text-center">
  <h2>개인 정보 수정</h2>
</div>
<br><br>
<form class="form-horizontal" onsubmit="return false;">
  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_id">아이디</label>
    <div class="col-sm-3">
      <input type="email" name="mem_id" class="form-control" id="mem_id" readonly>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_pw">비밀번호</label>
    <div class="col-sm-3">
      <input type="password" name="mem_pw" class="form-control" id="mem_pw" placeholder="비밀번호 입력">
    </div>
    <div class="col-sm-5">
      <div class="password-buttons">
        <button type="button" class="btn btn-primary btn-sm" id="changePasswordBtn">비밀번호 변경</button>
        <button type="button" class="btn btn-primary btn-sm" id="togglePasswordBtn">보기</button>
        <button type="button" class="btn btn-primary btn-sm" id="changePasswordConfirmBtn">비밀번호 변경 확인</button>
      </div>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_nickname">닉네임</label>
    <div class="col-sm-3">
      <input type="text" name="mem_nickname" class="form-control" id="mem_nickname" placeholder="닉네임 입력">
    </div>
    <div class="col-sm-2">
      <input id="nicknameCheckBtn" type="button" class="btn btn-success btn-sm" value="중복확인">
      <span id="nicknameCheckMsg"></span>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_name">이름</label>
    <div class="col-sm-3">
      <input type="text" name="mem_name" class="form-control" id="mem_name" readonly>
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
  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_phone">전화번호</label>
    <div class="col-sm-3">
      <input type="text" name="mem_phone" class="form-control" id="mem_phone" placeholder="전화번호 입력">
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-sm-2" for="mem_bir">생년월일</label>
    <div class="col-sm-3">
      <input type="date" name="mem_bir" class="form-control" id="mem_bir" readonly>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-sm-2">성별</label>
    <div class="col-sm-10">
      <label class="radio-inline">
        <input type="radio" name="mem_gen" value="M"> 남자
      </label>
      <label class="radio-inline">
        <input type="radio" name="mem_gen" value="F"> 여자
      </label>
    </div>
  </div>
  <div class="form-group">
    <div class="text-center mt-4">
      <button type="button" class="btn btn-custom btn-sm" id="send">수정 완료</button>
    </div>
  </div>
</form>
</body>