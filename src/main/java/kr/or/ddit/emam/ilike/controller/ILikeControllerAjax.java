package kr.or.ddit.emam.ilike.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.ilike.service.ILikeService;
import kr.or.ddit.emam.ilike.service.LikeServiceImpl;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.notification.service.INotificationService;
import kr.or.ddit.emam.notification.service.NotificationServiceImpl;
import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.post.service.PostServiceImpl;
import kr.or.ddit.emam.usersettings.service.IUsersettingsService;
import kr.or.ddit.emam.usersettings.service.UsersettingsServiceImpl;
import kr.or.ddit.emam.vo.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/setilike.do")
public class ILikeControllerAjax extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=utf-8");

        String postindex = req.getParameter("postindex");
        int postindexInt = Integer.parseInt(postindex);
        String memid = req.getParameter("memid");
        ILikeService Service = LikeServiceImpl.getInstance();

        ILikeVO lv = new ILikeVO(postindexInt,memid);

        int cnt = Service.likeCheck(lv);
        //좋아요 체크
        boolean liked = false;

        INotificationService notificationService = NotificationServiceImpl.getInstance();
        //알림1 - 좋아요한 포스트의 작성자ID 구하기 위한 service
        IPostService postService = PostServiceImpl.getInstance();
        PostVO postVo = postService.getPost(postindexInt);
        if(cnt>0){
            //체크한 적이 있으면 체크 취소
            Service.deleteILike(lv);
            liked = false;
            //해당 좋아요에 대한 알림 삭제
            //알림1 - 해당 알림index 찾기
            if(!memid.equals(postVo.getMem_id())) { //좋아요한 사용자와 포스트의 작성자가 다를 경우에만 알림 발생
                NotificationVO notificationVo = new NotificationVO();
                notificationVo.setNotification_fromId(memid);
                notificationVo.setNotification_target(postindexInt);
                notificationVo.setNotification_type("ilike");
                int notiIndex = notificationService.selectIlikeNotification(notificationVo);
                notificationService.deleteNotification(notiIndex);
            }
        }else{
            Service.insertILike(lv);
            liked = true;
            //해당 좋아요에 대한 알림 발생
            if(!memid.equals(postVo.getMem_id())) { //좋아요한 사용자와 포스트의 작성자가 다를 경우에만 알림 발생
                //알림2 - 좋아요한 사용자의 닉네임을 구하기 위한 service
                IMemberService memberService = MemberServiceImpl.getInstance();
                MemberVO memberVo = memberService.getMember(memid);
                //알림3 - 알림vo에 내용 넣기
                NotificationVO notificationVo = new NotificationVO();
                notificationVo.setNotification_toId(postVo.getMem_id());
                notificationVo.setNotification_fromId(memid);
                notificationVo.setNotification_target(postindexInt);
                notificationVo.setNotification_type("ilike");
                int conSize = postVo.getPost_con().length();
                String notificationContent = "";
                if(conSize>=10) {
                    notificationContent = memberVo.getMem_nickname() + "님이 " + postVo.getPost_con().substring(0, 10) + "... 게시글을 마음에 들어합니다.";
                }else {
                    notificationContent = memberVo.getMem_nickname() + "님이 " + postVo.getPost_con() + " 게시글을 마음에 들어합니다.";
                }
                notificationVo.setNotification_con(notificationContent);
                //신청 받는 유저의 유저세팅 확인
                IUsersettingsService usersettingsService = UsersettingsServiceImpl.getInstance();
                UsersettingsVO usersettingsVo = new UsersettingsVO();
                usersettingsVo = usersettingsService.checkUsersettings(postVo.getMem_id());
                if(usersettingsVo.getSet_ilike() == 1){
                    notificationVo.setNotification_isread(0);
                }else{
                    notificationVo.setNotification_isread(1);
                }
                notificationService.insertNotification(notificationVo);
            }
        }
        Gson gson = new Gson();
        String jsonData = null;

        jsonData = gson.toJson(liked);

        PrintWriter out = resp.getWriter();
        out.write(jsonData);
        resp.flushBuffer();
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //게시글 가져올때
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=utf-8");
        String postindex = req.getParameter("postindex");
        int postindexInt = Integer.parseInt(postindex);
        String memid = req.getParameter("memid");
        ILikeService Service = LikeServiceImpl.getInstance();

        ILikeVO lv = new ILikeVO(postindexInt,memid);
        int cnt = Service.likeCheck(lv);
        boolean liked = false;
        if(cnt>0){
            liked = true;
        }else {
            liked = false;
        }
        Gson gson = new Gson();
        String jsonData = null;
        jsonData = gson.toJson(liked);

        PrintWriter out = resp.getWriter();
        out.write(jsonData);
        resp.flushBuffer();
    }
}
