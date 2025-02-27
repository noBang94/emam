package kr.or.ddit.emam.report.service;


import kr.or.ddit.emam.report.dao.IReportDao;
import kr.or.ddit.emam.report.dao.ReportDaoImpl;
import kr.or.ddit.emam.vo.ReportVO;

public class ReportServiceImpl implements IReportService {

    private IReportDao dao;
    private static IReportService service;

    private ReportServiceImpl() {
        dao = ReportDaoImpl.getInstance();
    }

    public static IReportService getInstance() {
        if(service == null)  service = new ReportServiceImpl();

        return service;
    }

    @Override
    public int insertReport(ReportVO reportVO) {
        return dao.insertReport(reportVO);
    }
}