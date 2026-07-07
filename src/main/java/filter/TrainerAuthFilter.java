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

public class TrainerAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI();
        String contextPath = req.getContextPath();
        if (isPublicPath(path, contextPath)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session == null || !isAuthenticatedTrainer(session)) {
            resp.sendRedirect(contextPath + "/trainer/login");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublicPath(String path, String contextPath) {
        if (path.equals(contextPath + "/trainer/login")) {
            return true;
        }
        if (path.equals(contextPath + "/trainer/logout")) {
            return true;
        }
        if (path.startsWith(contextPath + "/trainer/signup")) {
            return true;
        }
        return path.equals(contextPath + "/trainer/gymLookup");
    }

    private boolean isAuthenticatedTrainer(HttpSession session) {
        if (session.getAttribute("loginTrainer") != null) {
            return true;
        }
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        return loginUser != null && "TRAINER".equals(loginUser.getRole());
    }
}
