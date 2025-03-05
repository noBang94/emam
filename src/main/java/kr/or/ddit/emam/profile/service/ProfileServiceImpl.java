package kr.or.ddit.emam.profile.service;

import java.util.List;

import kr.or.ddit.emam.profile.dao.IProfileDao;
import kr.or.ddit.emam.profile.dao.ProfileDaoImpl;
import kr.or.ddit.emam.vo.PostVO;
import kr.or.ddit.emam.vo.ProfileVO;

public class ProfileServiceImpl implements IProfileService { // @Service 어노테이션 제거

    private static IProfileService instance; // 싱글톤 instance
    private IProfileDao profileDao; // DAO 인터페이스

    private ProfileServiceImpl() {profileDao = ProfileDaoImpl.getInstance();} // private 생성자

    public static IProfileService getInstance() { // 싱글톤 instance 반환 메소드
        if (instance == null) {
            instance = new ProfileServiceImpl();
        }
        return instance;
    }

    // 수동 의존성 주입 (setter 메소드 또는 생성자 주입 방식 선택 가능)
    public void setProfileDao(IProfileDao profileDao) {
        this.profileDao = profileDao;
    }


    @Override
    public ProfileVO getProfile(String memId) {
        return profileDao.selectProfile(memId); // profileDao 싱글톤 instance 사용
    }

    @Override
    public List<PostVO> getPostList(String memId) {
        return profileDao.selectPostList(memId); // profileDao 싱글톤 instance 사용
    }
}