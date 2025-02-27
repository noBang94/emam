package kr.or.ddit.emam.report.dao;

import kr.or.ddit.emam.vo.ReportVO;

public interface IReportDao {
    //신고하기
    public int insertReport(ReportVO reportVO);

}


