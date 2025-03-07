package kr.or.ddit.emam.usersettings.dao;

import kr.or.ddit.emam.util.MyBatisUtil;
import kr.or.ddit.emam.vo.UsersettingsVO;
import org.apache.ibatis.session.SqlSession;

public class UsersettingsDaoImpl implements IUsersettingsDao {

    //싱글톤
    private static IUsersettingsDao dao;
    private UsersettingsDaoImpl() {}

    //자신의 객체를 생성하고 리턴하는 메소드
    public static IUsersettingsDao getInstance() {
        if (dao == null) dao = new UsersettingsDaoImpl();
        return dao;
    }

    //유저세팅 기본설정
    @Override
    public int insertUsersettings(String mem_id) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.insert("usersettings.insertUsersettings", mem_id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //유저세팅 확인
    @Override
    public UsersettingsVO checkUsersettings(String mem_id) {
        UsersettingsVO usersettingsVO = null;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            usersettingsVO = session.selectOne("usersettings.checkUsersettings", mem_id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return usersettingsVO;
    }

    //유저세팅(생일 외) 변경
    @Override
    public int updateUsersettings(UsersettingsVO usersettingsVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.update("usersettings.updateUsersettings", usersettingsVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }

    //유저세팅(생일 외) 변경
    @Override
    public int updateUsersettingBir(UsersettingsVO usersettingsVo) {
        int res = 0;
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            res = session.update("usersettings.updateUsersettingBir", usersettingsVo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.commit();
            session.close();
        }
        return res;
    }
}
