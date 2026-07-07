package filter;

import dto.common.UserDTO;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class GymAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        UserDTO loginUser = session != null ? (UserDTO) session.getAttribute("loginUser") : null;

        if (loginUser == null || !"GYM".equals(loginUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/member/login");
            return;
        }

        Integer gymId = session != null ? (Integer) session.getAttribute("gymId") : null;
        if (gymId == null) {
            gymId = loginUser.getOtherId();
        }
        if (gymId == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login");
            return;
        }

        chain.doFilter(request, response);
    }
}
