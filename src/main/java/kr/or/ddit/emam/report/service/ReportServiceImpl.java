package kr.or.ddit.emam.report.service;


import kr.or.ddit.emam.report.dao.IReportDao;
import kr.or.ddit.emam.report.dao.ReportDaoImpl;
import kr.or.ddit.emam.vo.ReportVO;

import java.util.List;

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

    @Override
    public ReportVO getReport(int reportIndex) {
        return dao.getReport(reportIndex);
    }

    @Override
    public List<ReportVO> selectAllReport(String getReport) {
        return dao.selectAllReport(getReport);
    }

    @Override
    public List<ReportVO> searchReportId(String searchTitle) {
        return dao.searchReportId(searchTitle);
    }

    @Override
    public int updateReport(int reportId) {
        return dao.updateReport(reportId);
    }
}