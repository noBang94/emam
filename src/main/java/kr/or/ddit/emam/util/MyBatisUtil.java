package kr.or.ddit.emam.util;

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * SqlSession객체를 제공하기 위한 팩토리 클래스
 */
public class MyBatisUtil {
    private static SqlSessionFactory sqlSessionFactory = null;

    static {
        Reader rd = null;
        try {
            rd = Resources.getResourceAsReader("kr/or/ddit/emam/config/mybatis-config.xml");

            sqlSessionFactory = new SqlSessionFactoryBuilder().build(rd);
        } catch (Exception e) {
            System.out.println("myBatis 초기화 실패!!!");
            e.printStackTrace();
        } finally {
            if(rd!=null) try { rd.close(); }catch(IOException e) {}
        }
    }

    /**
     * SqlSessionFactory객체를 이용하여 SQL문을 처리할 SqlSession객체를 반환하는 메서드
     *
     * @return SqlSession객체
     */
    public static SqlSessionFactory  getSessionFactory() {
        return  sqlSessionFactory;
    }

    public static SqlSession getSqlSession() {
        SqlSession session = sqlSessionFactory.openSession(true);
        return session;
    }

    public static SqlSession getSqlSession(boolean autoComm) {
        SqlSession session = sqlSessionFactory.openSession(autoComm);
        return session;
    }
}