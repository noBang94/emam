<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관리자 로그인</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        body {
            background-color: #e9ecef; /* 연한 회색 배경 */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            width: 400px;
            padding: 50px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15); /* 그림자 강화 */
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 40px;
            color: #343a40;
            font-weight: 600; /* 폰트 굵게 */
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-control {
            border-radius: 8px;
            padding: 14px;
            border: 1.5px solid #ced4da; /* 테두리 두께 조정 */
            font-size: 16px; /* 폰트 크기 조정 */
        }
        .btn-primary {
            width: 100%;
            padding: 14px;
            background-color: #007bff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px; /* 폰트 크기 조정 */
            font-weight: 500; /* 폰트 굵기 조정 */
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        #adminLoginResult {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
        }
        .login-container label {
            font-weight: 500; /* 라벨 폰트 굵기 조정 */
            margin-bottom: 8px;
            display: block;
        }
    </style>

    <script>

        $(function(){
            $("#adminLoginBtn").on("click", function(){
                const adminId = $("#adminId").val();
                const adminPw = $("#adminPw").val();

                if (adminId.length === 0 || adminPw.length === 0) {
                    alert("관리자 아이디와 비밀번호를 입력하세요.");
                    return;
                }

                $.ajax({
                    url: "<%=request.getContextPath() %>/admin/adminLogin.do",
                    method: "POST",
                    data: { "adminId": adminId, "adminPw": adminPw },
                    success: function(data) {
                        if (data.result === "success") {
                            window.location.href = "<%=request.getContextPath() %>/admin/adminMain.do";
                            alert("관리자님 환영합니다.");
                        } else {
                            $("#adminLoginResult").text("로그인 실패. 아이디 또는 비밀번호를 확인하세요.").css("color", "red");
                        }
                    },
                    error: function(xhr) {
                        alert("오류 상태값: " + xhr.status);
                    },
                    dataType: "json"
                });
            });
        });
    </script>
</head>
<body>

<div class="login-container">
    <h2>관리자 로그인</h2>
    <form onsubmit="return false;">
        <div class="form-group">
            <label for="adminId">관리자 아이디</label>
            <input type="text" class="form-control" id="adminId" placeholder="관리자 아이디 입력">
        </div>
        <div class="form-group">
            <label for="adminPw">비밀번호</label>
            <input type="password" class="form-control" id="adminPw" placeholder="비밀번호 입력">
        </div>
        <button id="adminLoginBtn" type="button" class="btn btn-primary">로그인</button>
        <p id="adminLoginResult"></p>
    </form>
</div>

</body>
</html>