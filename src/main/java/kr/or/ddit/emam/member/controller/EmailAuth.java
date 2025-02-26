package kr.or.ddit.emam.member.controller;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;

@WebServlet("/member/emailAuth.do")
public class EmailAuth extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String authCode = generateAuthCode(); // 인증 번호 생성
        long timestamp = System.currentTimeMillis();    // 현재 시간 (타임스탬프)

        request.getSession().setAttribute("authCode_" + timestamp + "_" + email, authCode); // 세션에 인증 번호 저장

        boolean success = sendEmail(email, authCode);

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.print("{\"success\": " + success + "}");
        out.flush();
        out.close();
    }

    private String generateAuthCode() {
        Random random = new Random(System.currentTimeMillis());
        int authCode = random.nextInt(999999);

        return String.valueOf(authCode);
    }

    private boolean sendEmail(String toEmail, String authCode) {
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
            message.setSubject("으밀아밀 || 이메일 인증 번호 발급 메일입니다.");

            // 메일 내용 설정
            message.setText("인증 코드는 [ " + authCode + " ] 입니다.");

            // 메일 전송
            Transport.send(message);
            System.out.println("NAVER 이메일 발송 성공");

        } catch (MessagingException e) {
            e.printStackTrace();
        }

        System.out.println("NAVER mail send : sendEmail() 종료");
        return true;
    }
}
