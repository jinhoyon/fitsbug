package dao.member;

import org.apache.ibatis.session.SqlSession;
import dto.common.UserDTO;
import util.MybatisSqlSessionFactory;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDAOImpl implements UserDAO {

    private static final String NS = "mapper.member.user.";

    @Override
    public int insert(UserDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.insert(NS + "insert", dto);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public int insertSocial(UserDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.insert(NS + "insertSocial", dto);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public UserDTO findByEmailAndPassword(String email, String password) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        UserDTO user = null;
        try {
            Map<String, String> param = new HashMap<>();
            param.put("email", email);
            param.put("password", password);
            user = session.selectOne(NS + "findByEmailAndPassword", param);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return user;
    }

    @Override
    public UserDTO findByEmail(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        UserDTO user = null;
        try {
            user = session.selectOne(NS + "findByEmail", email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return user;
    }

    @Override
    public boolean isEmailExists(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        boolean result = false;
        try {
            int count = session.selectOne(NS + "isEmailExists", email);
            result = count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public List<UserDTO> findAll() {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<UserDTO> list = null;
        try {
            list = session.selectList(NS + "findAll");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    @Override
    public int update(UserDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.update(NS + "update", dto);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public int updatePassword(String email, String password) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            Map<String, String> param = new HashMap<>();
            param.put("email", email);
            param.put("password", password);
            result = session.update(NS + "updatePassword", param);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public int delete(int id) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.update(NS + "delete", id);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }
}
