<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="tx" value="${pageContext.request.contextPath }"/>
<c:set var="txAdmin" value="${pageContext.request.contextPath }/admin"/>
<c:set var="txFront" value="${pageContext.request.contextPath }/front"/>
<c:set var="txStatic" value="${pageContext.request.contextPath }/static"/>
<c:set var="txAvatar" value="${pageContext.request.contextPath }/upload/images/user_avatar/"/>
<c:set var="txAuth" value="${pageContext.request.contextPath }/upload/images/user_auth/"/>
<c:set var="txShow" value="${pageContext.request.contextPath }/upload/images/show/"/>

<link rel="shortcut icon" href="${txStatic }/favicon-admin.ico">
<script type="text/javascript" src="${txStatic }/js/jquery.min.js"></script>
<script type="text/javascript" src="${txStatic }/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${txStatic }/js/messages_zh.js"></script>

