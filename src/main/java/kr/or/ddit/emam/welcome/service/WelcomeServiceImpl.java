package kr.or.ddit.emam.welcome.service;

import kr.or.ddit.emam.vo.WeatherVO;
import kr.or.ddit.emam.welcome.dao.IWelcomeDao;
import kr.or.ddit.emam.welcome.dao.WelcomeDaoImpl;

public class WelcomeServiceImpl implements IWelcomeService {

    //dao객체
    private IWelcomeDao dao;

    //자신의 객체
    private static IWelcomeService service;

    //생성자 - dao객체 얻기
    private WelcomeServiceImpl() { dao = WelcomeDaoImpl.getInstance(); }

    //자신의 객체를 생성하고 리턴하는 메소드
    public static IWelcomeService getInstance() {
        if (service == null) service = new WelcomeServiceImpl();
        return service;
    }

    //지역별 좌표 가져오기
    @Override
    public WeatherVO getLocalXY(String local_name) { return dao.getLocalXY(local_name); }
}
