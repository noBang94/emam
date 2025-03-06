package kr.or.ddit.emam.reply.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.reply.service.IReplyService;
import kr.or.ddit.emam.reply.service.ReplyServiceImpl;
import kr.or.ddit.emam.vo.ReplyVO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/reply/replyreplyUpdate.do")
public class Replyreplyupdate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        //게시글 인덱스
        String postindex = req.getParameter("postindex");
        int postindexInt = Integer.parseInt(postindex);
        
        //뎃글 인덱스
        String reindex = req.getParameter("replyindex");
        int replyindexInt = Integer.parseInt(reindex);

        //부모 댓글 인덱스
        String parentreindex = req.getParameter("parentreindex");
        int parentreindexInt = Integer.parseInt(parentreindex);

        //수정될 뎃글 내용
        String Replycon = req.getParameter("replycon");

        //댓글 객체 생성
        IReplyService replyService = ReplyServiceImpl.getInstance();

        ReplyVO replyVO = new ReplyVO(replyindexInt,Replycon);

        int cnt = replyService.updateReply(replyVO);


        if (cnt > 0) {
            ReplyVO replyVO2 = new ReplyVO(parentreindexInt,postindexInt);
            List<ReplyVO> ReplyList = replyService.selectReplyReplyList(replyVO2);

            Gson gson = new Gson();
            String jsonData = null; //변환된 Json문자열이 저장될 변수

            jsonData = gson.toJson(ReplyList);

            PrintWriter out = resp.getWriter();
            out.write(jsonData);
            resp.flushBuffer();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
