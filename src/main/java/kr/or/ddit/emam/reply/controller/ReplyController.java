package kr.or.ddit.emam.reply.controller;

import kr.or.ddit.emam.reply.service.IReplyService;
import kr.or.ddit.emam.reply.service.ReplyServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.ReplyVO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/reply/replyInsert.do", "/reply/replyUpdate.do"})
public class ReplyController extends HttpServlet {

    private static ReplyController instance; // 싱글톤 instance
    private IReplyService replyService; // 서비스 인터페이스

    private ReplyController() {} // private 생성자

    public static ReplyController getInstance() { // 싱글톤 instance 반환 메소드
        if (instance == null) {
            instance = new ReplyController();
        }
        return instance;
    }


    @Override
    public void init() throws ServletException {
        super.init();
        replyService = ReplyServiceImpl.getInstance(); // ReplyServiceImpl 싱글톤 instance 획득
        System.out.println("ReplyController: init() 호출 및 ReplyServiceImpl 싱글톤 획득"); // 로그 추가
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.endsWith("/replyInsert.do")) {
            replyInsert(req, resp);
        } else if (uri.endsWith("/replyUpdate.do")) {
            replyUpdate(req, resp);
        }
    }

    private void replyInsert(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int post_index = Integer.parseInt(req.getParameter("post_index"));
        String replyCon = req.getParameter("reply");
        HttpSession session = req.getSession();
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        ReplyVO replyVO = new ReplyVO();
        replyVO.setPost_index(post_index);
        replyVO.setReply_con(replyCon);
        replyVO.setMem_id(loginMember.getMem_id());
        replyVO.setReply_parentreplyindex(null);

        int insertCnt = replyService.insertReply(replyVO); // replyService 싱글톤 instance 사용

        if (insertCnt > 0) {
            resp.sendRedirect(req.getContextPath() + "/post/postlist.do");
        } else {
            resp.sendRedirect(req.getContextPath() + "/post/postlist.do?error=replyInsertFail");
        }
    }

    private void replyUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int reply_index = Integer.parseInt(req.getParameter("reply_index"));
        String replyCon = req.getParameter("reply_con");

        ReplyVO replyVO = new ReplyVO();
        replyVO.setReply_index(reply_index);
        replyVO.setReply_con(replyCon);

        int updateCnt = replyService.updateReply(replyVO); // replyService 싱글톤 instance 사용

        if (updateCnt > 0) {
            resp.sendRedirect(req.getContextPath() + "/post/postlist.do");
        } else {
            resp.sendRedirect(req.getContextPath() + "/post/postlist.do?error=replyUpdateFail");
        }
    }
}