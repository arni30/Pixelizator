package world.ucode.Controller;
import org.json.simple.JSONObject;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import world.ucode.Model.ChangingImageAbstract;
import world.ucode.Model.Router;

@WebServlet(name = "Servlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
        maxFileSize=1024*1024*10,      // 10MB
        maxRequestSize=1024*1024*50)   // 50MB
public class Servlet extends HttpServlet {
    private final Router router = new Router();

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        ChangingImageAbstract changingImage = (ChangingImageAbstract) router.makeActionObject(request.getParameter("type"), request, response);
        changingImage.makeAction();
        JSONObject jsonArray = new JSONObject();
        jsonArray.put("newFile", changingImage.getNewFileName());
        StringWriter out = new StringWriter();
        jsonArray.writeJSONString(out);
        response.getWriter().write(String.valueOf(out));
    }
}
