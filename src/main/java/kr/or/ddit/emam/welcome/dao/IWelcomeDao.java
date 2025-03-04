package kr.or.ddit.emam.welcome.dao;

import kr.or.ddit.emam.vo.WeatherVO;

public interface IWelcomeDao {
    //지역별 좌표 가져오기
    public WeatherVO getLocalXY(String local_name);
}
