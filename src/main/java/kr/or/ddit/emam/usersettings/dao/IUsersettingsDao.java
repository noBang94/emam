package kr.or.ddit.emam.usersettings.dao;

import kr.or.ddit.emam.vo.UsersettingsVO;

public interface IUsersettingsDao {
    //유저세팅 기본설정
    public int insertUsersettings(String mem_id);

    //유저세팅 확인
    public UsersettingsVO checkUsersettings(String mem_id);

    //유저세팅(생일 외) 변경
    public int updateUsersettings(UsersettingsVO usersettingsVo);

    //유저세팅(생일만) 변경
    public int updateUsersettingBir(UsersettingsVO usersettingsVo);
}
