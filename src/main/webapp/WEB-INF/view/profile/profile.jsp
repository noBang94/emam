<%@ page import="kr.or.ddit.emam.vo.PostVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  </style>
</head>
<body>
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
        <img src="placeholder.jpg" alt="Profile">
      </div>
      <button class="edit-profile-btn">프로필 편집</button>
    </div>

    <!-- Profile Info -->
    <div class="profile-info">
      <h2 class="profile-name">닉네임</h2>
      <p class="profile-username">@username</p>

      <div class="profile-stats">
        <div class="stat-item">
          <div class="stat-value">99</div>
          <div class="stat-label">게시글 수</div>
        </div>
        <div class="stat-item">
          <div class="stat-value">99</div>
          <div class="stat-label">친구 수</div>
        </div>
      </div>

      <div class="profile-bio">
        <h3>자기소개</h3>
        <p>
          자기소개 텍스트가 여기에 표시됩니다. 프로필 소개글 영역입니다.
          여러 줄의 텍스트를 입력할 수 있으며, 사용자에 대한 정보를 제공합니다.
        </p>
      </div>

      <div class="profile-link">
        <h3>링크</h3>
        <a href="https://example.com" target="_blank">https://example.com</a>
      </div>
    </div>
  </div>

  <!-- Posts Section -->
  <div class="posts-section">
    <div class="section-header">
      <h2 class="section-title">게시글</h2>
      <button class="add-button">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M5 12h14"></path>
          <path d="M12 5v14"></path>
        </svg>
        새 게시글
      </button>
    </div>

    <div class="posts-grid">
      <%
        List<PostVO> postList = (List<PostVO>) request.getAttribute("postList");
        if (postList != null && !postList.isEmpty()) {
          for (PostVO post : postList) {
      %>
      <div class="post-card">
        <div class="post-image">
          <img src="placeholder.jpg" alt="Post 제목"> <%-- ${post.postTitle} 대신 "Post 제목" 과 같이 임시 텍스트로 변경 --%>
        </div>
        <div class="post-content">
          <h3 class="post-title">게시글 제목</h3> <%-- ${post.postTitle} 대신 "게시글 제목" 과 같이 임시 텍스트로 변경 --%>
          <p class="post-date">날짜</p> <%-- ${post.postDate} 대신 "날짜" 와 같이 임시 텍스트로 변경 --%>
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
      <button class="add-button">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M5 12h14"></path>
          <path d="M12 5v14"></path>
        </svg>
        친구 추가
      </button>
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
</body>
</html>