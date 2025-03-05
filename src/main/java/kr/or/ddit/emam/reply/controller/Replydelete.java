package kr.or.ddit.emam.reply.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.reply.service.IReplyService;
import kr.or.ddit.emam.reply.service.ReplyServiceImpl;
import kr.or.ddit.emam.vo.ReplyVO;

import java.io.IOException;

@WebServlet("/reply/replyDelete.do")
public class Replydelete extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        //뎃글 인덱스
        String Replyindex = req.getParameter("replyindex");
        int ReplyindexInt = Integer.parseInt(Replyindex);

        //댓글 객체 생성
        IReplyService replyService = ReplyServiceImpl.getInstance();

        int cnt = replyService.deleteReply(ReplyindexInt);
        if (cnt > 0) {
            resp.sendRedirect(req.getContextPath() + "/post/postList.do");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
