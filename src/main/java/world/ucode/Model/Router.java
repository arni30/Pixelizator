package world.ucode.Model;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class Router {
    public Object makeActionObject(String action, HttpServletRequest request) throws IOException, ServletException {
        switch (action) {
            case "pixelate":
                return new Pixelization(request);
            case "blacAndWhite":
                return new BlackAndWhite(request);
            default:
                return null;
        }
    }
}
