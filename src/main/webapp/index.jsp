<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>로그인</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        h2 {
            text-align: center;
            margin-top: 50px;
        }
        .login-container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            position: relative; /* 관리자 링크 위치 기준 설정 */
        }
        .button-group {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .button-group button {
            flex: 1;
            width: 48%; /* 버튼 너비 조정 */
            display: inline-block; /* 버튼을 인라인 블록 요소로 설정 */
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #loginBtn {
            background-color: #007bff;
            color: white;
        }

        #loginBtn:hover {
            background-color: #0056b3;
        }

        #joinBtn {
            background-color: #28a745;
            color: white;
        }

        #joinBtn:hover {
            background-color: #1e7e34;
        }

        #findPwdBtn {
            background-color: #17a2b8;
            color: white;
        }

        #findPwdBtn:hover {
            background-color: #138496;
        }

        .admin-link {
            position: absolute; /* 절대 위치 설정 */
            bottom: 10px; /* 하단 여백 설정 */
            right: 10px; /* 우측 여백 설정 */
            font-size: 12px; /* 폰트 크기 조정 */
        }
    </style>

    <script>
        $(function(){
            $("#loginBtn").on("click", function(){
                const userId = $("#id").val();
                const userPw = $("#pwd").val();

                if (userId.length === 0 || userPw.length === 0) {
                    alert("아이디와 비밀번호를 입력하세요.");
                    return;
                }

                $.ajax({
                    url: "<%=request.getContextPath() %>/member/loginMember.do",
                    method: "POST",
                    data: { "mem_id": userId, "mem_pw": userPw }, // 일반 파라미터 형식으로 데이터 전송
                    success: function(data) {
                        if (data.result === "success") {
                            window.location.href = "<%=request.getContextPath() %>/welcome/welcome.do";
                        } else {
                            $("#loginResult").text("로그인 실패. 아이디 또는 비밀번호를 확인하세요.").css("color", "red");
                        }
                    },
                    error: function(xhr) {
                        alert("오류 상태값: " + xhr.status);
                    },
                    dataType: "json"
                });
            });

            $("#joinBtn").on("click", function(){
                window.location.href = "<%=request.getContextPath() %>/member/memberJoin.do";
            });

            $("#findPwdBtn").on("click", function(){
                // 비밀번호 찾기 페이지로 이동
                window.location.href = "<%=request.getContextPath() %>/member/findPassword.do";
            });

        });
    </script>
</head>
<body>

<h2>로그인</h2>

<div class="login-container">
    <form onsubmit="return false;">
        <div class="form-group">
            <label for="id">아이디</label>
            <input type="text" class="form-control" id="id" placeholder="아이디 입력">
        </div>

        <div class="form-group">
            <label for="pwd">비밀번호</label>
            <input type="password" class="form-control" id="pwd" placeholder="비밀번호 입력">
        </div>

        <div class="button-group">
            <button id="loginBtn" type="button" class="btn btn-primary">로그인</button>
            <button id="joinBtn" type="button" class="btn btn-success">회원가입</button>
            <button id="findPwdBtn" type="button" class="btn btn-secondary">비밀번호 찾기</button>
        </div>

        <p id="loginResult"></p>
    </form>
    <a href="<%=request.getContextPath() %>/admin/adminLogin.do" class="admin-link">관리자</a>
</div>

</body>
</html>