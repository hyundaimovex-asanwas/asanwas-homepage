<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: ���� �׽�Ʈ
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �ڹ��ڵ�


	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
		<script language="javascript">
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε� 
// Parameter 	: 
%>
		function fnOnLoad(){
			fnInit(); 
		}
		
		function fnInit() {
			fnSetHeaderDs1();
		//	ds1.addrow();
			fnSelectDs1();
			
			
			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
// Parameter	:
%>	
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = "key_seq:STRING,name:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}

		function fnSelectDs1() {
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>Excel?flag=r";
			ds1.Reset();	
		}
		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			alert(ds1.CountRow);
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�."); 
			}
		</script>	
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert(" ��ȸ�� ������ �߻��߽��ϴ� : " + ds1.ErrorMsg );
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ü ���α׷� ��� 
%>
<%=HDConstant.COMMENT_START%>
<object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<param name="SyncLoad" 	value="true">
</object>
<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ü ���α׷� ��� 
%>
<object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F">
	<param name="KeyName"  value="toinb_dataid4">
</object>	
	</head>
	
<!--------------------------------- BODY Start ------------------------------->		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="javascript:fnOnLoad();">
		
								<table width="845px">
									<tr>
										<td>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->	
								<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=300px; height:383px" border="1">
								        <param name="DataID"            value="ds1">
								        <param name="BorderStyle"       value="0">
								        <param name="Fillarea"          value="true">
								        <param name="ColSizing"         value="true">
								        <param name="IndWidth"          value="0">
								        <param name="editable"          value="false">
								        <param name="LineColor"         value="#dddddd">
								        <param name="Format"            value="
								
								                <C> name='KEY_SEQ'     	ID='key_seq'    HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=12 show=true</C>
								                <C> name='NAME' 		ID='name'       HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=10 show=true</C>
								        ">
								</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
											
<!--------------------------------- �ڵ� �κ� �� -------------------------------->		
										</td>
									</tr>
								</table>
								
						
							</td>
						</tr>
					</table>
				</td>
			</tr>
<!-- ���α׷� ���� BODY END -->			
		</table>

<%
/*=============================================================================
			Status Bar Falsh
=============================================================================*/
%>	
	<iframe id="LowerFrame" 
			name="work" 
			style="visibility:hidden; position:absolute; left:280px; top:220px;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
			width="320px" 
			height="42px">
	</iframe>		
<!---------------------------------- BODY End -------------------------------->	
	</body>
</html>