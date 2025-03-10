package kr.or.ddit.emam.reply.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.profile.service.IProfileService;
import kr.or.ddit.emam.profile.service.ProfileServiceImpl;
import kr.or.ddit.emam.reply.service.IReplyService;
import kr.or.ddit.emam.reply.service.ReplyServiceImpl;
import kr.or.ddit.emam.vo.ProfileVO;
import kr.or.ddit.emam.vo.ReplyVO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/reply/replyreplyInsert.do")
public class ReplyreplyInsert extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        IProfileService profileService = ProfileServiceImpl.getInstance();
        //댓글 객체 생성
        IReplyService replyService = ReplyServiceImpl.getInstance();

        //게시글 인덱스 가져오기
//        String postindex = req.getParameter("post_index");
        String postindex = req.getParameter("postindex");
        int postindexInt = Integer.parseInt(postindex);

        //대댓글일때 상위 댓글 인덱스번호 가져오기
        String reply_parentreplyindex = req.getParameter("Replyindex");
        int replyindexInt = 0;
        if (reply_parentreplyindex == null || reply_parentreplyindex.equals("")){
            replyindexInt = 0;
        }else {
            replyindexInt = Integer.parseInt(reply_parentreplyindex);
        }

        //댓글 작성자 가져오기
        String memid = req.getParameter("memid");
        //댓글 내용
        String replycon = req.getParameter("replycon");

        ReplyVO replyVO = new ReplyVO(postindexInt,replyindexInt,memid,replycon);

        int cnt = replyService.insertReply(replyVO);
        if (cnt > 0) {
//            resp.sendRedirect(req.getContextPath() + "/post/postList.do");
            ReplyVO replyVO2 = new ReplyVO(replyindexInt,postindexInt);

            List<ReplyVO> ReplyList = replyService.selectReplyReplyList(replyVO2);
            for(ReplyVO replyVO3 : ReplyList){
                ProfileVO pfVO = profileService.selectProfile(replyVO3.getMem_id());
                replyVO3.setProfileVo(pfVO);
            }
            Gson gson = new Gson();
            String jsonData = null; //변환된 Json문자열이 저장될 변수

            jsonData = gson.toJson(ReplyList);

            PrintWriter out = resp.getWriter();
            out.write(jsonData);
            resp.flushBuffer();
        }else{
            System.out.println("댓글작성에러");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
