<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	     : �����ڻ���Ȳ
 * ���α׷�ID 	 : AM300S
 * J  S  P		     : AM300S
 * �� �� ��		 : AM300S
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2012-04-05
 * �������		 : �����ڻ���Ȳ
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML ����-->
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
        var v_job = "H";
        var div='';
	// �������ε�
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}
	//����ȸ
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
	}
	//������ȸ
	function fnSelect() {
		    v_job = "S";
	         msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + " sEMPNO=" 		+ sEMPNO.value
	            + ",sEMPNMK=" 	+ sEMPNMK.value;
	           // alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am300S",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
   }
	function fnExcel() {
		    getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").GridToExcel("�����ڻ�����Ȳ","�����ڻ�����Ȳ.xls", 8);
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
	// �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
	</script>
<%
		// �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";     
  	</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
		<%=HDConstant.COMMENT_START%>
		<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="false">
		</object>
		<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
		    <param name="ServerIP"   value="">
		    <param name="Action"     value="">
		    <param name="KeyName"    value="">
		    <param name="KeyValue"   value="">
		    <param name="Parameters" value="">
		</object>
		<%=HDConstant.COMMENT_END%>
		</head>
		<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer"  onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer"  onClick="fnExcel();">
											</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                        	<tr bgcolor="#6f7f8d">
		            						<td align="center" width="100px" class="text">�� ��</td>
											<td align=center bgcolor="#ffffff" colspan="3">&nbsp;																		
												<input id="sEMPNO" type="text" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();" style= "position:relative;left:-0px;top:2px;width:200px; height:20px;">
											</td>
			            					<td align="center" width="100px" class="text">�� ��</td>
			                                <td align=center bgcolor="#ffffff" colspan="3">&nbsp;																		
												<input id="sEMPNMK" type="text" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();" style= "position:relative;left:-0px;top:2px;width:200px; height:20px;">
											</td>
			            				</tr>	
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="30px">
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:370" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption	value=1>								                                        
										<param name="Format" 		value="
										   <C> name='��ü\\����' 				ID='RANK'	   			width=30 		align=CENTER	edit=none show=TRUE	bgColor='pink'</C>
						                   <C> name='��ü\\����'       ID='SCORE'    Width=60 	align=right show=true sort=true bgColor=<%=HDConstant.GRID_ITEM%></C>
							               <C> name='�������\\(���)'       ID='DATE_A'    Width=80 	align=center show=true sort=true</C>
							               <G> name='�λ�����'
							                <C> name='�μ�'       ID='DEPTCD'    Width=150 	align=left show=true sort=true</C>
							                <C> name='����'       ID='PAYGRD'    Width=60 	align=center show=true</C>
							                <C> name='���'       ID='EMPNO'    Width=60 	align=center show=true sort=true</C>
							                <C> name='����'       ID='EMPNMK'    Width=60 	align=center show=true sort=true	bgColor=<%=HDConstant.GRID_ITEM%></C>
							               </G>
						                   <G> name='�ϵ����'
							                <C> name='ǰ��'       ID='ITEM_NM'    Width=60 	align=left show=true sort=true bgColor=<%=HDConstant.GRID_ITEM%></C>
							                <C> name='������'       ID='MADE_CP'    Width=60 	align=center show=true </C>
							                <C> name='�𵨸�'       ID='MODEL_NM'    Width=40 	align=center show=true</C>
							                <C> name='CPU'       ID='CPU'    Width=40 	align=center show=true </C>
							                <C> name='����'       ID='MAINBD'    Width=40 	align=center show=true</C>
							                <C> name='�޸�'       ID='MEMORY'    Width=40 	align=center show=true</C>
							                <C> name='HDD'       ID='HDD'    Width=40 	align=center show=true </C>
							                <C> name='�׷���'       ID='GRAPHIC'    Width=40 	align=center show=true </C>
							               </G>
							                <C> name='�ݳ�����'       ID='DATE_B'    Width=80 	align=center show=false sort=true</C>
							                <C> name='�������'       ID='DATE_C'    Width=80 	align=center show=false sort=true</C>
							                <C> name='��������\\(�����)'       ID='DATE_D'    Width=80 	align=center show=false sort=true</C>
							                <C> name='���±���'       ID='STATUS_CD'    Width=80 	align=center show=false sort=true</C>

							                <C> name='�ڻ��ȣ'       ID='ASSET_NO'    Width=80 	align=center show=false sort=true</C>
							                <C> name='���'       ID='REMARKS'    Width=80 	align=left show=false</C>
							            ">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br>
			**<b>��ü���� ��������</b><br><br>
			&nbsp;&nbsp;&nbsp;1.��ü���ؽñ�: 4��<br><br>
			&nbsp;&nbsp;&nbsp;2.����:[����]-[�������]-4��<br><br>
			&nbsp;&nbsp;&nbsp;3.��ü������ <b>Ŭ ���� ��ü�켱���� ����.</b>
			
		</td>
	</tr>
</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

