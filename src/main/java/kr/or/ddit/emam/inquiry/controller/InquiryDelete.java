package kr.or.ddit.emam.inquiry.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.emam.inquiry.service.IInquiryService;
import kr.or.ddit.emam.inquiry.service.InquiryServiceImpl;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/inquiry/inquiryDelete.do")
public class InquiryDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");

        int num = Integer.parseInt(request.getParameter("num"));

        IInquiryService service = InquiryServiceImpl.getInstance();

        int res = service.deleteInquiry(num);

        String jsonStr =
                """
                     {
                        "result" : %d
                     }
                """.formatted(res);

        PrintWriter out = response.getWriter();
        out.write(jsonStr);
        response.flushBuffer();
    }
}
