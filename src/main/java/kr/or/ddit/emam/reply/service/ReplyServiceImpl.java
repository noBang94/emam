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

//    private static ReplyDAOImpl instance; // 싱글톤 instance
//    private SqlSessionFactory sqlSessionFactory; // MybatisUtil 에서 가져올 SqlSessionFactory
//
//    private ReplyServiceImpl() { // private 생성자 (외부에서 new 로 생성 불가)
//        sqlSessionFactory = MybatisUtil.getSqlSessionFactory(); // MybatisUtil 에서 SqlSessionFactory 획득
//        if (sqlSessionFactory == null) {
//            throw new IllegalStateException("SqlSessionFactory를 가져오는데 실패했습니다."); // 초기화 실패 예외 처리
//        }
//        System.out.println("ReplyDAOImpl 싱글톤 객체 생성 및 SqlSessionFactory 획득"); // 로그 추가
//    }
//
//    public static ReplyDAOImpl getInstance() { // 싱글톤 instance 반환 메소드
//        if (instance == null) {
//            instance = new ReplyDAOImpl();
//        }
//        return instance;
//    }
//
//
//    @Override
//    public int insertReply(ReplyVO replyVO) {
//        SqlSession sqlSession = sqlSessionFactory.openSession();
//        try {
//            return sqlSession.insert("kr.or.ddit.emam.reply.dao.IReplyDAO.insertReply", replyVO); // namespace 직접 지정
//        } finally {
//            sqlSession.close();
//        }
//    }
//
//    @Override
//    public int updateReply(ReplyVO replyVO) {
//        SqlSession sqlSession = sqlSessionFactory.openSession();
//        try {
//            return sqlSession.update("kr.or.ddit.emam.reply.dao.IReplyDAO.updateReply", replyVO); // namespace 직접 지정
//        } finally {
//            sqlSession.close();
//        }
//    }
//
//    @Override
//    public List<ReplyVO> selectReplyListByPostIndex(int postIndex) {
//        SqlSession sqlSession = sqlSessionFactory.openSession();
//        try {
//            return sqlSession.selectList("kr.or.ddit.emam.reply.dao.IReplyDAO.selectReplyListByPostIndex", postIndex); // namespace 직접 지정
//        } finally {
//            sqlSession.close();
//        }
//    }


}