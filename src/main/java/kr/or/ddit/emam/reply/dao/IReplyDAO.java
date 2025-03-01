package kr.or.ddit.emam.reply.dao;

import kr.or.ddit.emam.vo.ReplyVO;
import java.util.List;

public interface IReplyDAO {
    /**
     * 댓글 등록
     * @param replyVO 댓글 정보
     * @return 등록 성공 시 1, 실패 시 0
     */
    int insertReply(ReplyVO replyVO);

    /**
     * 댓글 수정
     * @param replyVO 댓글 정보
     * @return 수정 성공 시 1, 실패 시 0
     */
    int updateReply(ReplyVO replyVO);

    /**
     * 게시글 index로 댓글 목록 조회
     * @param postIndex 게시글 index
     * @return 댓글 목록
     */
    List<ReplyVO> selectReplyListByPostIndex(int postIndex);
}