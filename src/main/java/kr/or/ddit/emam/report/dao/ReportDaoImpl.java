package kr.or.ddit.emam.report.dao;

import kr.or.ddit.emam.member.dao.IMemberDao;
import kr.or.ddit.emam.member.dao.MemberDaoImpl;
import kr.or.ddit.emam.member.service.MemberServiceImpl;
import kr.or.ddit.emam.report.service.IReportService;
import kr.or.ddit.emam.report.service.ReportServiceImpl;
import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.MemberVO;
import kr.or.ddit.emam.vo.ReportVO;
import org.apache.ibatis.session.SqlSession;

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
}