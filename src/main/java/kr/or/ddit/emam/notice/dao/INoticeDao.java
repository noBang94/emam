package kr.or.ddit.emam.notice.dao;

import kr.or.ddit.emam.vo.NoticeVO;

import java.util.List;

public interface INoticeDao {

    public NoticeVO getNotice(int noticeIndex);

    public List<NoticeVO> selectAllNotice(String getNotice);

    public List<NoticeVO> searchTitle(String searchTitle);

}
