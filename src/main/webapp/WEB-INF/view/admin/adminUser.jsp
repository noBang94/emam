<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원 관리</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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
        .user-list-container {
            width: 80%;
            margin: 50px auto;
        }
        .pagination-container {
            text-align: center;
            margin-top: 20px;
        }
        .search-container {
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-end;
        }
        .search-container .form-group {
            display: flex;
            align-items: center;
        }
        .search-container label {
            margin-right: 10px;
            white-space: nowrap;
        }
        .search-container input[type="text"] {
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
        .search-container .btn-primary {
            margin-left: 10px;
        }
    </style>

    <script>
        $(function(){
            $("#logoutBtn").on("click", function(){
                window.location.href = "<%=request.getContextPath() %>/admin/adminLogout.do";
            });
        });

        function deleteUser(userId) {
            if (confirm("정말로 삭제하시겠습니까?")) {
                location.href = "<%=request.getContextPath() %>/admin/userDelete.do?memId=" + userId;
            }
        }
    </script>
</head>
<body>

<div class="top-bar">
    <h2>회원 관리</h2>
    <button id="logoutBtn" class="btn logout-btn">로그아웃</button>
</div>

<div class="user-list-container">
    <div class="search-container">
        <form action="<%=request.getContextPath() %>/admin/userList.do" method="get" class="form-inline">
            <div class="form-group">
                <label for="searchId">아이디 검색:</label>
                <input type="text" class="form-control" id="searchId" name="searchId" value="<%= request.getParameter("searchId") != null ? request.getParameter("searchId") : "" %>">
            </div>
            <button type="submit" class="btn btn-primary">검색</button>
        </form>
    </div>

    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>닉네임</th>
            <th>가입일</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            List<MemberVO> memberList = (List<MemberVO>) request.getAttribute("memberList");
            if (errorMessage == null && memberList != null && !memberList.isEmpty()) {
                for (MemberVO member : memberList) {
        %>
        <tr>
            <td><%= member.getMem_id() %></td>
            <td><%= member.getMem_name() %></td>
            <td><%= member.getMem_nickname() %></td>
            <td><%= member.getMem_joindate() %></td>
            <td>
                <button type="button" class="btn btn-danger btn-sm" onclick="deleteUser('<%= member.getMem_id() %>')">삭제</button>
            </td>
        </tr>
        <%
            }
        } else if (errorMessage != null) {
        %>
        <tr>
            <td colspan="5" class="empty-message">
                <%= errorMessage %>
            </td>
        </tr>
        <%
        } else {
        %>
        <tr>
            <td colspan="5" class="empty-message">회원 목록이 없습니다.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="pagination-container">
        <ul class="pagination">
            <%
                int currentPage = (Integer) request.getAttribute("currentPage");
                int totalPages = (Integer) request.getAttribute("totalPages");
                int startPage = Math.max(1, currentPage - 5);
                int endPage = Math.min(totalPages, currentPage + 5);

                if (currentPage > 1) {
            %>
            <li><a href="<%=request.getContextPath() %>/admin/userList.do?page=<%= currentPage - 1 %>&searchId=<%= request.getParameter("searchId") != null ? request.getParameter("searchId") : "" %>">&laquo;</a></li>
            <%
                }

                for (int i = startPage; i <= endPage; i++) {
            %>
            <li <%= currentPage == i ? "class='active'" : "" %>><a href="<%=request.getContextPath() %>/admin/userList.do?page=<%= i %>&searchId=<%= request.getParameter("searchId") != null ? request.getParameter("searchId") : "" %>"><%= i %></a></li>
            <%
                }

                if (currentPage < totalPages) {
            %>
            <li><a href="<%=request.getContextPath() %>/admin/userList.do?page=<%= currentPage + 1 %>&searchId=<%= request.getParameter("searchId") != null ? request.getParameter("searchId") : "" %>">&raquo;</a></li>
            <%
                }
            %>
        </ul>
    </div>
</div>

</body>
</html>