package kr.or.ddit.emam.notice.service;

import kr.or.ddit.emam.admin.dao.AdminDaoImpl;
import kr.or.ddit.emam.admin.dao.IAdminDao;
import kr.or.ddit.emam.notice.dao.INoticeDao;
import kr.or.ddit.emam.notice.dao.NoticeDaoImpl;
import kr.or.ddit.emam.vo.NoticeVO;

import java.util.List;
import java.util.Map;

public class NoticeServiceImpl implements INoticeService {
    private IAdminDao dao;
    private INoticeDao daoImpl = NoticeDaoImpl.getInstance();
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
    public List<NoticeVO> searchTitle(Map<String, Object> params) {
        return daoImpl.searchTitle(params);
    }
}


