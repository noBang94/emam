package kr.or.ddit.emam.notification.service;

import kr.or.ddit.emam.notification.dao.INotificationDao;
import kr.or.ddit.emam.notification.dao.NotificationDaoImpl;
import kr.or.ddit.emam.vo.NotificationVO;

import java.util.List;

public class NotificationServiceImpl implements INotificationService {

    //dao객체
    private INotificationDao dao;
    //자신의 객체
    private static INotificationService service;

    //생성자 - dao객체 열기
    private NotificationServiceImpl() { dao = NotificationDaoImpl.getInstance(); }

    //자신의 객체를 생성하고 리턴하는 메소드
    public static INotificationService getInstance() {
        if (service == null) service = new NotificationServiceImpl();
        return service;
    }

    //알림 리스트
    @Override
    public List<NotificationVO> selectNotification(String mem_id) { return dao.selectNotification(mem_id); }

    //미확인 알림 갯수 구하기
    @Override
    public int totalCount(String mem_id) { return dao.totalCount(mem_id); }

    //알림 발생
    @Override
    public int insertNotification(NotificationVO notificationVo) { return dao.insertNotification(notificationVo); }

    //알림 삭제
    @Override
    public int deleteNotification(int num) { return dao.deleteNotification(num); }

    //알림 확인
    @Override
    public int updateNotification(int num) { return dao.updateNotification(num); }

    @Override
    public int selectOneNotification(NotificationVO notificationVo) { return dao.selectOneNotification(notificationVo); }

    @Override
    public int selectIlikeNotification(NotificationVO notificationVo) { return dao.selectIlikeNotification(notificationVo); }
}
