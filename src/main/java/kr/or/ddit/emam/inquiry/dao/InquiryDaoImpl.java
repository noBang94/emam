package kr.or.ddit.emam.inquiry.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.InquiryVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class InquiryDaoImpl implements IInquiryDao {

    //싱글톤
    private static IInquiryDao dao;

    private InquiryDaoImpl() {}

    //자신의 객체를 생성하고 리턴하는 메소드
    public static IInquiryDao getInstance() {
        if(dao == null) dao = new InquiryDaoImpl();
        return dao;
    }

    //문의 작성
    @Override
    public int insertInquiry(InquiryVO inquiryVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.insert("inquiry.insertInquiry", inquiryVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //문의 삭제
    @Override
    public int deleteInquiry(int num) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.delete("inquiry.deleteInquiry", num);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //문의 수정
    @Override
    public int updateInquiry(InquiryVO inquiryVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.update("inquiry.updateInquiry", inquiryVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //문의 보기
    @Override
    public InquiryVO getInquiry(int num) {
        InquiryVO inquiryVo = null;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            inquiryVo = session.selectOne("inquiry.getInquiry", num);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return inquiryVo;
    }

    //문의 리스트 - 검색 포함
    @Override
    public List<InquiryVO> selectByPage(Map<String, Object> map) {
        List<InquiryVO> list = null;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            list = session.selectList("inquiry.selectByPage", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    //전체 문의글 갯수 구하기
    @Override
    public int totalCount(Map<String, Object> map) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.selectOne("inquiry.totalCount", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return res;
    }
}
