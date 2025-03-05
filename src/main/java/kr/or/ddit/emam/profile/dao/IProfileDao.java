package kr.or.ddit.emam.profile.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.emam.vo.PostVO;
import kr.or.ddit.emam.vo.ProfileVO;


public interface IProfileDao {

    /**
     * 회원 ID를 이용하여 프로필 정보 (ProfileVO) 를 DB에서 조회하는 메소드
     * @param memId 조회할 회원 ID
     * @return ProfileVO 프로필 정보, 정보가 없을 경우 null 반환
     */
    public ProfileVO selectProfile(String memId);

    /**
     * 회원 ID를 이용하여 게시글 목록 (List<PostVO>) 을 DB에서 최신순으로 조회하는 메소드
     * @param memId 조회할 회원 ID
     * @return List<PostVO> 게시글 목록, 게시글이 없을 경우 빈 List 반환
     */
    public List<PostVO> selectPostList(String memId);
}