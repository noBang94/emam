<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원 검색 결과</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f9;
        }
        .user-list-container {
            width: 80%;
            margin: 120px auto; /* 상단 마진 감소 */
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border-radius: 10px;
            overflow: hidden;
            background-color: white;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th, .table td {
            padding: 14px 18px; /* 패딩 증가 */
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        .table thead th {
            background-color: #e9f2ff;
            color: #333;
            font-weight: 600;
        }
        .table tbody tr:hover {
            background-color: #f9f9f9;
        }
        .btn-info {
            background-color: #5bc0de;
            border: none;
            padding: 10px 18px; /* 버튼 패딩 증가 */
            border-radius: 5px;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-info:hover {
            background-color: #46b8da;
        }
        .empty-message {
            text-align: center;
            padding: 40px; /* 패딩 증가 */
            font-style: italic;
            color: #888;
        }
    </style>

    <script>
        // ... 스크립트 코드 ...
    </script>
</head>
<body>

<div class="user-list-container">
    <table class="table">
        <thead>
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>닉네임</th>
            <th>프로필 보기</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<MemberVO> memberList = (List<MemberVO>) request.getAttribute("memberList");
            if (memberList != null && !memberList.isEmpty()) {
                for (MemberVO member : memberList) {
        %>
        <tr>
            <td><%= member.getMem_id() %></td>
            <td><%= member.getMem_name() %></td>
            <td><%= member.getMem_nickname() %></td>
            <td>
                <a href="<%=request.getContextPath() %>/profile.do?memId=<%= member.getMem_id() %>" class="btn btn-info btn-sm">프로필</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="empty-message">검색 결과가 없습니다.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>