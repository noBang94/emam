package kr.or.ddit.emam.reply.dao;

import kr.or.ddit.emam.report.dao.IReportDao;
import kr.or.ddit.emam.vo.ReplyVO;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;
import java.util.List;


private SqlSessionFactory sqlSessionFactory;
private String namespace = "kr.or.ddit.emam.reply.dao.IReplyDAO."; // Mapper namespace 설정 변경: ReplyDAO -> IReplyDAO

// 생성자에서 SqlSessionFactory 초기화 (또는 서블릿 초기화 시)
public ReplyDAOImpl() {
    try {
        String resource = "mybatis-config.xml"; // MyBatis 설정 파일 경로
        Reader reader = Resources.getResourceAsReader(resource);
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
    } catch (IOException e) {
        e.printStackTrace(); // 예외 처리
        // 또는 예외를 던져서 서블릿 초기화 실패 처리
    }
}


@Override
public int insertReply(ReplyVO replyVO) {
    SqlSession sqlSession = sqlSessionFactory.openSession(); // SqlSession 얻기
    try {
        return sqlSession.insert(namespace + "insertReply", replyVO);
    } finally {
        sqlSession.close(); // SqlSession 닫기 (finally 블록에서 항상 닫도록)
    }
}

@Override
public int updateReply(ReplyVO replyVO) {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    try {
        return sqlSession.update(namespace + "updateReply", replyVO);
    } finally {
        sqlSession.close();
    }
}

@Override
public List<ReplyVO> selectReplyListByPostIndex(int postIndex) {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    try {
        return sqlSession.selectList(namespace + "selectReplyListByPostIndex", postIndex);
    } finally {
        sqlSession.close();
    }
}
}