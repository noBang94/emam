package kr.or.ddit.emam.profile.service;

import java.util.Collection;
import java.util.List;

import jakarta.servlet.http.Part;
import kr.or.ddit.emam.profile.dao.IProfileDao;
import kr.or.ddit.emam.profile.dao.ProfileDaoImpl;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.PostVO;
import kr.or.ddit.emam.vo.ProfileVO;

public class ProfileServiceImpl implements IProfileService {

    private static IProfileService instance; // 싱글톤 instance
    private IProfileDao profileDao; // DAO 인터페이스

    private ProfileServiceImpl() {profileDao = ProfileDaoImpl.getInstance();} // private 생성자

    public static IProfileService getInstance() { // 싱글톤 instance 반환 메소드
        if (instance == null) {
            instance = new ProfileServiceImpl();
        }
        return instance;
    }

    // 수동 의존성 주입 (setter 메소드 또는 생성자 주입 방식 선택 가능

    @Override
    public int insertProfile(MemberVO memberVo) { return profileDao.insertProfile(memberVo); }

    @Override
    public ProfileVO getProfile(String memId) {
        return profileDao.selectProfile(memId); // profileDao 싱글톤 instance 사용
    }

    @Override
    public List<PostVO> getPostList(String memId) {
        return profileDao.selectPostList(memId); // profileDao 싱글톤 instance 사용
    }



    @Override
    public ProfileVO selectProfile(String memId) {
        return profileDao.selectProfile(memId);
    }

    @Override
    public int updateProfile(ProfileVO profileVO) {
        return profileDao.updateProfile(profileVO);
    }

    @Override
    public void updateProfileImg(Collection<Part> parts, String memId) {

    }
    @Override
    public int updatePostCount(String memId) {
        // 1. 해당 회원 ID의 실제 게시글 수를 DB에서 조회 (COUNT 쿼리 사용)
        int postCount = profileDao.selectPostCount(memId);

        // 2. ProfileVO 객체 생성 및 게시글 수 설정
        ProfileVO profileVO = new ProfileVO();
        profileVO.setMem_id(memId);
        profileVO.setProfile_postcnt(postCount);

        // 3. ProfileDao 를 통해 DB 업데이트
        return profileDao.updateProfilePostCount(profileVO);
    }
    @Override
    public List<MemberVO> getFriend(String memId) {
        return profileDao.selectFriend(memId);
    }

    @Override
    public boolean isFriend(String loginMemberId, String profileOwnerId) {
        return profileDao.isFriend(loginMemberId, profileOwnerId);
    }

    }