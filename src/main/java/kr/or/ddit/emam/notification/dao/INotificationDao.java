package kr.or.ddit.emam.notification.dao;

import kr.or.ddit.emam.vo.NotificationVO;

import java.util.List;

public interface INotificationDao {
    //알림 리스트
    public List <NotificationVO> selectNotification(String mem_id);

    //미확인 알림 갯수 구하기
    public int totalCount(String mem_id);

    //알림 발생
    public int insertNotification(NotificationVO notificationVo);

    //알림 삭제
    public int deleteNotification(int num);

    //알림 확인
    public int updateNotification(int num);

    //타겟과 타입으로 해당하는 알림 index 구하기
    public int selectOneNotification(NotificationVO notificationVo);

    //(좋아요 인덱스가 없어서...) 타겟과 타입과 fromId로 해당하는 알림 index 찾기
    public int selectIlikeNotification(NotificationVO notificationVo);
}
