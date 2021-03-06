<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@include file="header.jsp"%>
<html>

<head>
<title>Welcome Page</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link href="<c:url value="/resources/css/homepage.css" />"
	rel="stylesheet" />
<script type="text/javascript" src="/resources/js/jquery-3.1.1.min.js"></script>

<script>
	function addQuestion() {
		document.getElementById("addQuestion").submit();
	}
	
	function myQuestions() {
		document.getElementById("myQuestions").submit();
	}
</script>
</head>
<style>
.navigationButton, #addQues, #myQues {
	background-color: #0095ff;
	padding: 10px;
	color: #FFF;
	cursor: pointer;
	display: inline-block;
	line-height: 11px;
	border-radius: 2px;
	margin-bottom: 5px;
	margin-right: 5px;
	text-decoration: none;
}

#myQues {
	background-color: darkred;
}

.quesTitle {
	border-bottom: 1px solid #e4e6e8;
	font-size: 18px;
	padding-bottom: 10px;
	padding-top: 10px;
	padding-bottom: 10px;
}

.quesTitle:hover {
	background-color: #f2f2f2;
}

.quesLink {
	text-decoration: none;
	color: blue;
}
</style>
<body>

	<sec:authorize access="hasRole('ROLE_USER')">
		<!-- For login user -->
		<c:url value="/j_spring_security_logout" var="logoutUrl" />
		<c:url value="/Add_Question" var="questionUrl" />

		<c:if test="${not empty message}">
			<div class="alert alert-danger">
				<div class="error">${message}</div>
			</div>
		</c:if>
		<div style="text-align: center;">
			<form action="${questionUrl}" method="get" id="addQuestion"
				style="margin-top: 5px; display: inline-block;">
				<input type="button" name="button 1" id="addQues"
					onclick="addQuestion()" value="Add Question" />
			</form>
			<form action="myQuestions" method="get" id="myQuestions"
				style="display: inline-block; margin-top: 5px;">
				<input type="button" name="button 1" id="myQues"
					onclick="myQuestions()" value="My Questions" />
			</form>
		</div>

		<ul id="questions">
			<c:forEach items="${questions}" var="ques" varStatus="ctr">
				<li class="quesTitle"><a class="quesLink"
					href="quesDetail?quesId=${ques.questionId}">${ques.title}</a></li>
			</c:forEach>
		</ul>

		<div style="text-align: center;">
			<%--For displaying Previous link except for the 1st page --%>
			<c:if test="${currentPage != 0}">
				<a class="navigationButton"
					href="welcome?pageNum=${currentPage - 1}">Previous</a>
			</c:if>

			<%--For displaying Next link --%>
			<c:if test="${currentPage lt noOfPages}">
				<a class="navigationButton"
					href="welcome?pageNum=${currentPage + 1}">Next</a>
			</c:if>
		</div>
	</sec:authorize>
</body>
</html>