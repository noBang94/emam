package kr.or.ddit.emam.welcome.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.WeatherVO;
import org.apache.ibatis.session.SqlSession;

public class WelcomeDaoImpl implements IWelcomeDao {

    //싱글톤
    private static IWelcomeDao dao;

    private WelcomeDaoImpl() {}

    //자신의 객체를 생성하고 리턴하는 메소드
    public static IWelcomeDao getInstance() {
        if (dao == null) dao = new WelcomeDaoImpl();
        return dao;
    }

    //지역별 좌표 가져오기
    @Override
    public WeatherVO getLocalXY(String local_name) {
        WeatherVO weatherVo = null;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            weatherVo = session.selectOne("welcome.getLocalXY", local_name);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return weatherVo;
    }
}
