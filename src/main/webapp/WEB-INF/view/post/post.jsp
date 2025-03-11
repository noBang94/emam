<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
    List<PostVO> postList = (List<PostVO>) request.getAttribute("postList");
    // String msg = (String) session.getAttribute("msg") == null ? "" : (String) session.getAttribute("msg");
    // session.removeAttribute("msg");
%>

<html>
<head>
    <title>게시판</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/swiper-11.2.5.css" />
    <style>
        /* 모달 스타일 */
        .modal {display: none;position: fixed;top: 0;left: 0;width: 100%;height: 100%;background: rgba(0,0,0,0.5);z-index: 1000}
        .modal.view {display: block;}
        .modal-body {display: flex;width: 100%;min-height: 300px; max-height: 400px;}
        .modal-l { position: relative;width: 100%;background-color: #f5f5f5;border-radius: 8px;display: flex;flex-wrap: wrap;align-items: center;justify-content: center;overflow: hidden}
        .modal-l.view{width: 50%;transition: all 0.3s ease;margin-right: 15px;}
        .modal-l img {margin: 5px;border-radius: 4px;z-index: 2;}
        .modal-r {width: 0;overflow: hidden;}
        .modal-r.view{width: 50%;transition: all 0.3s ease;}

        .modal.view {display: flex;align-items: center;justify-content: center;}
        .modal-i-warp {background: white;border-radius: 15px;padding: 25px;width: 90%;max-width: 600px;max-height: 70vh;overflow-y: auto}
        .modal-i-warp {position: absolute;top: 50%;left: 50%;transform: translate(-50%, -50%);background: #fff;width: 90%;max-width: 1000px;border-radius: 10px;padding: 20px;box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);}
        .modal-i-warp from {}
        .post-insert-modal .modal-l::before {content: "이미지를 업로드하려면 클릭하세요";position: absolute;top: 50%;left: 50%;transform: translate(-50%, -50%);color: #888;z-index: 1;}
        .post-update-modal .modal-l{width: 50%; margin-right: 15px;}
        .post-update-modal .modal-r{width: 50%;}

        /* 모달 스타일 */
        /* 기본 스타일 리셋 */
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }

        body {
            position: relative;
            margin-top: 70px;
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
        }

        .pointer {
            cursor: pointer;
        }



        /* 버튼 스타일 */
        .btn-cover {
            cursor: pointer;
        }

        .btn {
            cursor: pointer;
            background-color: #E20707;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            font-weight: 500;
            font-size: 16px;
            width: calc(50% - 5px);
            height: 50px;
            border: 1px solid #D9D9D9;
            transition: all 0.2s ease-in;
        }

        .btn:hover {
            background-color: #ffffff;
            color: #E20707;
            border: 1px solid #4dabf7;
            font-weight: bold;
        }

        a.btn {
            text-decoration: none;
            display: flex;
        }

        .btn_2th {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn.s-btn {
            width: 40px;
            height: 30px;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 14px;
        }

        /* 토글 스위치 */
        .toggleSwitch {
            width: 50px;
            height: 20px;
            display: block;
            position: relative;
            border-radius: 30px;
            background-color: #fff;
            box-shadow: 0 0 16px 3px rgba(0, 0, 0, 0.15);
            cursor: pointer;
            margin: 10px;
        }

        .toggleSwitch .toggleButton {
            width: 14px;
            height: 14px;
            position: absolute;
            top: 50%;
            left: 4px;
            transform: translateY(-50%);
            border-radius: 50%;
            background: #64B5F6;
        }
        .gnb .toggleSwitch .toggleButton {
            width: 14px;
            height: 14px;
            position: absolute;
            top: 9px !important;
            left: 2px;
            border-radius: 50%;
            background: white;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            transition: all 0.2s ease;
        }

        #inserttoggles:checked ~ .toggleSwitch,
        #updatetoggles:checked ~ .toggleSwitch {
            background: #64B5F6;
        }

        #inserttoggles:checked ~ .toggleSwitch .toggleButton,
        #updatetoggles:checked ~ .toggleSwitch .toggleButton {
            left: calc(100% - 16px);
            background: #fff;
        }

        .toggleSwitch, .toggleButton {
            transition: all 0.2s ease-in;
        }

        /* 파일 업로드 */
        .post-ipt {
            width: 100%;
            display: block;
            height: 100%;
            opacity: 0;
            overflow: hidden;
            position: absolute;
            top: 0;
            left: 0;
            z-index: 2;
            cursor: pointer;
        }
        .post-ipt-label{
            cursor: pointer;
            z-index: 2;
            width: 100%;
            height: 100%;
        }

        /* 게시글 작성 버튼 */
        .post_write_btn {
            position: fixed;
            bottom: 80px;
            right: 20px;
            width: auto;
            padding: 0 20px;
            border-radius: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        /* 게시글 스타일 */
        .post-atcwrap {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }

        .post-atc {
            position: relative;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            background: white;
            width: 100%;
            margin: 0 auto 20px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .a-hd {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 15px;
            border-bottom: 1px solid #f0f0f0;
        }

        .a-h-prf-pho a {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #333;
        }

        .a-h-prf-pho a img {
            border-radius: 50%;
            width: 32px;
            height: 32px;
            margin-right: 10px;
        }

        .t-stemp {
            color: #888;
            font-size: 12px;
        }

        .a-bd {
            position: relative;
            max-height: 500px;
            overflow: hidden;
        }

        .a-bd .a-bd-img {
            text-align: center;
            background: #f9f9f9;
        }

        .a-bd .a-bd-btns {
            z-index: 1;
            background-color: rgba(255, 255, 255, 0.9);
            text-align: center;
            display: flex;
            justify-content: flex-start;
            gap: 20px;
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 10px 15px;
            border-top: 1px solid #f0f0f0;
        }

        .a-con {
            padding: 15px;
        }

        .a-c-h {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            margin-bottom: 10px;
        }

        .a-c-h > div {
            margin: 0 5px 10px 0;
            padding: 6px 8px;
            border-radius: 4px;
            font-size: 12px;
            line-height: 1;
            border: 1px solid #e0e0e0;
            color: #666;
            cursor: pointer;
            background: #f8f8f8;
        }

        .a-c-h > div:hover {
            background-color: #ebebeb;
            color: #333;
        }

        .a-c-bd {
            width: auto;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            margin-bottom: 15px;
            line-height: 1.5;
            position: relative;
            transition: all 0.3s ease;
        }

        .a-c-bd.view {
            display: block;
            transition: all 0.3s ease;
        }
        .read-more {
            position: absolute;
            bottom: 0;
            right: 0;
            background-color: transparent;
            border: none;
            color: blue;
            cursor: pointer;
            display: none;
        }

        .a-c-rp {
            overflow: hidden;
            height: 0;
            transition: all 0.3s ease;
        }

        .a-c-rp.view {
            height: auto;
            border-top: 1px solid #f0f0f0;
            padding-top: 15px;
            transition: all 0.3s ease;
        }

        .a-c-rp form {
            display: flex;
            margin-bottom: 15px;
        }

        .a-c-rp form input[type="text"] {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 20px;
            margin-right: 10px;
        }

        .a-c-rp form input[type="submit"] {
            background: #4dabf7;
            color: white;
            border: none;
            border-radius: 20px;
            padding: 8px 15px;
            cursor: pointer;
        }

        .a-c-rp-r ul {
            list-style: none;
        }

        .a-c-rp-r ul li {
            padding: 10px 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .rp-r-wrap {
            display: flex;
            position: relative;
        }

        .rp-r-wrap .rp-r-w-prf {
            border-radius: 50%;
            width: 32px;
            height: 32px;
            min-width: 32px;
            margin-right: 10px;
            overflow: hidden;
        }

        .rp-r-wrap .rp-r-w-prf > img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .rp-r-wrap .rp-r-w-container {
            flex: 1;
        }

        .rp-r-wrap .rp-r-w-con-warp {
            margin-bottom: 10px;
        }

        .rp-r-wrap .rp-r-w-nick {
            font-weight: bold;
            margin-right: 8px;
        }

        .rp-r-wrap .rp-r-w-con {
            color: #333;
        }

        .rp-r-w-btn-warp {
            display: flex;
            gap: 12px;
        }

        .unvis {
            display: none !important;
        }

        .post-photo-img {
            max-width: 100%;
            max-height: 500px;
            object-fit: contain;
        }

        /* 폼 스타일 */
        textarea {
            width: 100%;
            min-height: 260px;
            max-height: 300px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            resize: none;
            margin: 10px 0;
        }


        /* 반응형 스타일 */
        @media (max-width: 768px) {
            .modal-i-warp {
                width: 95%;
            }

            .post-atc {
                width: 100%;
            }
        }
        /* 기본 스타일 리셋 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #e6f3ff 0%, #ffffff 100%);
            min-height: 100vh;
            padding-top: 60px;
        }

        /* 헤더 스타일 */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 60px;
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            padding: 0 20px;
            z-index: 1000;
        }

        .header-search {
            flex: 1;
            max-width: 400px;
            margin: 0 20px;
        }

        .header-search input {
            width: 100%;
            padding: 8px 15px;
            border: 1px solid #e1e1e1;
            border-radius: 20px;
            outline: none;
        }

        .header-buttons {
            display: flex;
            gap: 10px;
        }

        .header-btn {
            padding: 8px 15px;
            border: none;
            border-radius: 20px;
            background: #4dabf7;
            color: white;
            cursor: pointer;
            transition: background 0.2s;
        }

        .header-btn:hover {
            background: #339af0;
        }

        /* 카드 스타일 */
        .card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin: 20px auto;
            max-width: 800px;
            overflow: hidden;
        }

        /* 게시글 스타일 */
        .post-atc {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin: 20px auto;
            max-width: 800px;
            overflow: hidden;
        }

        .a-hd {
            padding: 15px 20px;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .a-h-prf-pho a {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #333;
            gap: 10px;
        }

        .a-h-prf-pho img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .a-bd {
            position: relative;
        }

        .a-bd-img {
            background: #f8f9fa;
            text-align: center;
        }

        .post-photo-img {
            max-width: 100%;
            max-height: 500px;
            object-fit: contain;
        }

        .a-con {
            padding: 20px;
        }

        /* 버튼 스타일 */
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 20px;
            background: #4dabf7;
            color: white;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn:hover {
            background: #4dabf7;
        }

        .post_write_btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: #4dabf7;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
            cursor: pointer;
            transition: transform 0.2s;
            z-index: 7;
        }

        .post_write_btn:hover {
            transform: scale(1.1);
        }



        /* 댓글 스타일 */
        .a-c-rp {
            border-top: 1px solid #f0f0f0;
            margin: 15px;
        }

        .a-c-rp form {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }

        .a-c-rp input[type="text"] {
            flex: 1;
            padding: 8px 15px;
            border: 1px solid #e1e1e1;
            border-radius: 20px;
            outline: none;
        }

        /* 반응형 스타일 */
        @media (max-width: 768px) {
            .header-search {
                display: none;
            }

            .post-atc {
                margin: 15px;
            }

            .modal-i-warp {
                width: 95%;
                margin: 10px;
            }
        }

        /* 스와이퍼 스타일 */
        .swiper {width: 100%;height: 50%;}
        .post-update-modal .swiper {width: 100%;height: 100%;}
        .post-insert-modal .swiper {width: 100%;height: 100%;}
        .swiper-slide {
            text-align: center;
            font-size: 18px;
            background: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .swiper-slide img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        /* 스와이퍼 커스텀 스타일 */
        .swiper-button-next,
        .swiper-button-prev {
            color: #4dabf7;
        }

        .swiper-pagination-bullet-active {
            background: #4dabf7;
        }
        .flex-align-center{display: flex; align-items: center;}
        .flex-align-center > a{width: 40px;
            height: 30px;
            padding: 0;
            display: flex;}

        .toggleSwitch-warp{display: flex;
            align-items: center;
            align-content: center;
            justify-content: flex-start;
            justify-content: flex-end;
        }

        .swiper-pagination{
            bottom: 50px !important;
        }
        .modal .swiper-pagination{
            bottom: 0px;
        }
        .swiper-pagination-bullet{transition: all 0.3s ease;}
        .swiper-pagination-bullet-active{
            width: 30px;
            border-radius: 30px;
            transition: all 0.3s ease;

        }
        /*좋아요*/
        .heart {
            width: 24px;
            height: 24px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .ilikebtn:hover .heart path{
            stroke: #ff3366;
            transition: all 0.2s ease;
        }
        .heart path {
            fill: transparent;
            stroke: #262626;  /* Black outline */
            stroke-width: 2px;
            transition: all 0.2s ease;
        }
        .heart.filled path {
            fill: #ff3366;
            stroke: #ff3366;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />

<!-- 게시글 목록 컨테이너 -->
<div class="post-atcwrap"></div>

<!-- 글 작성 버튼 -->
<div class="post_write_btn">
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <line x1="12" y1="5" x2="12" y2="19"></line>
        <line x1="5" y1="12" x2="19" y2="12"></line>
    </svg>
</div>

<!-- 게시글 수정 모달 -->
<div class="post-update-modal modal">
    <div class="modal-i-warp">
        <form action="<%=request.getContextPath() %>/post/updatepost.do" method="post" enctype="multipart/form-data">
            <div class="modal-body">
                <div class="modal-l"></div>
                <div class="modal-r">
                    <div>
                        <input type="text" name="postindex" hidden="hidden"/>
                        <input type="text" name="postwriter" value="<%=loginMember.getMem_id()%>" hidden="hidden"/>
                        <div>
                            <textarea name="postcon" placeholder="내용을 입력하세요"></textarea>
                        </div>
                    </div>
                    <div class="toggleSwitch-warp">
                        <input type="checkbox" name="postvis" id="updatetoggles" value="Y" />
                        <label for="updatetoggles" class="toggleSwitch">
                            <span class="toggleButton"></span>
                        </label>
                        <span>공개 여부</span>
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

<!-- 게시글 작성 모달 -->
<div class="post-insert-modal modal">
    <div class="modal-i-warp">
        <form action="<%=request.getContextPath() %>/post/insertpost.do" method="post" enctype="multipart/form-data">
            <div class="modal-body">
                <div class="modal-l">
                    <label for="post-input" class="post-ipt-label">
                        <div class="swiper post-photo-swiper">
                            <div class="swiper-wrapper">
                            </div>
                            <div class="swiper-pagination"></div>
                            <div class="swiper-button-prev"></div>
                            <div class="swiper-button-next"></div>
                        </div>
                        <input type="file" id="post-input" class="post-ipt" multiple="multiple" name="postphoto" hidden="hidden" style="display: none;"/>
                    </label>
                </div>
                <div class="modal-r">
                    <div>
                        <input type="text" name="postwriter" value="<%=loginMember.getMem_id()%>" hidden="hidden">
                        <div>
                            <textarea name="postcon" placeholder="내용을 입력하세요"></textarea>
                        </div>
                    </div>
                    <div class="toggleSwitch-warp">
                        <input type="checkbox" name="postvis" id="inserttoggles" value="Y" hidden="hidden"/>

                        <span>공개 여부</span>
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

<!-- 게시글 삭제 모달 -->
<div class="post-delete-modal modal">
    <div class="modal-i-warp">
        <form action="<%=request.getContextPath() %>/post/deletepost.do">
            <div style="text-align: center; padding: 20px;">
                <input type="text" name="postindex" hidden/>
                <h3>정말로 게시물을 삭제하시겠습니까?</h3>
                <p style="color: #E20707; margin-top: 10px;">* 삭제 후 되돌릴 수 없습니다.</p>
            </div>
            <div class="btn_2th">
                <div class="btn close-btn">취소</div>
                <input type="submit" class="btn" value="삭제">
            </div>
        </form>
    </div>
</div>

<script src="<%=request.getContextPath() %>/js/swiper-11.2.5.js"></script>
<script>
    $(function () {
        function extractHashtags(text) {
            const hashtags = [];
            let currentIndex = 0;

            if(text != undefined){
                while (currentIndex < text.length) {
                    const hashIndex = text.indexOf('#', currentIndex);

                    if (hashIndex === -1) {
                        break; // 더 이상 해시태그가 없음
                    }

                    let endIndex = text.indexOf(' ', hashIndex);
                    const nextHashIndex = text.indexOf('#', hashIndex + 1);

                    if (endIndex === -1) {
                        endIndex = text.length; // 공백이 없으면 문자열 끝까지
                    }

                    if (nextHashIndex !== -1 && nextHashIndex < endIndex) {
                        currentIndex = nextHashIndex; // ##인 경우 다음 #으로 건너뜀
                    } else {
                        const hashtag = text.substring(hashIndex, endIndex);
                        hashtags.push(hashtag);
                        currentIndex = endIndex;
                    }
                }
            }


            return hashtags;
        }

        $(".post-insert-modal form").submit(function(event) {
            // textarea의 값 가져오기
            var postContent = $(".post-insert-modal textarea[name='postcon']").val().trim();

            // textarea가 비어있는지 확인
            if (postContent === "") {
                // 알림 표시
                alert("내용을 입력해주세요.");

                // 폼 제출 방지
                event.preventDefault();
            }
        });

        // 게시글 작성 버튼 클릭시
        $(".post_write_btn").on('click', function () {
            $(".post-insert-modal").toggleClass("view");
        });

        // 모달 닫기 클릭
        $(".close-btn").on('click', function () {
            $(".modal").removeClass("view");
        });

        // 모달 외부 클릭시 닫기
        $(".modal").on('click', function (e) {
            if (!$(e.target).closest('.modal-i-warp').length) {
                $(this).removeClass("view");
            }
        });

        // 게시글 수정 버튼 클릭시
        $(document).on('click', ".update-btn", function () {
            $(".post-update-modal").toggleClass("view");
            let postindex = $(this).data("index");

            $.ajax({
                url: "/post/postDetailAjax.do",
                type: "post",
                data: "postindex=" + postindex,
                contentType: "application/x-www-form-urlencoded",
                success: function (result) {
                    $('.post-update-modal input[name=postindex]').val(result.post_index);
                    $('.post-update-modal input[name=postwriter]').val(result.mem_id);
                    $('.post-update-modal textarea[name=postcon]').val(result.post_con);
                    let htmlcode ='';
                    htmlcode += '            <div class="swiper post-photo-swiper updatemodal">';
                    htmlcode += '                <div class="swiper-wrapper">';
                    $.each(result.postPhotoDetailList, function (i, v) {
                        htmlcode += '<div class="swiper-slide"><img class="post-photo-img" src="/post/postview.do?postphoto='+v.post_photo+'&postphotosn='+v.post_photo_sn+'"></div>';
                    });
                    htmlcode += '                </div>';
                    htmlcode += '                <div class="swiper-button-next"></div>';
                    htmlcode += '                <div class="swiper-button-prev"></div>';
                    htmlcode += '                <div class="swiper-pagination"></div>';
                    htmlcode += '            </div>';
                    $('.post-update-modal .modal-l').html(htmlcode);
                    setseiper();

                    if (result.post_visible == "Y") {
                        $("#updatetoggles").prop("checked", true);
                    } else {
                        $("#updatetoggles").prop("checked", false);
                    }



                }
            });
        });

        // 게시글 삭제 클릭시
        $(document).on('click', ".delete-btn", function () {
            $(".post-delete-modal").toggleClass("view");
            let postindex = $(this).data("index");
            $('.post-delete-modal input[name=postindex]').val(postindex);
        });

        //게시글 ... 줄여보기 > 전체보이게
        $(document).on('click',".a-c-bd", function () {
            $(this).addClass("view");
        });
        $('.a-c-bd').each(function() {
            var $textElement = $(this);
            var lineHeight = parseFloat($textElement.css('line-height'));
            var maxLines = 3;
            var maxHeight = lineHeight * maxLines;
            var $readMoreButton = $textElement.find('.read-more');

            // 말줄임표가 생성되었는지 확인
            if ($textElement[0].scrollHeight > maxHeight) {
                $readMoreButton.show(); // 말줄임표가 있다면 더보기 버튼 표시

                $readMoreButton.on('click', function() {
                    $textElement.css({
                        '-webkit-line-clamp': 'unset',
                        'overflow': 'visible'
                    });
                    $(this).hide();
                });
            }
        });

        //좋아요 클릭시
        $(document).on('click', ".btn-cover.ilikebtn", function () {
            let targetheart = $(this).find(".heart");
            let memid = '<%=loginMember.getMem_id()%>';
            let postindex = $(this).data('index');
            let getcount = $(this).find("span.likecnt").html();
            $.ajax({
                url: "/setilike.do",
                type: "post",
                data: {"memid":memid,"postindex":postindex},
                contentType: "application/x-www-form-urlencoded",
                success: function (data) {
                    console.log(data)
                    if(data == false){
                        targetheart.removeClass('filled');
                        getcount = +getcount - 1 ;
                        $('.btn-cover.ilikebtn[data-index="'+postindex+'"] span.likecnt').html(getcount);
                    }else {
                        targetheart.addClass('filled');
                        getcount = +getcount + 1 ;
                        $('.btn-cover.ilikebtn[data-index="'+postindex+'"] span.likecnt').html(getcount);
                    }

                }
            });
        });


        // 댓글 가져오기
        $(document).on('click', ".btn-cover.replybtn", function () {
            let postindex = $(this).data("index");
            $('.a-c-rp[data-index=' + postindex + ']').toggleClass("view");

            $.ajax({
                url: "/reply/getreply.do",
                type: "post",
                data: "postindex=" + postindex,
                contentType: "application/x-www-form-urlencoded",
                success: function (result) {
                    let htmlcode = "";
                    if (result.length > 0) {
                        $.each(result, function (i, v) {
                            if (v.mem_id == "<%=loginMember.getMem_id()%>") {
                                htmlcode += '<li>';
                                htmlcode += '    <div class="rp-r-wrap">';
                                htmlcode += '        <div class="rp-r-w-prf">';
                                if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                }else{
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                }
                                htmlcode += '        </div>';
                                htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                htmlcode += '            <div class="rp-r-w-con-warp">';
                                htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-btn-warp">';
                                htmlcode += '                <a class="btn s-btn re-re-btn" data-reindex=' + v.reply_index + '>답글</a>';
                                htmlcode += '                <a class="btn s-btn re-up-btn" data-reindex=' + v.reply_index + '>수정</a>';
                                htmlcode += '                <a class="btn s-btn re-del-btn" data-reindex=' + v.reply_index + ' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex=' + v.reply_index + '">삭제</a>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-reply-warp"></div>';
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '</li>';
                            } else {
                                htmlcode += '<li>';
                                htmlcode += '    <div class="rp-r-wrap">';
                                htmlcode += '        <div class="rp-r-w-prf">';
                                if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                }else{
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                }
                                htmlcode += '        </div>';
                                htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                htmlcode += '            <div class="rp-r-w-con-warp">';
                                htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-btn-warp">';
                                htmlcode += '                <a class="btn s-btn re-re-btn" data-reindex=' + v.reply_index + '>답글</a>';
                                htmlcode += '                <a class="btn s-btn re-report-btn" href="/report.do?nickname=' + v.mem_nickname + '" data-reindex=' + v.reply_index + '>신고</a>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-reply-warp"></div>';
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '</li>';
                            }
                        });
                    } else {
                        htmlcode += '<li>';
                        htmlcode += '    <div class="rp-r-wrap">';
                        htmlcode += '        <div class="rp-r-w-prf"><img src="<%=request.getContextPath() %>/upload/demo_logo.png"></div>';
                        htmlcode += '        <div class="rp-r-w-con">댓글이 없습니다.</div>';
                        htmlcode += '    </div>';
                        htmlcode += '</li>';
                    }
                    $('.a-c-rp[data-index=' + postindex + '] .a-c-rp-r ul').html(htmlcode);
                },
                dataType: "json"
            });
        });

        // 댓글 작성 후 가져오기
        $(document).on('click', ".reply-insert-btn", function (e) {
            e.preventDefault();
            let postindex = $(this).data("index");
            let memid = $(this).parent().find("input[name=mem_id]").val();
            let replycon = $(this).parent().find("input[name=reply_con]").val();

            if (replycon == "" || replycon == null) {
                alert("댓글을 입력해주세요");
                $(this).parent().find("input[name=reply_con]").focus();
                return;
            }

            $.ajax({
                url: "/reply/replyInsert.do",
                type: "post",
                data: {
                    "postindex": postindex,
                    "memid": memid,
                    "replycon": replycon
                },
                contentType: "application/x-www-form-urlencoded",
                dataType: "json",
                success: function (result) {
                    let htmlcode = "";
                    if (result.length > 0) {
                        $.each(result, function (i, v) {
                            if (v.mem_id == "<%=loginMember.getMem_id()%>") {
                                htmlcode += '<li>';
                                htmlcode += '    <div class="rp-r-wrap">';
                                htmlcode += '        <div class="rp-r-w-prf">';
                                if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                }else{
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                }
                                htmlcode += '        </div>';
                                htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                htmlcode += '            <div class="rp-r-w-con-warp">';
                                htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-btn-warp">';
                                htmlcode += '                <a class="btn s-btn re-re-btn" data-reindex=' + v.reply_index + '>답글</a>';
                                htmlcode += '                <a class="btn s-btn re-up-btn" data-reindex=' + v.reply_index + '>수정</a>';
                                htmlcode += '                <a class="btn s-btn re-del-btn" data-reindex=' + v.reply_index + ' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex=' + v.reply_index + '">삭제</a>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-reply-warp"></div>';
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '</li>';
                            } else {
                                htmlcode += '<li>';
                                htmlcode += '    <div class="rp-r-wrap">';
                                htmlcode += '        <div class="rp-r-w-prf">';
                                if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                }else{
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                }
                                htmlcode += '        </div>';
                                htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                htmlcode += '            <div class="rp-r-w-con-warp">';
                                htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-btn-warp">';
                                htmlcode += '                <a class="btn s-btn re-re-btn" data-reindex=' + v.reply_index + '>답글</a>';
                                htmlcode += '                <a class="btn s-btn re-report-btn" href="/report.do?nickname=' + v.mem_nickname + '" data-reindex=' + v.reply_index + '>신고</a>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-reply-warp"></div>';
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '</li>';
                            }
                        });
                    } else {
                        htmlcode += '<li>';
                        htmlcode += '    <div class="rp-r-wrap">';
                        htmlcode += '        <div class="rp-r-w-prf"><img src="<%=request.getContextPath() %>/upload/demo_logo.png"></div>';
                        htmlcode += '        <div class="rp-r-w-con">댓글이 없습니다.</div>';
                        htmlcode += '    </div>';
                        htmlcode += '</li>';
                    }
                    $('.a-c-rp[data-index=' + postindex + '] .a-c-rp-r ul').html(htmlcode);
                    $("input[name=reply_con]").val("");
                }
            });
        });

        // 댓글 수정 폼
        $(document).on("click", ".re-up-btn", function () {
            $(this).addClass("unvis");

            let postidex = $(this).parents(".a-c-rp-w").data("index");
            let reindex = $(this).data("reindex");
            let con = $(this).parents(".rp-r-w-container").find(".rp-r-w-con").html();

            // 댓글 내용 가리기
            $(this).parents(".rp-r-w-container").find(".rp-r-w-con").css("display", "none");

            $(this).parent().parent().children("div").eq(0).append(`
                <span id="spn\${reindex}">
                    <form action="<%=request.getContextPath() %>/reply/replyUpdate.do" method="post">
                        <input type="text" id="txtindex\${reindex}" name="replyindex" value="\${reindex}" hidden/>
                        <input type="text" id="txtCon\${reindex}" name="replycon" value="\${con}" />
                        <button type="submit" class="btnConfirm btn" data-index="\${postidex}" data-con="\${con}" data-reindex="\${reindex}">수정</button>
                        <button type="button" class="btnCancel btn" data-reindex="\${reindex}">취소</button>
                    </form>
                </span>
            `);
        });

        // 댓글 수정 확인 실행
        $(document).on("click", ".btnConfirm", function () {
            let postindex = $(this).data("index");
            let reindex = $(this).data("reindex");
            let replycon = $(this).parents("form").find("input[name=replycon]").val();
            let parentreindex = $(this).data("rereindex");

            // 댓글 가져오기 수정후
            $('form').submit(function (e) {
                e.preventDefault();
                $.ajax({
                    type: 'POST',
                    url: '/reply/replyUpdate.do',
                    data: "postindex=" + postindex + "&replyindex=" + reindex + "&replycon=" + replycon,
                    contentType: "application/x-www-form-urlencoded",
                    success: function (result) {
                        let htmlcode = "";
                        if (result.length > 0) {
                            $.each(result, function (i, v) {
                                if (v.mem_id == "<%=loginMember.getMem_id()%>") {
                                    htmlcode += '<li>';
                                    htmlcode += '    <div class="rp-r-wrap">';
                                    htmlcode += '        <div class="rp-r-w-prf">';
                                    if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                        htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                    }else{
                                        htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                    }
                                    htmlcode += '        </div>';
                                    htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                    htmlcode += '            <div class="rp-r-w-con-warp">';
                                    htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                    htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                    htmlcode += '            </div>';
                                    htmlcode += '            <div class="rp-r-w-btn-warp">';
                                    if (parentreindex != 1) {
                                        htmlcode += '<a class="btn s-btn re-re-btn" data-reindex=' + v.reply_index + '>답글</a>';
                                    }
                                    htmlcode += '                <a class="btn s-btn re-up-btn" data-reindex=' + v.reply_index + '>수정</a>';
                                    htmlcode += '                <a class="btn s-btn re-del-btn" data-reindex=' + v.reply_index + ' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex=' + v.reply_index + '">삭제</a>';
                                    htmlcode += '            </div>';
                                    htmlcode += '            <div class="rp-r-w-reply-warp"></div>';
                                    htmlcode += '        </div>';
                                    htmlcode += '    </div>';
                                    htmlcode += '</li>';
                                } else {
                                    htmlcode += '<li>';
                                    htmlcode += '    <div class="rp-r-wrap">';
                                    htmlcode += '        <div class="rp-r-w-prf">';
                                    if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                        htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                    }else{
                                        htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                    }
                                    htmlcode += '        </div>';
                                    htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                    htmlcode += '            <div class="rp-r-w-con-warp">';
                                    htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                    htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                    htmlcode += '            </div>';
                                    htmlcode += '            <div class="rp-r-w-btn-warp">';
                                    if (parentreindex != 1) {
                                        htmlcode += '<a class="btn s-btn re-re-btn" data-reindex=' + v.reply_index + '>답글</a>';
                                    }
                                    htmlcode += '                <a class="btn s-btn re-report-btn" href="/report.do?nickname=' + v.mem_nickname + '" data-reindex=' + v.reply_index + '>신고</a>';
                                    htmlcode += '            </div>';
                                    htmlcode += '            <div class="rp-r-w-reply-warp"></div>';
                                    htmlcode += '        </div>';
                                    htmlcode += '    </div>';
                                    htmlcode += '</li>';
                                }
                            });
                        }
                        if (parentreindex != 1) {
                            $('.a-c-rp[data-index=' + postindex + '] .a-c-rp-r ul').html(htmlcode);
                        } else {
                            $('.a-c-rp[data-index=' + postindex + '] .a-c-rp-r ul .rp-r-w-container[data-reindex=' + reindex + ']').append(htmlcode);
                        }
                    },
                    error: function (error) {
                        console.error('댓글 수정 실패:', error);
                    },
                    dataType: "json"
                });
            });
        });

        // 댓글 수정 취소
        $(document).on("click", ".btnCancel", function () {
            let reindex = $(this).data("reindex");

            // 댓글 내용 살리기
            $(this).parents(".rp-r-w-con-warp").find(".rp-r-w-con").css("display", "inline");

            $("#spn" + reindex).remove();
            $(".rp-r-w-btn-warp .re-up-btn[data-reindex=" + reindex + "]").removeClass("unvis");
        });

        // 답글 쓰기 클릭시
        $(document).on("click", ".re-re-btn", function () {
            let reindex = $(this).data("reindex");
            let postindex = $(this).parents(".a-c-rp-w").data("index");
            $(this).parents(".rp-r-w-btn-warp").find(".btn").css("display", "none");

            $(this).parents(".rp-r-w-btn-warp").append(`
                <span id="spn\${reindex}">
                    <form action="<%=request.getContextPath() %>/reply/replyInsert.do" method="post">
                        <input type="text" id="pindex\${postindex}" name="post_index" value="\${postindex}" hidden/>
                        <input type="text" id="rindex\${reindex}" name="Replyindex" value="\${reindex}" hidden/>
                        <input type="text" name="mem_id" value="<%=loginMember.getMem_id()%>" hidden/>
                        <input type="text" id="txtCon\${reindex}" name="reply_con" value="" placeholder="답글을 입력하세요"/>
                        <button type="submit" class="rereply-insert-btn btn" data-reindex="\${reindex}">답글</button>
                    </form>
                </span>
            `);

            // 대댓글(답글) 가져오기
            $.ajax({
                url: "/reply/getreplyreply.do",
                type: "post",
                data: "postindex=" + postindex + "&Replyindex=" + reindex,
                contentType: "application/x-www-form-urlencoded",
                success: function (result) {
                    let htmlcode = "";
                    if (result.length > 0) {
                        $.each(result, function (i, v) {
                            if (v.mem_id == "<%=loginMember.getMem_id()%>") {
                                htmlcode += '<li>';
                                htmlcode += '    <div class="rp-r-wrap">';
                                htmlcode += '        <div class="rp-r-w-prf">';
                                if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                }else{
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                }
                                htmlcode += '        </div>';
                                htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                htmlcode += '            <div class="rp-r-w-con-warp">';
                                htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-btn-warp">';
                                htmlcode += '                <a class="btn s-btn re-re-up-btn" data-reindex=' + v.reply_index + '>수정</a>';
                                htmlcode += '                <a class="btn s-btn re-del-btn" data-reindex=' + v.reply_index + ' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex=' + v.reply_index + '">삭제</a>';
                                htmlcode += '            </div>';
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '</li>';
                            } else {
                                htmlcode += '<li>';
                                htmlcode += '    <div class="rp-r-wrap">';
                                htmlcode += '        <div class="rp-r-w-prf">';
                                if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                }else{
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                }
                                htmlcode += '        </div>';
                                htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                htmlcode += '            <div class="rp-r-w-con-warp">';
                                htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-btn-warp">';
                                htmlcode += '                <a class="btn s-btn re-report-btn" href="/report.do?nickname=' + v.mem_nickname + '" data-reindex=' + v.reply_index + '>신고</a>';
                                htmlcode += '            </div>';
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '</li>';
                            }
                        });
                    }
                    $('.a-c-rp[data-index=' + postindex + '] .a-c-rp-r ul .rp-r-w-container[data-reindex=' + reindex + '] .rp-r-w-reply-warp').append(htmlcode);
                },
                dataType: "json"
            });
        });

        // 답글 작성 후 가져오기
        $(document).on('click', ".rereply-insert-btn", function (e) {
            e.preventDefault();
            let postindex = $(this).parent().find("input[name=post_index]").val();
            let memid = $(this).parent().find("input[name=mem_id]").val();
            let replycon = $(this).parent().find("input[name=reply_con]").val();
            let Replyindex = $(this).parents(".rp-r-w-container").data("reindex");

            if (replycon == "" || replycon == null) {
                alert("댓글을 입력해주세요");
                $(this).parent().find("input[name=reply_con]").focus();
                return;
            }

            // 답글 작성 후 가져오기
            $.ajax({
                url: "/reply/replyreplyInsert.do",
                type: "post",
                data: {
                    "postindex": postindex,
                    "memid": memid,
                    "replycon": replycon,
                    "Replyindex": Replyindex
                },
                contentType: "application/x-www-form-urlencoded",
                success: function (result) {
                    let htmlcode = "";
                    if (result.length > 0) {
                        $.each(result, function (i, v) {
                            if (v.mem_id == "<%=loginMember.getMem_id()%>") {
                                htmlcode += '<li>';
                                htmlcode += '    <div class="rp-r-wrap">';
                                htmlcode += '        <div class="rp-r-w-prf">';
                                if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                }else{
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                }
                                htmlcode += '        </div>';
                                htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                htmlcode += '            <div class="rp-r-w-con-warp">';
                                htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-btn-warp">';
                                htmlcode += '                <a class="btn s-btn re-re-up-btn" data-reindex=' + v.reply_index + '>수정</a>';
                                htmlcode += '                <a class="btn s-btn re-del-btn" data-reindex=' + v.reply_index + ' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex=' + v.reply_index + '">삭제</a>';
                                htmlcode += '            </div>';
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '</li>';
                            } else {
                                htmlcode += '<li>';
                                htmlcode += '    <div class="rp-r-wrap">';
                                htmlcode += '        <div class="rp-r-w-prf">';
                                if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                }else{
                                    htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                }
                                htmlcode += '        </div>';
                                htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                htmlcode += '            <div class="rp-r-w-con-warp">';
                                htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="rp-r-w-btn-warp">';
                                htmlcode += '                <a class="btn s-btn re-report-btn" href="/report.do?nickname=' + v.mem_nickname + '" data-reindex=' + v.reply_index + '>신고</a>';
                                htmlcode += '            </div>';
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '</li>';
                            }
                        });
                    }
                    $('.a-c-rp[data-index=' + postindex + '] .a-c-rp-r ul .rp-r-w-container[data-reindex=' + Replyindex + '] .rp-r-w-reply-warp').html(htmlcode);
                    $("input[name=reply_con]").val("");
                },
                dataType: "json"
            });
        });

        // 답글 수정 폼
        $(document).on("click", ".re-re-up-btn", function () {
            $(this).addClass("unvis");

            let postidex = $(this).parents(".a-c-rp-w").data("index");
            let reindex = $(this).data("reindex");
            let con = $(this).parents(".rp-r-w-container").eq(0).find(".rp-r-w-con").html();

            // 댓글 내용 가리기
            $(this).parents(".rp-r-w-container").eq(0).find(".rp-r-w-con").css("display", "none");

            $(this).parent().parent().children("div").eq(0).append(`
                <span id="spn\reindex}">
                    <form action="<%=request.getContextPath() %>/reply/replyreplyUpdate.do" method="post">
                        <input type="text" id="txtindex\${reindex}" name="replyindex" value="\${reindex}" hidden/>
                        <input type="text" id="txtCon\{reindex}" name="replycon" value="\${con}" />
                        <button type="submit" class="rebtnConfirm" data-index="\${postidex}" data-con="\${con}" data-reindex="\${reindex}">확인</button>
                        <button type="button" class="rebtnCancel" data-reindex="\${reindex}">취소</button>
                    </form>
                </span>
            `);
        });

        // 답글 수정 확인 실행
        $(document).on("click", ".rebtnConfirm", function () {
            let reindex = $(this).data("reindex");
            let postindex = $(this).parents(".a-c-rp-w").data("index");
            let replycon = $(this).parents("form").find("input[name=replycon]").val();
            let parentreindex = $(this).parents(".rp-r-w-container").eq(1).data("reindex");

            // 대댓글(답글) 가져오기 수정후
            $('form').submit(function (e) {
                e.preventDefault();
                $.ajax({
                    type: 'POST',
                    url: '/reply/replyreplyUpdate.do',
                    data: {
                        "postindex": postindex,
                        "replyindex": reindex,
                        "replycon": replycon,
                        "parentreindex": parentreindex
                    },
                    contentType: "application/x-www-form-urlencoded",
                    success: function (result) {
                        let htmlcode = "";
                        if (result.length > 0) {
                            $.each(result, function (i, v) {
                                if (v.mem_id == "<%=loginMember.getMem_id()%>") {
                                    htmlcode += '<li>';
                                    htmlcode += '    <div class="rp-r-wrap">';
                                    htmlcode += '        <div class="rp-r-w-prf">';
                                    if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                        htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                    }else{
                                        htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                    }
                                    htmlcode += '        </div>';
                                    htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                    htmlcode += '            <div class="rp-r-w-con-warp">';
                                    htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                    htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                    htmlcode += '            </div>';
                                    htmlcode += '            <div class="rp-r-w-btn-warp">';
                                    htmlcode += '                <a class="btn s-btn re-re-up-btn" data-reindex=' + v.reply_index + '>수정</a>';
                                    htmlcode += '                <a class="btn s-btn re-del-btn" data-reindex=' + v.reply_index + ' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex=' + v.reply_index + '">삭제</a>';
                                    htmlcode += '            </div>';
                                    htmlcode += '        </div>';
                                    htmlcode += '    </div>';
                                    htmlcode += '</li>';
                                } else {
                                    htmlcode += '<li>';
                                    htmlcode += '    <div class="rp-r-wrap">';
                                    htmlcode += '        <div class="rp-r-w-prf">';
                                    if(v.profileVo == undefined || v.profileVo.profile_photo != null){
                                        htmlcode += '            <img src="<%=request.getContextPath() %>/'+v.profileVo.profile_photo+'">';
                                    }else{
                                        htmlcode += '            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                    }
                                    htmlcode += '        </div>';
                                    htmlcode += '        <div class="rp-r-w-container" data-reindex=' + v.reply_index + '>';
                                    htmlcode += '            <div class="rp-r-w-con-warp">';
                                    htmlcode += '                <span class="rp-r-w-nick">' + v.mem_nickname + '</span>';
                                    htmlcode += '                <span class="rp-r-w-con">' + v.reply_con + '</span>';
                                    htmlcode += '            </div>';
                                    htmlcode += '            <div class="rp-r-w-btn-warp">';
                                    htmlcode += '                <a class="btn s-btn re-report-btn" href="/report.do?nickname=' + v.mem_nickname + '" data-reindex=' + v.reply_index + '>신고</a>';
                                    htmlcode += '            </div>';
                                    htmlcode += '        </div>';
                                    htmlcode += '    </div>';
                                    htmlcode += '</li>';
                                }
                            });
                        }
                        $('.a-c-rp[data-index=' + postindex + '] .a-c-rp-r ul .rp-r-w-container[data-reindex=' + reindex + ']').parents(".rp-r-w-container").find(".rp-r-w-reply-warp").html(htmlcode);
                    },
                    error: function (error) {
                        console.error('댓글 수정 실패:', error);
                    },
                    dataType: "json"
                });
            });
        });

        // 답글 취소
        $(document).on("click", ".rebtnCancel", function () {
            let reindex = $(this).data("reindex");
            $(this).parents(".rp-r-w-con-warp").eq(0).find(".rp-r-w-con").css("display", "inline");

            $("#spn" + reindex).remove();
            $(".rp-r-w-btn-warp .re-re-up-btn[data-reindex=" + reindex + "]").removeClass("unvis");
        });

        // 무한 스크롤 관련 변수
        let page = 1; // 현재 페이지 번호
        let loading = false; // 로딩 상태
        let stoploading = false; // 더 불러올 데이터 없는지 체크

        // 게시글 가져오기 함수
        function loadData() {
            if (loading) return; // 로딩 중이면 중복 요청 방지
            loading = true;

            $.ajax({
                url: "/post/postList.do",
                type: "post",
                data: { page: page },
                contentType: "application/x-www-form-urlencoded",
                dataType: "json",
                success: function (data) {
                    let htmlcode = "";
                    if (data.length > 0) {
                        $.each(data, function (i, pl) {
                            htmlcode += '<article class="post-atc">';
                            htmlcode += '    <div class="a-hd">';
                            htmlcode += '        <div class="a-h-prf-pho">';
                            htmlcode += '            <a>';
                            if(pl.profileVo.profile_photo != null){
                                htmlcode += '                <img src="<%=request.getContextPath()%>/'+pl.profileVo.profile_photo+'">';
                            }else {
                                htmlcode += '                <img src="/upload/demo_logo.png">';
                            }

                            htmlcode += '                <span>' + pl.memVo.mem_nickname + '</span>';
                            htmlcode += '            </a>';
                            htmlcode += '        </div>';
                            htmlcode += '        <div class="t-stemp">' + pl.post_date + '</div>';
                            htmlcode += '    </div>';
                            htmlcode += '    <div class="a-bd">';
                            htmlcode += '        <div class="a-bd-img">';
                            if (pl.postPhotoDetailList.length > 0) {
                                htmlcode += '            <div class="swiper post-photo-swiper">';
                                htmlcode += '                <div class="swiper-wrapper">';
                                $.each(pl.postPhotoDetailList, function (i, plphoto) {
                                    htmlcode += '                    <div class="swiper-slide">';
                                    htmlcode += '                        <img class="post-photo-img" src="/post/postview.do?postphoto=' + plphoto.post_photo + '&postphotosn=' + plphoto.post_photo_sn + '">';
                                    htmlcode += '                    </div>';
                                });
                                htmlcode += '                </div>';
                                htmlcode += '                <div class="swiper-button-next"></div>';
                                htmlcode += '                <div class="swiper-button-prev"></div>';
                                htmlcode += '                <div class="swiper-pagination"></div>';
                                htmlcode += '            </div>';
                            } else {
                                htmlcode += '            <img src="/upload/demo_logo.png">';
                            }
                            htmlcode += '        </div>';
                            htmlcode += '        <div class="a-bd-btns">';
                            htmlcode += '            <div class="btn-cover ilikebtn" data-index=' + pl.post_index + '>';
                            if(pl.Likecheck){
                                htmlcode += '                <svg aria-label="좋아요" class="heart filled" role="img" viewBox="0 0 24 24" height="24" width="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">';
                            }else{
                                htmlcode += '                <svg aria-label="좋아요" class="heart" role="img" viewBox="0 0 24 24" height="24" width="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">';
                            }


                            htmlcode += '                    <title>좋아요</title>';
                            htmlcode += '                    <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>';
                            htmlcode += '                </svg>';
                            htmlcode += '               <span class="likecnt">'+pl.likecheckcnt+'</span>';
                            htmlcode += '            </div>';
                            htmlcode += '            <div class="btn-cover replybtn" data-index=' + pl.post_index + '>';
                            htmlcode += '                <svg aria-label="댓글 달기" class="" fill="currentColor" height="24" role="img" viewBox="0 0 24 24" width="24">';
                            htmlcode += '                    <title>댓글 달기</title>';
                            htmlcode += '                    <path d="M20.656 17.008a9.993 9.993 0 1 0-3.59 3.615L22 22Z" fill="none" stroke="currentColor" stroke-linejoin="round" stroke-width="2"></path>';
                            htmlcode += '                </svg>';
                            htmlcode += '            </div>';
                            // 로그인한 회원과 작성자의 아이디가 같을때
                            if (pl.mem_id == "<%=loginMember.getMem_id()%>") {
                                htmlcode += '            <div class="btn-cover">';
                                htmlcode += '                <div class="update-btn pointer" data-index=' + pl.post_index + '>수정</div>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="btn-cover">';
                                htmlcode += '                <div class="delete-btn pointer" data-index=' + pl.post_index + '>삭제</div>';
                                htmlcode += '            </div>';
                            } else {
                                htmlcode += '            <div class="btn-cover">';
                                htmlcode += '                <a class="report-btn pointer" href="/report.do?nickname=' + pl.memVo.mem_nickname + '" data-index=' + pl.post_index + '>신고</a>';
                                htmlcode += '            </div>';
                            }
                            htmlcode += '        </div>';
                            htmlcode += '    </div>';
                            htmlcode += '    <div class="a-con">';
                            htmlcode += '        <div class="a-c-h">';
                            let hashs = extractHashtags(pl.post_con)
                            $.each(hashs, function (i, v) {
                                if(v == "#"){}else {htmlcode += '<div>'+v+'</div>';}
                            });
                            htmlcode += '        </div>';
                            htmlcode += '        <div class="a-c-bd">' + pl.post_con.replace("\r\n", "<br>").replace("\r", "<br>").replace("\n", "<br>") + '<button class="read-more">더보기</button></div>';
                            htmlcode += '        <div class="a-c-rp a-c-rp-w" data-index=' + pl.post_index + '>';
                            htmlcode += '            <form action="/reply/replyInsert.do" method="post">';
                            htmlcode += '                <input type="hidden" name="post_index" value="' + pl.post_index + '"/>';
                            htmlcode += '                <input type="hidden" name="mem_id" value="<%=loginMember.getMem_id()%>"/>';
                            htmlcode += '                <input type="text" placeholder="댓글을 입력하세요" name="reply_con"/>';
                            htmlcode += '                <input type="submit" class="reply-insert-btn" data-index=' + pl.post_index + ' value="댓글달기">';
                            htmlcode += '            </form>';
                            htmlcode += '            <div class="a-c-rp-r">';
                            htmlcode += '                <ul>';
                            htmlcode += '                </ul>';
                            htmlcode += '            </div>';
                            htmlcode += '        </div>';
                            htmlcode += '    </div>';
                            htmlcode += '</article>';
                        });

                    } else {
                        stoploading = true;
                        // htmlcode += '<article class="post-atc">데이터가 없습니다.</article>';
                    }

                    $(".post-atcwrap").append(htmlcode);
                    setseiper();
                    page++; // 페이지 번호 증가
                    loading = false;
                },
                error: function () {
                    alert("데이터 로드 실패!" +
                        "정상적 접근이 아닙니다.");
                    window.location.href = '/';
                    loading = false;
                }
            });
        }

        // 초기 데이터 로드
        loadData();

        // 스크롤 이벤트 처리
        $(window).scroll(function () {
            if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
                // 스크롤이 거의 끝까지 내려왔을 때 추가 데이터 로드
                if (stoploading != true) {
                    loadData();
                }
            }
        });

        // 이미지 미리보기
        $('.post-ipt').on('change', function (e) {
            const files = e.target.files; // 선택된 파일 목록 가져오기
            if (files && files.length > 0) {
                // 기존 슬라이드 내용 제거
                $('.swiper-wrapper').empty();
                $('.modal-l').addClass('view');
                $('.modal-r').addClass('view');

                for (let i = 0; i < files.length; i++) {
                    const file = files[i];

                    if (file.type.startsWith('image/')) {
                        const reader = new FileReader();
                        reader.onload = function (event) {
                            // Swiper 슬라이드에 이미지 추가
                            const slide = $('<div class="swiper-slide"></div>');
                            const img = $('<img>').attr('src', event.target.result).css('max-width', '100%'); // 이미지 최대 너비 설정
                            slide.append(img);
                            $('.swiper-wrapper').append(slide);
                        };
                        reader.readAsDataURL(file);
                    } else {
                        console.log('이미지 파일이 아닙니다:', file.name);
                    }
                }
                // Swiper 초기화 또는 업데이트
                if (typeof swiper !== 'undefined') {
                    swiper.update(); // Swiper가 이미 초기화된 경우 업데이트
                } else {
                    setseiper()
                }
            }
        });
    });

    // Swiper 초기화 함수
    function setseiper() {
        if (typeof swiper !== 'undefined') {
            swiper.update(); // Swiper가 이미 초기화된 경우 업데이트
        }else {
            let swiper = new Swiper(".post-photo-swiper", {
                cssMode: true,
                navigation: {
                    nextEl: ".swiper-button-next",
                    prevEl: ".swiper-button-prev",
                },
                pagination: {
                    el: ".swiper-pagination",
                },
                mousewheel: true,
                keyboard: true,
            });
        }
    }


</script>
</body>
</html>