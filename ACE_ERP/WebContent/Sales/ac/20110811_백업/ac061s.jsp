<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������ ��볻��
 * ���α׷�ID 	: AC061S
 * J  S  P		: ac061s
 * �� �� ��		: Ac061S
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2008-11-29
 * [ �������� ][������] ����
 * [2008-11-29][�ɵ���] �� �޴� ����
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
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		// �������ε�
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit();
		} 
		 
		function fnInit() {
			// ����
			div = 'init';
            codeDs3.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC001&s_item1=Y";
            codeDs3.Reset();
            

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_SAUP_DS=codeDs1,O:S_GOODS_DS=codeDs2)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		}
		
				
		// ���� ��ȸ
		function fnSelect() {
			
			if(sPAY_MANAGE_NO.Text==""){
				alert('����������ȣ�� �Է����ּ���');
				return;
			}
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sPAY_MANAGE_NO="+ sPAY_MANAGE_NO.Text;
                      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac061S",
			    "JSP(O:DS1=ds1)",
			    param);
			tr_post(tr1);
		}
			
		/*
		 * ����
		 */
		function fnExcel() {
			if(ds1.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
            
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:������ ��볻��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("������ ��볻��","������ ��볻��.xls", 32);
		}
    	
		// �˻����� �븮��  �˾� 
	    function fnSelectClientPopup(dirPath) {
	        
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	        
	        arrResult = fnClientPop(dirPath,'');
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            sClientNm.value = arrParam[1];
	            sClientSid.value = arrParam[0];
	        } else {
	          sClientNm.value = "";
	          sClientSid.value = "";
	        }               
	    }   
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
    <script language="javascript" for="tr1" event="onsuccess()">
        window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
    </script>   

    <script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert(error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
    </script>

    <script language="javascript" for="tr2" event="onsuccess()">
        window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
    </script>   

    <script language="javascript" for="tr2" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
        var error_cnt = tr2.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert(error_msg);
        else
            alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
    </script>

   

   
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>	<%//���� %>
	<param name="SyncLoad" 	value="true">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px' align=right>
				<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
				<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcel()">		<!-- ���� -->
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='25'>
						<td class="text" width="100">����������ȣ</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=sPAY_MANAGE_NO classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;">
	                            <param name=Format      value="000000-0000">
	                            <param name=Alignment   value=1>
	                            <param name=ClipMode    value=true>
	                            <param name=Border      value=false>
	                            <param name=Enable      value=true>
	                            <param name=SelectAll   value=true>
	                            <param name=SelectAllOnClick      value=true>
	                            <param name=SelectAllOnClickAny   value=false>								
							</object>
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >

	                        			<param name="DataID"		VALUE="ds1">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name="SuppressOption"    value="1">
										<param name="ViewSummary"    value="1">
										<param name="Format" 			value="
											<C> name='����������ȣ'		ID='PAY_MANAGE_NO'  width=80   	align=center editlimit=50 show=true  mask='XXXXXX-XXXX' sumtext='��' Suppress='1'</C>
											<C> name='�������'			ID='DEPART_DATE'  	width=80   	align=center editlimit=50 show=true  mask='XXXX-XX-XX' sumtext=@cnt Suppress='2'</C>
											<C> name='��ǰ��'			ID='GOODS_NM' 		width=100   align=center editlimit=50 show=true sumtext='��' Suppress='3'</C>
											<C> name='��û����ȣ'		ID='ACCEPT_NO'  	width=110   align=center editlimit=50 show=true mask='XXXXX-XXXXXX-XXX'</C>
											<C> name='����'			ID='CUST_NM'  		width=80   	align=center editlimit=50 show=true</C>		
											<C> name='�������'			ID='BIRTHDAY'  		width=60  	align=center editlimit=50 show=true </C>		
											<C> name='�ݾ�'				ID='PAY_AMT'  		width=70  	align=right editlimit=50 show=true decao=0 sumtext=@sum</C>
											<C> name='ȸ�豸��'			ID='ACCT_GUBN_NM'	width=60  	align=center editlimit=50 show=true</C>
											<C> name='�����ڵ�'			ID='PAY_CD_NM'  	width=60  	align=center editlimit=50 show=true</C>
											<C> name='�Ͻ�'				ID='U_DATE'  		width=115  	align=left editlimit=50 show=true dec=0</C>
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

		<tr>
			<td><br>���� 1�� �����ǿ� ���� ������ ��볻���̸�, �Ͻ� > ��û����ȣ > ���� �����Դϴ�.<br>
				���� �������� �������� <font color=red>�ݾ��� �հ� = 0</font> �� �Ǿ�� �մϴ�.<br>
			</td>
		</tr>
	</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

