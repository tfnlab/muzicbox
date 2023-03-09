<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tfnlab.mg.mysql.Review" %>
<%@ page import="com.tfnlab.mg.mysql.ReviewDAO" %>
<%@ page import="java.sql.Timestamp" %>

<html>
<head>

<title>Meme Genesis</title>
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
      <a class="navbar-brand" href="index.jsp">Meme Genesis</a>
      <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
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
      <!--
      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
      </form>
      -->
    </div>
  </nav>

  <div class="container mt-5">
      <h4>The Art of Meme</h4>

    <%
        // Create an instance of the APIConfig class

        ReviewDAO reviewDAO = new ReviewDAO();


        %>

        <div class="container mt-5">
      <%try{%>
          <% double averageRating = reviewDAO.getAverageRating(); %>
          <p>Average Rating: <%= averageRating %></p>
            <HR>
      <% List<Review> reviews = reviewDAO.getAverageReviewsByMemeUUID(); %>

          <div class="d-flex flex-wrap">
      <% for (Review review : reviews) { %>
          <div class="col-md-6 col-lg-4 mb-4">
            <div class="card">
              <div class="card-body">
                <a href="index.meme.jsp?meme_id=<%= review.getMeme_uuid() %>" >
                <img class="card-img-top" src="img.jsp?filename=<%= review.getMeme_uuid() %>" alt="Rating <%= review.getRating() %>">
                </a>
                <BR><BR>
                <h5 class="card-title">Rating <%= review.getRating() %></h5>
                <a href="index.meme.jsp?meme_id=<%= review.getMeme_uuid() %>" class="btn btn-primary">Reviews</a>
              </div>
            </div>
          </div>
      <% } %>
      </div>
      <%
      } catch (Exception e) {
        e.printStackTrace();
        out.println("<p class='text-danger'>Error getting review.</p> " + e.getMessage());
      }%>
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
