package world.ucode.Model;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.awt.image.WritableRaster;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
//import java.util.

public class Pixelization extends ChangingImageAbstract {
    private int PIX_SIZE;
    public Pixelization(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        super(request, response);
        PIX_SIZE = Integer.parseInt(request.getParameter("pixels"));
    }
    @Override
    public void makeAction() throws IOException {
        BufferedImage img = getOriginalImage();

        // loop through the image and produce squares pixelSize*pixelSize
        for(int w = 0 ; w < img.getWidth() ; w+=PIX_SIZE) {
            for(int h = 0 ; h < img.getHeight() ; h+=PIX_SIZE) {
                Color pixelColor = new Color(img.getRGB(w, h));
                Graphics graphics = img.getGraphics();
                graphics.setColor(pixelColor);
                graphics.fillRect(w, h, PIX_SIZE, PIX_SIZE);
            }
        }
        saveNewImage(img, "px_");
    }
    
    @Override
    public String getNewFileName() {
        return "px_" + getFileName();
    }
}
