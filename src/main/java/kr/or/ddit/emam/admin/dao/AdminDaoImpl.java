package kr.or.ddit.emam.admin.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.AdminVO;
import kr.or.ddit.emam.vo.InquiryVO;
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

    // 관리자 로그인
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

    // 관리자 회원관리
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

    // 관리자 공지사항
    @Override
    public NoticeVO getNotice(int noticeIndex) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne("admin.getNotice", noticeIndex);
        }
    }

    @Override
    public int insertNotice(NoticeVO noticeVO) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            int result = session.insert("admin.insertNotice", noticeVO);
            session.commit();
            return result;
        }
    }

    @Override
    public int updateNotice(NoticeVO noticeVO) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
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
    public List<NoticeVO> searchTitle(String searchTitle) {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<NoticeVO> noticelist = null;

        try {
            noticelist = session.selectList("admin.searchTitle", searchTitle);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return noticelist;
    }

    @Override
    public int deleteNotice(int noticeIndex) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            int result = session.delete("admin.deleteNotice", noticeIndex);
            session.commit();
            session.close();
            return result;
        }
    }

    // 관리자 문의사항
    @Override
    public List<InquiryVO> getInquiryList() {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<InquiryVO> iqVoList = null;

        try {
            iqVoList = session.selectList("admin.getInquiryList");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return iqVoList;
    }

    @Override
    public InquiryVO getInquiryDetail(int inquiryIndex) {
        SqlSession session = MyBatisUtil.getSqlSession();
        InquiryVO inquiry = null;

        try {
            inquiry = session.selectOne("admin.getInquiryDetail", inquiryIndex);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return inquiry;
    }

    @Override
    public int updateInquiryComment(InquiryVO inquiry) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;

        try {
            result = session.update("admin.updateInquiryComment", inquiry);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public List<InquiryVO> searchInquiryList(String searchTitle) {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<InquiryVO> iqVoList = null;

        try {
            iqVoList = session.selectList("admin.searchInquiryList", searchTitle);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return iqVoList;
    }

    // 관리자 메인화면 (대시보드)
    @Override
    public int getTotalPosts() {
        SqlSession session = MyBatisUtil.getSqlSession();
        Integer count = null;
        try {
            count = session.selectOne("admin.getTotalPosts");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return count != null ? count : 0;
    }

    @Override
    public int getTotalReports() {
        SqlSession session = MyBatisUtil.getSqlSession();
        Integer count = null;
        try {
            count = session.selectOne("admin.getTotalReports");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return count != null ? count : 0;
    }

    @Override
    public int getUnprocessedReportsCount() {
        SqlSession session = MyBatisUtil.getSqlSession();
        Integer count = null;
        try {
            count = session.selectOne("admin.getUnprocessedReportsCount");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return count != null ? count : 0;
    }

    @Override
    public int getUnprocessedInquiriesCount() {
        SqlSession session = MyBatisUtil.getSqlSession();
        Integer count = null;
        try {
            count = session.selectOne("admin.getUnprocessedInquiriesCount");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return count != null ? count : 0;
    }

    //수정
    @Override
    public int getNewMembersCount() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("admin.getNewMembersCount");
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    @Override
    public int getNewPostsCount() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("admin.getNewPostsCount");
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    @Override
    public int getNewReportsCount() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("admin.getNewReportsCount");
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    @Override
    public int getNewInquiriesCount() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("admin.getNewInquiriesCount");
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}