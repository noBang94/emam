package kr.or.ddit.emam.ilike.dao;

import kr.or.ddit.emam.vo.ILikeVO;

public interface ILikeDao {

    /**
     * 좋아요를 했는지 체크
     * @param ILikeVO
     * @return
     */
    public int likeCheck(ILikeVO ILikeVO);

    /**
     * 좋아요 추가
     * @param ILikeVO 게시글 번호 회원번호를 담는 VO
     * @return
     */
    public int insertILike(ILikeVO ILikeVO);

    /**
     * 좋아요 취소
     * @param ILikeVO
     * @return
     */
    public int deleteILike(ILikeVO ILikeVO);

    /**
     * 좋아요 수 가져오기
     * @param postindex
     * @return
     */
    public int countLike(String postindex);
}
