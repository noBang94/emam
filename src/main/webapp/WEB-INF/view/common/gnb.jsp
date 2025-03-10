<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.usersettings.service.IUsersettingsService" %>
<%@ page import="kr.or.ddit.emam.usersettings.service.UsersettingsServiceImpl" %>
<%@ page import="kr.or.ddit.emam.vo.UsersettingsVO" %>
<%@ page import="kr.or.ddit.emam.vo.ProfileVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
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

    /*토글 스위치(s)*/
    .toggleSwitch {width: 50px;height: 20px;display: block;position: relative;border-radius: 30px;background-color: #fff;box-shadow: 0 0 16px 3px rgba(0 0 0 / 15%);cursor: pointer;margin: 10px;}
    .toggleSwitch .toggleButton {width: 16px;height: 16px;position: absolute;top: 50%;left: 4px;transform: translateY(-50%);border-radius: 50%;background: #64B5F6;}
    [id*="toggles"]:checked ~ .toggleSwitch {background: #64B5F6;}
    [id*="toggles"]:checked ~ .toggleSwitch .toggleButton {left: calc(100% - 18px);background: #fff;}
    #updatetoggles:checked ~ .toggleSwitch {background: #64B5F6;}
    #updatetoggles:checked ~ .toggleSwitch .toggleButton {left: calc(100% - 18px);background: #fff;}
    .toggleSwitch, .toggleButton {transition: all 0.2s ease-in;}

    /*토글 스위치(e)*/

    /* GNB 스타일 */
    .gnb {
        z-index: 9999;
        width: 100%;
        height: auto;
        position: fixed;
        top: 0;
        left: 0;
    }
    .gnb-inner{
        background-color: #282828;
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
        margin-left: 15px;
        flex: 1.2;
        max-width: 300px;
    }

    .gnb .search-warp {
        display: flex;
        gap: 5px;
        width: 100%;
    }

    .gnb .search-warp input[type="text"] {
        flex: 1;
        height: 34px;
        padding: 5px 10px;
        border-radius: 4px;
        border: none;
        font-size: 13px;
        color: black;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .gnb-logo img {
        height: 38px;
    }

    .gnb-menu ul {
        list-style: none;
        display: flex;
    }

    .gnb-menu li {
        margin-right: 15px;
    }

    .gnb-menu a {
        color: white;
        text-decoration: none;
    }

    .gnb-right {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        flex: 1;
    }

    .gnb-button, .gnb-search .btn {
        background-color: #64B5F6;
        color: white;
        border: none;
        padding: 9px 15px;
        border-radius: 3px;
        cursor: pointer;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
        transition: background-color 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 0.9rem;
        margin-left: 10px;
        height: 38px;
    }

    .gnb-button:hover, .gnb-search .btn:hover { /* 호버 시 스타일 */
        background-color: #90CAF9;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
    }

    .dropdown-menu li{padding: 10px 10px;}
    .noti-set{display: flex;
        align-items: center;
    }
    .friend-dropdown-menu, .noti-dropdown-menu, .my-dropdown-menu {
        position: absolute;
        right: 0;
        top: 50px;
        background-color: #fff;
        border: 1px solid #ccc;
        padding: 10px;
        width: 200px;
        display: none;
        z-index: 1000;
        color: #000000;
    }
    .friend-dropdown-menu ul, .noti-dropdown-menu ul, .my-dropdown-menu ul {
        padding: 0;
        margin: 0;
    }
    .friend-dropdown-menu li, .noti-dropdown-menu li, .my-dropdown-menu li {
        padding: 8px 10px;
        border-bottom: 1px solid #eee;
        color: #000000;
    }
    .friend-dropdown-menu li:last-child, .noti-dropdown-menu li:last-child, .my-dropdown-menu li:last-child {
        border-bottom: none;
    }
    .noti-set {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 5px;
    }
    .noti-set span {
        flex-grow: 1;
    }
    .profile-img {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background-color: #ddd; /* 프로필 이미지 배경색 */
        margin-left: 15px;
        cursor: pointer;
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .gnb-inner {
            flex-wrap: wrap;
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
            justify-content: center;
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
        $(".gnb-button").on("click", function(){
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

        $(document).on("click", function(event) {
            if (!$(event.target).closest(".gnb-button, .friend-dropdown-menu, .noti-dropdown-menu, .my-dropdown-menu").length) {
                $(".friend-dropdown-menu, .noti-dropdown-menu, .my-dropdown-menu").hide();
            }
        });

        //토글버튼을 DB값대로 on/off 표기하기
        <% if(usersettingsVo.getSet_friend()==1) { %> $("#friendtoggles").attr("checked", true); <% } %>
        <% if(usersettingsVo.getSet_reply()==1) { %> $("#replytoggles").attr("checked", true); <% } %>
        <% if(usersettingsVo.getSet_ilike()==1) { %> $("#iliketoggles").attr("checked", true); <% } %>
        <% if(usersettingsVo.getSet_chat()==1) { %> $("#chattoggles").attr("checked", true); <% } %>
        //토글버튼 변경 시 데이터 전송하기
        $(".toggles").on("click", function(){
            let togglesFormData = $("#toggliesForm").serialize();
            $.ajax({
                url: "<%=request.getContextPath() %>/usersettings/usersettings.do",
                type: "get",
                data: togglesFormData
            });
        });

        // 알림 버튼 클릭 시 알림 목록 불러오기
        <%--$(".noti-btn").on("click", function(){--%>
        <%--    $.ajax({--%>
        <%--        url: "<%=request.getContextPath() %>/notification/notificationList.do",--%>
        <%--        type: "get",--%>
        <%--        dataType: "json",--%>
        <%--        success: function(data) {--%>
        <%--            // 알림 목록을 HTML로 변환하여 noti-dropdown-menu에 추가--%>
        <%--            var notiHtml = "";--%>
        <%--            $.each(data, function(index, noti) {--%>
        <%--                notiHtml += "<li>" + noti.notification_con + "</li>";--%>
        <%--            });--%>
        <%--            $(".noti-dropdown-menu ul").html(notiHtml);--%>
        <%--        },--%>
        <%--        error: function(xhr) {--%>
        <%--            alert("알림 목록을 불러오는 데 실패했습니다.");--%>
        <%--        }--%>
        <%--    });--%>
        <%--});--%>

        // 프로필 이미지 클릭 시 프로필 페이지로 이동
        $(".profile-img").on("click", function() {
            window.location.href = "<%=request.getContextPath() %>/profile/profile.do";
        });

        function loadFriendList() {
            $.ajax({
                url: "<%=request.getContextPath() %>/friend/friendGnbList.do",
                type: "get",
                dataType: "html", // 응답 데이터 타입을 HTML로 설정
                success: function(html) {
                    $(".friend-dropdown-menu").html(html);
                },
                error: function() {
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
                        <input type="text" name="id" placeholder="검색어를 입력하세요"/>
                        <input type="submit" class="btn" value="검색">
                    </div>
                </form>
            </div>
        </div>

        <div class="gnb-right">
            <button class="gnb-button friend-btn">친구</button>
<%--            <button class="gnb-button noti-btn">알림</button>--%>
            <button class="gnb-button my-btn">내 메뉴</button>
            <div class="profile-img">
            </div>
        </div>

        <div class="friend-dropdown-menu">
        </div>

        <div class="noti-dropdown-menu">
            <ul>
                <li>*(핀) 공지사항: 블라블라...</li>
                <li>*(알림) 누구님이 친구를 신청하였습니다.</li>
                <li>(수락/거절)</li>
                <li>누구님이 댓글을 남겼습니다.</li>
                <li>누구님이 게시글에 좋아요를 눌렀습니다.</li>
            </ul>
        </div>

        <div class="my-dropdown-menu">
            <ul>
                <li><a href="<%=request.getContextPath() %>/profile/profile.do">내 프로필</a></li>
                <li><a href="<%=request.getContextPath() %>/member/memberset.do">개인정보 수정</a></li>
                <li><a href="<%=request.getContextPath() %>/member/logoutMember.do">로그아웃</a></li>
                <li><a href="<%=request.getContextPath() %>/inquiry/inquiryList.do">문의사항</a></li>
                <li><a href="<%=request.getContextPath() %>/notice/notice.do">공지사항</a></li>
                <li>
                    <form id="toggliesForm" method="get">
                        <div>설정</div>
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
                        <div class="noti-set">
                            <span>채팅 허용</span>
                            <input type="checkbox" name="chatnoti" id="chattoggles" value="1" class="toggles" hidden="hidden"/>
                            <label for="chattoggles" class="toggleSwitch">
                                <span class="toggleButton"></span>
                            </label>
                        </div>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</div>