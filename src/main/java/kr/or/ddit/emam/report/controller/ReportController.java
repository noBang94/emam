package kr.or.ddit.emam.report.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import kr.or.ddit.emam.report.service.IReportService;
import kr.or.ddit.emam.report.service.ReportServiceImpl;
import kr.or.ddit.emam.vo.ReportVO;

import java.io.*;
import java.util.UUID;

@MultipartConfig
@WebServlet(urlPatterns = {"/report.do", "/initialReport.do"})
public class ReportController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");

        String requestURI = request.getRequestURI();

        if (requestURI.endsWith("/initialReport.do")) {
            request.getRequestDispatcher("/WEB-INF/view/report/initial_report.jsp").forward(request, response);
        } else if (requestURI.endsWith("/report.do")) {
            // 신고대상
            String toId = request.getParameter("toId");
            request.getRequestDispatcher("/WEB-INF/view/report/report.jsp").forward(request, response);
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");


        String fromId = new String(request.getPart("fromid").getInputStream().readAllBytes());
        String toId = new String(request.getPart("toid").getInputStream().readAllBytes());
        String reportType = new String(request.getPart("reportType").getInputStream().readAllBytes());
        String content = new String(request.getPart("content").getInputStream().readAllBytes());


        /////////////////////파일 저장 영역
        Part filePart = request.getPart("reportPhoto");
        String fileName = filePart.getSubmittedFileName();
        String saveFileName = "";
        if(fileName !=null && !fileName.isEmpty()) {


            saveFileName = UUID.randomUUID().toString()+"_"+fileName;
            String filePath = "D:"+ File.separator+saveFileName;

            try (InputStream is = filePart.getInputStream();
                 OutputStream os = new FileOutputStream(filePath))
            {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        System.out.println("첨부한 파일 이름은? " + fileName);
        System.out.println("저장 될 파일 이름은? " + saveFileName);
        ////////////////////////////////////


        ReportVO vo = new ReportVO();
        vo.setFromId(fromId);
        vo.setToId(toId);
        vo.setReportContent(content);
        vo.setReportType(reportType);
        vo.setReportPhoto(saveFileName);


        IReportService service = ReportServiceImpl.getInstance();
        int insetCnt = service.insertReport(vo);


        String message = "";
        boolean redirectToInitial = false; // 리다이렉션 여부 변수 초기화 (기본값: false)

        if (insetCnt > 0) {
            message = "신고가 정상적으로 접수되었습니다.";
            redirectToInitial = true; // 신고 성공 시 true로 설정
        }else{
            message = "신고 접수에 실패했습니다. 다시 시도해주세요.";
            redirectToInitial = false; // 신고 실패 시 false로 설정
            request.setAttribute("reportVO", vo); // **신고 실패 시 ReportVO 객체를 request scope 에 설정**
        }

        request.setAttribute("popupMessage", message);
        request.setAttribute("redirectToInitial", redirectToInitial);
        request.getRequestDispatcher("/WEB-INF/view/report/report.jsp").forward(request, response);

    }


}