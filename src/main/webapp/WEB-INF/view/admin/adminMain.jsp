<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관리자 메인 페이지</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
        }
        .top-bar {
            background-color: #343a40;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .top-bar h2 {
            margin: 0;
            font-size: 24px;
        }
        .top-bar .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .top-bar .logout-btn:hover {
            background-color: #c82333;
        }
        .admin-menu {
            width: 80%;
            margin: 50px auto;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }
        .menu-item {
            width: 220px;
            height: 180px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background-color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease;
        }
        .menu-item:hover {
            transform: translateY(-5px);
        }
        .menu-item a {
            text-decoration: none;
            color: #333;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .menu-item p {
            color: #777;
            text-align: center;
            padding: 0 15px;
        }
        /* 대시보드 스타일 추가 */
        .dashboard {
            width: 80%;
            margin: 30px auto;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            padding: 30px;
        }
        .dashboard-title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            color: #333;
        }
        .dashboard-items {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }
        .dashboard-item {
            width: 220px;
            padding: 25px;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            text-align: center;
            margin: 15px;
        }
        .dashboard-item h3 {
            margin-bottom: 15px;
            font-size: 22px;
            color: #333;
        }
        .dashboard-item p {
            font-size: 28px;
            font-weight: 600;
            color: #007bff;
            margin-bottom: 10px;
        }
        .dashboard-item i {
            font-size: 36px;
            color: #6c757d;
            margin-bottom: 15px;
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
        });
    </script>

</head>
<body>

<div class="top-bar">
    <h2>관리자 메인 페이지</h2>
    <button id="logoutBtn" class="btn logout-btn">로그아웃</button>
</div>

<div class="admin-menu">
    <div class="menu-item">
        <a href="<%=request.getContextPath() %>/admin/userList.do">회원 관리</a>
        <p>회원 정보 조회 및 관리</p>
    </div>
    <div class="menu-item">
        <a href="<%=request.getContextPath() %>/admin/noticeList.do">공지사항 관리</a>
        <p>공지사항 등록 및 수정</p>
    </div>
    <div class="menu-item">
        <a href="<%=request.getContextPath() %>/admin/reportList.do">신고 관리</a>
        <p>신고된 게시물 및 사용자 관리</p>
    </div>
    <div class="menu-item">
        <a href="<%=request.getContextPath() %>/admin/qnaList.do">문의 관리</a>
        <p>사용자 문의 답변 및 관리</p>
    </div>
</div>

<div class="dashboard">
    <div class="dashboard-title">
        통계
    </div>
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

</body>
</html>