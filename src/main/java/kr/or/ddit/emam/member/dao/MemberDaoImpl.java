package kr.or.ddit.emam.member.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.MemberVO;
import org.apache.ibatis.session.SqlSession;

public class MemberDaoImpl implements IMemberDao {

    private static IMemberDao dao;

    private MemberDaoImpl() { }

    public static IMemberDao getInstance() {
        if(dao == null) dao = new MemberDaoImpl();
        return dao;
    }

    @Override
    public MemberVO getLoginMember(MemberVO memberVo) {
        SqlSession  session = MyBatisUtil.getSqlSession();
        MemberVO  memVo = null;

        try {
            memVo = session.selectOne("member.getLoginMember", memberVo);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            session.close();
        }

        return memVo;
    }

    @Override
    public int insertMember(MemberVO memberVo) {
        SqlSession  session = MyBatisUtil.getSqlSession();
        int cnt = 0;

        try {
            cnt = session.insert("member.insertMember", memberVo);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            session.commit();
            session.close();
        }

        return cnt;
    }

    @Override
    public int getMemberIdCount(String memId) {
        SqlSession  session = MyBatisUtil.getSqlSession(true);
        int count = 0;

        try {
            count = session.selectOne("member.getMemberIdCount", memId);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            session.close();
        }

        return count;
    }

    @Override
    public MemberVO getMember(String memId) {
        SqlSession  session = MyBatisUtil.getSqlSession();
        MemberVO  memVo = null;

        try {
            memVo = session.selectOne("member.getMember", memId);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            session.close();
        }

        return memVo;
    }

}
