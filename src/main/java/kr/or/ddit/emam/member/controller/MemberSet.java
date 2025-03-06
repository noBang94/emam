package kr.or.ddit.emam.member.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/member/memberset.do")
public class MemberSet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/member/memberSet.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");

        MemberVO loginMember = (MemberVO) request.getSession().getAttribute("loginMember");
        String memId = (loginMember != null) ? loginMember.getMem_id() : null;

        if(memId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // 클라이언트 요청에 따라 회원 정보 조회, 업데이트, 비밀번호 변경
        String action = request.getParameter("action");

        if ("getMemberInfo".equals(action)) {
            getMemberInfo(request, response, memId);
        } else if ("updateMember".equals(action)) {
            updateMember(request, response, memId);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, memId);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void getMemberInfo(HttpServletRequest request, HttpServletResponse response, String memId) throws IOException {
        if (memId != null) {
            IMemberService service = MemberServiceImpl.getInstance();
            MemberVO member = service.getMember(memId);

            if (member != null) {
                Gson gson = new Gson();
                String json = gson.toJson(member);

                PrintWriter out = response.getWriter();
                out.write(json);
                response.flushBuffer();
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }

    private void updateMember(HttpServletRequest request, HttpServletResponse response, String memId) throws IOException {
        try {
            // 클라이언트로부터 전송된 데이터 가져오기
            String memNickname = request.getParameter("mem_nickname");
            String memAddr = request.getParameter("mem_addr");
            String memPhone = request.getParameter("mem_phone");

            // MemberVO에 데이터 설정
            MemberVO member = new MemberVO();
            member.setMem_id(memId);
            member.setMem_nickname(memNickname);
            member.setMem_addr(memAddr);
            member.setMem_phone(memPhone);

            // 회원 정보 업데이트
            IMemberService service = MemberServiceImpl.getInstance();
            int result = service.updateMember(member);

            // 업데이트 결과 JSON 응답
            Gson gson = new Gson();
            String json = (result > 0) ? "{\"flag\": \"success\"}" : "{\"flag\": \"fail\"}";

            PrintWriter out = response.getWriter();
            out.write(json);
            response.flushBuffer();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response, String memId) throws IOException {
        try {
            String newPassword = request.getParameter("mem_pw");

            MemberVO member = new MemberVO();
            member.setMem_id(memId);
            member.setMem_pw(newPassword);

            IMemberService service = MemberServiceImpl.getInstance();
            int result = service.updatePassword(member);

            Gson gson = new Gson();
            String json = (result > 0) ? "{\"flag\": \"success\"}" : "{\"flag\": \"fail\"}";

            PrintWriter out = response.getWriter();
            out.write(json);
            response.flushBuffer();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
