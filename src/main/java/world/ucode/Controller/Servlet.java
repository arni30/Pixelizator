package world.ucode.Controller;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import world.ucode.Model.ChangingImageAbstract;
import world.ucode.Model.Router;

@WebServlet(name = "Servlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
        maxFileSize=1024*1024*10,      // 10MB
        maxRequestSize=1024*1024*50)   // 50MB
public class Servlet extends HttpServlet {
    private final Router router = new Router();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/View/mainPage.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        ChangingImageAbstract changingImage = (ChangingImageAbstract) router.makeActionObject("pixelate", request);
        changingImage.makeAction();
        request.setAttribute("path", changingImage.getNewImagePath());
        getServletContext().getRequestDispatcher("/View/mainPage.jsp").forward(
                request, response);
    }
}
