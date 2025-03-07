package kr.or.ddit.emam.profile.service;

import java.util.Collection;
import java.util.List;

import jakarta.servlet.http.Part;
import kr.or.ddit.emam.vo.PostVO;
import kr.or.ddit.emam.vo.ProfileVO;

public interface IProfileService {

    /**
     * 회원 ID를 이용하여 프로필 정보 (ProfileVO) 를 조회하는 메소드
     * @param memId 조회할 회원 ID
     * @return ProfileVO 프로필 정보, 정보가 없을 경우 null 반환
     */
    public ProfileVO getProfile(String memId);

    /**
     * 회원 ID를 이용하여 게시글 목록 (List<PostVO>) 을 최신순으로 조회하는 메소드
     * @param memId 조회할 회원 ID
     * @return List<PostVO> 게시글 목록, 게시글이 없을 경우 빈 List 반환
     */
    public List<PostVO> getPostList(String memId);


    ProfileVO selectProfile(String memId);

    int updatePostCount(String memId);

    public int updateProfile(ProfileVO profileVO);

    void updateProfileImg(Collection<Part> parts, String memId);
}