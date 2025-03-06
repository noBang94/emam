package kr.or.ddit.emam.notification.service;

import kr.or.ddit.emam.vo.NotificationVO;

import java.util.List;

public interface INotificationService {
    //알림 리스트
    public List<NotificationVO> selectNotification(String mem_id);

    //미확인 알림 갯수 구하기
    public int totalCount(String mem_id);

    //알림 발생
    public int insertNotification(NotificationVO notificationVo);

    //알림 삭제
    public int deleteNotification(int num);

    //알림 확인
    public int updateNotification(int num);
}
