package controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import dto.member.TrainerCertificationDTO;
import dto.member.TrainerPricingDTO;
import dto.member.TrainerSpecializationDTO;
import util.MybatisSqlSessionFactory;

@WebServlet("/member/trainerDetail")
public class TrainerDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int trainerId = 0;
        try {
            trainerId = Integer.parseInt(req.getParameter("trainerId"));
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/member/trainerList");
            return;
        }

        Map<String,Object> trainer = null;
        List<TrainerPricingDTO> pricingList = new ArrayList<>();
        List<TrainerSpecializationDTO> specList = new ArrayList<>();
        List<TrainerCertificationDTO> certList = new ArrayList<>();

        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            trainer = sql.selectOne("mapper.TrainerMapper.findById", trainerId);
        }
        
        if (trainer != null) {
            try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {        	
                pricingList = sql.selectList("mapper.TrainerPricingMapper.findByTrainerId", trainerId);
            } catch(Exception e) {
            	e.printStackTrace();
            }
            try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {        	
                specList    = sql.selectList("mapper.TrainerSpecializationMapper.findByTrainerId", trainerId);
            }catch(Exception e) {
            	e.printStackTrace();
            }
            try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {        	
                certList    = sql.selectList("mapper.TrainerCertificationMapper.findByTrainerId", trainerId);
            }catch(Exception e) {
            	e.printStackTrace();
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/member/trainerList");
            return;
        }

        req.setAttribute("trainer",     trainer);
        req.setAttribute("pricingList", pricingList);
        req.setAttribute("specList",    specList);
        req.setAttribute("certList",    certList);
        System.out.println(trainer);
        System.out.println(pricingList);
        System.out.println(specList);
        System.out.println(certList);

        req.getRequestDispatcher("/member/trainerDetail.jsp").forward(req, resp);
    }
}
