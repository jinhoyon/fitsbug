package service.admin;

import dao.admin.AdminMainDAO;
import dao.admin.AdminMainDAOImpl;
import dto.admin.AdminMainDTO;

public class AdminMainServiceImpl implements AdminMainService {

	private AdminMainDAO adminMainDAO;
	public AdminMainServiceImpl() {
		adminMainDAO = new AdminMainDAOImpl();
	}
	
	@Override
	public AdminMainDTO getDashboardStats() throws Exception {
		return adminMainDAO.getDashboardStats();
	}

}
