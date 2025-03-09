package kr.or.ddit.emam.ilike.service;

import kr.or.ddit.emam.vo.ILikeVO;

public interface ILikeService {

    /**
     * 좋아요 했는지 체크
     * @param ILikeVO
     * @return
     */
    public int likeCheck(ILikeVO ILikeVO);

    /**
     * 좋아요 추가
     * @param ILikeVO
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
