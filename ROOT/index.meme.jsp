<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.mg.mysql.Review" %>
<%@ page import="com.tfnlab.mg.mysql.ReviewDAO" %>
<%@ page import="java.sql.Timestamp" %>
<%

String meme_id = request.getParameter("meme_id");
meme_id = meme_id.replace("/", "").replace(".", "");

%>

<html>
<head>
  <style>
    .thumbnail img {
      width: 100%;
      height: auto;
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 5px;
      box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1);
    }
</style>
<title>PNG Files</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Meme Genesis">
<meta name="twitter:description" content="MemeGenesis.com Meme ID <%=meme_id %>">
<meta name="twitter:image" content="https://memegenesis.com/img.jsp?filename=<%=meme_id %>&filetype=png">
<meta property="og:title" content="Meme Genesis">
<meta property="og:description" content="MemeGenesis.com Meme ID <%=meme_id %>">
<meta property="og:image" content="https://memegenesis.com/img.jsp?filename=<%=meme_id %>&filetype=png">
<meta property="og:url" content="https://www.linkedin.com/sharing/share-offsite/?url=https://memegenesis.com/index.meme.jsp?meme_id=<%=meme_id %>">
<meta property="og:type" content="website">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
  <div class="container mt-5">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="index.jsp">Meme Genesis</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="https://mint.memegenesis.com">Mint</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="https://opensea.io/collection/meme-genesis-1">OpenSea</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="index.rank.jsp">Ranking</a>
          </li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </div>
    </nav>

  </div>
  <div class="container mt-5">
  <h4>The Art of Meme</h4>
  <HR>
<div class="d-flex flex-wrap">
    <div class="p-2">
      <div class="thumbnail">
        <img src="img.jsp?filename=<%=meme_id %>" alt="<%=meme_id %>">
        <HR>
          Tweeter
          <a href="https://twitter.com/share?text=hey%20@genesis_meme%20Check%20out%20this%20meme!%20%23MemeEngagement%20%23LaughOutLoud%20%23NFT%20%23MEMEGENESIS&url=https://memegenesis.com/index.meme.jsp?meme_id=<%=meme_id %>" target="_blank">
        <i class="fa fa-share"></i>
        </a>
      </div>
    </div>
    <div class="p-2">
      <div class="thumbnail">
        <img src="img.jsp?filetype=png&filename=<%=meme_id %>" alt="<%=meme_id %>">
        
      </div>
    </div>
</div>

  </div>


  <div class="container mt-5">
  <%
    ReviewDAO reviewDAO = new ReviewDAO();
    if (request.getMethod().equals("POST")) {
        // Get the form data and create a new Review object
      int memeId = Integer.parseInt("0");
      String meme_uuid = request.getParameter("meme_id");
      int rating = Integer.parseInt(request.getParameter("rating"));
      String comment = request.getParameter("comment");
      Timestamp now = new Timestamp(System.currentTimeMillis());
      Review review = new Review(0, memeId, rating, comment, now, now, meme_uuid);

      // Use the ReviewDAO object to insert the new review into the database
      try {
        reviewDAO.insertReview(review);
        out.println("<p class='text-success'>Review added successfully!</p>");
      } catch (Exception e) {
        e.printStackTrace();
        out.println("<p class='text-danger'>Error adding review.</p> ");
      }
    }
  %>
  <form action="index.meme.jsp" method="post">
      <input type="hidden" class="form-control" id="meme_id" name="meme_id" required value="<%=meme_id %>">
    <div class="form-group">
      <label for="rating">Rating:</label>
      <select class="form-control" id="rating" name="rating" required>
        <option value="">-- Select Rating --</option>
        <%for(int j =1; j<421;j++){%>
          <option value="<%=j%>"><%=j%></option>
        <%}%>
      </select>
    </div>
    <div class="form-group">
      <label for="comment">Comment:</label>
      <textarea class="form-control" id="comment" name="comment" rows="3"></textarea>
    </div>
    <HR>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>

    </div>

      <div class="container mt-5">
    <%try{%>
        <% double averageRating = reviewDAO.getAverageRatingByMemeUUID(meme_id); %>
        <p>Average Rating: <%= averageRating %></p>
          <HR>
    <% List<Review> reviews = reviewDAO.getAllReviewsByMemeUUID(meme_id); %>

    <% for (Review review : reviews) { %>
        <div class="mt-2">
            <p>Rating: <%= review.getRating() %></p>
            <p>Comment: <%= review.getComment() %></p>
        </div>
    <% }
    } catch (Exception e) {
      e.printStackTrace();
      out.println("<p class='text-danger'>Error getting review.</p> ");
    }%>
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
