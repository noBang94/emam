package kr.or.ddit.emam.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.member.service.IMemberService;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.profile.service.IProfileService;
import kr.or.ddit.emam.profile.service.ProfileServiceImpl;
import kr.or.ddit.emam.usersettings.service.IUsersettingsService;
import kr.or.ddit.emam.usersettings.service.UsersettingsServiceImpl;
import kr.or.ddit.emam.vo.MemberVO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/member/memberInsert.do")
public class MemberInsert extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");

        try {
            String id = request.getParameter("mem_id");
            String pass = request.getParameter("mem_pw");
            String name = request.getParameter("mem_name");
            String nickName = request.getParameter("mem_nickname");
            String hp = request.getParameter("mem_phone");
            String addr = request.getParameter("mem_addr");
            String bir = request.getParameter("mem_bir");
            String gen = request.getParameter("mem_gen");

            MemberVO vo = new MemberVO();
            vo.setMem_id(id);
            vo.setMem_pw(pass);
            vo.setMem_name(name);
            vo.setMem_nickname(nickName);
            vo.setMem_addr(addr);
            vo.setMem_phone(hp);
            vo.setMem_bir(bir);
            vo.setMem_gen(gen);

            IMemberService service = MemberServiceImpl.getInstance();
            IUsersettingsService usersettingsService = UsersettingsServiceImpl.getInstance();
            IProfileService profileService = ProfileServiceImpl.getInstance();

            int insetCnt = service.insertMember(vo);
            String result;
            if (insetCnt > 0) {
                result = String.format("{\"flag\": \"%s님 가입을 축하합니다\", \"redirectUrl\": \"%s/member/loginMember.do\"}", vo.getMem_name(), request.getContextPath());
                usersettingsService.insertUsersettings(vo.getMem_id());
                profileService.insertProfile(vo);
            } else {
                result = "{\"flag\": \"이미 존재하는 회원입니다.\"}";
            }

            PrintWriter out = response.getWriter();
            out.write(result);
            response.flushBuffer();

        } catch (Exception e) {
            e.printStackTrace(); // 로깅
            String errorResult = "{\"flag\": \"서버 오류가 발생했습니다.\"}";
            PrintWriter out = response.getWriter();
            out.write(errorResult);
            response.flushBuffer();
        }
    }
}