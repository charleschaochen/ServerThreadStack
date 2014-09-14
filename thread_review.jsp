<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	import="java.util.Map, java.util.Map.Entry"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
	<head lang="zh-cn">
		<title>Server Thread Stack Review</title>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta name="viewport"
			content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
		<link
			href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css"
			rel="stylesheet">
		<style>
.panel-body ul {
	width: 100%;
	padding: 0;
}

.panel-body ul li {
	list-style: none;
	line-height: 2em;
	margin-left: 10px;
}
</style>
	</head>
	<body>
		<nav class="navbar navbar-inverse" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Server Thread Stack Review</a>
			</div>
		</div>
		<!-- /.container-fluid -->
		</nav>


		<div class="panel-group" id="accordion" role="tablist"
			aria-multiselectable="true">
			<%
				Map<Thread, StackTraceElement[]> stacktraces = Thread
						.getAllStackTraces();
				for (Entry<Thread, StackTraceElement[]> stacktrace : stacktraces
						.entrySet()) {
					Thread thread = stacktrace.getKey();
					if (Thread.currentThread().equals(thread)) {
						continue;
					}
			%>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion"
							href="#<%=thread.getId() %>" aria-expanded="true"
							aria-controls="collapseOne"> 线程：&nbsp;<%=thread.getName()%> </a>
					</h4>
				</div>
				<div id="<%=thread.getId()%>" class="panel-collapse collapse in"
					role="tabpanel">
					<div class="panel-body">
						<ul>
							<%
								StackTraceElement[] elems = stacktrace.getValue();
									if (elems.length < 1) {
							%>
							<li>
								无调用堆栈
							</li>
							<%
								} else {
							%>
							<%
								for (StackTraceElement elem : elems) {
							%>
							<li>
								-
								<%=elem%>
							</li>
							<%
								}
									}
							%>
						</ul>
					</div>
				</div>
			</div>
			<%
				}
			%>
		</div>


		<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
		<script
			src="http://cdn.bootcss.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

	</body>
</html>
