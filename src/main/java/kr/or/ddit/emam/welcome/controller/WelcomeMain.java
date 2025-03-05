package kr.or.ddit.emam.welcome.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.emam.admin.service.AdminServiceImpl;
import kr.or.ddit.emam.admin.service.IAdminService;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NoticeVO;
import kr.or.ddit.emam.vo.WeatherVO;
import kr.or.ddit.emam.welcome.service.IWelcomeService;
import kr.or.ddit.emam.welcome.service.WelcomeServiceImpl;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/welcome/welcomeMain.do")
public class WelcomeMain extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        //로그인한 계정정보 가져오기
        HttpSession session = request.getSession();
        MemberVO loginMemberVo = (MemberVO) session.getAttribute("loginMember");



        //날씨 - 회원 거주지역 정보 가져오기
        String local_name = loginMemberVo.getMem_addr().trim();
        IWelcomeService welcomeService = WelcomeServiceImpl.getInstance();
        WeatherVO weatherVo = welcomeService.getLocalXY(local_name);

        //날씨 - 날씨API 주소
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst"); //API URL
        String apiKey = "Zj%2B2%2Fwu6xX5ZhK%2FnMdhrzzV1rj97PApDWMvhzoTk4CML3dV15YlmVfnsTtLEIa5eWYcvpVQXSPhn2XIyCl7LFA%3D%3D"; //인증키

        //날씨 - 오늘 날짜
        LocalDate today = LocalDate.now();
        LocalTime nowtime = LocalTime.now();
        DateTimeFormatter formatterBaseDate = DateTimeFormatter.ofPattern("yyyyMMdd");
        DateTimeFormatter formatterBaseTime = DateTimeFormatter.ofPattern("HH00");

        //날씨 - 날짜와 시간과 좌표 받아서 API URL로 보내기
        String baseDate = today.format(formatterBaseDate);
        String baseTime = nowtime.plusHours(-1).format(formatterBaseTime); //날씨정보 발표시간
        String nx = weatherVo.getLocal_nx();
        String ny = weatherVo.getLocal_ny();

        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + apiKey); //인증키
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); //페이지번호
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8")); //한페이지결과수
        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); //요청자료형식
        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + baseDate); //날씨발표일자(최근 1일)
        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + baseTime); //날씨발표시간(30분 단위)
        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + 98); //예보지점 X 좌표값
        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + 76); //예보지점 Y 좌표값

        //날씨 - GET형식으로 전송해서 정보 받아오기
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        String result = sb.toString();
        System.out.println(result);

        //날씨 - json에서 데이터 파싱하기
        //(1)response키로 데이터 파싱
        JSONObject jsonObj = new JSONObject(result);
        JSONObject jsonResponse = jsonObj.getJSONObject("response");
        //(2)response로부터 body 찾기
        JSONObject body = jsonResponse.getJSONObject("body");
        //(3)body로부터 items 찾기
        JSONObject items = body.getJSONObject("items");
        //(4)items로부터 itemList 받기
        JSONArray jsonArray = items.getJSONArray("item");

        JSONObject weather;
        String category = "";
        String time = nowtime.format(formatterBaseTime); //조회할 시간

        String wSky = ""; //SKY 하늘상태코드 - 1(맑음) 2(구름조금) 3(구름많음) 4(흐림)
        String wPty = ""; //PTY 강수형태코드 - 0(없음) 1(비) 2(비/눈) 3(눈) 5(빗방울) 6(빗방울눈날림) 7(눈날림)
        String wT1h = ""; //T1H 기온

        for(int i = 0; i < jsonArray.length(); i++) {
            weather = jsonArray.getJSONObject(i);
            String fcstValue = weather.getString("fcstValue");
            String fcstTime = weather.getString("fcstTime");

            category = weather.getString("category");

            //조회할 시간에 대한 날씨 정보 저장
            if (time.equals(fcstTime)&&category.equals("SKY")) {
                wSky = fcstValue;
            }
            if (time.equals(fcstTime)&&category.equals("PTY")) {
                wPty = fcstValue;
            }
            if (time.equals(fcstTime)&&category.equals("T1H")) {
                wT1h = fcstValue;
            }
        }

        request.setAttribute("wSky", wSky);
        request.setAttribute("wPty", wPty);
        request.setAttribute("wT1h", wT1h);

        //공지사항 정보 가져오기
        IAdminService adminService = AdminServiceImpl.getInstance();
        List<NoticeVO> noticeList = adminService.selectAllNotice(null);
        request.setAttribute("noticeList", noticeList);

        //알림 정보 가져오기




        request.getRequestDispatcher("/WEB-INF/view/welcome.jsp").forward(request, response);
    }
}
