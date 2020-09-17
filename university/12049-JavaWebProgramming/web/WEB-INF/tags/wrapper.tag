<%--https://stackoverflow.com/a/3257426--%>
<%@tag description="Simple Wrapper Tag" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Red Rivers - electronics supplier</title>
</head>

<body>
<jsp:doBody/>

<footer class="blog-footer">
    <p>Copyright 2020, Red Rivers
        <a class="text-muted" href="${pageContext.request.contextPath}/admin/admin.jsp" aria-label="Search">
            <span class="oi oi-account-login"></span>
        </a>
    <p>
        <a href="#">Back to top</a>
    </p>
</footer>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
      integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<!-- vue, axios -->
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.2"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.min.js"></script>

<!-- additional css, custom js -->
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/res/css/style.css"/>
<script src="${pageContext.request.contextPath}/res/js/index.js"></script>
<link type="text/css" rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/open-iconic/1.1.1/font/css/open-iconic-bootstrap.min.css"/>

<!-- bootstrap css (js) -->
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/res/css/bootstrap-custom.css"/>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
        integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
</body>

</html>