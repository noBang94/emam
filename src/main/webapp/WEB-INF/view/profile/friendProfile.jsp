<%@ page import="kr.or.ddit.emam.vo.PostVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.ProfileVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");

    // 친구 프로필 정보 (ProfileVO) 와 회원 정보 (MemberVO) 를 request 속성에서 가져옴
    ProfileVO friendPv = (ProfileVO) request.getAttribute("friendPv"); // profile.jsp 와 다른 속성 이름 사용!
    MemberVO friendMv = (MemberVO) request.getAttribute("friendMv"); // profile.jsp 와 다른 속성 이름 사용!

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=friendMv.getMem_nickname()%> 님의 프로필</title> <%-- 친구 닉네임으로 title 설정 --%>
    <style>
        /* style 태그는 profile.jsp 의 스타일을 그대로 복사해서 사용하거나, 필요한 스타일만 추가 */
        /* ... profile.jsp 의 style 내용 복사 ... */
    </style>
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script>
        $(function () {

        });//제이쿼리 끝
    </script>
</head>

<body>
<div class="container">
    <header>
        <h1>친구 프로필</h1> <%-- header 제목 변경 --%>
        <div class="header-actions">
            <%-- header actions (아이콘 버튼 등) 필요하다면 profile.jsp 에서 복사 --%>
        </div>
    </header>

    <div class="profile-section">
        <div class="profile-picture-container">
            <div class="profile-picture">
                <img src="<%=request.getContextPath()%>/<%=friendPv.getProfile_photo()%>" alt="Profile"> <%-- friendPv 사용 --%>
            </div>
            <%-- <form action="/profile/editProfile.do" method="get"> --%>  <%-- "프로필 편집" 버튼 제거! --%>
            <%--   <button type="submit" class="edit-profile-btn">프로필 편집</button> --%>
            <%-- </form> --%>
        </div>

        <div class="profile-info">
            <h2 class="profile-name"><%=friendMv.getMem_nickname()%></h2> <%-- friendMv 사용 --%>
            <p class="profile-username"><%=friendMv.getMem_id()%></p> <%-- friendMv 사용 --%>

            <div class="profile-stats">
                <div class="stat-item">
                    <div class="stat-value"><%=friendPv.getProfile_postcnt()%></div> <%-- friendPv 사용 --%>
                    <div class="stat-label">게시글 수</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value"><%=friendPv.getProfile_friendcnt()%></div> <%-- friendPv 사용 --%>
                    <div class="stat-label">친구 수</div>
                </div>
            </div>

            <div class="profile-bio">
                <h3>자기소개</h3>
                <p>
                    <%=friendPv.getProfile_intro()%> <%-- friendPv 사용 --%>
                </p>
            </div>

            <div class="profile-link">
                <h3>링크</h3>
                <p>
                        <%if(friendPv.getProfile_url()==null){%> <%-- friendPv 사용 --%>
                <h1>링크가 없습니다</h1>
                <%}else {%>
                <a href="<%=friendPv.getProfile_url()%>" target="_blank"><%=friendPv.getProfile_url()%></a> <%-- friendPv 사용 --%>
                <%}%>
                </p>
            </div>
        </div>
    </div>

    <div class="posts-section">
        <div class="section-header">
            <h2 class="section-title">게시글</h2>
            <%-- "새 게시글" 추가 버튼 제거 (친구 프로필에는 게시글 작성 버튼 불필요) --%>
        </div>

        <div class="posts-grid">
            <%
                List<PostVO> friendPostList = (List<PostVO>) request.getAttribute("friendPostList"); // profile.jsp 와 다른 속성 이름 사용!
                if (friendPostList != null && !friendPostList.isEmpty()) {
                    for (PostVO post : friendPostList) {
            %>
            <div class="post-card" data-index="<%=post.getPost_index()%>">
                <div class="post-image">
                    <img src="<%=request.getContextPath()%>/<%=friendPv.getProfile_headerphoto()%>" alt=<%-- ${post.postTitle} 대신 "Post 제목" 과 같이 임시 텍스트로 변경 --%>
                            </div>
                    <div class="post-content">
                        <h3 class="post-title">${post.post_con}</h3> <%-- 게시글 제목/내용 출력: ${post.post_con} 사용 --%>
                        <p class="post-date">${post.post_date}</p> <%-- 게시글 날짜 출력: ${post.post_date} 사용 --%>
                        <%-- 친구 프로필에서는 수정/삭제 버튼 불필요하므로 제거 --%>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <p>게시글이 없습니다.</p> <%-- 게시글 없을 때 메시지 표시 --%>
                <%
                    }
                %>
            </div>
        </div>

        <div class="friends-section">
            <div class="section-header">
                <h2 class="section-title">친구의 친구</h2> <%-- section 제목 변경 --%>
                <p>
                    <%=friendMv.getMem_nickname()%> 님의 친구 목록 <%-- 문구 변경: "나의 친구 목록" -> "OOO님의 친구 목록" --%>
                </p>
                <%-- "친구 추가" 버튼 제거 (친구 프로필에서는 친구 추가 버튼 불필요하거나, 다른 위치에 배치할 수 있음) --%>
            </div>

            <div class="friends-grid">
                <%
                    List<MemberVO> friendFriendList = (List<MemberVO>) request.getAttribute("friendFriendList"); // profile.jsp 와 다른 속성 이름 사용! (친구의 친구 목록)
                    if (friendFriendList != null && !friendFriendList.isEmpty()) {
                        for (MemberVO friend : friendFriendList) {
                %>
                <div class="friend-item">
                    <div class="friend-avatar">
                        <img src="placeholder.jpg" alt="Friend 닉네임">
                    </div>
                    <span class="friend-name">친구 닉네임</span>
                </div>
                <%
                    }
                } else {
                %>
                <p>친구가 없습니다.</p> <%-- 친구 목록 없을 때 메시지 표시 --%>
                <%
                    }
                %>
            </div>
        </div>
    </div>

</body>
</html>