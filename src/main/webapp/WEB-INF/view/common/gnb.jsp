<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.usersettings.service.IUsersettingsService" %>
<%@ page import="kr.or.ddit.emam.usersettings.service.UsersettingsServiceImpl" %>
<%@ page import="kr.or.ddit.emam.vo.UsersettingsVO" %>
<%@ page import="kr.or.ddit.emam.vo.ProfileVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    /* 기본 스타일 초기화 */
    html, body, div, span, applet, object, iframe,
    h1, h2, h3, h4, h5, h6, p, blockquote, pre,
    a, abbr, acronym, address, big, cite, code,
    del, dfn, em, img, ins, kbd, q, s, samp,
    small, strike, strong, sub, sup, tt, var,
    b, u, i, center,
    dl, dt, dd, ol, ul, li,
    fieldset, form, label, legend,
    table, caption, tbody, tfoot, thead, tr, th, td,
    article, aside, canvas, details, embed,
    figure, figcaption, footer, header, hgroup,
    menu, nav, output, ruby, section, summary,
    time, mark, audio, video {
        margin: 0;
        padding: 0;
        border: 0;
        font-size: 100%;
        font: inherit;
        vertical-align: baseline;
    }

    /* HTML5 display-role reset for older browsers */
    article, aside, details, figcaption, figure,
    footer, header, hgroup, menu, nav, section {
        display: block;
    }

    body {
        margin-top: 60px;
        line-height: 1;
        font-family: 'Noto Sans KR', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    }

    ol, ul {
        list-style: none;
    }

    blockquote, q {
        quotes: none;
    }

    blockquote:before, blockquote:after,
    q:before, q:after {
        content: '';
        content: none;
    }

    table {
        border-collapse: collapse;
        border-spacing: 0;
    }

    /* 토글 스위치 */
    .toggleSwitch {
        width: 36px;
        height: 18px;
        display: block;
        position: relative;
        border-radius: 18px;
        background-color: #e0e0e0;
        cursor: pointer;
        margin: 8px;
        transition: all 0.2s ease;
    }

    .gnb .toggleSwitch .toggleButton {
        width: 14px;
        height: 14px;
        position: absolute;
        top: 2px;
        left: 2px;
        border-radius: 50%;
        background: white;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        transition: all 0.2s ease;
    }

    [id*="toggles"]:checked ~ .toggleSwitch {
        background: #2196F3;
    }

    [id*="toggles"]:checked ~ .toggleSwitch .toggleButton {
        left: calc(100% - 16px);
    }

    #updatetoggles:checked ~ .toggleSwitch {
        background: #2196F3;
    }

    #updatetoggles:checked ~ .toggleSwitch .toggleButton {
        left: calc(100% - 16px);
    }

    /* GNB 스타일 */
    .gnb {
        z-index: 9999;
        width: 100%;
        height: auto;
        position: fixed;
        top: 0;
        left: 0;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .gnb-inner {
        background-color: #212121;
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 20px;
        position: relative;
    }

    .gnb-left {
        display: flex;
        align-items: center;
        flex: 1;
    }

    .gnb-search {
        margin-left: 20px;
        flex: 1.2;
        max-width: 450px; /* 검색창 최대 너비 증가 */
    }

    .gnb .search-warp {
        display: flex;
        width: 80%;
        position: relative;
    }

    .gnb .search-warp input[type="text"] {
        flex: 1;
        height: 36px;
        padding: 0 15px;
        border-radius: 4px;
        border: none;
        font-size: 14px;
        color: #333;
        background-color: rgba(255, 255, 255, 0.9);
        transition: all 0.2s ease;
        width: 100%; /* 검색창 너비 100%로 설정 */
    }

    .gnb .search-warp input[type="text"]:focus {
        background-color: white;
        outline: none;
    }

    .gnb-logo img {
        height: 36px;
        transition: opacity 0.2s ease;
    }

    .gnb-logo img:hover {
        opacity: 0.9;
    }

    .gnb-right {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        flex: 1;
    }

    .gnb-button, .gnb-search .btn {
        background-color: transparent;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.2s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        font-weight: 400;
        margin-left: 8px;
    }

    .gnb-search .btn {
        background-color: #2196F3;
        position: absolute;
        right: 0;
        top: 0;
        height: 36px;
        width: 40px; /* 검색 버튼 너비 축소 */
        border-radius: 0 4px 4px 0;
        padding: 0; /* 패딩 제거 */
    }

    .gnb-button:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }

    .gnb-search .btn:hover {
        background-color: #1976D2;
    }

    .gnb-button i {
        margin-right: 6px;
        font-size: 14px;
    }

    .friend-dropdown-menu, .noti-dropdown-menu, .my-dropdown-menu {
        position: absolute;
        right: 16px;
        top: 56px;
        background-color: white;
        border-radius: 4px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 8px 0;
        width: 240px;
        display: none;
        z-index: 1000;
        color: #333;
        animation: fadeIn 0.15s ease-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-8px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .friend-dropdown-menu::before,
    .noti-dropdown-menu::before,
    .my-dropdown-menu::before {
        content: '';
        position: absolute;
        top: -6px;
        right: 16px;
        width: 12px;
        height: 12px;
        background-color: white;
        transform: rotate(45deg);
        box-shadow: -1px -1px 3px rgba(0, 0, 0, 0.05);
    }

    .friend-dropdown-menu ul, .noti-dropdown-menu ul, .my-dropdown-menu ul {
        padding: 0;
        margin: 0;
    }

    .friend-dropdown-menu li, .noti-dropdown-menu li, .my-dropdown-menu li {
        padding: 8px 16px;
        color: #333;
        transition: background-color 0.2s;
        font-size: 14px;
    }

    .friend-dropdown-menu li:hover, .noti-dropdown-menu li:hover, .my-dropdown-menu li:hover {
        background-color: #f5f5f5;
    }

    .my-dropdown-menu a {
        color: #333;
        text-decoration: none;
        display: block;
        transition: color 0.2s;
    }

    .my-dropdown-menu a:hover {
        color: #2196F3;
    }

    .noti-set {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin: 6px 0;
    }

    .noti-set span {
        flex-grow: 1;
        font-size: 14px;
    }

    .profile-img {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background-color: #2196F3;
        margin-left: 12px;
        cursor: pointer;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 16px;
        font-weight: 500;
        transition: background-color 0.2s ease;
    }

    .profile-img:hover {
        background-color: #1976D2;
    }

    /* 설정 섹션 스타일 */
    .settings-header {
        font-weight: 500;
        font-size: 14px;
        margin: 8px 16px;
        padding-bottom: 8px;
        border-bottom: 1px solid #eee;
        color: #757575;
    }

    /* 구분선 */
    .dropdown-divider {
        height: 1px;
        background-color: #eee;
        margin: 4px 0;
    }
    .gnbprofilephoto{
        width: 40px;
        height: 40px;
    }

    /* 검색 버튼 아이콘 추가 */
    .search-icon {
        font-size: 14px;
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .gnb-inner {
            flex-wrap: wrap;
            padding: 8px 12px;
        }

        .gnb-left {
            flex: 0 0 100%;
            justify-content: space-between;
            margin-bottom: 8px;
        }

        .gnb-search {
            flex: 0 0 100%;
            margin-left: 0;
            margin-bottom: 8px;
            order: 3;
            max-width: none;
        }

        .gnb-right {
            flex: 0 0 100%;
            justify-content: space-between;
        }

        .friend-dropdown-menu, .noti-dropdown-menu, .my-dropdown-menu {
            width: calc(100% - 24px);
            right: 12px;
            left: 12px;
        }

        .friend-dropdown-menu::before,
        .noti-dropdown-menu::before,
        .my-dropdown-menu::before {
            right: 16px;
        }
    }
</style>
<script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<%
    MemberVO loginMemberVo = (MemberVO) session.getAttribute("loginMember");
    IUsersettingsService usersettingsService = UsersettingsServiceImpl.getInstance();
    UsersettingsVO usersettingsVo = usersettingsService.checkUsersettings(loginMemberVo.getMem_id());
%>

<script>
    $(function(){
        // 프로필 이미지에 사용자 이니셜 표시
        const userName = "<%= loginMemberVo.getMem_name() %>";
        const initial = userName.charAt(0);

        let getprofileimg = "<%= loginMemberVo.getPfVo().getProfile_photo() %>";

        if(getprofileimg != "upload/demo_logo.png" && getprofileimg != null ) {
            let htmlcode = '<img class="gnbprofilephoto" src="<%=request.getContextPath()%>/'+getprofileimg+'">';
            $(".profile-img").append(htmlcode)
        }else {
            $(".profile-img").html("").text(initial);
        }



        $(".gnb-button").on("click", function () {
            $(".friend-dropdown-menu, .noti-dropdown-menu, .my-dropdown-menu").hide();
            if ($(this).hasClass("friend-btn")) {
                loadFriendList();
                $(".friend-dropdown-menu").show();
            } else if ($(this).hasClass("noti-btn")) {
                $(".noti-dropdown-menu").show();
            } else if ($(this).hasClass("my-btn")) {
                $(".my-dropdown-menu").show();
            }
        });

        $(document).on("click", function (event) {
            if (!$(event.target).closest(".gnb-button, .friend-dropdown-menu, .noti-dropdown-menu, .my-dropdown-menu").length) {
                $(".friend-dropdown-menu, .noti-dropdown-menu, .my-dropdown-menu").hide();
            }
        });

        //토글버튼을 DB값대로 on/off 표기하기
        <% if(usersettingsVo.getSet_friend()==1) { %>
        $("#friendtoggles").attr("checked", true);
        <% } %>
        <% if(usersettingsVo.getSet_reply()==1) { %>
        $("#replytoggles").attr("checked", true);
        <% } %>
        <% if(usersettingsVo.getSet_ilike()==1) { %>
        $("#iliketoggles").attr("checked", true);
        <% } %>
        <% if(usersettingsVo.getSet_chat()==1) { %>
        $("#chattoggles").attr("checked", true);
        <% } %>
        //토글버튼 변경 시 데이터 전송하기
        $(".toggles").on("click", function () {
            let togglesFormData = $("#toggliesForm").serialize();
            $.ajax({
                url: "<%=request.getContextPath() %>/usersettings/usersettings.do",
                type: "get",
                data: togglesFormData
            });
        });

        // 프로필 이미지 클릭 시 프로필 페이지로 이동
        $(".profile-img").on("click", function () {
            window.location.href = "<%=request.getContextPath() %>/profile/profile.do";
        });

        function loadFriendList() {
            $.ajax({
                url: "<%=request.getContextPath() %>/friend/friendGnbList.do",
                type: "get",
                dataType: "html",
                success: function (html) {
                    $(".friend-dropdown-menu").html(html);
                    // AJAX 성공 후 이벤트 바인딩
                    $(".chat-button").on("click", function () {
                        window.location.href = "<%=request.getContextPath() %>/chat";
                    });
                },
                error: function () {
                    alert("친구 목록을 불러오는 데 실패했습니다.");
                }
            });
        }
    });
</script>
<div class="gnb">
    <div class="gnb-inner">
        <div class="gnb-left">
            <a href="<%=request.getContextPath() %>/welcome/welcomeMain.do" alt="home">
                <div class="gnb-logo">
                    <img src="<%=request.getContextPath() %>/images/emam.png" alt="으밀아밀">
                </div>
            </a>
            <div class="gnb-search">
                <form action="/search.do">
                    <div class="search-warp">
                        <input type="text" name="id" placeholder="검색할 계정을 입력하세요"/>
                        <button type="submit" class="btn">
                            <i class="fas fa-search search-icon"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div class="gnb-right">
            <button class="gnb-button friend-btn">
                <i class="fas fa-user-friends"></i> 친구
            </button>
            <%--            <button class="gnb-button noti-btn">알림</button>--%>
            <button class="gnb-button my-btn">
                <i class="fas fa-cog"></i> 내 메뉴
            </button>
            <div class="profile-img">
                <!-- 이니셜이 JavaScript로 삽입됩니다 -->

            </div>
        </div>

        <div class="friend-dropdown-menu">
            <!-- 친구 목록이 AJAX로 로드됩니다 -->
        </div>

        <div class="noti-dropdown-menu">
            <ul>
                <li><i class="fas fa-thumbtack fa-fw text-muted"></i> 공지사항: 블라블라...</li>
                <li><i class="fas fa-bell fa-fw text-muted"></i> 누구님이 친구를 신청하였습니다.</li>
                <div class="dropdown-divider"></div>
                <li class="text-center">(수락/거절)</li>
                <div class="dropdown-divider"></div>
                <li><i class="fas fa-comment fa-fw text-muted"></i> 누구님이 댓글을 남겼습니다.</li>
                <li><i class="fas fa-heart fa-fw text-muted"></i> 누구님이 게시글에 좋아요를 눌렀습니다.</li>
            </ul>
        </div>

        <div class="my-dropdown-menu">
            <ul>
                <li><a href="<%=request.getContextPath() %>/profile/profile.do"><i class="fas fa-user fa-fw text-muted"></i> 내 프로필</a></li>
                <li><a href="<%=request.getContextPath() %>/member/memberset.do"><i class="fas fa-user-edit fa-fw text-muted"></i> 개인정보 수정</a></li>
                <div class="dropdown-divider"></div>
                <li><a href="<%=request.getContextPath() %>/inquiry/inquiryList.do"><i class="fas fa-question-circle fa-fw text-muted"></i> 문의사항</a></li>
                <li><a href="<%=request.getContextPath() %>/notice/notice.do"><i class="fas fa-bullhorn fa-fw text-muted"></i> 공지사항</a></li>
                <div class="dropdown-divider"></div>
                <li>
                    <form id="toggliesForm" method="get">
                        <div class="settings-header">설정</div>
                        <div class="noti-set">
                            <span>친구 알람</span>
                            <input type="checkbox" name="friendnoti" id="friendtoggles" value="1" class="toggles" hidden="hidden"/>
                            <label for="friendtoggles" class="toggleSwitch">
                                <span class="toggleButton"></span>
                            </label>
                        </div>
                        <div class="noti-set">
                            <span>댓글 알람</span>
                            <input type="checkbox" name="replynoti" id="replytoggles" value="1" class="toggles" hidden="hidden"/>
                            <label for="replytoggles" class="toggleSwitch">
                                <span class="toggleButton"></span>
                            </label>
                        </div>
                        <div class="noti-set">
                            <span>좋아요 알람</span>
                            <input type="checkbox" name="ilikenoti" id="iliketoggles" value="1" class="toggles" hidden="hidden"/>
                            <label for="iliketoggles" class="toggleSwitch">
                                <span class="toggleButton"></span>
                            </label>
                        </div>
<%--                        <div class="noti-set">--%>
<%--                            <span>채팅 허용</span>--%>
<%--                            <input type="checkbox" name="chatnoti" id="chattoggles" value="1" class="toggles" hidden="hidden"/>--%>
<%--                            <label for="chattoggles" class="toggleSwitch">--%>
<%--                                <span class="toggleButton"></span>--%>
<%--                            </label>--%>
<%--                        </div>--%>
                    </form>
                </li>
                <div class="dropdown-divider"></div>
                <li><a href="<%=request.getContextPath() %>/member/logoutMember.do"><i class="fas fa-sign-out-alt fa-fw text-muted"></i> 로그아웃</a></li>
            </ul>
        </div>
    </div>
</div>

