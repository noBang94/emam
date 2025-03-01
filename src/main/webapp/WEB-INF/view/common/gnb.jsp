<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    .toggleSwitch .toggleButton {width: 16px;height: 16px;position: absolute;top: 50%;left: 4px;transform: translateY(-50%);border-radius: 50%;background: #f03d3d;}
    [id*="toggles"]:checked ~ .toggleSwitch {background: #f03d3d;}
    [id*="toggles"]:checked ~ .toggleSwitch .toggleButton {left: calc(100% - 18px);background: #fff;}
    #updatetoggles:checked ~ .toggleSwitch {background: #f03d3d;}
    #updatetoggles:checked ~ .toggleSwitch .toggleButton {left: calc(100% - 18px);background: #fff;}
    .toggleSwitch, .toggleButton {transition: all 0.2s ease-in;}

    /*토글 스위치(e)*/

    /* GNB 스타일 */
    .gnb {
        width: 100%;
        height: auto;
        position: fixed;
        top: 0;
        left: 0;
    }
    .gnb-inner{
        background-color: #282828; /* 유튜브 GNB 배경색 */
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
    }
    .gnb .search-warp{display: flex;gap: 10px;}
    .gnb input{color: black;}

    .gnb-logo img {
        height: 40px; /* 로고 높이 */
        margin-right: 20px;
    }

    .gnb-menu ul {
        list-style: none;
        display: flex;
    }

    .gnb-menu li {
        margin-right: 20px;
    }

    .gnb-menu a {
        color: white;
        text-decoration: none;
    }

    .gnb-right {
        display: flex;
        align-items: center;
    }

    .gnb-button {
        background-color: #383838; /* 버튼 배경색 */
        color: white;
        border: none;
        padding: 8px 15px;
        margin-left: 10px;
        border-radius: 3px;
        cursor: pointer;
    }
    .gnb-dropdown-menu{
        position: fixed;
        right: 0;
        top: 62px;
        color:black;
    }
    .dropdown-menu{
        display: none;
        position: absolute;
        right: 0;
        left: initial;
        width: 180px;
    }
    .dropdown-menu li{padding: 10px 10px;}
    .dropdown-menu.view{
        display: block;
    }
    .noti-set{display: flex;
        align-items: center;}
</style>
<script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
<script>
    $(function(){
        $(".gnb-button").on("click", function(){
            $(".dropdown-menu").toggleClass("view")
        });

        $("html").on('click', function(e){
            if(!$(e.target).closest('.dropdown-menu').length) {
                $(this).removeClass("view");
            }
        });

        $(document).click(function(event) {
            if($(".dropdown-menu.view").length>0){
                if (!$(event.target).closest(".dropdown-menu").length) {
                    $(".dropdown-menu.view").removeClass("view");
                }
            }
        });
    });

</script>
<div class="gnb">
    <div class="gnb-inner">
        <a href="<%=request.getContextPath() %>" alt="home">
            <div class="gnb-left">
                <div class="gnb-logo">
                    <img src="<%=request.getContextPath() %>/images/demo_logo.png" alt="으밀아밀 이에요잉">
                </div>
            </div>
        </a>
        <div class="gnb-search">
            <form action="/search.do">
                <div class="search-warp">
                    <input type="text" placeholder="대충 만든 검색창이에요잉"/>
                    <input type="submit" class="btn" value="검색">
                </div>
            </form>
        </div>
        <div class="gnb-right">
            <button class="gnb-button">친구</button>
            <button class="gnb-button">알림</button>
            <button class="gnb-button">내 메뉴</button>
        </div>

        <div class="gnb-dropdown-menu">
            <ul class="dropdown-menu">
                <li><a href="<%=request.getContextPath() %>/profile/profile.do">내 프로필</a></li>
                <li><a href="<%=request.getContextPath() %>/member/memberset.do">개인정보 수정</a></li>
                <li><a href="<%=request.getContextPath() %>/logout/logout.do">로그아웃</a></li>
                <li><a href="<%=request.getContextPath() %>/inquiry/inquiry.do">문의 사항</a></li>
                <li><a href="<%=request.getContextPath() %>/notice/notice.do">공지사항</a></li>
                <li>
                    <form>
                        <div>설정</div>
                        <div class="noti-set">
                            <span>친구 알람</span>
                            <input type="checkbox" name="friendnoti" id="friendtoggles" value="Y" />
                            <label for="friendtoggles" class="toggleSwitch">
                                <span class="toggleButton"></span>
                            </label>
                        </div>
                        <div class="noti-set">
                            <span>댓글 알람</span>
                            <input type="checkbox" name="replynoti" id="replytoggles" value="Y" />
                            <label for="replytoggles" class="toggleSwitch">
                                <span class="toggleButton"></span>
                            </label>
                        </div>
                        <div class="noti-set">
                            <span>좋아요 알람</span>
                            <input type="checkbox" name="ilikenoti" id="iliketoggles" value="Y" />
                            <label for="iliketoggles" class="toggleSwitch">
                                <span class="toggleButton"></span>
                            </label>
                        </div>
                        <div class="noti-set">
                            <span>채팅 허용</span>
                            <input type="checkbox" name="chatnoti" id="chattoggles" value="Y" />
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
