<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	     : ǰ�񸶽���
 * ���α׷�ID 	 : pu031I
 * J  S  P		 : pu031I
 * �� �� ��		 : pu031I
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2012-02-17
 * �������		 : ���籸�����α׷�
 *				      ������ ��ȸ, ����, ����, �߰�
 * [��  ��   ��  ��][������] ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My710DTO" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>

<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
   		var div='';
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){
			fnInit();		//�ش� �������� ���� �ʱ�ȭ
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
		}
	
	/*
	 * ����ȸ
	 */
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");	//�׸��忡 ��Ÿ�� �����ϴ� �κ�. 1��="comn";2��="comn1"
        window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //������ ����â ����.

     
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
   	     	+ "menu_level=" + getObjectFirst("menu_level").value;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu031I",
            "JSP(O:DS_MENU=ds_menu)",
            param);
        tr_post(tr1); 		
	}


	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {    
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
       	     	+ "menu_level=" + getObjectFirst("menu_level").value;

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu031I",
	            "JSP(O:DEFAULT=ds1)",
	            param);
	        tr_post(tr1);
        }
    }

	/*
	 * ���߰�(�׸��庰)
	 */
	function fnAddRow1() {
		ds1.addrow();
		ds1.namevalue(ds1.rowposition,"LEVEL")= getObjectFirst("menu_level").value;

	}
	/*
	 * �����(�׸��庰)
	 */
	function fnDeleteRow1() {
		ds1.deleterow(ds1.rowposition);
	}
	/*
	 * ����
	 */
	function fnApply() {
		if (ds1.IsUpdated ) {
	        v_job = "I";	
	        window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
       	     	+ "menu_level=" + getObjectFirst("menu_level").value;       	     	
       	     	
    	    ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu031I",
	            "JSP(I:DS1=ds1)",
	            param);
	         tr_post(tr1);
         }
	}
	/*
	 * ���
	 */
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
	}
	
    </script>
<%
/*=============================================================================
				Developer Java Script ��
=============================================================================*/
%>
    
    
    
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts ����
=============================================================================*/


/*=============================================================================
			Gauce Components Event Scripts ��
=============================================================================*/
%>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/

	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
	%>
		<script language="javascript" for="tr1" event="onsuccess()">
	        if(v_job=="I") {
	            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	        }  else if(v_job == "H" || v_job=="S")
	            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
	%>
		<script language="javascript" for="tr1" event="onfail()">
	        if(v_job=="I") {
	            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	        }  else if(v_job == "H" || v_job=="S")
	            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	                   
	        var alertMsg = '';
	       	var nErrCnt = tr1.SrvErrCount("ERROR");
	       	for (i = 0; i < nErrCnt; i++) 
				alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
	        if ( nErrCnt > 0 )
			    alert(alertMsg);              
		</script>
	
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR2
	%>
		<script language="javascript" for="tr2" event="onsuccess()">
	        if(v_job=="I") {
	            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	        }  else if(v_job == "H" || v_job=="S")
	            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR2
	%>
		<script language="javascript" for="tr2" event="onfail()">
	        if(v_job=="I") {
	            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	        }  else if(v_job == "H" || v_job=="S")
	            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	                   
	        var alertMsg = '';
	       	var nErrCnt = tr1.SrvErrCount("ERROR");
	       	for (i = 0; i < nErrCnt; i++) 
				alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
	        if ( nErrCnt > 0 )
			    alert(alertMsg);              
		</script>
		
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR3
	%>
		<script language="javascript" for="tr3" event="onsuccess()">
	        if(v_job=="I") {
	            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	        }  else if(v_job == "H" || v_job=="S")
	            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR3
	%>
		<script language="javascript" for="tr3" event="onfail()">
	        if(v_job=="I") {
	            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	        }  else if(v_job == "H" || v_job=="S")
	            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	                   
	        var alertMsg = '';
	       	var nErrCnt = tr1.SrvErrCount("ERROR");
	       	for (i = 0; i < nErrCnt; i++) 
				alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
	        if ( nErrCnt > 0 )
			    alert(alertMsg);              
		</script>		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts ��
=============================================================================*/
%>



<%
/*=============================================================================
			DataSet Component's Event Message Scripts ����
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts ��
=============================================================================*/



/*=============================================================================
			DataSet Component's Event Message Scripts ��
=============================================================================*/
%>



<%
/*=============================================================================
			DataSet Components(DS) ���� ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_menu classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_page classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ������� -->
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>


</head>
<jsp:include page="/Common/sys/body_s08.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border=0 cellpadding="0" cellspacing="0" width="100%" bordercolor=orange>
  <tr>
	<td>
		<table border=0 width=845 cellpadding=0 cellspacing=0>
		  <tr height="50px">
			<td align="left" ><!-- ��ư ����-->
				<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
					<tr> 
						<td align="right">
							<table border="0"  cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="right" height="30px">		
										<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRow1()" >
										<!-- <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRow1()" >-->
										<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">						 			
									</td>
								</tr>
							</table>
						</td>
					</tr>															
				</table>	
			</td>											
		  </tr>
		
		  <tr height="30px">
			<td align="left" ><!-- �˻����� ����-->
				<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
					<tr> 
						<td  width="845px">
	                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
	                            <tr bgcolor="#6f7f8d">
	            					<td align=left class="text" width=70>&nbsp;ǰ�񷹺�</td>
	                                <td align=left bgcolor="#ffffff">&nbsp;																										
										<SELECT NAME=menu_level style="width:120px;align:center;">
											<OPTION value=1>����1 ����</OPTION>
											<OPTION value=2>����2 ����</OPTION>
											<OPTION value=3>����3 ����</OPTION>
										</SELECT>
									</td>
	            				</tr>
	            			</table>
						</td>
					</tr>															
				</table>	
			</td>											
		  </tr>
		  <tr height="10">
			<td></td>
		  </tr>		
		  <tr>
			<td width="845px"><!-- �׸��� ����-->
				
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
                                <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								 	<C> name='No.'        		ID='{STRING(CURROW)}'   	width=50    align=center</C>
								 	<C> name='�ڵ��ȣ'	    ID='CODE_NO'	width=100  	align=center editlimit=10 	show=true edit=true</C>
									<C> name='ǰ�񷹺�'     	ID='LEVEL'     	width=100		align=center editlimit=5 	show=true edit=none </C>
									<C> name='����ǰ��'		ID='P_CODE'	width=250  	align=left	 	show=true 	editstyle=lookup data='ds_menu:code_no:code_nm'</C>
									<C> name='ǰ���'   		ID='CODE_NM'  width=250	align=left 		editlimit=200  show=true Sort=true</C>
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
