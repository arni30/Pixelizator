package world.ucode.Model;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.awt.image.WritableRaster;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
//import java.util.

public class Pixelization extends ChangingImageAbstract {
    public Pixelization(HttpServletRequest request) throws IOException, ServletException {
        super(request);
    }
    @Override
    public void makeAction() throws IOException {
        BufferedImage img = getOriginalImage();
        final int PIX_SIZE = 10;
        // loop through the image and produce squares pixelSize*pixelSize
        for(int w = 0 ; w < img.getWidth() ; w+=PIX_SIZE) {
            for(int h = 0 ; h < img.getHeight() ; h+=PIX_SIZE) {
                Color pixelColor = new Color(img.getRGB(w, h));
                Graphics graphics = img.getGraphics();
                graphics.setColor(pixelColor);
                graphics.fillRect(w, h, PIX_SIZE, PIX_SIZE);
            }
        }
//        final int PIX_SIZE = 10;
//        // Read the file as an Image
//        BufferedImage img = getOriginalImage();
//        // Get the raster data (array of pixels)
//        Raster src = img.getData();
//        // Create an identically-sized output raster
//        WritableRaster dest = src.createCompatibleWritableRaster();
//        // Loop through every PIX_SIZE pixels, in both x and y directions
//        for(int y = 0; y < src.getHeight(); y += PIX_SIZE) {
//            for(int x = 0; x < src.getWidth(); x += PIX_SIZE) {
//                // Copy the pixel
//                double[] pixel = new double[3];
//                pixel = src.getPixel(x, y, pixel);
//                // "Paste" the pixel onto the surrounding PIX_SIZE by PIX_SIZE neighbors
//                // Also make sure that our loop never goes outside the bounds of the image
//                for(int yd = y; (yd < y + PIX_SIZE) && (yd < dest.getHeight()); yd++) {
//                    for(int xd = x; (xd < x + PIX_SIZE) && (xd < dest.getWidth()); xd++) {
//                        dest.setPixel(xd, yd, pixel);
//                    }
//                }
//            }
//        }
//        // Save the raster back to the Image
//        img.setData(dest);
//        // Write the new file
        saveNewImage(img, "px_");
    }
    
    @Override
    public String getNewFileName() {
        return "px_" + getFileName();
    }
}
