package service.member;

import java.util.List;
import org.apache.ibatis.session.SqlSession;

import dao.gym.GymMainDao;
import dao.gym.GymMainDaoImpl;
import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dao.member.UserDAO;
import dao.member.UserDAOImpl;
import dto.gym.Gym;
import dao.trainer.TrainerDAO;
import dao.trainer.TrainerDAOImpl;
import dto.gym.Gym;
import dto.member.MemberDTO;
import dto.common.UserDTO;
import dto.trainer.TrainerDTO;
import util.MybatisSqlSessionFactory;

public class UserServiceImpl implements UserService {

    private UserDAO userDAO = new UserDAOImpl();
    private GymMainDao gymMainDAO = new GymMainDaoImpl();
    private MemberDAO memberDAO = new MemberDAOImpl();
    private TrainerDAO trainerDAO = new TrainerDAOImpl();

    @Override
    public int register(UserDTO dto) {
        if (userDAO.isEmailExists(dto.getEmail())) return 0;
        
        // 기본 역할 설정
        if (dto.getRole() == null || dto.getRole().isEmpty()) {
            dto.setRole("MEMBER");
        }
        return userDAO.insert(dto);
    }

    @Override
    public int registerSocial(UserDTO dto) {
        if (userDAO.findByEmail(dto.getEmail()) != null) return 0;
        dto.setRole("MEMBER");
        return userDAO.insertSocial(dto);
    }

    @Override
    public UserDTO login(String email, String password) throws Exception {
        UserDTO user = userDAO.findByEmailAndPassword(email, password);
        if (user != null && !user.isDeleted()) {
        	String role = user.getRole();
        	if(role.equals("GYM")) {
        		Gym gym = gymMainDAO.selectGymByUserId(user.getId());
        		user.setOtherId(gym.getId()); // gymId  userDTO에 추가
        	} else if (role.equals("MEMBER")) {
        		MemberDTO member = memberDAO.selectMemberByUserId(user.getId());
        		user.setOtherId(member.getId()); // memberId userDTO에 추가
        	} else if(role.equals("TRAINER")) {               
                try(SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
                	TrainerDTO trainer = trainerDAO.findByUserId(session, user.getId());
                	user.setOtherId(trainer.getTrainerId());	
                } 

        	}
            return user;
        }
        return null;
    }

    @Override
    public boolean isEmailExists(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        return userDAO.isEmailExists(email);
    }

    @Override
    public UserDTO findByEmail(String email) { 
        return userDAO.findByEmail(email); 
    }

    @Override
    public List<UserDTO> findAll() { 
        return userDAO.findAll(); 
    }

    @Override
    public int update(UserDTO dto) { 
        return userDAO.update(dto); 
    }

    @Override
    public int updatePassword(String email, String password) {
        return userDAO.updatePassword(email, password);
    }

    @Override
    public int delete(int id) { 
        return userDAO.delete(id); 
    }
}