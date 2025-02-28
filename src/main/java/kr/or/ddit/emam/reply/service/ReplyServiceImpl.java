package kr.or.ddit.emam.reply.service;

import kr.or.ddit.emam.reply.dao.IReplyDAO;
import kr.or.ddit.emam.reply.dao.ReplyDAOImpl; // ReplyDAOImpl import 추가
import kr.or.ddit.emam.vo.ReplyVO;

import java.util.List;

public class ReplyServiceImpl implements IReplyService {

    private IReplyDAO replyDAO; // ReplyDAO 구현체 직접 생성

    public ReplyServiceImpl() {
        replyDAO = new ReplyDAOImpl(); // ReplyDAOImpl 객체 생성
    }

    @Override
    public int insertReply(ReplyVO replyVO) {
        return replyDAO.insertReply(replyVO);
    }

    @Override
    public int updateReply(ReplyVO replyVO) {
        return replyDAO.updateReply(replyVO);
    }

    @Override
    public List<ReplyVO> selectReplyListByPostIndex(int postIndex) {
        return replyDAO.selectReplyListByPostIndex(postIndex);
    }
}