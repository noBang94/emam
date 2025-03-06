package kr.or.ddit.emam.util.dao;


import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.MemberVO;

import java.util.List;

public class SearchDaoImpl implements ISearchDao {
    private static ISearchDao dao;

    private SearchDaoImpl() {
    }

    public static ISearchDao getInstance() {
        if (dao == null) dao = new SearchDaoImpl();
        return dao;
    }

    @Override
    public List<MemberVO> getMemberListById(String searchId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<MemberVO> memberList = null;

        try {
            memberList = session.selectList("member.getMemberListById", searchId);
        } finally {
            session.close();
        }

        return memberList;
    }
}