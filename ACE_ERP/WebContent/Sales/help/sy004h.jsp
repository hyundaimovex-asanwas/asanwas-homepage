<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	: ������ ���� Help 
 * ���α׷�ID 	: SY004H (�ڵ�� �빮��)
 * J  S  P		: sy004h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Sy004H
 * �� �� ��		: ������
 * �� �� ��		: 2006-05-19
 * �������		: ������ ��ȸ 
 * ��������		: 2006-06-08 : ������������ �°� ����
 * �� �� ��		: ���ؼ�
 * ������������ :  
 * TODO			:
 * TODO         :
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
		<title>����������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		
		<script language="javascript">
			
			// ������ �ε�
			function fnOnLoad(){
			
				var strParam = new Array();
				strParam=window.dialogArguments;

				if(strParam[0]!=null) { //upjang_cd����
					txt_upjang_cd.value=strParam[0];
				}else {
				}
				fnInit();
			}

			/*
			 * �ʱ��۾�
			 */
			function fnInit(){
				fnSelectDs2();
			}
		
			// ���� ��ȸ
			function fnSelect() {
				fnSubSelect1();
			}
			
			// ���������� ��ȸ 
			function fnSubSelect1() {
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?proType=S&dsType=1&s_SaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid")+"&s_UpjangSid=&s_UpjangCd="+txt_upjang_cd.value;
				ds1.Reset();
			}
			
			// ������ ��ȸ
			function fnSelectDs2() {
				ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?dsType=1&proType=INIT";
				ds2.Reset();			
			}					
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "upjang_sid") + ";" +
								 ds1.namevalue(row, "upjang_cd") + ";" + 
								 ds1.namevalue(row, "upjang_nm") + ";" +
								 ds1.namevalue(row, "upjang_eng_nm") + ";" + 
								 ds1.namevalue(row, "upjang_short_nm") + ";" + 
								 ds1.namevalue(row, "upjang_type") + ";" + 
								 ds1.namevalue(row, "direct_yn") + ";" + 
								 ds1.namevalue(row, "close_date") + ";" + 
								 ds1.namevalue(row, "use_yn") + ";" + 
								 ds1.namevalue(row, "remarks") + ";" +
								 ds1.namevalue(row, "saup_sid") + ";" + 
								 ds1.namevalue(row, "u_empno") + ";" + 
								 ds1.namevalue(row, "u_date") + ";" + 
								 ds1.namevalue(row, "u_ip");
			 	fnClose();
			}
			
			function fnClose() {
				window.close();
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
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 2 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>	
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 2 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 2 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds2 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>		

		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "upjang_sid") + ";" +
								 ds1.namevalue(row, "upjang_cd") + ";" + 
								 ds1.namevalue(row, "upjang_nm") + ";" +
								 ds1.namevalue(row, "upjang_eng_nm") + ";" + 
								 ds1.namevalue(row, "upjang_short_nm") + ";" + 
								 ds1.namevalue(row, "upjang_type") + ";" + 
								 ds1.namevalue(row, "direct_yn") + ";" + 
								 ds1.namevalue(row, "close_date") + ";" + 
								 ds1.namevalue(row, "use_yn") + ";" + 
								 ds1.namevalue(row, "remarks") + ";" +
								 ds1.namevalue(row, "saup_sid") + ";" + 
								 ds1.namevalue(row, "u_empno") + ";" + 
								 ds1.namevalue(row, "u_date") + ";" + 
								 ds1.namevalue(row, "u_ip"); 
			window.close();
		</script>
		
<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>		
<!-----------------------------------------------------------------------------
                                DataSet Components ���� 
# ��ȸ�� �� ��� ����Ѵ�. 
------------------------------------------------------------------------------->
		<comment id="__NSID__">
		<object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
			<param name="SyncLoad" value="false">
		</object>
		</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>		
		<comment id="__NSID__">
		<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
			<param name="SyncLoad" 	value="false">
		</object>
		</comment><SCRIPT>__WS__(__NSID__);</SCRIPT>		
	</head>	
	
<!--  BODY START -->
		<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
						<tr>
							<td colspan=2 height=30>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:20;">����</font>
								<comment id="__NSID__"><object id=lc1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=120 style="position:relative;top:4px;left:25px;">
										<param name=ComboDataID		value=ds2>
										<param name=EditExprFormat	value="%,%;saup_nm,saup_sid">
										<param name=ListExprFormat  value="saup_nm^0^120">
								</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
							</td>
						</tr>
						<tr>
							<td class="text" width="80px" height="30" style="border:1 solid #708090">�ڵ�/��</td>
							<td width="110px" style="border:1 solid #708090;border-left-width:0px">
								<input type="text" id="txt_upjang_cd" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
						<tr>
							<td align=right><img src="<%=dirPath%>/Sales/images/p_find.gif" alt="�ڵ�/���� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:pointer;" onclick="fnSelect();">
							    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnAdd()">                            
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:pointer;" onClick="fnClose()">                          
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
<%
/*---------------------------------------------------------------------------->
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:248px;border:1 solid #777777;">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit����  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
						<param name="LineColor" 	value="#dddddd">
						<param name="Format" 		value="
							<c> Name='sid'			ID='upjang_sid'		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center show=false</c>
							<c> Name='��        ��'		ID='upjang_cd'		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center </c>
							<c> Name='��   ��   ��' 		ID='upjang_nm'	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=379  LeftMargin=50 </c>
							
						">
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
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
	<!-- BODY END -->
</html>