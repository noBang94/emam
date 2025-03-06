package kr.or.ddit.emam.usersettings.service;

import kr.or.ddit.emam.vo.UsersettingsVO;

public interface IUsersettingsService {
    //유저세팅 기본설정
    public int insertUsersettings(String mem_id);

    //유저세팅 확인
    public UsersettingsVO checkUsersettings(String mem_id);

    //유저세팅 변경
    public int updateUsersettings(String mem_id);
}
