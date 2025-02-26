package kr.or.ddit.emam.member.controller;

import jakarta.mail.*;
import jakarta.mail.internet.*;
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
import java.util.Properties;
import java.util.Random;

@WebServlet("/member/SendTempPassword.do")
public class SendTempPassword extends HttpServlet {

    private IMemberService memberService = MemberServiceImpl.getInstance(); // 싱글톤 패턴

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memId = request.getParameter("email");
        MemberVO email = memberService.getMemberByEmail(memId);

        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        if(email == null) {
            request.setAttribute("message", "일치하는 회원 정보가 없습니다.");
            request.getRequestDispatcher("/WEB-INF/view/member/findPassword.jsp").forward(request, response);
        } else {
            String tempPassword = generateTempPassword();
            email.setMem_pw(tempPassword);
            memberService.updatePassword(email);
            sendEmail(memId, tempPassword);

            out.println("<script>alert('임시 비밀번호가 이메일로 발송되었습니다.'); location.href='"
                    + request.getContextPath() + "/';</script>");
        }
        out.close();
    }

    private String generateTempPassword() { // 임시 비밀번호 생성
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder(8);

        // System.currentTimeMilles() : 중복 방지 처리
        Random random = new Random(System.currentTimeMillis());

        for (int i = 0; i < 8; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }

        return sb.toString();
    }

    private void sendEmail(String toEmail, String tempPassword) {
        String host = "smtp.naver.com"; // SMTP 서버명
        String fromEmail = "vmfls789@naver.com";  // 발신자 이메일 계정
        String password = "WCN853TB3VDY";  // 발신자 SMTP 패스워드

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS 활성화

        /* SMTP 서버 정보와 사용자 정보를 기반으로 Session 클래스의 인스턴스를 생성 */
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        /* Message 객체에 수신자와 내용, 제목의 메세지를 작성 */
        try {
            Message message = new MimeMessage(session);

            // 발신자 설정
            message.setFrom(new InternetAddress(fromEmail));

            // 수신자 메일 주소 설정
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

            // 메일 제목 설정
            message.setSubject("으밀아밀 || 임시 비밀번호 발급 메일입니다.");

            // 메일 내용 설정
            message.setText("임시 비밀번호는 [ " + tempPassword + " ] 입니다.");

            // 메일 전송
            Transport.send(message);


            System.out.println("NAVER 이메일 발송 성공");

        } catch (MessagingException e) {
            e.printStackTrace();
        }

        System.out.println("NAVER mail send : sendEmail() 종료");
    }
}
