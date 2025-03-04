package kr.or.ddit.emam.reply.service;

import kr.or.ddit.emam.reply.dao.IReplyDAO;
import kr.or.ddit.emam.reply.dao.ReplyDAOImpl;
import kr.or.ddit.emam.vo.ReplyVO;
import java.util.List;

public class ReplyServiceImpl implements IReplyService {

    //dao객체
    private IReplyDAO dao;
    //서비스객체
    private static IReplyService service;

    //생성자
    private ReplyServiceImpl() {
        dao = ReplyDAOImpl.getInstance();
    }

    public static IReplyService getInstance() {
        if (service == null) service = new ReplyServiceImpl();
        return service;
    }


    @Override
    public int insertReply(ReplyVO replyVO) {
        return dao.insertReply(replyVO);
    }

    @Override
    public int updateReply(ReplyVO replyVO) {
        return dao.updateReply(replyVO);
    }

    @Override
    public List<ReplyVO> selectReplyListByPostIndex(int postIndex) {
        return dao.selectReplyListByPostIndex(postIndex);
    }

    @Override
    public ReplyVO selectOneReply(int postIndex) {
        return null;
    }


}