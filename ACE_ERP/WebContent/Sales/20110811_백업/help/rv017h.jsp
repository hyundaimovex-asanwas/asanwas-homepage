<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : ���� ���� �˾� (��Һ����� �� �����..)
 * ���α׷�ID   : RV017H (�ڵ�� �빮��)
 * J  S  P      : rv017h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��     : Rv012H
 * �� �� ��     : �ɵ���
 * �� �� ��     : 2008-03-28
 * �������     : ���� ���� �˾� (��Һ���- rv505i.jsp���� �����..)
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
	String sClientSid = request.getParameter("sClientSid");	
    String sAcceptSid = request.getParameter("sAcceptSid");	//��û����ȣ
    String sAcceptDate = request.getParameter("sAcceptDate");
    String sAcceptTime = request.getParameter("sAcceptTime");    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>���� ���á�����������������������������������������������������������������������������������������������������������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>		
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
		        cfStyleGrid(getObjectFirst("gr1"), "comn1");
				fnSelect();		        	        
			}
			
			function fnSelect() {
//				fnShowLoading(410,180);	//�ε��� ����
			    var v_param = "proType=S"
			                + ",v_accept_sid=<%=sAcceptSid%>" 
			                + ",v_accept_check=N";
			    ln_TRSetting(tr1, 
			                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv200I",
			                "JSP(O:TOUR=ds1)",
			                v_param);
			    tr_post(tr1);
			}
			 
			
			function fnAdd() {
				var row = ds1.rowposition;
				
				if(ds1.namevalue(row, "join_cd")=="01"){
					window.returnValue = ds1.namevalue(row, "cust_nm")  + ";" +
									 	 ds1.namevalue(row, "rsv_sid") + ";" 
					fnClose();					
				}else{
					alert("����(�����)�� �����ϼž� �մϴ�.");
					return false;
				}

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
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>	

	<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
		if(ds1.namevalue(row, "max_persons")>ds1.namevalue(row, "ppl_in_room")){
			fnAdd();			
		}else{
			alert("�ִ� ������ �����Ͽ� ������ �濡 �� �� �����ϴ�.\n �ٸ� ������ �������ּ���.");
			return false;
		};

	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			fnHideLoading();		
	</script>	

<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>	
	
<!--  BODY START -->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
	<!--  loading file ���¹� �÷���  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>
	
		<table border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="479px">
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:150;height:15;">���� ����</font>
							</td>
						</tr>
						<tr>
							<td>
								<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
									<tr>
										<td class="text" width="80px" height="30" style="border:1 solid #708090">����</td>
										<td width="110px" style="border:1 solid #708090;border-left-width:0px">
											<input type="text" name="sCustNm" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
										</td>
									</tr>
								</table>
							</td>	
							<td>
								<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
									<tr>
										<td align=right>
										    <img src="<%=dirPath%>/Sales/images/p_find.gif" alt="�������� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">&nbsp;&nbsp;
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
										</td>
									</tr>
								</table>
							</td>											
						</tr>
					</table>
				</td>
			</tr>
		</table>
			
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
	                <%=HDConstant.COMMENT_START%>
	                <object classid=<%=HDConstant.CT_GRID_CLSID%> id=gr1 style="width=479px; height:290" border="1">
	                    <param name="DataID"        VALUE="ds1">
	                    <param name="BorderStyle"   VALUE="0">
	                    <param name=ColSizing       value="true">
	                    <param name="editable"      value="true">
	                    <Param Name="SuppressOption"      value="1">
	                    <param name=ViewSummary     value=1>
	                    <Param Name="SortView"     value="Right">
	                    <param name="Format"         VALUE="
	                        <C> name='���ǵ��'   	ID='ROOM_TYPE_CD'  Width=70   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left SumText='�ο�/�ݾ�' suppress=1 sort=true</C>
	                        <C> name='���� ����(����)'	ID='CUST_NM'   Width=160   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left SumText=@count SumTextAlign=right sort=true</C>
	                        <C> name='�ֹε�Ϲ�ȣ' ID='MANAGE_NO'     Width=90   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left</C>
	                        <C> name='�ִ�����'     ID='MAX_PERSONS'  Width=70   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right</C>
	                        <C> name='�����ο�'     ID='PPL_IN_ROOM'  Width=70   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right</C>
	                        <C> name='�ǸŰ�'       ID='TOUR_AMT'      Width=65   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right SumText=@sum SumTextAlign=right dec=0 Show=False</C>
	                    ">
	                </object>
	                <%=HDConstant.COMMENT_END%>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
				</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>