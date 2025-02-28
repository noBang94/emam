package kr.or.ddit.emam.reply.controller;

import kr.or.ddit.emam.reply.service.IReplyService; // import 변경: ReplyService -> IReplyService
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

/**
 *  순수 서블릿 환경에서 게시판 댓글 기능을 처리하는 컨트롤러 서블릿 클래스
 *  스프링 프레임워크를 사용하지 않고, 서블릿 API와 JSP, MyBatis를 이용하여 구현됨
 */
@WebServlet(urlPatterns = {"/reply/replyInsert.do", "/reply/replyUpdate.do"})
public class ReplyController extends HttpServlet {

    private IReplyService replyService; // 필드 타입 변경: ReplyService -> IReplyService

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.endsWith("/replyInsert.do")) {
            replyInsert(req, resp);
        } else if (uri.endsWith("/replyUpdate.do")) {
            replyUpdate(req, resp);
        }
    }

    private void replyUpdate(HttpServletRequest req, HttpServletResponse resp) {
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

        int insertCnt = replyService.insertReply(replyVO);

        if (insertCnt > 0) {
            resp.sendRedirect(req.getContextPath() + "/post/postlist.do");
        } else {
            resp.sendRedirect(req.getContextPath() + "/post/postlist.do?error=replyInsertFail");


            }
        }
        }