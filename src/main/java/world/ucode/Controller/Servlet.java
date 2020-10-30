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
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        ChangingImageAbstract changingImage = (ChangingImageAbstract) router.makeActionObject("pixelate", request, response);
        changingImage.makeAction();
        System.out.println(request.getParameter("pixels"));
        response.setContentType("image/*");
        request.setAttribute("imgName", changingImage.getNewFileName());
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
