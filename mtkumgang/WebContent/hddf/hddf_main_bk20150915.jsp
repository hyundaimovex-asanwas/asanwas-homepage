<%--
  - �ۼ���: �ɵ���
  - ����: 2015.05.19
  - ����: ����鼼�� ��ǰ�ȳ�
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>
<html>
<head>
<title>���� �鼼�� �̿� �ȳ�</title>
<link rel="STYLESHEET" type="text/css" href="css/common.css">
<script langage="JavaScript">

</script>
<style type="text/css">
<!--
	html,body { width:100%; height: 100%; }
	.container {
		width:70%;
		height:70%;
		margin: 40px auto;
		background: red;
	}
	.outer {
		display: table;
		width: 100%;
		height: 100%;
	}
	.inner {
		display: table-cell;
		vertical-align: middle;	/* ����� �������� : ie10���� �ȵ�.. ũ���� ����*/
		text-align: center;		/* ����� ��������*/
	}
	.centered {
		position: relative;
		display: inline-block;
		
		width: 50%;
		padding: 1em;
		background: orange;
		color: white;
	}
	.positioned-absolutely {
	  position: absolute;
	  top: -2em;
	  right: -2em;	/* Device�� body ��Ʈ ������ = 1em(�빮��1��) ������..������ Ȯ���� �� ������!*/
	  background: #00f;
	  padding: 1em;
	}
-->
</style>
</head>

<body>

<div class="container">
	<div class="outer">
		<div class="inner">
			<div class="centered">
		        <p>
		          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nam assumenda blanditiis.
		        </p>
		        <div class="positioned-absolutely">����</div>
				
			</div>
		</div>
	</div>
</div>
<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr>
	<td valign="top" align="center">
	
	<!-- / content  -->
	<table cellpadding="0" cellspacing="0" border="0" width="932">
	  <tr height="10"><td></td></tr>
	  <tr>
		<td><!-- header -->
			<%@ include file="./hddf_topnav.jsp" %>
		</td>
	  </tr>
	  <tr height="30"><td></td></tr>
	  <tr>
		<td><img src="./imgs/main_ban1.jpg" >
		</td>
	  </tr>
	  <tr height="32"><td></td></tr>	  
	  <tr>
		<td align="center"><img src="./imgs/main_txt1.gif" ></td>
	  </tr>
	</table>
	<!-- footer -->
	<%@ include file="./hddf_footer.jsp" %>
	</td>
  </tr>
</table>

</body>
</html>