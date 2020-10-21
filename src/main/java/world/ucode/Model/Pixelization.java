package world.ucode.Model;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;

public class Pixelization extends ChangingImageAbstract {
    public Pixelization(HttpServletRequest request) throws IOException, ServletException {
        super(request);
    }
    @Override
    public void makeAction() throws IOException {
        BufferedImage img = getOriginalImage();

        // loop through the image and produce squares pixelSize*pixelSize
        for(int w = 0 ; w < img.getWidth() ; w+=2)
        {
            for(int h = 0 ; h < img.getHeight() ; h+=2)
            {
                Color pixelColor = new Color(img.getRGB(w, h));

                Graphics graphics = img.getGraphics();
                graphics.setColor(pixelColor);
                graphics.fillRect(w, h, 2, 2);
            }
        }
        saveNewImage(img, "px_");
    }
}
