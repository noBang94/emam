package kr.or.ddit.emam.notification.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.NotificationVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class NotificationDaoImpl implements INotificationDao {

    //싱글톤
    private static INotificationDao dao;
    private NotificationDaoImpl() {}

    //자신의 객체를 생성하고 리턴하는 메소드
    public static INotificationDao getInstance() {
        if (dao == null) dao = new NotificationDaoImpl();
        return dao;
    }

    //알림 리스트
    @Override
    public List<NotificationVO> selectNotification(String mem_id) {
        List<NotificationVO> list = null;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            list = session.selectList("notification.selectNotification", mem_id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    //미확인 알림 갯수 구하기
    @Override
    public int totalCount(String mem_id) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.selectOne("notification.totalCount", mem_id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return res;
    }

    //알림 발생
    @Override
    public int insertNotification(NotificationVO notificationVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.insert("notification.insertNotification", notificationVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //알림 삭제
    @Override
    public int deleteNotification(int num) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.delete("notification.deleteNotification", num);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //알림 확인
    @Override
    public int updateNotification(int num) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.update("notification.updateNotification", num);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //타겟과 타입으로 해당하는 알림 index 구하기
    @Override
    public int selectOneNotification(NotificationVO notificationVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.update("notification.selectOneNotification", notificationVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }
}
