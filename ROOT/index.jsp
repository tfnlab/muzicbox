<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Arrays" %>

<html>
<head>

<title>MuzicBox.xyz</title>
<meta name="description" content="Meme Genesis is a website that provides a collection of the latest and most popular memes on the internet. Our website is updated daily with new memes, and we have a community section where users can submit their own memes. Join us to stay up-to-date with the funniest memes on the web!">
<meta name="keywords" content="meme, memes, funny memes, internet memes, viral memes, popular memes, meme collection, meme community, submit memes">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
      <a class="navbar-brand" href="index.jsp">MuzicBox.xyz</a>
      <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="https://muzicbox.makotodigital.art/">Mint</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="https://opensea.io/collection/muzicbox">OpenSea</a>
        </li>
      </ul>
      <!--
      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
      </form>
      -->
    </div>
  </nav>

  <div class="container mt-5">
      <h4>The Muzic Box</h4>

    <%
        // Create an instance of the APIConfig class
        String meme_text = request.getParameter("meme_text");
        String uuid = java.util.UUID.randomUUID().toString();
        String ocrDescription = "";


        APIConfig conf = new APIConfig();
        // Validate form data
        if (meme_text != null && meme_text.trim().length() > 0) {
          if(!request.getParameter("popular_meme_subjects").equals("select_subject")){
            meme_text += " " + request.getParameter("popular_meme_subjects") ;
          }
          try{
//               Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/aigl.w.py", "'" + meme_text + "'", uuid).start();
//               String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
//               String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
//               ocrDescription = stdout + stderr + " MEME " ;

               File file = new File(conf.getPdfloc() + "mr/" + "rm." + uuid.toString() + ".txt");
               FileWriter fw = new FileWriter(file);
               BufferedWriter bw = new BufferedWriter(fw);
               bw.write(meme_text);
               bw.close();

           }catch(IOException ex){
               ocrDescription = ex.getMessage();
           }

        }

        // Get the directory path and list all PNG files
        String dirPath = conf.getPdfloc() +  "../img/mp4/";
        File dir = new File(dirPath);
        File[] files = dir.listFiles(new FilenameFilter() {
            public boolean accept(File dir, String name) {
                return name.toLowerCase().endsWith(".mp4");
            }
        });

        Arrays.sort(files, new Comparator<File>() {
            public int compare(File f1, File f2) {
                return Long.compare(f2.lastModified(), f1.lastModified());
            }
        });
        %>
        <HR>
          Unleashing creativity with every loop: <B><%=files.length%></B> amount of loop riffs and stems created.
        <HR>

        <form method="POST" action="index.jsp">

            <div class="form-group">
          <label for="popular-meme-subjects">Select Type (Loop, Riff or Stem):</label>
          <select name="popular_meme_subjects" id="popular_meme_subjects" class="form-control" >
            <option value="select_subject">Select Type</option>
            <%
            String[] music_loops = { "Drum loop", "Bassline loop", "Melodic loop",
                                     "Chord progression loop", "Arpeggio loop", "Vocal loop",
                                     "FX loop", "Percussion loop", "Top loop", "Breakbeat loop",
                                     "drum stem", "bass stem", "melody stem", "vocal stem",
                                     "pads/atmospheres stem", "fx stem", "Blues riff",
                                     "Rock riff", "Metal riff", "Funk riff", "Jazz riff",
                                     "Reggae riff", "Hip-hop riff", "Pop riff", "Country riff" };

            %>
            <% for (String loop : music_loops) { %>
              <option value="<%= loop %>"><%= loop %></option>
            <% } %>
          </select>
          </div>

          <HR>
          <div class="form-group">
            <label for="meme-text">Enter the text for your music: (i.e. Style of Eric Clapton)</label>
            <input type="text" class="form-control" id="meme_text" name="meme_text" required>
          </div>
          <HR>
          <button type="submit" class="btn btn-primary">Create</button>
        </form>
        <HR>
        <small><%=ocrDescription%></small>
        <%
           if (meme_text != null && meme_text.trim().length() > 0) {
              %>
                <HR>
                The MuzicBox is Working on your Request
                <HR>
                We have received your request to create an audio file, please be patient as this is a delicate process and it may take up to a minute to generate the file. If there were no errors, you can check back in a minute and the audio file will be listed here. Thank you for choosing our service.
                <HR>
              <%
           }else{
             %><HR><%
           }
        %>

    <div class="d-flex flex-wrap">
      <% int count = 0;%>
      <% int countDown = files.length -1; %>
      <% for (File file : files) { %>
        <% count += 1; %>
        <%if(count<31 || request.getParameter("showall")!=null){%>
        <div class="col-md-6 col-lg-4 mb-4">
          <div class="card">
            <div class="card-body">

              <div class="col-md-8 mx-auto">
                <video src="https://meta.makotodigital.art/mp4/<%=file.getName()%>" class="w-100" controls></video>
              </div>
              <h5 class="card-title mt-3">NFT #<%=countDown%></h5>
              <HR>
              Download
              <a href="https://meta.makotodigital.art/music/<%=countDown %>.mid" controls><i class="fas fa-download"></i> Mid</a>
              <a href="https://meta.makotodigital.art/mp3/<%=countDown %>.mp3" controls><i class="fas fa-download"></i>  Mp3</a>
              <HR>
              <a href="https://opensea.io/assets/ethereum/0xac1e192a284d54f442d97bee44256eef7425d7a1/<%=countDown %>" >
              Opensea
              </a>
              <hr>
              <img src="https://meta.makotodigital.art/mp4image/<%=countDown %>.png" class="img-fluid"/>
            </div>
          </div>
        </div>
        <% countDown -= 1; %>
        <%}%>
      <% } %>
      <HR>
      <%if(request.getParameter("showall")==null){%>
      <a href="index.jsp?showall=true" >show all</a>
      <%}%>
      <HR>
    </div>

  </div>

  <footer class="bg-light text-center text-lg-start">
    <!-- Copyright -->
    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
      2023 Copyright:
      <a class="text-dark" href="https://tfnlab.com/">TFNLab.com</a>
    </div>
    <!-- Copyright -->
  </footer>

  <!-- Google tag (gtag.js) -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-1VPBKWMBT3"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-1VPBKWMBT3');
  </script>
</body>
</html>
