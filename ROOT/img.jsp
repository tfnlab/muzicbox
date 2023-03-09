<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%
    String firstName = request.getParameter("filename");
    String filetype = request.getParameter("filetype");
    int fileno = 0;
    if (request.getParameter("fileno") != null && !request.getParameter("fileno").isEmpty()) {
      fileno = Integer.parseInt(request.getParameter("fileno"));
      APIConfig conf = new APIConfig();

      // Get the directory path and list all PNG files
      String dirPath = conf.getPdfloc() +  "../img/";
      File dir = new File(dirPath);
      File[] files = dir.listFiles(new FilenameFilter() {
          public boolean accept(File dir, String name) {
              return name.toLowerCase().endsWith(".png");
          }
      });

      Arrays.sort(files, new Comparator<File>() {
          public int compare(File f1, File f2) {
              return Long.compare(f1.lastModified(), f2.lastModified());
          }
      });


     int count = 0;
      for (File file : files) {
        if(count == fileno){
            firstName = file.getName().replaceAll("\\.png$", "");
        }
        count += 1;
      }
    }

    APIConfig conf = new APIConfig();
    String filename = firstName + ".png";
    String download_filename = filename;
    String filepath = conf.getPdfloc();
    String logofilepath  = filepath +  "../img/" + filename;
    File file = new File(logofilepath + ".gif");
    response.setContentType("image/jpeg");
    if (file.exists() && filetype ==null) {
      response.setContentType("image/gif");
      logofilepath += ".gif";
      download_filename += ".gif";
    }
//    response.setContentLength(new File(logofilepath).length());
    response.setHeader("Content-Length", String.valueOf(new File(logofilepath).length()));
    response.setHeader("Content-Disposition", "attachment;filename=\"" + download_filename + "\"");


    FileInputStream fis = new FileInputStream(logofilepath);
    byte[] buffer = new byte[1024];
    int length;
    while ((length = fis.read(buffer)) > 0) {
      response.getOutputStream().write(buffer, 0, length);
    }
    fis.close();
%>
