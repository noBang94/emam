<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.emam.vo.PostVO" %>
<%@ page import="kr.or.ddit.emam.vo.MemberVO" %>
<%@ page import="kr.or.ddit.emam.vo.PostPhotoVO" %>
<%@ page import="kr.or.ddit.emam.vo.PostPhotoDetailVO" %><%--
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

%>

<html>
<head>
    <title>게시판 이에요잉</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
    <script>
        $(function (){
            //게시글 작성 버튼클릭시
            $(".post_write_btn").on('click', function(){
                $(".post-insert-modal").toggleClass("view");
            });

            //모달 닫기 클릭
            $(".close-btn").on('click', function(){
                $(".modal").removeClass("view");
            });

            $(".modal").on('click', function(e){
                if(!$(e.target).closest('.modal-i-warp').length) {
                    $(this).removeClass("view");
                }
            });

            //게시글 수정버튼클릭시
            $(".update-btn").on('click', function(){
                $(".post-update-modal").toggleClass("view");
                let postindex = $(this).data("index");

                $.ajax({
                    url:"/post/postDetailAjax.do",
                    type:"post",
                    data:"postindex="+postindex,
                    contentType : "application/x-www-form-urlencoded", //content-type 설정 (생략가능)
                    success:function(result){

                        $('.post-update-modal input[name=postindex]').val(result.post_index);
                        $('.post-update-modal input[name=postwriter]').val(result.mem_id);
                        $('.post-update-modal textarea[name=postcon]').val(result.post_con);

                        if(result.post_visible=="Y"){
                            $("#updatetoggles").prop("checked",true);
                        }else{
                            $("#updatetoggles").prop("checked",false);
                        }
                    }
                });

            });

            //게시글 삭제 클릭시
            $(".delete-btn").on('click', function(){
                $(".post-delete-modal").toggleClass("view");
                let postindex = $(this).data("index")
                $('.post-delete-modal input[name=postindex]').val(postindex);
            });

        });//제이쿼리 끝
    </script>
    <style>
        *{padding: 0;margin: 0;}
        body{position: relative; margin-top: 70px;}
        .pointer{cursor: pointer}

        /*공통으로 사용할만한것(s)*/
        .modal{display: none;width: 100%; height: 100%; position: fixed; top: 0; left: 0; background: rgba(0, 0, 0, 0.5); }
        .modal-i-warp{position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; width: 1000px; height: auto;}
        .modal.view{display: block}
        /*버튼(s)*/
        .btn{cursor: pointer; background-color: #E20707; color: #ffffff; display: flex;align-items: center;justify-content: center;border-radius: 10px;font-style: normal;font-weight: 500;font-size: 18px;width: calc(50% - 5px);height: 50px;border: 1px solid #D9D9D9; transition: all 0.2s ease-in;}
        .btn:hover{background-color: #ffffff;  color: #E20707; border: 1px solid #D9D9D9; transition: all 0.2s ease-in;}
        a.btn {text-decoration: none}
        .btn_2th{display: flex}
        /*버튼(e)*/

        /*토글 스위치(s)*/
        .toggleSwitch {width: 50px;height: 20px;display: block;position: relative;border-radius: 30px;background-color: #fff;box-shadow: 0 0 16px 3px rgba(0 0 0 / 15%);cursor: pointer;margin: 10px;}
        .toggleSwitch .toggleButton {width: 16px;height: 16px;position: absolute;top: 50%;left: 4px;transform: translateY(-50%);border-radius: 50%;background: #f03d3d;}
        #inserttoggles:checked ~ .toggleSwitch {background: #f03d3d;}
        #inserttoggles:checked ~ .toggleSwitch .toggleButton {left: calc(100% - 18px);background: #fff;}
        #updatetoggles:checked ~ .toggleSwitch {background: #f03d3d;}
        #updatetoggles:checked ~ .toggleSwitch .toggleButton {left: calc(100% - 18px);background: #fff;}
        .toggleSwitch, .toggleButton {transition: all 0.2s ease-in;}

        /*토글 스위치(e)*/

        .post-ipt{width: 100%;display: block;height: 100px;background: green;}
        .modal-body{display: flex;width: 100%;}
        .modal-l{width: 50%;}
        .modal-r{width: 50%;}

        /*공통으로 사용할만한것(e)*/

        .prof-ph{width: 100px; border-radius: 50%;}

        .post_write_btn{position: fixed; bottom: 80px; right: 20px; width: 100px;}

        table th{ width: 15px;}

        .post-atc{position: relative; border: 20px solid rgb(201 156 24);}
        .post-atc{width: 500px; margin: 0 auto;}
        .a-hd{display: flex ;
            align-items: center;
            justify-content: space-between;}
        .a-h-prf-pho a img{border-radius: 20px; width: 23px;}
        .a-bd{position: relative;}
        .a-bd .a-bd-img{text-align: center;}
        .a-bd .a-bd-btns{background-color: rgba(0, 0, 0, 0.5);
            text-align: center;
            display: flex;
            justify-content: flex-end;
            gap: 20px;
            position: absolute;
            bottom: 0;
            right: 0;}
        .a-con{}
        .a-c-h{
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
        }
        .a-c-h > div{
            margin: 0 5px 10px;
            padding: 6px 8px 7px;
            border-radius: 4px;
            font-size: 12px;
            line-height: 12px;
            letter-spacing: -.2px;
            border-width: 2px;
            --border-opacity: 1;
            border-color: #bfbfbf;
            --text-opacity: 1;
            color: #9f9f9f;
            cursor: pointer;
            border: 2px solid;
        }
        .a-c-h > div:hover{
            --bg-opacity: 1;
            background-color: #ebebeb;
            --text-opacity: 1;
            color: #333;
            color: rgba(51, 51, 51, var(--text-opacity));
        }
        .a-c-bd{width: auto;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;}

        .rp-r-wrap{display: flex;}
        .rp-r-wrap .rp-r-w-prf{border-radius: 20px;
            width: 23px;
            margin-right: 10px;
        }
        .rp-r-wrap .rp-r-w-prf > img{width: 100%;}
        .rp-r-wrap .rp-r-w-con{width: auto;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;}
    </style>
</head>
<body>
<div>
    <% if (loginMember != null) { %>
    계정ID : <span><%=loginMember.getMem_id()%></span>
    <% } else { %>
    <span>로그인 정보가 없습니다.</span>
    <% } %>
</div>
    <div class="post-atcwrap">
        <%
            int pz = postList.size();
            if(pz == 0){
                System.out.println("siiiiiiiiii");
        %>
        <article>
            데이터가 없습니다.
        </article>
        <%
        }else{
            for(PostVO p : postList){
                System.out.println(p);

        %>
        <article class="post-atc">
            <div class="a-hd">
                <div class="a-h-prf-pho">
                    <a>
                        <img src="<%=request.getContextPath() %>/upload/demo_logo.png">
                        <span><%=p.getMemVo().getMem_nickname() %></span>
                    </a>
                </div>

                <div class="t-stemp"><%=p.getPost_date() %></div>
            </div>
            <div class="a-bd">
                <div class="a-bd-img"><img src="<%=request.getContextPath() %>/upload/demo_logo.png"></div>
                <div class="a-bd-btns">
                    <div class="btn-cover">
                        <svg aria-label="좋아요" class="" fill="currentColor" height="24" role="img" viewBox="0 0 24 24" width="24">
                            <title>좋아요</title>
                            <path d="M16.792 3.904A4.989 4.989 0 0 1 21.5 9.122c0 3.072-2.652 4.959-5.197 7.222-2.512 2.243-3.865 3.469-4.303 3.752-.477-.309-2.143-1.823-4.303-3.752C5.141 14.072 2.5 12.167 2.5 9.122a4.989 4.989 0 0 1 4.708-5.218 4.21 4.21 0 0 1 3.675 1.941c.84 1.175.98 1.763 1.12 1.763s.278-.588 1.11-1.766a4.17 4.17 0 0 1 3.679-1.938m0-2a6.04 6.04 0 0 0-4.797 2.127 6.052 6.052 0 0 0-4.787-2.127A6.985 6.985 0 0 0 .5 9.122c0 3.61 2.55 5.827 5.015 7.97.283.246.569.494.853.747l1.027.918a44.998 44.998 0 0 0 3.518 3.018 2 2 0 0 0 2.174 0 45.263 45.263 0 0 0 3.626-3.115l.922-.824c.293-.26.59-.519.885-.774 2.334-2.025 4.98-4.32 4.98-7.94a6.985 6.985 0 0 0-6.708-7.218Z"></path>
                        </svg>
                    </div>
                    <div class="btn-cover">
                        <svg aria-label="댓글 달기" class="" fill="currentColor" height="24" role="img" viewBox="0 0 24 24" width="24">
                            <title>댓글 달기</title>
                            <path d="M20.656 17.008a9.993 9.993 0 1 0-3.59 3.615L22 22Z" fill="none" stroke="currentColor" stroke-linejoin="round" stroke-width="2"></path>
                        </svg>
                    </div>
                    <div class="btn-cover">
                        <div class="update-btn pointer" data-index="<%=p.getPost_index() %>">수정</div>
                    </div>
                    <div class="btn-cover">
                        <div class="delete-btn pointer" data-index="<%=p.getPost_index() %>">삭제</div>
                    </div>
                </div>
            </div>
            <div class="a-con">
                <div class="a-c-h">
                    <div>해쉬태그</div>
                    <div>프로잭트</div>
                    <div>공부</div>
                    <div>집가고싶다</div>
                </div>

                <div class="a-c-bd"><%=p.getPost_con() %></div>
                <div class="a-c-rp a-c-rp-w">
                    <form action="/reply/replyInsert.do" method="post">
                        <input type="hidden" name="post_index" value=""/> <%-- 게시글 번호 전달 --%>
                        <input type="text" placeholder="댓글을 입력하세요" name="reply"/> <%-- textarea 대신 input type=text 사용 --%>
                        <input type="submit" value="댓글달기">
                    </form>
                </div>
                <div class="a-c-rp-r">
                    <ul>
                        <li>
                            <div class="rp-r-wrap">
                                <div class="rp-r-w-prf"><img src="<%=request.getContextPath() %>/upload/demo_logo.png"></div>
                                <div class="rp-r-w-con">테스트 댓글 내용입니다요이이이잉</div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </article>
        <%
                }
            }
        %>
    </div>
<div class="post_write_btn btn">글 쓰기</div>
<div class="post-update-modal modal">
    <div class="modal-i-warp">
        <form action="<%=request.getContextPath() %>/post/updatepost.do" method="post" enctype="multipart/form-data">
            <div class="modal-body">
                <div class="modal-l">
                    <input type="file" class="post-ipt" multiple="multiple" name="postphoto"/>
                </div>
                <div class="modal-r">
                    <div>
                        프로필이 올자리 입니당
                        <input type="text" name="postindex"/>
                        <input type="text" name="postwriter" placeholder="임시 작성자 인풋 있는 사용자만 됨" />

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
                    <%--                        <a href="<%=request.getContextPath() %>/post/insertpost.do" class="btn">등록하기</a>--%>
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
                        <input type="text" name="postwriter" placeholder="임시 작성자 인풋 있는 사용자만 됨">

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

</body>
</html>
