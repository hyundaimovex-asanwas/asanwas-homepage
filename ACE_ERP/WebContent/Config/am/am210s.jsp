<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	     : �����⺰ ������ ��Ȳ
 * ���α׷�ID 	 : AM210S
 * J  S  P		     : AM210S
 * �� �� ��		 : AM210S
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2011-01-11
 * �������		 : �����⺰ ������ ������Ȳ
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
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
	}
	//������ȸ
	function fnSelect() {
		    v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sITEM_CD=" 	+ sITEM_CD.value
	            + ",sITEM_NM=" + sITEM_NM.value;
	       	ln_TRSetting(tr1, 
	           "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am210S",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
   }
   function fnExcel() {
		    getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").GridToExcel("���������_��⺰��ȸ","���������_��⺰��ȸ.xls", 8);
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
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
            
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);             
	</script>
<%
		// �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        
        //���� �޽���
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);      
		    
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg); 		       
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
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
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand"  onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onClick="fnExcel();">
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
		            						<td align=CENTER width="100px" class="text">������ȣ</td>
											<td align=CENTER bgcolor="#ffffff" colspan="3">&nbsp;																										
												<input id="sITEM_CD" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:200px; height:20px;">
			            					<td align=CENTER width=100 class="text">&nbsp;&nbsp;&nbsp;ǰ��&nbsp;&nbsp;&nbsp;</td>
			                                <td align=CENTER bgcolor="#ffffff" colspan="3">&nbsp;																										
												<input id="sITEM_NM" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:200px; height:20px;">
											</td>
			            				</tr>	
			            			</table>
								</td>											
							</tr>
						<tr>
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:370" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption	value=1>								                                        
										<param name="Format" 		value="
							               <C> name='������ȣ' ID='ITEM_CD' 		width=60  align=center 	  show=true edit=false	suppress=4	BgColor=pink				</C>
										   <C> name='ǰ��'  	 	ID='ITEM_NM' 		width=60  align=center 	  show=true edit=false	suppress=5	BgColor=pink				</C>
							               <C> name='�𵨸�'   	ID='MODEL_NM' 	width=120  align=left 	  show=true edit=false	BgColor=pink					</C>
							               <C> name='���'       ID='EMPNO'        	width=60    show=true align=center 	BgColor=#D7FFDA		edit=false suppress=1</C>
							               <C> name='����'       ID='EMPNMK'      	width=60  align=center  show=true BgColor=#D7FFDA 	edit=false suppress=2</C>
							               <C> name='�μ�'       ID='DEPTNM'       	width=90    show=true align=center 	BgColor=#D7FFDA		edit=false suppress=3 </C>
							               <C> name='����'   	ID='STATUS_NM' 	width=50  align=center 	  show=true edit=false			BgColor=#b4f0b4		</C>
							               <C> name='����'   	ID='DATE' 		 		width=70  align=left 	  show=true edit=false			BgColor=#b4f0b4 			</C>
							               <C> name='���'   	ID='REMARKS'  		width=200 align=left  show=true  	edit=false</C>
							       	">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		