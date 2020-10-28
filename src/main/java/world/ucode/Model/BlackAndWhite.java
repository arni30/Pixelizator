package world.ucode.Model;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;

public class BlackAndWhite extends ChangingImageAbstract {
    public BlackAndWhite(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        super(request, response);
    }
    @Override
    public void makeAction() throws IOException {
        BufferedImage blackAndWhiteImg = new BufferedImage(
                super.getOriginalImage().getWidth(), super.getOriginalImage().getHeight(),
                BufferedImage.TYPE_BYTE_BINARY);

        Graphics2D graphics = blackAndWhiteImg.createGraphics();
        graphics.drawImage(super.getOriginalImage(), 0, 0, null);
        saveNewImage(blackAndWhiteImg, "bw_");
    }
    @Override
    public String getNewFileName() {
        return "bw_" + getFileName();
    }
}
