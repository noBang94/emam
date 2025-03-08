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
  ProfileVO mv = (ProfileVO) request.getAttribute("mv");
  List<PostVO> postList = (List<PostVO>) request.getAttribute("postList");
  boolean isMyProfile = (Boolean) request.getAttribute("isMyProfile");
  List<MemberVO> friendList = (List<MemberVO>) request.getAttribute("friendList");
  boolean isFriend = (Boolean) request.getAttribute("isFriend"); // ⭐ 친구 여부 정보 추가됨 ⭐
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SNS 프로필</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    }

    body {
      background-color: #f9fafb;
      color: #333;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      background-color: white;
      min-height: 100vh;
      padding: 1.5rem;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
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
      font-size: 1.75rem;
      font-weight: 700;
      color: #1f2937;
      letter-spacing: -0.5px;
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
      transition: all 0.2s ease;
    }

    .icon-button:hover {
      background-color: #f3f4f6;
      transform: scale(1.05);
    }

    /* 프로필 섹션 개선 */
    .profile-header {
      position: relative;
      height: 400px;
      border-radius: 12px;
      overflow: hidden;
      margin-bottom: 80px;
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .profile-header-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(to bottom, rgba(0,0,0,0.1), rgba(0,0,0,0.4));
    }

    .profile-section {
      display: grid;
      grid-template-columns: 1fr;
      gap: 2rem;
      margin-bottom: 2.5rem;
      position: relative;
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
      margin-top: -60px;
      position: relative;
      z-index: 10;
    }

    .profile-picture {
      width: 160px;
      height: 160px;
      border-radius: 50%;
      background-color: #f3f4f6;
      border: 5px solid white;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      overflow: hidden;
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: transform 0.3s ease;
    }

    .profile-picture:hover {
      transform: scale(1.03);
    }

    .profile-picture img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    /* 프로필 편집 버튼 개선 */
    .edit-profile-btn {
      width: 100%;
      padding: 0.75rem 1.25rem;
      background-color: #4f46e5;
      color: white;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      font-size: 0.95rem;
      cursor: pointer;
      transition: all 0.2s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
      box-shadow: 0 2px 5px rgba(79, 70, 229, 0.3);
    }

    .edit-profile-btn:hover {
      background-color: #4338ca;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(79, 70, 229, 0.4);
    }

    .edit-profile-btn:active {
      transform: translateY(0);
    }

    .profile-info {
      display: flex;
      flex-direction: column;
      padding: 1.5rem;
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    .profile-name {
      font-size: 1.75rem;
      font-weight: 700;
      margin-bottom: 0.25rem;
      color: #1f2937;
    }

    .profile-username {
      color: #6b7280;
      margin-bottom: 1.5rem;
      font-size: 1.1rem;
    }

    .profile-stats {
      display: flex;
      gap: 2.5rem;
      margin-bottom: 1.5rem;
      padding: 1rem 0;
      border-top: 1px solid #f3f4f6;
      border-bottom: 1px solid #f3f4f6;
    }

    .stat-item {
      text-align: center;
      transition: transform 0.2s ease;
    }

    .stat-item:hover {
      transform: translateY(-3px);
    }

    .stat-value {
      font-size: 1.5rem;
      font-weight: 700;
      color: #4f46e5;
    }

    .stat-label {
      font-size: 0.9rem;
      color: #6b7280;
      margin-top: 0.25rem;
    }

    .profile-bio h3, .profile-link h3 {
      font-weight: 600;
      margin-bottom: 0.75rem;
      color: #374151;
      font-size: 1.1rem;
    }

    .profile-bio {
      margin-bottom: 1.5rem;
      padding-bottom: 1.5rem;
      border-bottom: 1px solid #f3f4f6;
    }

    .profile-bio p {
      color: #4b5563;
      line-height: 1.6;
      font-size: 1rem;
    }

    .profile-link a {
      color: #4f46e5;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.2s ease;
    }

    .profile-link a:hover {
      color: #4338ca;
      text-decoration: underline;
    }

    .section-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 1.5rem;
      padding-bottom: 0.75rem;
      border-bottom: 2px solid #f3f4f6;
    }

    .section-title {
      font-size: 1.4rem;
      font-weight: 700;
      color: #1f2937;
      position: relative;
    }

    .section-title::after {
      content: '';
      position: absolute;
      bottom: -0.75rem;
      left: 0;
      width: 40px;
      height: 3px;
      background-color: #4f46e5;
      border-radius: 3px;
    }

    /* 버튼 스타일 개선 */
    .add-button {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      padding: 0.6rem 1.2rem;
      background-color: #4f46e5;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 0.95rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s ease;
      box-shadow: 0 2px 5px rgba(79, 70, 229, 0.3);
    }

    .add-button:hover {
      background-color: #4338ca;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(79, 70, 229, 0.4);
    }

    .add-button:active {
      transform: translateY(0);
    }

    .add-button svg {
      transition: transform 0.3s ease;
    }

    .add-button:hover svg {
      transform: rotate(90deg);
    }

    .posts-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 1.5rem;
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
      border-radius: 12px;
      overflow: hidden;
      border: 1px solid #e5e7eb;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
      transition: all 0.3s ease;
      background-color: white;
    }

    .post-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
    }

    .post-image {
      position: relative;
      aspect-ratio: 1 / 1;
      background-color: #f3f4f6;
      overflow: hidden;
    }

    .post-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.5s ease;
    }

    .post-card:hover .post-image img {
      transform: scale(1.05);
    }

    .post-content {
      padding: 1rem;
    }

    .post-title {
      font-weight: 600;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      color: #1f2937;
      margin-bottom: 0.5rem;
    }

    .post-date {
      font-size: 0.875rem;
      color: #6b7280;
      margin-top: 0.25rem;
    }

    /* 게시글 수정/삭제 버튼 개선 */
    .post-actions {
      display: flex;
      justify-content: flex-end;
      gap: 0.75rem;
      margin-top: 0.75rem;
      padding-top: 0.75rem;
      border-top: 1px solid #f3f4f6;
    }

    .edit-button, .delete-button {
      padding: 0.4rem 0.8rem;
      border-radius: 6px;
      font-size: 0.85rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s ease;
      border: none;
    }

    .edit-button {
      background-color: #3b82f6;
      color: white;
    }

    .edit-button:hover {
      background-color: #2563eb;
    }

    .delete-button {
      background-color: #ef4444;
      color: white;
    }

    .delete-button:hover {
      background-color: #dc2626;
    }

    .friends-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 1.5rem;
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
      padding: 1rem;
      border-radius: 12px;
      transition: all 0.3s ease;
      background-color: white;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
    }

    .friend-item:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
    }

    .friend-avatar {
      width: 5.5rem;
      height: 5.5rem;
      border-radius: 50%;
      background-color: #f3f4f6;
      overflow: hidden;
      margin-bottom: 0.75rem;
      border: 3px solid white;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .friend-avatar img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s ease;
    }

    .friend-item:hover .friend-avatar img {
      transform: scale(1.08);
    }

    .friend-name {
      font-size: 0.95rem;
      font-weight: 600;
      text-align: center;
      color: #1f2937;
    }

    .modal {
      display: none;
      width: 100%;
      height: 100%;
      position: fixed;
      top: 0;
      left: 0;
      background: rgba(0, 0, 0, 0.6);
      backdrop-filter: blur(4px);
      z-index: 1000;
      animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    .modal-i-warp {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background: #fff;
      width: 90%;
      max-width: 1000px;
      height: auto;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
      overflow: hidden;
    }

    .modal.view {
      display: block;
    }

    /* 친구 프로필 버튼 개선 */
    .friend-profile-buttons {
      display: flex;
      justify-content: center;
      gap: 1rem;
      margin-top: 1.5rem;
      margin-bottom: 2rem;
    }

    .friend-profile-buttons button {
      padding: 0.75rem 1.5rem;
      font-size: 1rem;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 600;
      transition: all 0.2s ease;
      border: none;
      display: flex;
      align-items: center;
      gap: 0.5rem;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .friend-profile-buttons button:hover {
      transform: translateY(-3px);
      box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
    }

    .friend-profile-buttons button:active {
      transform: translateY(-1px);
    }

    .friend-profile-buttons .btn-primary {
      background-color: #4f46e5;
      color: white;
    }

    .friend-profile-buttons .btn-primary:hover {
      background-color: #4338ca;
    }

    .friend-profile-buttons .btn-secondary {
      background-color: #4b5563;
      color: white;
    }

    .friend-profile-buttons .btn-secondary:hover {
      background-color: #374151;
    }

    .friend-profile-buttons .btn-danger {
      background-color: #ef4444;
      color: white;
    }

    .friend-profile-buttons .btn-danger:hover {
      background-color: #dc2626;
    }

    /* 모달 내용 스타일 개선 */
    .modal-body {
      display: flex;
      padding: 1.5rem;
    }

    .modal-l {
      flex: 1;
      padding-right: 1.5rem;
    }

    .modal-r {
      flex: 1;
      border-left: 1px solid #e5e7eb;
      padding-left: 1.5rem;
    }

    .modal-footer {
      padding: 1rem 1.5rem;
      background-color: #f9fafb;
      border-top: 1px solid #e5e7eb;
      display: flex;
      justify-content: flex-end;
    }

    .btn_2th {
      display: flex;
      gap: 1rem;
    }

    .btn {
      padding: 0.6rem 1.2rem;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s ease;
      text-decoration: none;
      display: inline-block;
      text-align: center;
    }

    .close-btn {
      background-color: #e5e7eb;
      color: #4b5563;
      border: none;
    }

    .close-btn:hover {
      background-color: #d1d5db;
    }

    input[type="submit"].btn {
      background-color: #4f46e5;
      color: white;
      border: none;
    }

    input[type="submit"].btn:hover {
      background-color: #4338ca;
    }

    textarea {
      width: 100%;
      min-height: 150px;
      padding: 0.75rem;
      border: 1px solid #d1d5db;
      border-radius: 8px;
      resize: vertical;
      margin-bottom: 1rem;
      font-family: inherit;
    }

    textarea:focus {
      outline: none;
      border-color: #4f46e5;
      box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.2);
    }

    .post-ipt {
      margin-bottom: 1rem;
    }

    /* 토글 스위치 스타일 */
    .toggleSwitch-warp {
      display: flex;
      align-items: center;
      margin-top: 1rem;
    }

    .toggleSwitch {
      position: relative;
      display: inline-block;
      width: 60px;
      height: 30px;
      background-color: #e5e7eb;
      border-radius: 30px;
      cursor: pointer;
    }

    .toggleButton {
      position: absolute;
      top: 4px;
      left: 4px;
      width: 22px;
      height: 22px;
      border-radius: 50%;
      background-color: white;
      transition: all 0.3s ease;
    }

    input[type="checkbox"]:checked + .toggleSwitch {
      background-color: #4f46e5;
    }

    input[type="checkbox"]:checked + .toggleSwitch .toggleButton {
      left: calc(100% - 26px);
    }

    input[type="checkbox"] {
      display: none;
    }

    /* 빈 상태 메시지 스타일 */
    .empty-state {
      text-align: center;
      padding: 3rem 2rem;
      color: #6b7280;
      background-color: #f9fafb;
      border-radius: 12px;
      border: 1px dashed #d1d5db;
    }

    /* 애니메이션 효과 */
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    @keyframes slideUp {
      from { transform: translateY(20px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    .profile-section, .posts-section, .friends-section {
      animation: fadeIn 0.5s ease-out;
    }

    .post-card, .friend-item {
      animation: slideUp 0.5s ease-out;
    }
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

  <!-- 배경 이미지 개선 -->
  <div class="profile-header" style="background-image: url('<%=request.getContextPath()%>/<%=pv.getProfile_headerphoto()%>')">
    <div class="profile-header-overlay"></div>
  </div>

  <div class="profile-section">
    <div class="profile-picture-container">
      <div class="profile-picture">
        <img src="<%=request.getContextPath()%>/<%=pv.getProfile_photo()%>" alt="프로필 사진">
      </div>
      <% if (isMyProfile) { %>
      <form action="/profile/editProfile.do" method="get">
        <button type="submit" class="edit-profile-btn">
          <i class="fas fa-edit"></i> 프로필 편집
        </button>
      </form>
      <% } %>
    </div>

    <div class="profile-info">
      <h2 class="profile-name"><%=mv.getMem_nickname()%></h2>
      <p class="profile-username">@<%=mv.getMem_id()%></p>

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
        <h3><i class="fas fa-user-circle"></i> 자기소개</h3>
        <p>
          <%=pv.getProfile_intro()%>
        </p>
      </div>

      <div class="profile-link">
        <h3><i class="fas fa-link"></i> 링크</h3>
        <p>
          <%if(pv.getProfile_url()==null){%>
          <span>링크가 없습니다</span>
          <%}else {%>
          <a href="<%=pv.getProfile_url()%>" target="_blank"><%=pv.getProfile_url()%></a>
          <%}%>
        </p>
      </div>

      <% if (!isMyProfile) { %> <%-- [⭐ 조건부 렌더링: 친구 프로필일 때만 표시 ⭐] --%>
      <div class="friend-profile-buttons">
        <%-- 🚩 [조건부 렌더링]: 친구 여부에 따라 다른 버튼 표시 --%>
        <% if (isFriend) { %> <%-- [⭐ isFriend 값이 true (친구) 이면 "친구 삭제" 버튼 표시 --%>
        <button class="btn btn-secondary" type="button">
          <i class="fas fa-user-minus"></i> 친구 삭제
        </button>
        <% } else { %> <%-- [⭐ isFriend 값이 false (친구 아님) 이면 "친구 신청" 버튼 표시 --%>
        <button class="btn btn-primary" type="button">
          <i class="fas fa-user-plus"></i> 친구 신청
        </button>
        <% } %> <%-- [⭐ 조건부 렌더링 종료 --%>
        <button type="button" class="btn btn-danger">
          <i class="fas fa-flag"></i> 계정 신고
        </button>
      </div>
      <% } %> <%-- [⭐ 조건부 렌더링 종료: 친구 프로필일 때만 표시 ⭐] --%>

    </div>
  </div>

  <div class="posts-section">
    <div class="section-header">
      <h2 class="section-title">게시글</h2>
      <% if (isMyProfile) { %>
      <form action="/post/postList.do" method="get" class="post_write_btn">
        <button type="submit" class="add-button">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M5 12h14"></path>
            <path d="M12 5v14"></path>
          </svg>
          새 게시글
        </button>
      </form>
      <% } %>
    </div>

    <div class="posts-grid">
      <%
        if (postList != null && !postList.isEmpty()) {
          for (PostVO post : postList) {
      %>
      <div class="post-card" data-index="<%=post.getPost_index()%>">
        <div class="post-image">
          <%if (post.getPostPhotoDetailList().getFirst() != null) {%>
          <img src="<%=request.getContextPath()%>/post/postview.do?postphoto=<%=post.getPostPhotoDetailList().getFirst().getPost_photo()%>&postphotosn=<%=post.getPostPhotoDetailList().getFirst().getPost_photo_sn()%>" alt=>
          <%}%>
        </div>
        <div class="post-content">
          <h3 class="post-title">${post.post_con}</h3>
          <p class="post-date"><i class="far fa-calendar-alt"></i> ${post.post_date}</p>
          <% if (isMyProfile) { %>
          <div class="post-actions">
            <form action="<%=request.getContextPath()%>/post/updatePostForm.do" class="post_modi_btn" method="get" style="display:inline;">
              <input type="hidden" name="post_index" value="${post.getPost_index()}">
              <button type="submit" class="edit-button"><i class="fas fa-edit"></i> 수정</button>
            </form>
            <form action="<%=request.getContextPath()%>/post/deletePost.do" method="post" style="display:inline;">
              <input type="hidden" name="post_index" value="${post.getPost_index()}">
              <button type="submit" class="delete-button"><i class="fas fa-trash-alt"></i> 삭제</button>
            </form>
          </div>
          <% } %>
        </div>
      </div>
      <%
        }
      } else {
      %>
      <div class="empty-state">
        <p><i class="fas fa-inbox fa-2x mb-3"></i></p>
        <p>게시글이 없습니다.</p>
      </div>
      <%
        }
      %>
    </div>
  </div>

  <div class="friends-section">
    <div class="section-header">
      <h2 class="section-title">친구</h2>
      <p>
        <%=mv.getMem_nickname()%> 님의 친구 목록
      </p>

    </div>

    <div class="friends-grid">
      <%
        if (friendList != null && !friendList.isEmpty()) {
          for (MemberVO friend : friendList) {
      %>
      <a href="<%=request.getContextPath()%>/profile/profile.do?memId=<%=friend.getMem_id()%>" style="text-decoration: none; color: inherit;">
        <div class="friend-item">
          <div class="friend-avatar">
            <img src="<%=request.getContextPath()%>/<%=friend.getProfile_photo() != null ? friend.getProfile_photo() : "images/default_profile.png"%>" alt="친구 프로필 사진">
          </div>
          <span class="friend-name"><%=friend.getMem_nickname()%></span>
        </div>
      </a>
      <%
        }
      } else {
      %>
      <div class="empty-state">
        <p><i class="fas fa-users fa-2x mb-3"></i></p>
        <p>친구가 없습니다.</p>
      </div>
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
          <h3><i class="fas fa-image"></i> 이미지 업로드</h3>
          <input type="file" class="post-ipt" multiple="multiple" name="postphoto">
        </div>
        <div class="modal-r">
          <div>
            <h3><i class="fas fa-edit"></i> 게시글 작성</h3>
            <input type="text" name="postwriter" value="aaaaa" hidden="hidden">

            <div>
              <textarea name="postcon" placeholder="내용을 입력하세요..."></textarea>
            </div>

          </div>
          <div class="toggleSwitch-warp">
            <span>공개 여부: </span>
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
          <h3><i class="fas fa-info-circle"></i> 안내</h3>
          <p>수정할때 사진 못넣습니다~</p>
        </div>
        <div class="modal-r">
          <div>
            <h3><i class="fas fa-edit"></i> 게시글 수정</h3>
            <input type="text" name="postindex" hidden="hidden"/>
            <input type="text" name="postwriter" value="<%=loginMember.getMem_id()%>" hidden="hidden"/>

            <div>
              <textarea name="postcon" placeholder="수정할 내용을 입력하세요..."></textarea>
            </div>

          </div>
          <div class="toggleSwitch-warp">
            <span>공개 여부: </span>
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

