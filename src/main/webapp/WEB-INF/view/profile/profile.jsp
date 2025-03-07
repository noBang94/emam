<%@ page import="kr.or.ddit.emam.vo.PostVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.ProfileVO" %>
<%@ page import="kr.or.ddit.emam.vo.PostPhotoDetailVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");

  MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");

  ProfileVO pv = (ProfileVO) request.getAttribute("pv");
  MemberVO mv = (MemberVO) request.getAttribute("mv");
  List<PostVO> postList = (List<PostVO>) request.getAttribute("postList");


%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SNS 프로필</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    }

    body {
      background-color: #f9fafb;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      background-color: white;
      min-height: 100vh;
      padding: 1.5rem;
    }

    header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 1rem 0;
      margin-bottom: 2rem;
      border-bottom: 1px solid #e5e7eb;
    }

    header h1 {
      font-size: 1.5rem;
      font-weight: 600;
    }

    .header-actions {
      display: flex;
      gap: 1rem;
    }

    .icon-button {
      background: none;
      border: none;
      cursor: pointer;
      padding: 0.5rem;
      border-radius: 0.375rem;
    }

    .icon-button:hover {
      background-color: #f3f4f6;
    }

    .profile-section {
      display: grid;
      grid-template-columns: 1fr;
      gap: 2rem;
      margin-bottom: 2.5rem;
      background: url("<%=request.getContextPath()%>/<%=pv.getProfile_headerphoto()%>");
    }

    @media (min-width: 768px) {
      .profile-section {
        grid-template-columns: 1fr 3fr;
      }
    }

    .profile-picture-container {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .profile-picture {
      width: 10rem;
      height: 10rem;
      border-radius: 9999px;
      background-color: #f3f4f6;
      border: 4px solid white;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      margin-bottom: 1rem;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .profile-picture img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .edit-profile-btn {
      width: 100%;
      padding: 0.5rem 1rem;
      background-color: #f3f4f6;
      border: 1px solid #d1d5db;
      border-radius: 0.375rem;
      font-weight: 500;
      cursor: pointer;
    }

    .edit-profile-btn:hover {
      background-color: #e5e7eb;
    }

    .profile-info {
      display: flex;
      flex-direction: column;
    }

    .profile-name {
      font-size: 1.5rem;
      font-weight: 700;
      margin-bottom: 0.25rem;
    }

    .profile-username {
      color: #6b7280;
      margin-bottom: 1rem;
    }

    .profile-stats {
      display: flex;
      gap: 2rem;
      margin-bottom: 1.5rem;
    }

    .stat-item {
      text-align: center;
    }

    .stat-value {
      font-size: 1.25rem;
      font-weight: 700;
    }

    .stat-label {
      font-size: 0.875rem;
      color: #6b7280;
    }

    .profile-bio h3, .profile-link h3 {
      font-weight: 600;
      margin-bottom: 0.5rem;
    }

    .profile-bio {
      margin-bottom: 1rem;
    }

    .profile-bio p {
      color: #374151;
      line-height: 1.5;
    }

    .profile-link a {
      color: #2563eb;
      text-decoration: none;
    }

    .profile-link a:hover {
      text-decoration: underline;
    }

    .section-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 1.5rem;
    }

    .section-title {
      font-size: 1.25rem;
      font-weight: 600;
    }

    .add-button {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      padding: 0.5rem 1rem;
      background-color: white;
      border: 1px solid #d1d5db;
      border-radius: 0.375rem;
      font-size: 0.875rem;
      font-weight: 500;
      cursor: pointer;
    }

    .add-button:hover {
      background-color: #f9fafb;
    }

    .posts-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 1rem;
      margin-bottom: 2.5rem;
    }

    @media (min-width: 768px) {
      .posts-grid {
        grid-template-columns: repeat(3, 1fr);
      }
    }

    @media (min-width: 1024px) {
      .posts-grid {
        grid-template-columns: repeat(4, 1fr);
      }
    }

    .post-card {
      border-radius: 0.5rem;
      overflow: hidden;
      border: 1px solid #e5e7eb;
      box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
    }

    .post-image {
      position: relative;
      aspect-ratio: 1 / 1;
      background-color: #f3f4f6;
    }

    .post-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .post-content {
      padding: 0.75rem;
    }

    .post-title {
      font-weight: 500;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .post-date {
      font-size: 0.875rem;
      color: #6b7280;
      margin-top: 0.25rem;
    }

    .friends-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 1rem;
    }

    @media (min-width: 768px) {
      .friends-grid {
        grid-template-columns: repeat(4, 1fr);
      }
    }

    @media (min-width: 1024px) {
      .friends-grid {
        grid-template-columns: repeat(6, 1fr);
      }
    }

    .friend-item {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .friend-avatar {
      width: 5rem;
      height: 5rem;
      border-radius: 9999px;
      background-color: #f3f4f6;
      overflow: hidden;
      margin-bottom: 0.5rem;
    }

    .friend-avatar img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .friend-name {
      font-size: 0.875rem;
      font-weight: 500;
      text-align: center;
    }

    .modal{display: none;width: 100%; height: 100%; position: fixed; top: 0; left: 0; background: rgba(0, 0, 0, 0.5); }
    .modal-i-warp{position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; width: 1000px; height: auto;}
    .modal.view{display: block}
  </style>

  <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
  <script>
    $(function () {
      //게시글 작성 버튼클릭시
      $(".post_write_btn").on('click', function () {
        $(".post-insert-modal").toggleClass("view");
        $('form').submit(function(e) {
          e.preventDefault();
        });
      });

      //게시글 수정 버튼클릭시
      $(".post_modi_btn").on('click', function () {
        $(".post-update-modal").toggleClass("view");
        $('form').submit(function(e) {
          e.preventDefault();
        });
      });

      //모달 닫기 클릭
      $(".close-btn").on('click', function () {
        $(".modal").removeClass("view");
      });

      $(".modal").on('click', function (e) {
        if (!$(e.target).closest('.modal-i-warp').length) {
          $(this).removeClass("view");
        }
      });

    })
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />
<div class="container">
  <!-- Header -->
  <header>
    <h1>배경사진</h1>
    <div class="header-actions">
      <button class="icon-button">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M12.22 2h-.44a2 2 0 0 0-2 2v.18a2 2 0 0 1-1 1.73l-.43.25a2 2 0 0 1-2 0l-.15-.08a2 2 0 0 0-2.73.73l-.22.38a2 2 0 0 0 .73 2.73l.15.1a2 2 0 0 1 1 1.72v.51a2 2 0 0 1-1 1.74l-.15.09a2 2 0 0 0-.73 2.73l.22.38a2 2 0 0 0 2.73.73l.15-.08a2 2 0 0 1 2 0l.43.25a2 2 0 0 1 1 1.73V20a2 2 0 0 0 2 2h.44a2 2 0 0 0 2-2v-.18a2 2 0 0 1 1-1.73l.43-.25a2 2 0 0 1 2 0l.15.08a2 2 0 0 0 2.73-.73l.22-.39a2 2 0 0 0-.73-2.73l-.15-.08a2 2 0 0 1-1-1.74v-.5a2 2 0 0 1 1-1.74l.15-.09a2 2 0 0 0 .73-2.73l-.22-.38a2 2 0 0 0-2.73-.73l-.15.08a2 2 0 0 1-2 0l-.43-.25a2 2 0 0 1-1-1.73V4a2 2 0 0 0-2-2z"></path>
          <circle cx="12" cy="12" r="3"></circle>
        </svg>
      </button>
      <button class="icon-button">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="1"></circle>
          <circle cx="19" cy="12" r="1"></circle>
          <circle cx="5" cy="12" r="1"></circle>
        </svg>
      </button>
    </div>
  </header>

  <!-- Profile Section -->
  <div class="profile-section">
    <!-- Profile Picture -->
    <div class="profile-picture-container">

      <div class="profile-picture">
        <img src="<%=request.getContextPath()%>/<%=pv.getProfile_photo()%>" alt="Profile">
      </div>
      <form action="/profile/editProfile.do" method="get">
        <button type="submit" class="edit-profile-btn">프로필 편집</button>
      </form>
    </div>

    <!-- Profile Info -->
    <div class="profile-info">
      <h2 class="profile-name"><%=mv.getMem_nickname()%></h2>
      <p class="profile-username"><%=mv.getMem_id()%></p>

      <div class="profile-stats">
        <div class="stat-item">
          <div class="stat-value"><%=pv.getProfile_postcnt()%></div>
          <div class="stat-label">게시글 수</div>
        </div>
        <div class="stat-item">
          <div class="stat-value"><%=pv.getProfile_friendcnt()%></div>
          <div class="stat-label">친구 수</div>
        </div>
      </div>

      <div class="profile-bio">
        <h3>자기소개</h3>
        <p>
          <%=pv.getProfile_intro()%>
        </p>
      </div>

      <div class="profile-link">
        <h3>링크</h3>
        <p>
          <%if(pv.getProfile_url()==null){%>
          <h1>링크가 없습니다</h1>
          <%}else {%>
            <a href="<%=pv.getProfile_url()%>" target="_blank"><%=pv.getProfile_url()%></a>

          <%}%>

        </p>

      </div>
    </div>
  </div>

  <!-- Posts Section -->
  <div class="posts-section">
    <div class="section-header">
      <h2 class="section-title">게시글</h2>

      <form action="/post/postList.do" method="get" class="post_write_btn">
        <button type="submit" class="add-button">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M5 12h14"></path>
            <path d="M12 5v14"></path>
          </svg>
          새 게시글
        </button>
      </form>

    </div>

    <div class="posts-grid">
      <%

        if (postList != null && !postList.isEmpty()) {
          for (PostVO post : postList) {
      %>
      <div class="post-card" data-index="<%=post.getPost_index()%>">
        <div class="post-image">
          <%if (post.getPostPhotoDetailList().getFirst() != null) {%>
            <img src="<%=request.getContextPath()%>/post/postview.do?postphoto=<%=post.getPostPhotoDetailList().getFirst().getPost_photo()%>&postphotosn=<%=post.getPostPhotoDetailList().getFirst().getPost_photo_sn()%>" alt=> <%-- ${post.postTitle} 대신 "Post 제목" 과 같이 임시 텍스트로 변경 --%>
          <%}%>

        </div>
        <div class="post-content">
          <h3 class="post-content">${post.post_con}</h3> <%--  수정:  임시 텍스트 -> 실제 게시글 내용 --%>
          <p class="post-date">${post.post_date}</p> <%--  수정:  임시 텍스트 -> 실제 게시글 날짜 --%>
          <div class="post-actions">  <%-- 게시글 액션 버튼 div 추가 시작 --%>
            <form action="<%=request.getContextPath()%>/post/updatePostForm.do" class="post_modi_btn" method="get" style="display:inline;"> <%-- 수정 폼 요청 --%>
              <input type="hidden" name="post_index" value="${post.post_index}">
              <button type="submit" class="edit-button">수정</button>
            </form>
            <form action="<%=request.getContextPath()%>/post/deletePost.do" method="post" style="display:inline;"> <%-- 삭제 요청 --%>
              <input type="hidden" name="post_index" value="${post.post_index}">
              <button type="submit" class="delete-button">삭제</button>
            </form>
          </div> <%-- 게시글 액션 버튼 div 추가 끝 --%>
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
      <h2 class="section-title">친구</h2>
      <%if(loginMember.getMem_id().equals(pv.getMem_id())){%>

      <p>
        <%=pv.getMem_nickname()%> 님의 친구 목록
      </p></h1>
      <%}else{%>
      <button class="add-button">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M5 12h14"></path>
          <path d="M12 5v14"></path>
        </svg>
        친구 추가
      </button>
      <% }%>
    </div>

    <div class="friends-grid">
      <%
        List<MemberVO> friendList = (List<MemberVO>) request.getAttribute("friendList"); // 친구 목록을 request 속성에서 가져온다고 가정 (실제 속성명에 맞게 수정 필요)
        if (friendList != null && !friendList.isEmpty()) {
         for (MemberVO friend : friendList) {
      %>
      <div class="friend-item">
        <div class="friend-avatar">
          <img src="placeholder.jpg" alt="Friend 닉네임"> <%-- ${friend.memNickname} 대신 "Friend 닉네임" 과 같이 임시 텍스트로 변경 --%>
        </div>
        <span class="friend-name">친구 닉네임</span> <%-- ${friend.memNickname} 대신 "친구 닉네임" 과 같이 임시 텍스트로 변경 --%>
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

<div class="post-insert-modal modal">
  <div class="modal-i-warp">
    <form action="/post/insertpost.do" method="post" enctype="multipart/form-data">
      <div class="modal-body">
        <div class="modal-l">
          <input type="file" class="post-ipt" multiple="multiple" name="postphoto">
        </div>
        <div class="modal-r">
          <div>
            프로필이 올자리 입니당
            <input type="text" name="postwriter" value="aaaaa" hidden="hidden">

            <div>
              <textarea name="postcon"></textarea>
            </div>

          </div>
          <div class="toggleSwitch-warp">
            <input type="checkbox" name="postvis" id="inserttoggles" value="Y">
            <label for="inserttoggles" class="toggleSwitch">
              <span class="toggleButton"></span>
            </label>
          </div>
        </div>
      </div>

      <div class="modal-footer">
        <div class="btn_2th">
          <a href="javascript:void(0);" class="btn close-btn">닫기</a>

          <input type="submit" class="btn" value="등록하기">

        </div>
      </div>
    </form>
  </div>
</div>
<div class="post-update-modal modal">
  <div class="modal-i-warp">
    <form action="<%=request.getContextPath() %>/post/updatepost.do" method="post" enctype="multipart/form-data">
      <div class="modal-body">
        <div class="modal-l">
          수정할때 사진 못넣습니다~
        </div>
        <div class="modal-r">
          <div>
            프로필이 올자리 입니당
            <input type="text" name="postindex" hidden="hidden"/>
            <input type="text" name="postwriter" value="<%=loginMember.getMem_id()%>" hidden="hidden"/>

            <div>
              <textarea name="postcon"></textarea>
            </div>

          </div>
          <div class="toggleSwitch-warp">
            <input type="checkbox" name="postvis" id="updatetoggles" value="Y" />
            <label for="updatetoggles" class="toggleSwitch">
              <span class="toggleButton"></span>
            </label>
          </div>
        </div>
      </div>

      <div class="modal-footer">
        <div class="btn_2th">
          <a href="javascript:void(0);" class="btn close-btn">닫기</a>
          <input type="submit" class="btn" value="수정하기">

        </div>
      </div>
    </form>
  </div>
</div>

</body>
</html>