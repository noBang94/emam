package kr.or.ddit.emam.admin.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.AdminVO;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NoticeVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDaoImpl implements IAdminDao {
    private static IAdminDao dao;

    private AdminDaoImpl() {
    }

    public static IAdminDao getInstance() {
        if (dao == null) dao = new AdminDaoImpl();
        return dao;
    }

    @Override
    public AdminVO getLoginAdmin(AdminVO adminVo) {
        SqlSession session = MyBatisUtil.getSqlSession();
        AdminVO adVo = null;

        try {
            adVo = session.selectOne("admin.getLoginAdmin", adminVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return adVo;
    }

    @Override
    public List<MemberVO> getMemberList(MemberVO memberVo, int page, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<MemberVO> memberList = null;

        try {
            Map<String, Object> params = new HashMap<>();
            params.put("memberVo", memberVo);
            params.put("offset", (page - 1) * pageSize);
            params.put("limit", pageSize);

            memberList = session.selectList("admin.getMemberList", params);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return memberList;
    }

    @Override
    public int deleteMember(String memId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int cnt = 0;

        try {
            cnt = session.delete("admin.deleteMember", memId);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return cnt;
    }

    @Override
    public int getTotalMemberCount(String searchId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        Integer count = null;

        try {
            count = session.selectOne("admin.getTotalMemberCount", searchId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return count != null ? count : 0;
    }

    @Override
    public NoticeVO getNotice(int noticeIndex) {
        try(SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne("admin.getNotice", noticeIndex);
        }
    }

    @Override
    public int insertNotice(NoticeVO noticeVO) {
        try(SqlSession session = MyBatisUtil.getSqlSession()) {
            int result = session.insert("admin.insertNotice", noticeVO);
            session.commit();
            return result;
        }
    }

    @Override
    public int updateNotice(NoticeVO noticeVO) {
        try(SqlSession session = MyBatisUtil.getSqlSession()) {
            int result = session.update("admin.updateNotice", noticeVO);
            session.commit();
            return result;
        }
    }

    @Override
    public List<NoticeVO> selectAllNotice(String getNotice) { // 전체 공지 조회
        SqlSession session = MyBatisUtil.getSqlSession();
        List<NoticeVO> noticelist = null;

        try {
            noticelist = session.selectList("admin.selectAllNotice");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return noticelist;
    }

    @Override
    public int deleteNotice(int noticeIndex) {
        try(SqlSession session = MyBatisUtil.getSqlSession()) {
            int result = session.delete("admin.deleteNotice", noticeIndex);
            session.commit();
            return result;
        }
    }
}