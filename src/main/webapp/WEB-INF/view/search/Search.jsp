<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.FriendVO" %>

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

    <%
        //세션 로그인 값
        MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
        //컨트롤러에서 자료 받기
        List<FriendVO> friendCheckList =(List<FriendVO>)request.getAttribute("friendCheckList");
        List friendPhotoList = (List)request.getAttribute("friendPhotoList");
    %>


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
        $(function () {
            //친구 신청 버튼 클릭 시
            $(".friendBtn").on("click", ".friendRequestBtn", function () {
                //신청 데이터 전송하기
                $.ajax({
                    url: "<%=request.getContextPath() %>/friend/friendRequest.do",
                    type: "get",
                    data: "toFriend="+$(this).data("value"),
                });
                $(this).attr("class", "friendReadyBtn");
                $(this).attr("src", "../../.././images/friendready.png");
            });
            //친구 삭제 버튼 클릭 시
            $(".friendBtn").on("click", ".friendDeleteBtn", function () {
                $.ajax({
                    url: "<%=request.getContextPath() %>/friend/friendDelete.do",
                    type: "get",
                    data: "toFriend="+$(this).data("value"),
                });
                $(this).attr("class", "friendRequestBtn");
                $(this).attr("src", "../../.././images/friendflus.png");
            });
            //친구 신청중 버튼 클릭 시 (신청 취소)
            $(".friendBtn").on("click", ".friendReadyBtn", function () {
                $.ajax({
                    url: "<%=request.getContextPath() %>/friend/friendDelete.do",
                    type: "get",
                    data: "toFriend="+$(this).data("value"),
                });
                $(this).attr("class", "friendRequestBtn");
                $(this).attr("src", "../../.././images/friendflus.png");
            });

        });
    </script>
</head>
<body>

<div class="user-list-container">
    <table class="table">
        <thead>
        <tr>
            <th colspan="2">아이디</th>
            <th>이름</th>
            <th>닉네임</th>
            <th>프로필 보기</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <%
            List<MemberVO> memberList = (List<MemberVO>) request.getAttribute("memberList");
            if (memberList != null && !memberList.isEmpty()) {
                int i = 0;
                for (MemberVO member : memberList) {
        %>
        <tr>
            <%
                if(member.getMem_id().equals(loginMember.getMem_id())){
                    return;
                }
            %>

            <td><img src="<%=request.getContextPath()%>/<%=friendPhotoList.get(i)%>" alt="프로필사진"></td>
            <td><%= member.getMem_id() %></td>
            <td><%= member.getMem_name() %></td>
            <td><%= member.getMem_nickname() %></td>
            <td>
                <a href="<%=request.getContextPath() %>/profile/profile.do?memId=<%= member.getMem_id() %>" class="btn btn-info btn-sm">프로필</a>
            </td>
            <td class="friendBtn">
                <%
                    if(friendCheckList.get(i).getFriend_status().equals("null")) {
                %>
                <img src="../../.././images/friendflus.png" width="25px" height="25px" class="friendRequestBtn" data-value="<%=member.getMem_id() %>">
                <%
                    }else if(friendCheckList.get(i).getFriend_status().equals("0")) {
                %>
                <img src="../../.././images/friendready.png" width="25px" height="25px" class="friendReadyBtn" data-value="<%=member.getMem_id() %>">
                <%
                    }else {
                %>
                <img src="../../.././images/frienddelete.png" width="25px" height="25px" class="friendDeleteBtn" data-value="<%=member.getMem_id() %>">
                <%
                    }
                %>
            </td>
        </tr>
                <%
                    i++;
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