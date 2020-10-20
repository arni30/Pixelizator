package world.ucode;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.awt.image.WritableRaster;
import java.io.*;
import java.util.Iterator;
import java.util.List;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "Servlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
        maxFileSize=1024*1024*10,      // 10MB
        maxRequestSize=1024*1024*50)   // 50MB
public class Servlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer count = (Integer)session.getAttribute("count");
//        if(count == null)
//            session.setAttribute("count", 1);
//        else
//            session.setAttribute("count", count + 1);
        request.getRequestDispatcher("mainPage.jsp").forward(request, response);
    }
    /**
     * Name of the directory where uploaded files will be saved, relative to
     * the web application directory.
     */
    private static final String SAVE_DIR = "uploadFiles";

    /**
     * handles file upload
     */
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        String fileName = null;
        // gets absolute path of the web application
        String appPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        String savePath = appPath + File.separator + SAVE_DIR;

        // creates the save directory if it does not exists
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        for (Part part : request.getParts()) {
            fileName = extractFileName(part);
            // refines the fileName in case it is an absolute path
            fileName = new File(fileName).getName();
            part.write(savePath + File.separator + fileName);
        }

        /*
         делает изображение черно белым
         */
//        File file = new File(savePath + File.separator + fileName);
//        BufferedImage orginalImage = ImageIO.read(file);
//
//        BufferedImage blackAndWhiteImg = new BufferedImage(
//                orginalImage.getWidth(), orginalImage.getHeight(),
//                BufferedImage.TYPE_BYTE_BINARY);
//
//        Graphics2D graphics = blackAndWhiteImg.createGraphics();
//        graphics.drawImage(orginalImage, 0, 0, null);
//
//        ImageIO.write(blackAndWhiteImg, "png", new File(savePath + File.separator + "bw_" + fileName));



        /*
         делает пикселизацию
         */
        // Write the new file
        BufferedImage img = ImageIO.read(new File(savePath + File.separator + fileName));

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
        ImageIO.write(img, "png", new File(savePath  + File.separator + "px_"+ fileName));

        /*
        отправка ответа
            если нужно черно белое, то px_ поменять на bw_
         */
        request.setAttribute("path", SAVE_DIR + File.separator + "px_" + fileName);
        getServletContext().getRequestDispatcher("/mainPage.jsp").forward(
                request, response);
    }
    /**
     * Extracts file name from HTTP header content-disposition
     */

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
        return "";
    }
}
