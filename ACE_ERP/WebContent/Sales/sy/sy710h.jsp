<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 		: ����ġ �������� 
 * ���α׷�ID 	: SY710(�ڵ�� �빮��)
 * J  S  P		: sy710h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: 
 * �� �� ��		: ���ϳ�
 * �� �� ��		: 2011-03-07
 * �������		: 
 * ��������		: 
 * �� �� ��		:
 * ������������ 	: 
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>�������� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</title>
		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="<%=dirPath%>/Sales/common/include/embedControl.js"></script>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����ȸ
%>
			function fnSelect() {
				if (sKeyWord.value==""){
				alert("��(��/��/��)���� �˻��ϼ���!");
				}
				else{fnSubSelect1();}
			}
			// ���� �ٸ����� ��ȸ���� 
			function fnSubSelect1() {
			
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy002H?dsType=1&proType=S&sKeyWord="+sKeyWord.value;
				ds1.Reset();
			}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �˾�â �ݱ�
// Parameter 	: A - ����
%>
			function fnClose(p){
				if (p=="A") {
					var row = ds1.rowposition;
					window.returnValue = ds1.namevalue(row, "zip_cd") + ";" +
								 ds1.namevalue(row, "ADDRESS") + ";" + 
								 ds1.namevalue(row, "ZIP_SID")  ;
				window.close();
				} else {
					window.close();
				}
			}
		</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//              :  �����ȣ Opener�� ���õ� �����ȣ ��� 
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;
			
			
			window.returnValue = ds1.namevalue(row, "zip_cd") + ";" +
								 ds1.namevalue(row, "ADDRESS") + ";" +
								 ds1.namevalue(row, "ZIP_SID") ;
			window.close();
		</script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	window.returnValue = ds1.namevalue(ds1.rowposition, "zip_cd") + ";" +
								 ds1.namevalue(ds1.rowposition, "ADDRESS") + ";" +
								 ds1.namevalue(ds1.rowposition, "ZIP_SID") ;
				window.close();
            }
		</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>	
		<object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
			<param name="SyncLoad" value="false">
		</object>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
		<object id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
			<param name="KeyName" value="toinb_dataid4">
		</object>
	</head>
<!--------------------------------- BODY START ------------------------------->
	<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
						<tr>
							<td colspan=2 height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">�ȳ�</font>
							</td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:495px;">
						<tr>
							<td>
										������ �����е��� ������ ���Ծ� ���� 2.28 ������ ���û�� �귣�� ���� �� 204�� <br> (�ߺ� ����)�� ���յǾ����ϴ�. 
										�Ʒ��� ���� ������ �¶��� ��ǥ�� ���� ���û�� �귣�带 ������ �����̿��� ���� ���� �ٶ��ϴ�.<br><br>
							</td>
						</tr>			
						<tr>
						    <td align=center>- ��    �� - <br><br> </td>
						 </tr>
						 <tr>
							<td >			
										         1. 1�� ������ �¶��� ��ǥ (����)  <br>
										          - ��  �� : 3.9~11 (3�ϰ�) <br>
										          - 204���� �������� 65�� ���� 3�� �׸����� �з� <br>
										          - �׸�� ���κ� 3ǥ�� ��ǥ ���� <br>
										          - �׸� �ٵ�ǥ ���� ���� �ĺ��� ����<br><br><br>
										
										         2. 2�� ������ �¶��� ��ǥ (����) <br>
										          - ��  �� : 3.15~17 (3�ϰ�) <br>
										          - ������ ����� ���� ���� �ĺ��� <br>
										          - ���κ� 1ǥ�� ��ǥ ���� <br>
										          - �ٵ�ǥ ���� ���� ���� 3�� ����<br>
							</td>
						</tr>
					</table>					
				</td>
			</tr>
		</table>
			</tr>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
				</td>
			</tr>
			<tr>
				<td>
				<!--  ���¹� �÷���  -->
			<iframe id="LowerFrame" 
				name="work" 
				style="visibility:hidden; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
<!--------------------------------- BODY E N D ------------------------------->
</html>