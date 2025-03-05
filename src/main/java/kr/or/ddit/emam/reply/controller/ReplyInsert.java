package kr.or.ddit.emam.reply.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.post.service.IPostService;
import kr.or.ddit.emam.post.service.PostServiceImpl;
import kr.or.ddit.emam.reply.service.IReplyService;
import kr.or.ddit.emam.reply.service.ReplyServiceImpl;
import kr.or.ddit.emam.vo.ReplyVO;

import java.io.IOException;

@WebServlet("/reply/replyInsert.do")
public class ReplyInsert extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        //게시글 인덱스 가져오기
        String postindex = req.getParameter("post_index");
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
        String memid = req.getParameter("mem_id");
        //댓글 내용
        String replycon = req.getParameter("reply_con");

        //댓글 객체 생성
        IReplyService replyService = ReplyServiceImpl.getInstance();

        ReplyVO replyVO = new ReplyVO(postindexInt,replyindexInt,memid,replycon);

        int cnt = replyService.insertReply(replyVO);
        if (cnt > 0) {
            resp.sendRedirect(req.getContextPath() + "/post/postList.do");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
