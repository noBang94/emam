package kr.or.ddit.emam.welcome.service;

import kr.or.ddit.emam.vo.WeatherVO;

public interface IWelcomeService {
    //지역별 좌표 가져오기
    public WeatherVO getLocalXY(String local_name);
}
