<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">   
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : �����ȣ �˻� with ��ü��API
 * J  S  P      : openZip
 * �� �� ��     : -
 * �� �� ��     : �ɵ���
 * �� �� ��     : 2011-05-30
 * �������     : ��ü������ API�� �̿��� �����ȣ �˻����
 * [ �������� ][������] ����
 * [2011-05-30][�ɵ���] ���ͳݼ� ���������ؼ� ���� 
 *						��ü��API�� XML����� �����ȣ�� ����, �װ� �Ľ��ؼ� ȭ�鿡 ������
 * ����API��û���Home > ������ > ����API��û���
 *	�����ȣ��ȸ ���� �ɵ��� ȸ�� ����ƻ�(��) 
 *	����ó 010-7574-9010 �̸��� webmaster@hdasan.com 
 *	��û�� 2011-05-30 ����Ű af1300d3f6c467d601306735007670 
 *	API �ּ� : http://biz.epost.go.kr/KpostPortal/openapi?regkey=af1300d3f6c467d601306735007670&target=post&query=������
 *****************************************************************************/
%>
<%@ page import="java.util.*,java.net.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="org.jdom.input.SAXBuilder" %>
<%@ page import="org.jdom.Document" %>
<%@ page import="org.jdom.Element" %> 

<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
<meta http-equiv="Content-Style-Type" content="text/css"/>
<link rel="stylesheet" href="http://www.hdasan.com/css/apass.css" type="text/css"/>
<title>openZip @hdasan</title>
<script language="javascript" >
	<!--
	function tabAddr(){
		//to opener page
		
	}

	function returnAddr(zip,addr1,addr2) {
		var x=opener.document.form;
		var tmp1 = zipcode.substring(0,3);
		var tmp2 = zipcode.substring(4,7);

		var fname1,fname2,fname3,fname4;

		if (type == "mem") {
			fname1 = x.zip1;
			fname2 = x.zip2;
			fname3 = x.addr1;
			fname4 = x.addr2;
			x.area.value = area;
		}
		else if (type == "agent") {
			fname1 = x.agentzip1;
			fname2 = x.agentzip2;
			fname3 = x.agentaddr1;
			fname4 = x.agentaddr2;
		}

		else if (type == "czip") {
			fname1 = x.czip1;
			fname2 = x.czip2;
			fname3 = x.caddr1;
			fname4 = x.caddr2;
		}

		else if (type == "hzip") {
			fname1 = x.hzip1;
			fname2 = x.hzip2;
			fname3 = x.haddr1;
			fname4 = x.haddr2;
		}

		fname1.value = tmp1;
		fname2.value = tmp2;
		fname3.value = addr;

		fname4.focus();

		window.close();
	}
	-->
</script>
</head>
<body>
<!----- title----->
<div id="titleArea" style="width:430px; height: 47px; background-color:#234790">
	<div id="title1" style="float: left; width: 114px;">
		<img src="http://www.hdasan.com/img/member/pop_tit_02.gif" />
	</div>
	<div id="title2" style="float: right; width: 75px;">
		<img src="http://www.hdasan.com/img/common/pop_logo.gif" />
	</div>
</div>
<!----- title----->
<%
	request.setCharacterEncoding("ISO8859-1");
	String addr = request.getParameter("addr");
	if (addr==null||addr==""){
		addr="";
	%>
		<!-- �ּ��Է�-->
		<form id="form" method="post" action="openZip.jsp">
�Է��Ͻ� �ּ��� ��/��/�� �̸��� �Է��ϼ���.<br />
��) ��ȭ��<br />
			<input type="text" id="addr" name="addr"  style="width:175px; height:18px;" value="<%=addr%>" class="gray_input1" onfocus="this.className='gray_input1_focus';" onfocusout="this.className='gray_input1';" />
			<input type="submit" src="http://www.hdasan.com/img/common/btn_search.gif" border="0" />
		</form>
		<!-- //�ּ��Է�-->
	<%
	}else{ 
		String keyAddr = new String(addr.getBytes("ISO8859-1"),"EUC-KR");	//�̷��� ��ȯ�ؾ����� ����� �߳׿�..��
		String apiurl = "http://biz.epost.go.kr/KpostPortal/openapi?regkey=af1300d3f6c467d601306735007670&target=post&query=";
		HttpURLConnection conn = null;
	
	%>
		<!-- �ּ��Է�-->
		<form id="form" method="post" action="openZip.jsp">
�Է��Ͻ� �ּ��� ��/��/�� �̸��� �Է��ϼ���.<br />
��) ��ȭ��<br />
					<input type="text" id="addr" name="addr"style="width:175px; height:18px;" value="<%=keyAddr%>" />
					<input type="submit"  />
		</form>
		<!-- //�ּ��Է�-->
		<div style="width:430px; height: 1px; border:solid 0px red; padding:0 0 10 0 ; background:url(http://www.hdasan.com/img/common/bg_dot_01.gif)">
		</div>

		<!-- ���-->
		<div id="scrollArea" style="text-align: left; width:430px; height: 140px; overflow: auto">

		<%
		try{
			apiurl += URLEncoder.encode(keyAddr);	//�ּҰ˻��� �Ķ���ͷ� ȣ��URL ��ģ��.
		  
			URL url = new URL(apiurl);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("accept-language","ko"); //��ü��API�� �ѱ� ���� ����
			SAXBuilder builder = new SAXBuilder();
			Document doc= builder.build(conn.getInputStream());
			Element itemlist = doc.getRootElement().getChild("itemlist");
			//out.println(itemlist.getName());
			List list = itemlist.getChildren();
			//out.println(list.size());
				for(int i=0; i<list.size();i++){
				   Element item = (Element)list.get(i);
				   String address = item.getChildText("address");
				   String postcd = item.getChildText("postcd");
	
				   //�ϰ����ϴ� �۾�
				   %>
					<div onclick="alert('<%=postcd %>');"  style="cursor:hand"><%=postcd %>:<%=address %></div>
				   <%
				}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{ if(conn != null) conn.disconnect(); } catch(Exception e){}
		}
		%>
		</div>
		<!-- //���-->
		<%
		}
		%>	

		<div style="width:430px; height: 1px; border:solid 0px red; padding:0 0 10 0 ; background:url(http://www.hdasan.com/img/common/bg_dot_01.gif)">
		</div>

<!----- CopyRight----->
<div id="copyRightArea" style="width:430px; height: 35px; ">
	<img src="http://www.hdasan.com/img/common/pop_copyright2.gif" />
</div>
<!----- CopyRight----->


</body>
</html>



 
