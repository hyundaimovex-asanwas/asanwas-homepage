<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : �������� ���� (����)
 * ���α׷�ID   : rm120_4f
 * J  S  P      : RM120H
 * �� �� ��     : RM120H
 * �� �� ��     : �̺���
 * �� �� ��     : 2006-08-16
 * �������		: ���� ���(���ǹ���, �̿���Ȳ)���� �Ķ���͸� �޾Ƽ�
 *				  �ش�Ⱓ + ������ ��������� �����ش�.
 * [��  ��   ��  ��][������] ����
 * [2008-02-20][�ɵ���] �����ο� ���� 
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
   	String sRoomStatus 	= HDUtil.nullCheckStr(request.getParameter("sRoomStatus")); // ����� 
	int 	sRoomSid	= HDUtil.nullCheckNum(request.getParameter("sRoomSid"));	// ��sid

    
			          
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            
             function fnOnLoad() {
           	 cfStyleGrid(getObjectFirst("gr1"), "comn");

	        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	            	  		+",dsType=1"
				    	      + ",sKeySeq=<%=sRoomSid%>"
				        	  + ",sRoomStatus=<%=sRoomStatus%>";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm120H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
            }
            
            
            
			//������ �Է�â �ݱ�
			function hidePop()
			{
				var win = parent.window.document.all.roomInfoWin;
				win.src = "";
				win.style.display = "none";
			}         
        </script>
        
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>  
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
//            document.all.LowerFrame.style.visibility="visible"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
//            document.all.LowerFrame.style.visibility="hidden";
            if(row==0){
                alert("<%=HDConstant.S_MSG_NO_DATA%>");
//                window.close();
            }
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            document.all.LowerFrame.style.visibility="hidden";
        </script>



<%=HDConstant.COMMENT_START%>       
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>


    </head> 
    
<!--  BODY START -->
    <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

<!-- ���Ⱑ ȭ���� -->
<table border="0" cellpadding="0" cellspacing="0" width="350" background="<%=dirPath%>/Sales/images/map/box_350_bg.gif">
<form name=pplForm target=execute1 METHOD=post > <!-- �������������� ��������..���̽�!!! -->
  <tr>
	<td height="10" valign="top"><img src="<%=dirPath%>/Sales/images/map/box_350_top.gif"></td>
  </tr>
  <tr>
	<td align=center>

					<table width=300 border="0" cellspacing="0" cellpadding="0" bgcolor="#fdfde7">
						<tr height=30>
							<td background="<%=dirPath%>/Sales/images/map/w_bg.gif" align="center"><input type=text  id=box_txt1 style="border:0 solid #ffffff;font-size:14px;font-weight:bold;color:white;width:100%;text-align:center;background:#73be10;"></td>	
						</tr>
						<tr>
							<td height="5"></td>
						</tr>
						<tr>
							<td align="center">
								<table width="290" height="120" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_1.gif"></td>
										<td background="<%=dirPath%>/Sales/images/map/wr_2.gif"></td>
										<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_3.gif"></td>
									</tr>
									<tr>
										<td background="<%=dirPath%>/Sales/images/map/wr_8.gif">&nbsp;</td>
										<td bgcolor="#FFFFFF" align=center>
											<table width="90%" height="110" border="0" cellspacing="0" cellpadding="0">
												<tr height=26>
													<td width="15" align="right"><img src="<%=dirPath%>/Sales/images/map/trace_dot.gif"></td>
													<td width="85" align=center>�󡡡�����</td>
													<td><input type=text  id=box_txt2 style="border:0 solid #ffffff;font-size:12px"></td>	
												</tr>
												<tr>
													<td colspan=3 bgcolor=#cccccc height=1></td>
												</tr>
												<tr height=26>
													<td align="right"><img src="<%=dirPath%>/Sales/images/map/trace_dot.gif"></td>
													<td align=center>�����ࡡ��</td>
													<td><input type=text id=box_txt3 style="border:0 solid #ffffff;font-size:12px"></td>	
												</tr>
												<tr>
													<td colspan=3 bgcolor=#cccccc height=1></td>
												</tr>
												<tr height=26>
													<td align="right"><img src="<%=dirPath%>/Sales/images/map/trace_dot.gif"></td>
													<td align=center>���ǹ�����</td>
													<td><input type=text id=box_txt4 style="border:0 solid #ffffff;font-size:12px"></td>	
												</tr>
												<tr>
													<td colspan=3 bgcolor=#cccccc height=1></td>
												</tr>
												<tr height=26>
													<td align="right"><img src="<%=dirPath%>/Sales/images/map/trace_dot.gif"></td>
													<td align=center>�����ࡡ��</td>
													<td><input type=text id=box_txt5 style="border:0 solid #ffffff;font-size:12px"></td>	
												</tr>
												<tr>
													<td colspan=3 bgcolor=#cccccc height=1></td>
												</tr>

												<tr height=26>
													<td align="right"><img src="<%=dirPath%>/Sales/images/map/trace_dot.gif"></td>
													<td align=center>��û����ȣ</td>
													<td><input type=text id=box_txt6 style="border:0 solid #ffffff;font-size:12px"></td>	
												</tr>
												<tr height=26>
													<td align="center" colspan=3>
														<%
														/*---------------------------------------------------------------------------->
															Object ID   : �׸��� , gr1
															Data ID     : ds1
															������ ����Ʈ
														-----------------------------------------------------------------------------*/
														%>
														<%=HDConstant.COMMENT_START%>
														<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='94%' height='100px' border=1>
															<param name="DataID"        value="ds1">
															<param name="BorderStyle"   value="0"> 
															<param name="ColSizing"     value="true">
															<param name="Fillarea"      value="true">
															<param name="AutoResizing"  value=true> 
															<param name="Editable"      value="false">
															<param name="SuppressOption"    value="1">
															<param name=ViewSummary     value=0>
															<param name="Format"        value="
																<C> name='����(�ֹι�ȣ)'	ID='txt7'	 width=150 align=center editlimit=52 show=true sort=true</C>
																<C> name='����'	ID='txt8'	 width=50 align=center editlimit=50 show=true</C>
															">
														</object>
														<%=HDConstant.COMMENT_END%> 
													</td>	
												</tr>
											
											</table>
										</td>
										<td background="<%=dirPath%>/Sales/images/map/wr_4.gif">&nbsp;</td>
									</tr>
									<tr>
										<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_7.gif"></td>
										<td background="<%=dirPath%>/Sales/images/map/wr_6.gif"></td>
										<td width="8" height="8"><img src="<%=dirPath%>/Sales/images/map/wr_5.gif"></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height="5"></td>
						</tr>
					</table>

	</TD>
  </tr>
  <tr>
	<td align=center><img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="hidePop();"></td>
  </tr>
  <tr>
	<td height="10" valign="bottom"><img src="<%=dirPath%>/Sales/images/map/box_350_bottom.gif"></td>
  </tr>
</form>
</table>

<%=HDConstant.COMMENT_START%>
<!-- ������ ���ε� : USERFILE  -->
	<OBJECT id=ADE_Bind_1 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
      <PARAM NAME="DataID" VALUE="ds1">
      <PARAM NAME="BindInfo" VALUE="
		<C>Col=txt1 Ctrl=box_txt1 Param=value</C>
		<C>Col=txt2 Ctrl=box_txt2 Param=value</C>
		<C>Col=txt3 Ctrl=box_txt3 Param=value</C>
		<C>Col=txt4 Ctrl=box_txt4 Param=value</C>
		<C>Col=txt5 Ctrl=box_txt5 Param=value</C>
		<C>Col=txt6 Ctrl=box_txt6 Param=value</C>
		">
    </OBJECT>
<%=HDConstant.COMMENT_END%> 


	</body>
    <!-- BODY END -->
</html>