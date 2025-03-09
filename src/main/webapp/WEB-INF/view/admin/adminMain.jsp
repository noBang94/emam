<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관리자 메인 페이지</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        :root {
            --primary-color: #64B5F6;
            --primary-light: #90CAF9;
            --primary-lighter: #BBDEFB;
            --primary-dark: #42A5F5;
            --primary-darker: #1E88E5;
            --accent-color: #4FC3F7;
            --secondary-color: #7986CB;
            --secondary-light: #9FA8DA;
            --secondary-dark: #5C6BC0;
            --tertiary-color: #4DD0E1;
            --text-color: #333;
            --text-light: #666;
            --background-color: #EBF5FE;
            --card-background: #fff;
            --border-color: #e2e8f0;
            --danger-color: #F08E95;
            --danger-hover: #E57373;
            --success-color: #81C784;
            --warning-color: #FFD54F;
            --info-color: #4DD0E1;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --radius: 0.5rem;
            --transition: all 0.3s ease;
        }

        body {
            padding: 0;
            margin: 0;
            color: var(--text-color);
            font-family: 'Noto Sans KR', sans-serif;
            min-height: 100vh;
            position: relative;
            background: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%2364b5f6' fill-opacity='0.15'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            z-index: -1;
            opacity: 0.7;
        }

        .page-wrapper {
            position: relative;
            min-height: 100vh;
            overflow: hidden;
        }

        .bg-gradient-1 {
            position: absolute;
            width: 600px;
            height: 600px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(79, 195, 247, 0.2) 0%, rgba(79, 195, 247, 0) 70%);
            top: -300px;
            right: -200px;
            z-index: -1;
        }

        .bg-gradient-2 {
            position: absolute;
            width: 500px;
            height: 500px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(121, 134, 203, 0.2) 0%, rgba(121, 134, 203, 0) 70%);
            bottom: -200px;
            left: -100px;
            z-index: -1;
        }

        .bg-gradient-3 {
            position: absolute;
            width: 400px;
            height: 400px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(77, 208, 225, 0.15) 0%, rgba(77, 208, 225, 0) 70%);
            top: 30%;
            left: 10%;
            z-index: -1;
        }

        .top-bar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .top-bar h2 {
            margin: 0;
            font-size: 24px;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .top-bar h2::before {
            content: "\f2f6";
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            margin-right: 12px;
            font-size: 20px;
        }

        .logout-btn {
            background-color: white;
            color: var(--primary-darker);
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
        }

        .logout-btn i {
            margin-right: 8px;
        }

        .logout-btn:hover {
            background-color: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .container-wrapper {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            position: relative;
            z-index: 1;
        }

        .section-title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-darker);
            letter-spacing: -0.5px;
            position: relative;
            display: inline-block;
            left: 50%;
            transform: translateX(-50%);
            padding-bottom: 10px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-lighter) 0%, var(--primary-darker) 100%);
            border-radius: 3px;
        }

        .admin-menu {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 25px;
            margin-bottom: 50px;
        }

        .menu-item {
            width: 220px;
            height: 200px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 16px;
            box-shadow: var(--shadow-md);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 25px 20px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(100, 181, 246, 0.2);
            backdrop-filter: blur(5px);
        }

        .menu-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary-color), var(--primary-darker));
            transition: var(--transition);
        }

        .menu-item::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(100, 181, 246, 0.1) 0%, transparent 100%);
            z-index: 0;
        }

        .menu-item:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-xl);
            border-color: rgba(100, 181, 246, 0.3);
        }

        .menu-item:hover::before {
            width: 100%;
            opacity: 0.1;
        }

        .menu-item-icon {
            font-size: 40px;
            margin-bottom: 20px;
            color: var(--primary-color);
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
            z-index: 1;
            transition: var(--transition);
        }

        .menu-item:hover .menu-item-icon {
            transform: scale(1.1);
        }

        .menu-item a {
            text-decoration: none;
            color: var(--text-color);
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
            transition: var(--transition);
        }

        .menu-item:hover a {
            color: var(--primary-darker);
        }

        .menu-item p {
            color: var(--text-light);
            text-align: center;
            font-size: 14px;
            position: relative;
            z-index: 1;
        }

        .dashboard {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 16px;
            box-shadow: var(--shadow-lg);
            padding: 30px;
            margin-bottom: 40px;
            border: 1px solid rgba(100, 181, 246, 0.2);
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(5px);
        }

        .dashboard::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-darker) 100%);
        }

        .dashboard-items {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 25px;
        }

        .dashboard-item {
            width: 220px;
            padding: 25px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 16px;
            box-shadow: var(--shadow-md);
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(100, 181, 246, 0.2);
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(5px);
        }

        .dashboard-item::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-darker) 100%);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease;
        }

        .dashboard-item:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-xl);
            border-color: rgba(100, 181, 246, 0.3);
        }

        .dashboard-item:hover::after {
            transform: scaleX(1);
        }

        .dashboard-item h3 {
            margin: 15px 0;
            font-size: 18px;
            color: var(--text-color);
            font-weight: 600;
        }

        .dashboard-item p {
            font-size: 32px;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0;
            transition: var(--transition);
        }

        .dashboard-item:hover p {
            transform: scale(1.1);
        }

        .dashboard-item i {
            font-size: 40px;
            color: var(--primary-color);
            opacity: 0.8;
            transition: var(--transition);
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-darker) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .dashboard-item:hover i {
            transform: scale(1.1);
        }

        .floating-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            overflow: hidden;
            pointer-events: none;
        }

        .shape {
            position: absolute;
            border-radius: 50%;
            animation: float 15s infinite ease-in-out;
        }

        .shape-1 {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, rgba(100, 181, 246, 0.3) 0%, rgba(100, 181, 246, 0.1) 100%);
            top: 20%;
            right: 10%;
            animation-delay: 0s;
        }

        .shape-2 {
            width: 150px;
            height: 150px;
            background: linear-gradient(135deg, rgba(121, 134, 203, 0.3) 0%, rgba(121, 134, 203, 0.1) 100%);
            bottom: 15%;
            left: 5%;
            animation-delay: 2s;
        }

        .shape-3 {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, rgba(77, 208, 225, 0.3) 0%, rgba(77, 208, 225, 0.1) 100%);
            top: 50%;
            left: 15%;
            animation-delay: 4s;
        }

        .shape-4 {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, rgba(129, 199, 132, 0.3) 0%, rgba(129, 199, 132, 0.1) 100%);
            bottom: 30%;
            right: 15%;
            animation-delay: 6s;
        }

        @keyframes float {
            0% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(5deg);
            }
            100% {
                transform: translateY(0) rotate(0deg);
            }
        }

        .wave-container {
            position: absolute;
            width: 100%;
            bottom: 0;
            left: 0;
            height: 150px;
            overflow: hidden;
            z-index: -1;
        }

        .wave {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 100px;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%2364B5F6" fill-opacity="0.2" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: 1440px 100px;
            animation: wave 20s linear infinite;
        }

        .wave:nth-child(2) {
            bottom: 0;
            animation: wave 15s linear reverse infinite;
            opacity: 0.7;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%237986CB" fill-opacity="0.2" d="M0,64L48,80C96,96,192,128,288,128C384,128,480,96,576,90.7C672,85,768,107,864,144C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
        }

        .wave:nth-child(3) {
            bottom: 0;
            animation: wave 30s linear infinite;
            opacity: 0.5;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%234DD0E1" fill-opacity="0.2" d="M0,160L48,144C96,128,192,96,288,106.7C384,117,480,171,576,197.3C672,224,768,224,864,213.3C960,203,1056,181,1152,186.7C1248,192,1344,224,1392,240L1440,256L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
        }

        @keyframes wave {
            0% {
                background-position-x: 0;
            }
            100% {
                background-position-x: 1440px;
            }
        }

        @media (max-width: 992px) {
            .admin-menu, .dashboard-items {
                gap: 15px;
            }

            .menu-item, .dashboard-item {
                width: calc(50% - 15px);
            }
        }

        @media (max-width: 576px) {
            .top-bar {
                padding: 15px 20px;
            }

            .top-bar h2 {
                font-size: 20px;
            }

            .container-wrapper {
                padding: 0 15px;
                margin: 30px auto;
            }

            .section-title {
                font-size: 24px;
                margin-bottom: 20px;
            }

            .menu-item, .dashboard-item {
                width: 100%;
            }

            .dashboard {
                padding: 20px;
            }
        }
    </style>

    <script>
        window.history.pushState(null, '', location.href);
        window.onpopstate = () => {
            console.log("뒤로가기")
            history.go(1);
            this.handleGoback();
        };

        $(function(){
            $("#logoutBtn").on("click", function(){
                window.location.href = "<%=request.getContextPath() %>/admin/adminLogout.do";
            });

            // Add hover effect for menu items
            $(".menu-item").hover(
                function() {
                    $(this).find("a").css("color", "#1E88E5");
                },
                function() {
                    $(this).find("a").css("color", "#333");
                }
            );
        });
    </script>
</head>
<body>
<div class="page-wrapper">
    <div class="bg-gradient-1"></div>
    <div class="bg-gradient-2"></div>
    <div class="bg-gradient-3"></div>

    <div class="top-bar">
        <h2>관리자 메인 페이지</h2>
        <button id="logoutBtn" class="logout-btn"><i class="fas fa-sign-out-alt"></i> 로그아웃</button>
    </div>

    <div class="container-wrapper">
        <div class="floating-shapes">
            <div class="shape shape-1"></div>
            <div class="shape shape-2"></div>
            <div class="shape shape-3"></div>
            <div class="shape shape-4"></div>
        </div>

        <h2 class="section-title">관리자 메뉴</h2>

        <div class="admin-menu">
            <div class="menu-item">
                <div class="menu-item-icon">
                    <i class="fas fa-users"></i>
                </div>
                <a href="<%=request.getContextPath() %>/admin/userList.do">회원 관리</a>
                <p>회원 정보 조회 및 관리</p>
            </div>
            <div class="menu-item">
                <div class="menu-item-icon">
                    <i class="fas fa-bullhorn"></i>
                </div>
                <a href="<%=request.getContextPath() %>/admin/noticeList.do">공지사항 관리</a>
                <p>공지사항 등록 및 수정</p>
            </div>
            <div class="menu-item">
                <div class="menu-item-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <a href="<%=request.getContextPath() %>/admin/reportList.do">신고 관리</a>
                <p>신고된 게시물 및 사용자 관리</p>
            </div>
            <div class="menu-item">
                <div class="menu-item-icon">
                    <i class="fas fa-question-circle"></i>
                </div>
                <a href="<%=request.getContextPath() %>/admin/qnaList.do">문의 관리</a>
                <p>사용자 문의 답변 및 관리</p>
            </div>
        </div>

        <h2 class="section-title">통계 현황</h2>

        <div class="dashboard">
            <div class="dashboard-items">
                <div class="dashboard-item">
                    <i class="fas fa-users"></i>
                    <h3>총 회원 수</h3>
                    <p>${totalUsers}</p>
                </div>
                <div class="dashboard-item">
                    <i class="fas fa-file-alt"></i>
                    <h3>총 게시글 수</h3>
                    <p>${totalPosts}</p>
                </div>
                <div class="dashboard-item">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>총 신고 건수</h3>
                    <p>${totalReports}</p>
                </div>
                <div class="dashboard-item">
                    <i class="fas fa-question-circle"></i>
                    <h3>총 문의 건수</h3>
                    <p>${totalQnas}</p>
                </div>
            </div>
        </div>
    </div>

    <div class="wave-container">
        <div class="wave"></div>
        <div class="wave"></div>
        <div class="wave"></div>
    </div>
</div>
</body>
</html>