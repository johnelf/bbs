﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" scope="request" value="Home"/>

<%@ include file="header.jsp" %>

<table class="table">
    <thead>
    <tr class="darkgrey">
        <th>Title</th>
        <th>Author</th>
        <th>Publish Time</th>
        <th>Operations</th>
    </tr>
    </thead>
    <tbody>
        <c:forEach var="post" items="${postsWithLiked}" varStatus="row" >
            <tr class="white">
                <td>
                    <a href="<c:url value='/posts/${post.key.postId}' />">
                        <c:out value="${post.key.title}"/>
                    </a>
                </td>
                <td>
                    <a href="<c:url value='/user/users/${post.key.authorName}' />">
                        <c:out value="${post.key.authorName}"/>
                    </a>
                </td>
                <td><c:out value="${post.key.createTimeString}"/></td>
                <td>
                    <c:if test="${not post.value}">
                        <a href='javascript:alert("you like this post");location.href="posts/like/${post.key.postId}";'>Like</a>
                    </c:if>
                    <c:if test="${not post.value}">
                        <c:if test="${isAdmin}">
                        |
                        </c:if>
                        <c:if test="${not isAdmin}">
                           <c:if test="${post.key.isTopped}">
                           |
                           </c:if>
                        </c:if>
                    </c:if>
                    <c:if test="${post.key.isTopped}">
                        Topped
                    </c:if>
                    <c:if test="${isAdmin}">
                        <c:if test="${not post.key.isTopped}">
                            <a href='javascript:alert("you want to top this post");location.href="posts/top/${post.key.postId}";'>Top</a>
                        </c:if>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:choose>
            <c:when test="${postsFountCount == 0}">
                <tr class="white">
                    <td class="text-hint">
                        <i>No post found, please search again with other conditions.</i>
                    </td>
                    <td/><td/><td/>
                </tr>
            </c:when>
            <c:when test="${postsFountCount == 1}">
                <tr class="white">
                    <td class="text-hint">
                        <i class="text-error">${postsFountCount}<i/>
                        <i>result.</i>
                    </td>
                    <td/><td/><td/>
                <tr/>
            </c:when>
            <c:when test="${postsFountCount >= 2}">
                <tr class="white">
                    <td class="text-hint">
                        <i class="text-error">${postsFountCount}<i/>
                        <i>results.</i>
                    </td>
                    <td/><td/><td/>
                <tr/>
            </c:when>
        </c:choose>
    </tbody>
</table>

<div class="searchField" >
    <div class="title">Please fill search condition</div>
    <form id="searchPost" class="form-horizontal form row" name="createPost" action="<c:url value='/' />" method="post" >
        <div class="form-inline">
            <div class="input-group col-lg-6">
                <label class="control-label" for="title">Title</label><br/>
                <input type="text" class="form-control input-large" id="title" name="title" />
            </div>
            <div class="input-group col-lg-6">
                <label class="control-label" for="title">Content:</label><br/>
                <input type="text" class="form-control" id="content" name="content" />
            </div>
        </div>

        <div class="form-inline">
            <div class="input-group col-lg-6">
                <label class="control-label" for="title">Publish Time From</label><br/>
                <input type="text" class="span4 form-control" id="dp1" id="dp1" name="dp1">
            </div>
            <div class="input-group col-lg-6">
                <label class="control-label" for="title">Publish Time To</label><br/>
                <input type="text" class="span4 form-control" id="dp2" id="dp2" name="dp2">
            </div>
        </div>
        <div class="form-inline">
            <div class="input-group col-lg-6">
                <label class="control-label" for="title">Author</label><br/>
                <input type="text" class="form-control" id="author" name="author">
            </div>
            <div class="input-group col-lg-6">
                <br/>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript" src="<c:url value='/scripts/bootstrap-datepicker.js' />"></script>

<script type="text/javascript">
$(document).ready(function(){
    $('#searchPost  #dp1').datepicker({
        daysOfWeekDisabled: "",
        calendarWeeks: true,
        autoclose: true,
        todayHighlight: true,
        format: 'yyyy-mm-dd'
    });
    $('#searchPost #dp2').datepicker({
        daysOfWeekDisabled: "",
        calendarWeeks: true,
        autoclose: true,
        todayHighlight: true,
        format: 'yyyy-mm-dd'
    });
    $("#title").val("${title}");
    $("#content").val("${content}");
    $("#author").val("${author}");
    $("#dp1").val("${timeLeft}");
    $("#dp2").val("${timeRight}");
});
</script>

<%@ include file="footer.jsp" %>

