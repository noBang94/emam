package kr.or.ddit.emam.util;

import java.io.BufferedReader;

import jakarta.servlet.http.HttpServletRequest;

//json데이터 가져오기위한 클래스
public class StreamData {
    public static String getJsonStream(HttpServletRequest request) {
        StringBuffer strbuf = new StringBuffer();

        String temp = null;

        try {
            BufferedReader br = request.getReader();

            while((temp = br.readLine())!= null) {
                strbuf.append(temp);
            }
        } catch (Exception e) {
            System.out.println("JSON 문자열 읽기 오류 : "+e.toString());

        }
//		String jsonStr = strbuf.toString();
        String jsonStr = String.valueOf(strbuf);

        return jsonStr;
    }
}
