package world.ucode.Model;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Router {
    public Object makeActionObject(String action, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        switch (action) {
            case "pixelate":
                return new Pixelization(request, response);
            case "blacAndWhite":
                return new BlackAndWhite(request, response);
            default:
                return null;
        }
    }
}
