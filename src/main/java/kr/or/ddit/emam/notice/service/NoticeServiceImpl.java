package kr.or.ddit.emam.notice.service;

import kr.or.ddit.emam.admin.dao.AdminDaoImpl;
import kr.or.ddit.emam.admin.dao.IAdminDao;
import kr.or.ddit.emam.vo.NoticeVO;

import java.util.List;

public class NoticeServiceImpl implements INoticeService {
    private IAdminDao dao;
    private static INoticeService service;

    private NoticeServiceImpl() {
        dao = AdminDaoImpl.getInstance();
    }

    public static INoticeService getInstance() {
        if(service == null)  service = new NoticeServiceImpl();
        return service;
    }

    @Override
    public NoticeVO getNotice(int noticeIndex) {
        return dao.getNotice(noticeIndex);
    }

    @Override
    public int insertNotice(NoticeVO noticeVO) {
        return dao.insertNotice(noticeVO);
    }

    @Override
    public int updateNotice(NoticeVO noticeVO) {
        return dao.updateNotice(noticeVO);
    }

    @Override
    public List<NoticeVO> selectAllNotice(String getNotice) {
        return dao.selectAllNotice(getNotice);
    }

    @Override
    public List<NoticeVO> searchTitle(String searchTitle) {
        return dao.searchTitle(searchTitle);
    }
}


