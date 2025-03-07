<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>로그인</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">

    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        :root {
            --primary-color: #64B5F6;
            --primary-hover: #90CAF9;
            --secondary-color: #64B5F6; /* 회원가입 버튼 색상 */
            --secondary-hover: #90CAF9; /* 회원가입 버튼 호버 색상 */
            --tertiary-color: #64B5F6; /* 비밀번호 찾기 버튼 색상 */
            --tertiary-hover: #90CAF9; /* 비밀번호 찾기 버튼 호버 색상 */
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
            background-color: var(--background-color);
            color: var(--text-color);
            font-family: 'Noto Sans KR', sans-serif;
            min-height: 100vh;
        }

        .login-page {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }

        .login-form-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
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
            transition: var(--transition);
        }

        h2 {
            text-align: center;
            margin: 0 0 30px;
            font-size: 36px;
            font-weight: 700;
            color: var(--primary-color);
            letter-spacing: -0.5px;
        }

        .login-container {
            width: 100%;
            max-width: 400px;
            padding: 35px 40px;
            background-color: var(--card-background);
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
            position: relative;
            transition: var(--transition);
        }

        .login-container:hover {
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

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: 30px;
        }

        .button-group button {
            width: 100%;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            font-weight: 500;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            color: white;
        }

        #loginBtn {
            background-color: var(--primary-color);
        }

        #loginBtn:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        #joinBtn {
            background-color: var(--secondary-color);
        }

        #joinBtn:hover {
            background-color: var(--secondary-hover);
            transform: translateY(-2px);
        }

        #findPwdBtn {
            background-color: var(--tertiary-color);
        }

        #findPwdBtn:hover {
            background-color: var(--tertiary-hover);
            transform: translateY(-2px);
        }

        #loginResult {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            min-height: 20px;
        }

        .admin-button {
            position: absolute;
            bottom: -50px;
            right: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 16px;
            font-size: 14px;
            font-weight: 500;
            color: #64B5F6;
            background-color: rgba(255, 255, 255, 0.9);
            border: 1px solid #E1F0FE;
            border-radius: 20px;
            text-decoration: none;
            transition: var(--transition);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .admin-button:hover {
            color: white;
            background-color: #64B5F6;
            border-color: #64B5F6;
            box-shadow: 0 4px 8px rgba(100, 181, 246, 0.3);
            transform: translateY(-2px);
            text-decoration: none;
        }

        .admin-button:before {
            content: "👑";
            margin-right: 6px;
            font-size: 12px;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .login-page {
                flex-direction: column-reverse;
            }

            .login-form-container, .image-container {
                flex: none;
                width: 100%;
            }

            .image-container {
                height: 250px;
            }

            .login-container {
                max-width: 450px;
                margin-bottom: 60px;
            }

            h2 {
                font-size: 28px;
                margin-bottom: 20px;
            }
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 25px;
            }

            .image-container {
                height: 200px;
            }
        }
    </style>

    <script>
        $(function(){
            $("#loginBtn").on("click", function(){
                const userId = $("#id").val();
                const userPw = $("#pwd").val();

                if (userId.length === 0 || userPw.length === 0) {
                    $("#loginResult").text("아이디와 비밀번호를 입력하세요.").css("color", "#F08E95");
                    return;
                }

                $.ajax({
                    url: "<%=request.getContextPath() %>/member/loginMember.do",
                    method: "POST",
                    data: { "mem_id": userId, "mem_pw": userPw },
                    success: function(data) {
                        if (data.result === "success") {
                            window.location.href = "<%=request.getContextPath() %>/welcome/welcomeMain.do";
                        } else {
                            $("#loginResult").text("로그인 실패. 아이디 또는 비밀번호를 확인하세요.").css("color", "#F08E95");
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
                window.location.href = "<%=request.getContextPath() %>/member/findPassword.do";
            });

            // Enter key support
            $("#id, #pwd").on("keypress", function(e) {
                if (e.which === 13) {
                    $("#loginBtn").click();
                }
            });

            // Focus animation
            $(".form-control").on("focus", function() {
                $(this).parent().addClass("focused");
            }).on("blur", function() {
                $(this).parent().removeClass("focused");
            });
        });
    </script>
</head>
<body>

<div class="login-page">
    <div class="login-form-container">
        <h2>로그인</h2>

        <div class="login-container">
            <form onsubmit="return false;">
                <div class="form-group">
                    <label for="id">아이디</label>
                    <input type="text" class="form-control" id="id" placeholder="아이디를 입력하세요.">
                </div>

                <div class="form-group">
                    <label for="pwd">비밀번호</label>
                    <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요.">
                </div>

                <div class="button-group">
                    <button id="loginBtn" type="button" class="btn">로그인</button>
                    <button id="joinBtn" type="button" class="btn">회원가입</button>
                    <button id="findPwdBtn" type="button" class="btn">비밀번호 찾기</button>
                </div>

                <p id="loginResult"></p>
            </form>
            <a href="<%=request.getContextPath() %>/admin/adminLogin.do" class="admin-button">관리자</a>
        </div>

        <div id="signupForm" style="display: none;">
            <h2>회원가입</h2>
            <jsp:include page="/WEB-INF/view/member/memberJoin.jsp"/>
        </div>
    </div>
    <div class="image-container">
        <img src="<%=request.getContextPath()%>/images/emam_login.png" alt="로고">
    </div>
</div>

</body>
</html>