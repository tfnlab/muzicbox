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


        // Validate form data
        if (meme_text != null && meme_text.trim().length() > 0) {
          if(!request.getParameter("popular_meme_subjects").equals("select_subject")){
            meme_text += " " + request.getParameter("popular_meme_subjects") ;
          }
          try{
               Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/meme.py", "'" + meme_text + "'", uuid).start();
               String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
               String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
               ocrDescription = stdout + stderr + " MEME " ;

           }catch(IOException ex){
               ocrDescription = ex.getMessage();
           }

        }
        APIConfig conf = new APIConfig();

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
          <label for="popular-meme-subjects">Select a Popular Meme Subject:</label>
          <select name="popular_meme_subjects" id="popular_meme_subjects" class="form-control" >
            <option value="select_subject">Select Subject</option>
            <option value="pepe">Pepe</option>
            <option value="moonbirds">Moonbirds</option>
            <option value="cryptoads">Cryptoads</option>
            <option value="mfernft">Mfer</option>
            <option value="doge">Doge</option>
            <option value="grumpy-cat">Grumpy Cat</option>
            <option value="bad-luck-brian">Bad Luck Brian</option>
            <option value="distracted-boyfriend">Distracted Boyfriend</option>
            <option value="success-kid">Success Kid</option>
            <option value="drake-hotline-bling">Drake Hotline Bling</option>
            <option value="woman-yelling-at-a-cat">Woman Yelling at a Cat</option>
            <option value="surprised-pikachu">Surprised Pikachu</option>
            <option value="this-is-fine">This is Fine</option>
            <option value="rickroll">Rickroll</option>
            <option value="expanding-brain">Expanding Brain</option>
            <option value="the-dress">The Dress</option>
            <option value="hide-the-pain-harold">Hide the Pain Harold</option>
            <option value="y-u-no">Y U No</option>
            <option value="shut-up-and-take-my-money">Shut Up and Take My Money</option>
            <option value="aliens-guy">Aliens Guy</option>
            <option value="two-buttons">Two Buttons</option>
            <option value="ight-imma-head-out">Ight Imma Head Out</option>
            <option value="arthur-fist">Arthur Fist</option>
            <option value="drake_hotline_bling">Drake Hotline Bling</option>
            <option value="pikachu_surprised">Pikachu Surprised</option>
            <option value="kermit-tea">Kermit Tea</option>
            <option value="crying-cat">Crying Cat</option>
            <option value="confused-mr-krabs">Confused Mr. Krabs</option>
            <option value="dank-meme">Dank Meme</option>
            <option value="mocking-spongebob">Mocking Spongebob</option>
            <option value="evil-toddler">Evil Toddler</option>
            <option value="travolta-confused">Travolta Confused</option>
            <option value="distracted-puppy">Distracted Puppy</option>
            <option value="gru-plan">Gru Plan</option>
            <option value="karen">Karen</option>
            <option value="roll-safe">Roll Safe</option>
            <option value="wait-thats-illegal">Wait, That's Illegal</option>
            <option value="spongebob-imagination">Spongebob Imagination</option>
            <option value="savage-patrick">Savage Patrick</option>
            <option value="you-know-i-had-to-do-it-to-em">You Know I Had to Do It to Em</option>
            <option value="mr-bean">Mr. Bean</option>
            <option value="the-most-interesting-man-in-the-world">The Most Interesting Man in the World</option>
            <option value="bad-joke-eel">Bad Joke Eel</option>
            <option value="change-my-mind">Change My Mind</option>
            <option value="HODL">HODL</option>
            <option value="To the Moon">To the Moon</option>
            <option value="Lambo">Lambo</option>
            <option value="Buy the Dip">Buy the Dip</option>
            <option value="Diamond Hands">Diamond Hands</option>
            <option value="FOMO">FOMO</option>
            <option value="FUD">FUD</option>
            <option value="Shiba Inu Coin">Shiba Inu Coin</option>
            <option value="NFT">NFT</option>
            <option value="Gas Fees">Gas Fees</option>
            <option value="Smart Contracts">Smart Contracts</option>
            <option value="DeFi">DeFi</option>
            <option value="Crypto Winter">Crypto Winter</option>
            <option value="Bitcoin Pizza">Bitcoin Pizza</option>
            <option value="Crypto Kitties">Crypto Kitties</option>
            <option value="Satoshi Nakamoto">Satoshi Nakamoto</option>
            <option value="Whale Watching">Whale Watching</option>
            <option value="Rug Pull">Rug Pull</option>
            <option value="Hype Coin">Hype Coin</option>
            <option value="Moonshot">Moonshot</option>
            <option value="Bitcoin Ordinals">Bitcoin Ordinals</option>
            <option value="Metaverse">Metaverse</option>
          </select>
          </div>

          <HR>
          <div class="form-group">
            <label for="meme-text">Enter the topic for your meme: (NFT, Degen, WAGMI ...)</label>
            <input type="text" class="form-control" id="meme_text" name="meme_text" required>
          </div>
          <HR>
          <button type="submit" class="btn btn-primary">Create Meme</button>
        </form>
        <HR>
          <a href="index.jsp?animationStop=true" >Animate</a>
        <!--<small><%=ocrDescription%></small>-->
        <%
           if (meme_text != null && meme_text.trim().length() > 0) {
              File newimage = new File(dirPath + uuid + ".png");

              if (newimage.exists()) {
                %>
                <!--<small><%=ocrDescription%></small>-->
                      <HR>
                      <div class="jumbotron">
                        <div class="container">
                          <div class="row">
                            <div class="col-md-6 offset-md-3 text-center">
                              <a href="index.meme.jsp?meme_id=<%=uuid %>" >
                              <img src="img.jsp?filename=<%=uuid %>" alt="<%=uuid %>" class="img-fluid">
                              </a>
                              <h1><%=uuid %></h1>
                            </div>
                          </div>
                        </div>
                      </div>
                      <HR>

                <%
              } else {
                %>
                Listen up, my friend. This is a delicate process we've got going on here. We've hit a few snags while trying to bring your artistic vision to life, but don't you worry. We didn't get to where we are today by throwing in the towel at the first sign of trouble. No sir, we're made of sterner stuff than that.
                <BR>
                <BR>

                So, here's what you gotta do. Just <b>click</b> that <b>refresh</b> button like your life depends on it. Give it another shot, see if that fixes things up. And if it doesn't, well, then you gotta get a little creative. <b>Change the wording up a bit</b>, switch things around, see if that helps.
                <BR>
                <BR>

                We're in this together, you and me. We're not gonna let a little setback stop us from achieving greatness. No way, no how. So let's saddle up and ride this thing out, come hell or high water. Yeehaw!
                <BR>
                <BR>
                <%
              }
           }else{
             %><HR><%
           }
        %>

    <div class="d-flex flex-wrap">
      <% int count = 0;%>
      <% int countDown = files.length -1; %>
      <% for (File file : files) { %>
        <% count += 1; %>
        <%if(count<100 || request.getParameter("showall")!=null){%>
        <div class="col-md-6 col-lg-4 mb-4">
          <div class="card">
            <div class="card-body">
              <a href="index.meme.jsp?mb_id=<%=file.getName().replaceAll("\\.mp4$", "") %>" >

              <div class="col-md-8 mx-auto">
                <video src="https://meta.makotodigital.art/mp4/<%=file.getName()%>" class="w-100" controls></video>
              </div>
              </a>
              <h5 class="card-title mt-3">NFT #<%=countDown%></h5>
              <HR>
              <a href="https://opensea.io/assets/ethereum/0xac1e192a284d54f442d97bee44256eef7425d7a1/<%=countDown %>" >
              Opensea
              </a>
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
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-HH16PDS3VF"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-HH16PDS3VF');
  </script>
</body>
</html>
