package kr.or.ddit.emam.report.dao;

import kr.or.ddit.emam.vo.ReportVO;

import java.util.List;

public interface IReportDao {
    //신고하기
    public int insertReport(ReportVO reportVO);


    public ReportVO getReport(int reportIndex);
    public List<ReportVO> selectAllReport(String getReport);
    public List<ReportVO> searchReportId(String searchTitle);

    int updateReport(int reportId);
}


