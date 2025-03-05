package kr.or.ddit.emam.report.dao;

import kr.or.ddit.emam.member.dao.IMemberDao;
import kr.or.ddit.emam.member.dao.MemberDaoImpl;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.report.service.IReportService;
import kr.or.ddit.emam.report.service.ReportServiceImpl;
import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.NoticeVO;
import kr.or.ddit.emam.vo.ReportVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class ReportDaoImpl implements IReportDao{

    private static IReportDao dao;

    private ReportDaoImpl() {}

    public static IReportDao getInstance() {
        if (dao == null) dao = new ReportDaoImpl();
        return dao;
    }

    @Override
    public int insertReport(ReportVO reportVO) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int cnt = 0;

        try {
            cnt = session.insert("report.insertReport", reportVO);
            if(cnt > 0){
                session.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            session.close();
        }

        return cnt;
    }

    @Override
    public ReportVO getReport(int reportIndex) {
        try(SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne("report.getReport", reportIndex);
        }
    }

    @Override
    public List<ReportVO> selectAllReport(String getReport) { // 전체 신고 조회
        SqlSession session = MyBatisUtil.getSqlSession();
        List<ReportVO> reportlist = null;

        try {
            reportlist = session.selectList("report.selectAllReport");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return reportlist;
    }

    @Override
    public List<ReportVO> searchReportId(String searchTitle) { // 특정 신고 조회
        SqlSession session = MyBatisUtil.getSqlSession();
        List<ReportVO> reportlist = null;

        try {
            reportlist = session.selectList("report.searchReportId", searchTitle);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return reportlist;
    }

    @Override
    public int updateReport(int reportId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int cnt = 0;

        try {
            cnt = session.update("report.updateReport", reportId);
            if(cnt > 0) {
                session.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return cnt;
    }
}