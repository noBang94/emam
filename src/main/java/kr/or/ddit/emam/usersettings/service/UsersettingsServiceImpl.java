package kr.or.ddit.emam.usersettings.service;

import kr.or.ddit.emam.usersettings.dao.IUsersettingsDao;
import kr.or.ddit.emam.usersettings.dao.UsersettingsDaoImpl;
import kr.or.ddit.emam.vo.UsersettingsVO;

public class UsersettingsServiceImpl implements IUsersettingsService {
    
    //dao객체
    private IUsersettingsDao dao;
    //자신의 객체
    private static IUsersettingsService service;
    
    //생성자 - dao객체 열기
    public UsersettingsServiceImpl() { dao = UsersettingsDaoImpl.getInstance(); }
    
    //자신의 객체를 생성하고 리턴하는 메소드
    public static IUsersettingsService getInstance() {
        if (service == null) service = new UsersettingsServiceImpl();
        return service;
    }

    //유저세팅 기본설정
    @Override
    public int insertUsersettings(String mem_id) { return dao.insertUsersettings(mem_id); }

    //유저세팅 확인
    @Override
    public UsersettingsVO checkUsersettings(String mem_id) { return dao.checkUsersettings(mem_id); }

    //유저세팅 변경
    @Override
    public int updateUsersettings(String mem_id) { return dao.updateUsersettings(mem_id); }
}
