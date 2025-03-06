<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.*" %><%--
  Created by IntelliJ IDEA.
  User: PC-10
  Date: 2025-02-24
  Time: 오후 8:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
    List<PostVO> postList = (List<PostVO>) request.getAttribute("postList");
//    String msg = (String) session.getAttribute("msg") == null ? "" : (String) session.getAttribute("msg");
//    session.removeAttribute("msg");

%>



<html>
<head>
    <title>게시판 이에요잉</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script>
        $(function () {
<%--            <% if(msg != null){ %>--%>
<%--                alert(<%=msg %>);--%>
<%--            <%}%>--%>


            //게시글 작성 버튼클릭시
            $(".post_write_btn").on('click', function () {
                $(".post-insert-modal").toggleClass("view");
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

            //게시글 수정버튼클릭시
            $(document).on('click',".update-btn", function () {
                $(".post-update-modal").toggleClass("view");
                let postindex = $(this).data("index");

                $.ajax({
                    url: "/post/postDetailAjax.do",
                    type: "post",
                    data: "postindex=" + postindex,
                    contentType: "application/x-www-form-urlencoded", //content-type 설정 (생략가능)
                    success: function (result) {

                        console.log(result)
                        $('.post-update-modal input[name=postindex]').val(result.post_index);
                        $('.post-update-modal input[name=postwriter]').val(result.mem_id);
                        $('.post-update-modal textarea[name=postcon]').val(result.post_con);

                        if (result.post_visible == "Y") {
                            $("#updatetoggles").prop("checked", true);
                        } else {
                            $("#updatetoggles").prop("checked", false);
                        }
                    }
                });

            });

            //게시글 삭제 클릭시
            $(document).on('click',".delete-btn", function () {
                $(".post-delete-modal").toggleClass("view");
                let postindex = $(this).data("index")
                $('.post-delete-modal input[name=postindex]').val(postindex);
            });

            //게시글 줄여보기 > 전체보이게
            $(document).on('click',".a-c-bd", function () {
                $(this).addClass("view");
            });


            //댓글 가져오기 ajax
            $(document).on('click',".replybtn",function(){
                let postindex = $(this).data("index");
                $('.a-c-rp[data-index='+postindex+']').toggleClass("view");

                $.ajax({
                    url:"/reply/getreply.do",
                    type:"post",
                    data:"postindex="+postindex,
                    contentType : "application/x-www-form-urlencoded", //content-type 설정 (생략가능)
                    success:function(result){
                        console.log(result)
                        let htmlcode= "";
                        if(result.length>0){
                            $.each(result , function(i,v){
                                if(v.mem_id=="<%=loginMember.getMem_id()%>"){
                                    htmlcode +='<li>';
                                    htmlcode +='    <div class="rp-r-wrap">';
                                    htmlcode +='        <div class="rp-r-w-prf">';
                                    htmlcode +='            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                    htmlcode +='        </div>';
                                    htmlcode +='        <div class="rp-r-w-container" data-reindex='+v.reply_index+'>';
                                    htmlcode +='            <div class="rp-r-w-con-warp">';
                                    htmlcode +='                <span class="rp-r-w-nick">'+v.mem_nickname+'</span>';
                                    htmlcode +='                <span class="rp-r-w-con">'+v.reply_con+'</span>';
                                    htmlcode +='            </div>';
                                    htmlcode +='            <div class="rp-r-w-btn-warp">';
                                    htmlcode +='                <a class="btn s-btn re-re-btn" data-reindex='+v.reply_index+'>답글</a>';
                                    htmlcode +='                <a class="btn s-btn re-up-btn" data-reindex='+v.reply_index+'>수정</a>';
                                    htmlcode +='                <a class="btn s-btn re-del-btn" data-reindex='+v.reply_index+' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex='+v.reply_index+'">삭제</a>';
                                    htmlcode +='            </div>';
                                    htmlcode +='            <div class="rp-r-w-reply-warp"></div>';
                                    htmlcode +='        </div>';
                                    htmlcode +='    </div>';
                                    htmlcode +='</li>';
                                }else{
                                    htmlcode +='<li>';
                                    htmlcode +='    <div class="rp-r-wrap">';
                                    htmlcode +='        <div class="rp-r-w-prf">';
                                    htmlcode +='            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                    htmlcode +='        </div>';
                                    htmlcode +='        <div class="rp-r-w-container" data-reindex='+v.reply_index+'>';
                                    htmlcode +='            <div class="rp-r-w-con-warp">';
                                    htmlcode +='                <span class="rp-r-w-nick">'+v.mem_nickname+'</span>';
                                    htmlcode +='                <span class="rp-r-w-con">'+v.reply_con+'</span>';
                                    htmlcode +='            </div>';
                                    htmlcode +='            <div class="rp-r-w-btn-warp">';
                                    htmlcode +='                <a class="btn s-btn re-re-btn" data-reindex='+v.reply_index+'>답글</a>';
                                    htmlcode +='                <a class="btn s-btn re-report-btn" href="/report.do?nickname='+v.mem_nickname+'" data-reindex='+v.reply_index+'>신고</a>';
                                    htmlcode +='            </div>';
                                    htmlcode +='            <div class="rp-r-w-reply-warp"></div>';
                                    htmlcode +='        </div>';
                                    htmlcode +='    </div>';
                                    htmlcode +='</li>';
                                }
                            });
                        }else {
                            htmlcode +='<li>';
                            htmlcode +='    <div class="rp-r-wrap">';
                            htmlcode +='        <div class="rp-r-w-prf"><img src="<%=request.getContextPath() %>/upload/demo_logo.png"></div>';
                            htmlcode +='        <div class="rp-r-w-con">댓글이 없습니다.</div>';
                            htmlcode +='    </div>';
                            htmlcode +='</li>';
                        }
                        $('.a-c-rp[data-index='+postindex+'] .a-c-rp-r ul').html(htmlcode);
                    },
                    dataType : "json"
                });

            });

            //댓글 수정 폼
            $(document).on("click",".re-up-btn",function(){
                $(this).addClass("unvis");

                let postidex = $(this).parents(".a-c-rp-w").data("index");
                let reindex = $(this).data("reindex");
                console.log("reindex : ", reindex);

                let con = $(this).parents(".rp-r-w-container").find(".rp-r-w-con").html()
                console.log("con : ", con);
                //댓글 내용 가리기
                $(this).parents(".rp-r-w-container").find(".rp-r-w-con").css("display","none");

                $(this).parent().parent().children("div").eq(0).append(`
                    <span id="spn\${reindex}">
                        <form action="<%=request.getContextPath() %>/reply/replyUpdate.do" method="post">
                            <input type="text" id="txtindex\${reindex}" name="replyindex" value="\${reindex}" hidden/>
                            <input type="text" id="txtCon\${reindex}" name="replycon" value="\${con}" />
                            <button type="submit" class="btnConfirm" data-index="\${postidex}" data-con="\${con}" data-reindex="\${reindex}">확인</button>
                            <button type="button" class="btnCancel" data-reindex="\${reindex}">취소</button>
                        </form>
                    </span>
                `);
            });

            //댓글 수정 확인 실행
            $(document).on("click",".btnConfirm",function(){
                //<button type="button" class="btnConfirm" data-con="댓글테스트" data-reindex="8">확인</button>
                let postindex = $(this).data("index");
                let reindex = $(this).data("reindex");
                let replycon = $(this).parents("form").find("input[name=replycon]").val();
                //대댓글인지 확인
                let parentreindex = $(this).data("rereindex");

                // 댓글 가져오기 수정후
                $('form').submit(function(e) {
                    e.preventDefault();
                    $.ajax({
                        type: 'POST',
                        url: '/reply/replyUpdate.do',
                        data: "postindex="+postindex+"&replyindex="+reindex+"&replycon="+replycon,
                        contentType : "application/x-www-form-urlencoded", //content-type 설정 (생략가능)
                        success:function(result){
                            console.log(result)
                            let htmlcode= "";
                            if(result.length>0){
                                $.each(result , function(i,v){
                                    if(v.mem_id=="<%=loginMember.getMem_id()%>"){
                                        htmlcode +='<li>';
                                        htmlcode +='    <div class="rp-r-wrap">';
                                        htmlcode +='        <div class="rp-r-w-prf">';
                                        htmlcode +='            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                        htmlcode +='        </div>';
                                        htmlcode +='        <div class="rp-r-w-container" data-reindex='+v.reply_index+'>';
                                        htmlcode +='            <div class="rp-r-w-con-warp">';
                                        htmlcode +='                <span class="rp-r-w-nick">'+v.mem_nickname+'</span>';
                                        htmlcode +='                <span class="rp-r-w-con">'+v.reply_con+'</span>';
                                        htmlcode +='            </div>';
                                        htmlcode +='            <div class="rp-r-w-btn-warp">';
                                        if(parentreindex != 1){
                                            htmlcode +='<a class="btn s-btn re-re-btn" data-reindex='+v.reply_index+'>답글</a>';
                                        }
                                        htmlcode +='                <a class="btn s-btn re-up-btn" data-reindex='+v.reply_index+'>수정</a>';
                                        htmlcode +='                <a class="btn s-btn re-del-btn" data-reindex='+v.reply_index+' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex='+v.reply_index+'">삭제</a>';
                                        htmlcode +='            </div>';
                                        htmlcode +='            <div class="rp-r-w-reply-warp"></div>';
                                        htmlcode +='        </div>';
                                        htmlcode +='    </div>';
                                        htmlcode +='</li>';
                                    }else{
                                        htmlcode +='<li>';
                                        htmlcode +='    <div class="rp-r-wrap">';
                                        htmlcode +='        <div class="rp-r-w-prf">';
                                        htmlcode +='            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                        htmlcode +='        </div>';
                                        htmlcode +='        <div class="rp-r-w-container" data-reindex='+v.reply_index+'>';
                                        htmlcode +='            <div class="rp-r-w-con-warp">';
                                        htmlcode +='                <span class="rp-r-w-nick">'+v.mem_nickname+'</span>';
                                        htmlcode +='                <span class="rp-r-w-con">'+v.reply_con+'</span>';
                                        htmlcode +='            </div>';
                                        htmlcode +='            <div class="rp-r-w-btn-warp">';
                                        if(parentreindex != 1){
                                            htmlcode +='<a class="btn s-btn re-re-btn" data-reindex='+v.reply_index+'>답글</a>';
                                        }
                                        htmlcode +='                <a class="btn s-btn re-report-btn" href="/report.do?nickname='+v.mem_nickname+'" data-reindex='+v.reply_index+'>신고</a>';
                                        htmlcode +='            </div>';
                                        htmlcode +='            <div class="rp-r-w-reply-warp"></div>';
                                        htmlcode +='        </div>';
                                        htmlcode +='    </div>';
                                        htmlcode +='</li>';
                                    }
                                });
                            }
                            if(parentreindex != 1){
                                $('.a-c-rp[data-index='+postindex+'] .a-c-rp-r ul').html(htmlcode);
                            }else {
                                $('.a-c-rp[data-index='+postindex+'] .a-c-rp-r ul .rp-r-w-container[data-reindex='+reindex+']').append(htmlcode);
                            }

                        },
                        error: function(error) {
                            console.error('댓글 수정 실패:', error);
                        },
                        dataType : "json"
                    });
                });

            });

            //댓글 수정 취소
            $(document).on("click",".btnCancel",function(){
                //<button type="button" class="btnCancel" data-reindex="8">취소</button>
                let reindex = $(this).data("reindex");
                console.log("댓글 수정 취소->reindex : ", reindex);

                //댓글 내용 살리기
                //취소버튼 부모 : span. 그 앞의 이웃

                // $(this).parent().prev().css("display","inline");
                $(this).parents(".rp-r-w-con-warp").find(".rp-r-w-con").css("display","inline");

                /*
                <span id="spn8">
                    ...
                </span>
                 */
                $("#spn"+reindex).remove();
                $(".rp-r-w-btn-warp .re-up-btn[data-reindex="+reindex+"]").removeClass("unvis");
            });

            //답글 쓰기 클릭시
            $(document).on("click",".re-re-btn",function(){
                let reindex = $(this).data("reindex");
                let postindex = $(this).parents(".a-c-rp-w").data("index");
                $(this).parents(".rp-r-w-btn-warp").find(".btn").css("display","none");

                $(this).parents(".rp-r-w-btn-warp").append(`
                    <span id="spn\${reindex}">
                        <form action="<%=request.getContextPath() %>/reply/replyInsert.do" method="post">
                            <input type="text" id="pindex\${postindex}" name="post_index" value="\${postindex}" hidden/>
                            <input type="text" id="rindex\${reindex}" name="Replyindex" value="\${reindex}" hidden/>
                            <input type="text" name="mem_id" value="<%=loginMember.getMem_id()%>" hidden/>
                            <input type="text" id="txtCon\${reindex}" name="reply_con" value="" />
                            <button type="submit" class="rerebtnConfirm" data-reindex="\${reindex}">답글달기</button>
                        </form>
                    </span>
                `);

                //대댓글(답글) 가져오기
                $.ajax({
                    url:"/reply/getreplyreply.do",
                    type:"post",
                    data:"postindex="+postindex+"&Replyindex="+reindex,
                    contentType : "application/x-www-form-urlencoded", //content-type 설정 (생략가능)
                    success:function(result){
                        console.log(result)
                        let htmlcode= "";
                        if(result.length>0){
                            $.each(result , function(i,v){
                                if(v.mem_id=="<%=loginMember.getMem_id()%>"){
                                    htmlcode +='<li>';
                                    htmlcode +='    <div class="rp-r-wrap">';
                                    htmlcode +='        <div class="rp-r-w-prf">';
                                    htmlcode +='            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                    htmlcode +='        </div>';
                                    htmlcode +='        <div class="rp-r-w-container" data-reindex='+v.reply_index+'>';
                                    htmlcode +='            <div class="rp-r-w-con-warp">';
                                    htmlcode +='                <span class="rp-r-w-nick">'+v.mem_nickname+'</span>';
                                    htmlcode +='                <span class="rp-r-w-con">'+v.reply_con+'</span>';
                                    htmlcode +='            </div>';
                                    htmlcode +='            <div class="rp-r-w-btn-warp">';
                                    htmlcode +='                <a class="btn s-btn re-re-up-btn" data-reindex='+v.reply_index+'>수정</a>';
                                    htmlcode +='                <a class="btn s-btn re-del-btn" data-reindex='+v.reply_index+' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex='+v.reply_index+'">삭제</a>';
                                    htmlcode +='            </div>';
                                    htmlcode +='        </div>';
                                    htmlcode +='    </div>';
                                    htmlcode +='</li>';
                                }else{
                                    htmlcode +='<li>';
                                    htmlcode +='    <div class="rp-r-wrap">';
                                    htmlcode +='        <div class="rp-r-w-prf">';
                                    htmlcode +='            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                    htmlcode +='        </div>';
                                    htmlcode +='        <div class="rp-r-w-container" data-reindex='+v.reply_index+'>';
                                    htmlcode +='            <div class="rp-r-w-con-warp">';
                                    htmlcode +='                <span class="rp-r-w-nick">'+v.mem_nickname+'</span>';
                                    htmlcode +='                <span class="rp-r-w-con">'+v.reply_con+'</span>';
                                    htmlcode +='            </div>';
                                    htmlcode +='            <div class="rp-r-w-btn-warp">';
                                    htmlcode +='                <a class="btn s-btn re-report-btn" href="/report.do?nickname='+v.mem_nickname+'" data-reindex='+v.reply_index+'>신고</a>';
                                    htmlcode +='            </div>';
                                    htmlcode +='        </div>';
                                    htmlcode +='    </div>';
                                    htmlcode +='</li>';
                                }
                            });
                        }
                        $('.a-c-rp[data-index='+postindex+'] .a-c-rp-r ul .rp-r-w-container[data-reindex='+reindex+'] .rp-r-w-reply-warp').append(htmlcode);
                    },
                    dataType : "json"
                });

            });

            //대댓글 수정 폼
            $(document).on("click",".re-re-up-btn",function(){
                $(this).addClass("unvis");

                let postidex = $(this).parents(".a-c-rp-w").data("index");
                let reindex = $(this).data("reindex");
                let con = $(this).parents(".rp-r-w-container").eq(0).find(".rp-r-w-con").html()

                //댓글 내용 가리기
                $(this).parents(".rp-r-w-container").eq(0).find(".rp-r-w-con").css("display","none");

                $(this).parent().parent().children("div").eq(0).append(`
                    <span id="spn\${reindex}">
                        <form action="<%=request.getContextPath() %>/reply/replyreplyUpdate.do" method="post">
                            <input type="text" id="txtindex\${reindex}" name="replyindex" value="\${reindex}" hidden/>
                            <input type="text" id="txtCon\${reindex}" name="replycon" value="\${con}" />
                            <button type="submit" class="rebtnConfirm" data-index="\${postidex}" data-con="\${con}" data-reindex="\${reindex}">확인</button>
                            <button type="button" class="rebtnCancel" data-reindex="\${reindex}">취소</button>
                        </form>
                    </span>
                    `);
            });

            //대댓글(답글) 수정 확인 실행
            $(document).on("click",".rebtnConfirm",function(){
                let reindex = $(this).data("reindex");
                let postindex = $(this).parents(".a-c-rp-w").data("index");
                let replycon = $(this).parents("form").find("input[name=replycon]").val();
                //부모 댓글 확인
                let parentreindex = $(this).parents(".rp-r-w-container").eq(1).data("reindex");

                //대댓글(답글) 가져오기 수정후
                $('form').submit(function(e) {
                    e.preventDefault();
                    $.ajax({
                        type: 'POST',
                        url: '/reply/replyreplyUpdate.do',
                        data: "postindex="+postindex+"&replyindex="+reindex+"&replycon="+replycon+"&parentreindex="+parentreindex,
                        contentType : "application/x-www-form-urlencoded", //content-type 설정 (생략가능)
                        success:function(result){
                            console.log(result)
                            let htmlcode= "";
                            if(result.length>0){
                                $.each(result , function(i,v){
                                    if(v.mem_id=="<%=loginMember.getMem_id()%>"){
                                        htmlcode +='<li>';
                                        htmlcode +='    <div class="rp-r-wrap">';
                                        htmlcode +='        <div class="rp-r-w-prf">';
                                        htmlcode +='            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                        htmlcode +='        </div>';
                                        htmlcode +='        <div class="rp-r-w-container" data-reindex='+v.reply_index+'>';
                                        htmlcode +='            <div class="rp-r-w-con-warp">';
                                        htmlcode +='                <span class="rp-r-w-nick">'+v.mem_nickname+'</span>';
                                        htmlcode +='                <span class="rp-r-w-con">'+v.reply_con+'</span>';
                                        htmlcode +='            </div>';
                                        htmlcode +='            <div class="rp-r-w-btn-warp">';
                                        htmlcode +='                <a class="btn s-btn re-re-up-btn" data-reindex='+v.reply_index+'>수정</a>';
                                        htmlcode +='                <a class="btn s-btn re-del-btn" data-reindex='+v.reply_index+' href="<%=request.getContextPath() %>/reply/replyDelete.do?replyindex='+v.reply_index+'">삭제</a>';
                                        htmlcode +='            </div>';
                                        htmlcode +='        </div>';
                                        htmlcode +='    </div>';
                                        htmlcode +='</li>';
                                    }else{
                                        htmlcode +='<li>';
                                        htmlcode +='    <div class="rp-r-wrap">';
                                        htmlcode +='        <div class="rp-r-w-prf">';
                                        htmlcode +='            <img src="<%=request.getContextPath() %>/upload/demo_logo.png">';
                                        htmlcode +='        </div>';
                                        htmlcode +='        <div class="rp-r-w-container" data-reindex='+v.reply_index+'>';
                                        htmlcode +='            <div class="rp-r-w-con-warp">';
                                        htmlcode +='                <span class="rp-r-w-nick">'+v.mem_nickname+'</span>';
                                        htmlcode +='                <span class="rp-r-w-con">'+v.reply_con+'</span>';
                                        htmlcode +='            </div>';
                                        htmlcode +='            <div class="rp-r-w-btn-warp">';
                                        htmlcode +='                <a class="btn s-btn re-report-btn" href="/report.do?nickname='+v.mem_nickname+'" data-reindex='+v.reply_index+'>신고</a>';
                                        htmlcode +='            </div>';
                                        htmlcode +='        </div>';
                                        htmlcode +='    </div>';
                                        htmlcode +='</li>';
                                    }
                                });
                            }
                            $('.a-c-rp[data-index='+postindex+'] .a-c-rp-r ul .rp-r-w-container[data-reindex='+reindex+']').parents(".rp-r-w-container").find(".rp-r-w-reply-warp").html(htmlcode);

                        },
                        error: function(error) {
                            console.error('댓글 수정 실패:', error);
                        },
                        dataType : "json"
                    });
                });

            });

            $(document).on("click",".rebtnCancel",function(){
                let reindex = $(this).data("reindex");
                $(this).parents(".rp-r-w-con-warp").eq(0).find(".rp-r-w-con").css("display","inline");

                $("#spn"+reindex).remove();
                $(".rp-r-w-btn-warp .re-re-up-btn[data-reindex="+reindex+"]").removeClass("unvis");
            });

            let page = 1; // 현재 페이지 번호
            let loading = false; // 로딩 상태
            let stoploading = false; //더 불러올 데이터 없는지 체크

            function loadData() {
                if (loading) return; // 로딩 중이면 중복 요청 방지
                loading = true;

                $.ajax({
                    url: "/post/postList.do",
                    type: "post",
                    data: { page: page },
                    contentType : "application/x-www-form-urlencoded",
                    dataType : "json",
                    success: function(data) {
                        console.log(data)
                        let htmlcode = "";
                        if(data.length>0){
                            $.each(data, function (i, pl) {
                                htmlcode += '<article class="post-atc">';
                                htmlcode += '    <div class="a-hd">';
                                htmlcode += '        <div class="a-h-prf-pho">';
                                htmlcode += '            <a>';
                                htmlcode += '                <img src="/upload/demo_logo.png">';
                                htmlcode += '                    <span>' + pl.memVo.mem_nickname + '</span>';
                                htmlcode += '            </a>';
                                htmlcode += '        </div>';
                                htmlcode += '';
                                htmlcode += '        <div class="t-stemp">'+pl.post_date+'</div>';
                                htmlcode += '    </div>';
                                htmlcode += '    <div class="a-bd">';
                                htmlcode += '        <div class="a-bd-img">';
                                                if(pl.postPhotoDetailList.length>0){
                                htmlcode += '            <div class="swiper post-photo-swiper">';
                                htmlcode += '                <div class="swiper-wrapper">';
                                                    $.each(pl.postPhotoDetailList , function(i,plphoto) {
                                htmlcode += '                    <div class="swiper-slide">';
                                htmlcode += '                        <img class="post-photo-img" src="/post/postview.do?postphoto='+plphoto.post_photo+'&postphotosn='+plphoto.post_photo_sn+'">';
                                htmlcode += '                    </div>';
                                                    });
                                htmlcode += '                </div>';
                                htmlcode += '                <div class="swiper-button-next"></div>';
                                htmlcode += '                <div class="swiper-button-prev"></div>';
                                htmlcode += '                <div class="swiper-pagination"></div>';
                                htmlcode += '            </div>';
                                                }else {
                                htmlcode += '            <img src="/upload/demo_logo.png">';
                                                }
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="a-bd-btns">';
                                htmlcode += '            <div class="btn-cover">';
                                htmlcode += '            <svg aria-label="좋아요" class="" fill="currentColor" height="24" role="img" viewBox="0 0 24 24" width="24">';
                                htmlcode += '            <title>좋아요</title>';
                                htmlcode += '            <path d="M16.792 3.904A4.989 4.989 0 0 1 21.5 9.122c0 3.072-2.652 4.959-5.197 7.222-2.512 2.243-3.865 3.469-4.303 3.752-.477-.309-2.143-1.823-4.303-3.752C5.141 14.072 2.5 12.167 2.5 9.122a4.989 4.989 0 0 1 4.708-5.218 4.21 4.21 0 0 1 3.675 1.941c.84 1.175.98 1.763 1.12 1.763s.278-.588 1.11-1.766a4.17 4.17 0 0 1 3.679-1.938m0-2a6.04 6.04 0 0 0-4.797 2.127 6.052 6.052 0 0 0-4.787-2.127A6.985 6.985 0 0 0 .5 9.122c0 3.61 2.55 5.827 5.015 7.97.283.246.569.494.853.747l1.027.918a44.998 44.998 0 0 0 3.518 3.018 2 2 0 0 0 2.174 0 45.263 45.263 0 0 0 3.626-3.115l.922-.824c.293-.26.59-.519.885-.774 2.334-2.025 4.98-4.32 4.98-7.94a6.985 6.985 0 0 0-6.708-7.218Z"></path>';
                                htmlcode += '            </svg>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="btn-cover replybtn" data-index='+pl.post_index+'>';
                                htmlcode += '            <svg aria-label="댓글 달기" class="" fill="currentColor" height="24" role="img" viewBox="0 0 24 24" width="24">';
                                htmlcode += '            <title>댓글 달기</title>';
                                htmlcode += '            <path d="M20.656 17.008a9.993 9.993 0 1 0-3.59 3.615L22 22Z" fill="none" stroke="currentColor" stroke-linejoin="round" stroke-width="2"></path>';
                                htmlcode += '            </svg>';
                                htmlcode += '            </div>';
                                //로그인한 회원과 작성자의 아이디가 같을때
                                                    if(pl.mem_id == "<%=loginMember.getMem_id()%>"){
                                htmlcode += '            <div class="btn-cover">';
                                htmlcode += '            <div class="update-btn pointer" data-index='+pl.post_index+'>수정</div>';
                                htmlcode += '            </div>';
                                htmlcode += '            <div class="btn-cover">';
                                htmlcode += '            <div class="delete-btn pointer" data-index='+pl.post_index+'>삭제</div>';
                                htmlcode += '            </div>';
                                                    }else{
                                htmlcode += '            <div class="btn-cover">';
                                htmlcode += '                <a class="report-btn pointer" href="/report.do?nickname='+pl.memVo.mem_nickname+'" data-index='+pl.post_index+'>신고</a>';
                                htmlcode += '            </div>';
                                                    }
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '    <div class="a-con">';
                                htmlcode += '        <div class="a-c-h">';
                                htmlcode += '            <div>해쉬태그</div>';
                                htmlcode += '            <div>프로잭트</div>';
                                htmlcode += '            <div>공부</div>';
                                htmlcode += '            <div>집가고싶다</div>';
                                htmlcode += '        </div>';
                                htmlcode += '        <div class="a-c-bd">'+pl.post_con.replace("\r\n", "<br>").replace("\r", "<br>").replace("\n", "<br>")+'</div>';
                                htmlcode += '        <div class="a-c-rp a-c-rp-w" data-index='+pl.post_index+'>';
                                htmlcode += '            <form action="/reply/replyInsert.do" method="post">';
                                htmlcode += '                <input type="hidden" name="post_index" value="'+pl.post_index+'"/>';
                                htmlcode += '                <input type="hidden" name="mem_id" value="<%=loginMember.getMem_id()%>"/>';
                                htmlcode += '                <input type="text" placeholder="댓글을 입력하세요" name="reply_con"/>';
                                htmlcode += '                <input type="submit" value="댓글달기">';
                                htmlcode += '            </form>';
                                htmlcode += '            <div class="a-c-rp-r">';
                                htmlcode += '                <ul>';
                                htmlcode += '                </ul>';
                                htmlcode += '            </div>';
                                htmlcode += '        </div>';
                                htmlcode += '    </div>';
                                htmlcode += '</article>';
                            });

                        }else{
                            stoploading = true;
                            htmlcode +='<article>데이터가 없습니다.</article>';

                        }

                        $(".post-atcwrap").append(htmlcode)
                        setseiper();
                        page++; // 페이지 번호 증가
                        loading = false;
                    },
                    error: function() {
                        alert("데이터 로드 실패!");
                        loading = false;
                    }
                });
            }

            // 초기 데이터 로드 (3개)
            loadData();

            // 스크롤 이벤트 처리
            $(window).scroll(function() {
                if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
                    // 스크롤이 거의 끝까지 내려왔을 때 추가 데이터 로드
                    if(stoploading != true) {
                        loadData();
                    }
                }
            });

            $('.post-ipt').on('change', function(e) {
                const files = e.target.files; // 선택된 파일 목록 가져오기

                if (files && files.length > 0) {
                    for (let i = 0; i < files.length; i++) {
                        const file = files[i];

                        // 파일 타입 검사 (이미지 파일인지 확인)
                        if (file.type.startsWith('image/')) {
                            // 이미지 파일 처리 로직
                            console.log('선택된 이미지 파일:', file.name);

                            // 추가적인 이미지 처리 (미리보기, 업로드 등)
                            const reader = new FileReader();
                            reader.onload = function(event) {
                                // 이미지 미리보기 예시
                                const img = $('<img>').attr('src', event.target.result).width(100);
                                $('.modal-l').append(img);
                            };
                            reader.readAsDataURL(file);
                        } else {
                            console.log('이미지 파일이 아닙니다:', file.name);
                            // 이미지 파일이 아닌 경우 처리 로직
                        }
                    }
                }
            });
        });//제이쿼리 끝
    </script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/swiper-11.2.5.css" />
    <style>
        *{padding: 0;margin: 0;}
        body{position: relative; margin-top: 70px;}
        .pointer{cursor: pointer}

        /*공통으로 사용할만한것(s)*/
        .modal{display: none;width: 100%; height: 100%; position: fixed; top: 0; left: 0; background: rgba(0, 0, 0, 0.5); }
        .modal-i-warp{position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; width: 1000px; height: auto;}
        .modal.view{display: block}
        /*버튼(s)*/
        .btn-cover{cursor: pointer;}
        .btn{cursor: pointer; background-color: #E20707; color: #ffffff; display: flex;align-items: center;justify-content: center;border-radius: 10px;font-style: normal;font-weight: 500;font-size: 18px;width: calc(50% - 5px);height: 50px;border: 1px solid #D9D9D9; transition: all 0.2s ease-in;}
        .btn:hover{background-color: #ffffff;  color: #E20707; border: 1px solid #D9D9D9; transition: all 0.2s ease-in;}
        a.btn {text-decoration: none}
        .btn_2th{display: flex}
        .btn.s-btn{width: 40px;height: 30px;padding: 0;display: flex;justify-content: center;align-items: center;}
        /*버튼(e)*/

        .t-r-btn{position: absolute; top: 0;right: 0;}

        /*토글 스위치(s)*/
        .toggleSwitch {width: 50px;height: 20px;display: block;position: relative;border-radius: 30px;background-color: #fff;box-shadow: 0 0 16px 3px rgba(0 0 0 / 15%);cursor: pointer;margin: 10px;}
        .toggleSwitch .toggleButton {width: 16px;height: 16px;position: absolute;top: 50%;left: 4px;transform: translateY(-50%);border-radius: 50%;background: #f03d3d;}
        #inserttoggles:checked ~ .toggleSwitch {background: #f03d3d;}
        #inserttoggles:checked ~ .toggleSwitch .toggleButton {left: calc(100% - 18px);background: #fff;}
        #updatetoggles:checked ~ .toggleSwitch {background: #f03d3d;}
        #updatetoggles:checked ~ .toggleSwitch .toggleButton {left: calc(100% - 18px);background: #fff;}
        .toggleSwitch, .toggleButton {transition: all 0.2s ease-in;}

        /*토글 스위치(e)*/

        .post-ipt{width: 100%;display: block;height: 100px;background: green;opacity: 100%;overflow: hidden;
            position: absolute;
            top: 0;
            left: 0;
            z-index: -1;

        }
        .modal-body{display: flex;width: 100%;}
        .modal-l{position: relative; width: 50%;}
        .modal-r{width: 50%;}

        /*공통으로 사용할만한것(e)*/

        .prof-ph{width: 100px; border-radius: 50%;}

        .post_write_btn{position: fixed; bottom: 80px; right: 20px; width: 100px;}

        table th{ width: 15px;}

        .post-atc{position: relative; border: 20px solid rgb(144 233 159);}
        .post-atc{width: 500px; margin: 0 auto;}
        .a-hd{display: flex ;align-items: center;justify-content: space-between;}
        .a-h-prf-pho a img{border-radius: 20px; width: 23px;}
        .a-bd{position: relative;height: 400px;}
        .a-bd .a-bd-img{text-align: center;}
        .a-bd .a-bd-btns{z-index: 1; background-color: rgba(0, 0, 0, 0.5);text-align: center;display: flex;justify-content: flex-end;gap: 20px;position: absolute;bottom: 0;right: 0;}
        .a-con{}
        .a-c-h{display: flex;flex-wrap: wrap;justify-content: flex-start;}
        .a-c-h > div{margin: 0 5px 10px;padding: 6px 8px 7px;border-radius: 4px;font-size: 12px;line-height: 12px;letter-spacing: -0.2px;border-width: 2px;--border-opacity: 1;border-color: #bfbfbf;--text-opacity: 1;color: #9f9f9f;cursor: pointer;border: 2px solid;}
        .a-c-h > div:hover{--bg-opacity: 1;background-color: #ebebeb;--text-opacity: 1;color: #333;color: rgba(51, 51, 51, var(--text-opacity));}
        .a-c-bd{width: auto;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;overflow: hidden;}
        .a-c-bd.view{display: block;}
        .a-c-rp{overflow: hidden;height: 0;}
        .a-c-rp.view{height:auto;}

        .a-c-rp-r ul li{padding: 8px 10px;}
        .rp-r-wrap{display: flex; position: relative;}
        .rp-r-wrap .rp-r-w-prf{border-radius: 20px;width: 23px;min-width: 23px;margin-right: 10px;}
        .rp-r-wrap .rp-r-w-prf > img{width: 100%;}
        .rp-r-wrap .rp-r-w-container{}
        .rp-r-wrap .rp-r-w-container .rp-r-w-con-warp{margin-bottom: 10px;}

        .rp-r-wrap .rp-r-w-con-warp{}
        .rp-r-wrap .rp-r-w-nick{}
        .rp-r-wrap .rp-r-w-con{}

        /*수정된 글*/
        .modicheck{}

        .rp-r-w-btn-warp{display: flex; gap: 12px;}

        .unvis{display: none !important;}
        .post-photo-img{max-width: 100%}

        /*슬리이드 스와이퍼 css(s)*/
        .swiper {width: 100%;height: 100%;}
        .swiper-slide {text-align: center;font-size: 18px;background: #fff;display: flex;justify-content: center;align-items: center;}
        .swiper-slide img {display: block;width: 100%;height: 100%;object-fit: contain;}
        /*슬리이드 스와이퍼 css(e)*/
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/view/common/gnb.jsp" />
<div>
    <% if (loginMember != null) { %>
    계정ID : <span><%=loginMember.getMem_id()%></span>
    <% } else { %>
    <span>로그인 정보가 없습니다.</span>
    <% } %>
</div>
    <div class="post-atcwrap">
    </div>

<div class="post_write_btn btn">글 쓰기</div>


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
<div class="post-insert-modal modal">
    <div class="modal-i-warp">
        <form action="<%=request.getContextPath() %>/post/insertpost.do" method="post" enctype="multipart/form-data">
            <div class="modal-body">
                <div class="modal-l">
                    <input type="file" class="post-ipt" multiple="multiple" name="postphoto"/>
                </div>
                <div class="modal-r">
                    <div>
                        프로필이 올자리 입니당
                        <input type="text" name="postwriter" value="<%=loginMember.getMem_id()%>" hidden="hidden">

                        <div>
                            <textarea name="postcon"></textarea>
                        </div>

                    </div>
                    <div class="toggleSwitch-warp">
                        <input type="checkbox" name="postvis" id="inserttoggles" value="Y" />
                        <label for="inserttoggles" class="toggleSwitch">
                            <span class="toggleButton"></span>
                        </label>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <div class="btn_2th">
                    <a href="javascript:void(0);" class="btn close-btn">닫기</a>
                    <%--                        <a href="<%=request.getContextPath() %>/post/insertpost.do" class="btn">등록하기</a>--%>
                    <input type="submit" class="btn" value="등록하기">

                </div>
            </div>
        </form>
    </div>
</div>
<div class="post-delete-modal modal">
    <div class="modal-i-warp">
        <form action="<%=request.getContextPath() %>/post/deletepost.do">
            <div>
                <input type="text" name="postindex"/>
                정말로 게시물을 삭제하시겠습니까???<br>
                <span>* 삭제후 되돌릴수 없습니다.</span>
            </div>
            <div class="btn_2th">
                <div class="btn close-btn">N</div>
                <input type="submit" class="btn" value="Y">
            </div>
        </form>
    </div>
</div>

<script src="<%=request.getContextPath() %>/js/swiper-11.2.5.js"></script>
<script>
    function setseiper(){
        var swiper = new Swiper(".post-photo-swiper", {
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

</script>
</body>
</html>
