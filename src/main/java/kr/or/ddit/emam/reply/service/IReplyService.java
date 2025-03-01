package kr.or.ddit.emam.reply.service;

import kr.or.ddit.emam.vo.ReplyVO;
import java.util.List;

public interface IReplyService {
    int insertReply(ReplyVO replyVO);
    int updateReply(ReplyVO replyVO);
    List<ReplyVO> selectReplyListByPostIndex(int postIndex);
}