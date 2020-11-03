package world.ucode.Model;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public abstract class ChangingImageAbstract {
    private static final String SAVE_DIR = "uploadFiles";
    private String imageSavePath;
    private String fileName;
    private BufferedImage originalImage;
    private String newImagePath;
    private String newFileName;
    private HttpServletResponse response;
    private HttpServletRequest request;

    public ChangingImageAbstract(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.response = response;
        this.request = request;
        String appPath = request.getServletContext().getRealPath("");
        imageSavePath = appPath + File.separator + SAVE_DIR;
        fileName = makeFileName(request);
        try{
        originalImage = ImageIO.read(new File(imageSavePath + File.separator + fileName));
        }
        catch (Exception c){
            System.out.println("error");
        }
    }
    public String getImageSavePath() {
        return imageSavePath;
    }
    public String getFileName() {
        return fileName;
    }
    public BufferedImage getOriginalImage() {
        return originalImage;
    }
    public String getNewImagePath() {
        return newImagePath;
    }

    // creates the save directory if it does not exists
    private void checkDirExisting() {
        File fileSaveDir = new File(imageSavePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
    }
    public void makeAction() throws IOException {
    }
    private String makeFileName(HttpServletRequest request) throws IOException, ServletException {
        checkDirExisting();
        for (Part part : request.getParts()) {
            if (extractFileName(part).length() != 0) {
                fileName = extractFileName(part);
                // refines the fileName in case it is an absolute path
                fileName = new File(fileName).getName();
                part.write(imageSavePath + File.separator + fileName);
            }
        }
        return fileName;
    }


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
    public void saveNewImage(BufferedImage newImg, String prefix) throws IOException {
        newImagePath = imageSavePath + File.separator + prefix + fileName;
        ImageIO.write(newImg, "jpg", new File(newImagePath));
    }
    public String getNewFileName() {
        return null;
    }
}
