package service.member;

import java.util.List;
import org.apache.ibatis.session.SqlSession;

import dao.gym.GymProfileDAO;
import dao.gym.GymProfileDAOImpl;
import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dao.member.UserDAO;
import dao.member.UserDAOImpl;
import dto.common.Gym;
import dao.trainer.TrainerDAO;
import dao.trainer.TrainerDAOImpl;
import dto.member.MemberDTO;
import dto.common.UserDTO;
import dto.common.TrainerDTO;
import util.MybatisSqlSessionFactory;
import util.PasswordUtil;

public class UserServiceImpl implements UserService {

    private UserDAO userDAO = new UserDAOImpl();
    private GymProfileDAO gymProfileDAO = new GymProfileDAOImpl();
    private MemberDAO memberDAO = new MemberDAOImpl();
    private TrainerDAO trainerDAO = new TrainerDAOImpl();

    @Override
    public int register(UserDTO dto) {
        if (userDAO.isEmailExists(dto.getEmail())) return 0;
        
        // 기본 역할 설정
        if (dto.getRole() == null || dto.getRole().isEmpty()) {
            dto.setRole("MEMBER");
        }
        if (dto.getPassword() != null && !PasswordUtil.isBcryptHash(dto.getPassword())) {
            dto.setPassword(PasswordUtil.hash(dto.getPassword()));
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
        UserDTO user = userDAO.findByEmail(email);
        if (user == null || user.isDeleted()) {
            return null;
        }
        if (!PasswordUtil.verify(password, user.getPassword())) {
            return null;
        }
        if (!PasswordUtil.isBcryptHash(user.getPassword())) {
            userDAO.updatePassword(email, PasswordUtil.hash(password));
        }
        if (!user.isDeleted()) {
        	String role = user.getRole();
        	if(role.equals("GYM")) {
        		Gym gym = gymProfileDAO.selectGymByUserId(user.getId());
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
        return userDAO.updatePassword(email, PasswordUtil.hash(password));
    }

    @Override
    public int delete(int id) { 
        return userDAO.delete(id); 
    }
}