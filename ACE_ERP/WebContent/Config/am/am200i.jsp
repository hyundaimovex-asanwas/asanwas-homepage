<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ��������
 * ���α׷�ID 	: am200i
 * J  S  P		: am200i
 * �� �� ��		: am200i
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-01-06
 * �������		: ����������� �־ ������ ��� �� �����ϴ� ȭ��
 * [��  ��   ��  ��][������] ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>

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
		var jobFlag = "";
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit(); 
		} 
		/*
		 * �ʱ��۾�
		 * Header ���� 
		 */
		function fnInit(){
    	   jobFlag = "INIT";
		}
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			//if(sItem_cd.value == "" && sItem_nm.value == ""){
			//	alert("������ȣ �Ǵ� ǰ�� �� �ϳ��� �ݵ�� �ԷµǾ�� �մϴ�.")
			//	return;
			//}
			
			if (ds1.IsUpdated==false ) {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sItem_cd="+ sItem_cd.value
				          + ",sItem_nm=" + sItem_nm.value
				          + ",sModel_nm=" + sModel_nm.value;
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am200I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			} else {
				alert("�۾����� ���¿����� ��ȸ�Ҽ� �����ϴ�!");
			}
		}
		/*
		 * ���߰� , �ű� 
		 */
		function fnAddRowDs1() {
			jobFlag = "N";
			ds1.addRow();
			rowNum.value = ds1.rowposition;
		}
		function fnDeleteRowDs1() {
			jobFlag = "D";
			ds1.deleterow(ds1.rowposition);
		}
		/*
		 * �Է� üũ
		 */
		function fnCheck() {
		 if (ds1.IsUpdated) {
				if (jobFlag != "D") {
				 for(var i=1; i<=ds1.CountRow; i++){
				  	if(ds1.NameValue(ds1.rowposition, "item_cd")=="") {
	                 	alert("������ȣ�� �Է��ϼ���!");
	                 	getObjectFirst("item_cd").focus();
	                 	return;
	                 }
	                if(ds1.NameValue(ds1.rowposition, "item_nm")==""){
	                    alert("ǰ���� �Է��ϼ���!");
	                    getObjectFirst("item_nm").focus();
	                    return;
	                }
	              }
              }
		   }
			 return true;
		}
		/*
		 * ����
		 */		
		function fnApply() {
	
			var row=ds1.countRow;
			
			if (ds1.IsUpdated ) {
				if(fnCheck()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am200I",
	                "JSP(I:DS1=ds1)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            		tr_post(tr1);
            	}
			}	
		}
		/*
		 * ��� 
		 */
		function fnCancel() {
			ds1.undoall();
			if (ds1.countrow >= 1) {
				fnSelectDs1();
			}
			window. status="������ ������ ��ҵǾ����ϴ�.";
			return;		
		}
		/*
		 * ����
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:���������_���; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("���������","���������_���.xls", 8);
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
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
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
			<td width='425px'>
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
					<tr>
						<td width='70px' height="30px" class='text'>������ȣ</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  	name='sItem_sid' 		value='' maxlength='20' 	size='10' 	class='textbox'>
							<input type='text' 		name='sItem_cd' 		value='' maxlength='20' 	size='10' 	class='textbox'>
						</td>
						<td width='70px' height="30px" class='text'>ǰ��</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='text'  	name='sItem_nm' 		value='' maxlength='20' 	size='10' 	class='textbox'>
						</td>
						<td width='70px' height="30px" class='text'>�� ��</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='text'  	name='sModel_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
						</td>
					</tr>
				</table>
			</td>
			<td align='right'>
				<table border='0' cellpadding='0' cellspacing='0' width='390px'>
					<tr>
						<td height='30px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
						</td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr>
			<td height='10px'></td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
				<table  border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td valign='top'>
							<table  border='0' cellpadding='0' cellspacing='0' width='300px' height='430px' >
								<tr>
									<td>
										<%=HDConstant.COMMENT_START%>
										<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='427px' border='1'>
											<param name="DataID"			value="ds1">
											<param name="ColSizing"			value="true">
											<param name="Fillarea"			value="false">
											<param name="Editable"  		value="false">
											<param name="BorderStyle"       value="0">
											<param name=SortView  			value="Left">
											<param name="Format" 			value="
								                <C> name='ITEM_SID'    ID='item_sid' 		Width=100  align=left editlimit=10 	show=false</C>
								                <C> name='������ȣ'    ID='item_cd'    		Width=100  align=left editlimit=20 	show=true sort=true</C><!-- ������ȣ -->
								                <C> name='ǰ��'      	ID='item_nm'    		Width=120  align=left editlimit=20 	show=true</C> <!--ǰ�� -->
								                <C> name='�ڻ��ڵ�'    ID='asset_cd'    	Width=100  align=left editlimit=20 	show=FALSE</C>
								                <C> name='�𵨸�'      	ID='model_nm'   	Width=100  align=left editlimit=30 	show=FALSE</C>
								                <C> name='������'  		ID='made_company'   	Width=100  align=left editlimit=20 	show=false</C>
								                <C> name='CPU' 			ID='cpu'    	Width=100  align=left editlimit=50 	show=FALSE</C>
								                <C> name='���κ���'    ID='mainboard' 		Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='�ϵ��ũ' ID='hdd'  	Width=100  align=left editlimit=10 	show=false</C>
								                <C> name='�� '     		ID='ram'    				Width=100  align=left editlimit=10 	show=false</C>
								                <C> name='�׷���ī��'    	ID='graphic'  	Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='�Ŀ����ö���'      	ID='powersupply'    Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='DVD'       	ID='dvd'     			Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='������ PRODUCT KEY'      	ID='win_serial'     		Width=100  align=left editlimit=30 	show=false</C>
								                <C> name='���'     	ID='remarks'   		Width=100  align=left editlimit=200 	show=false</C>
								        	">											
										</object>	
										<%=HDConstant.COMMENT_END%>								
									</td>
								</tr>
							</table>
						</td>
						<td width='10px'></td>
						<td valign='top'>
							<table border='0' cellpadding='0' cellspacing='0' width='530px'>
								<tr>
									<td width='535px'>
										<table border='0' cellpadding='0' cellspacing='1' width='530px' height='244px' bgcolor="#666666">
											<tr>
												<td width='120px' height='30px' class='boardt02'>������ȣ</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='item_cd' 		name='item_cd' 		value='' maxlength='10' size='18' 	class='textbox' > <!-- ������ȣ -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>ǰ��</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='item_nm' 		name='item_nm' 		value='' maxlength='20' size='18' 	class='textbox' > <!-- ǰ�� -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>�𵨸�</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='model_nm' 		name='model_nm' 		value='' maxlength='30' size='18' 	class='textbox' > <!-- �𵨸� -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>������</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='made_company' 		name='made_company' 		value='' maxlength='20' size='18' 	class='textbox' > <!--������ -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>CPU</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='cpu' 		name='cpu' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- cpu -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>���κ���</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='mainboard' 		name='mainboard' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- ���κ��� -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>�ϵ��ũ</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='hdd' 		name='hdd' 		value='' maxlength='10' size='18' 	class='textbox' > <!-- �ϵ��ũ -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>��</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='ram' 		name='ram' 		value='' maxlength='10' size='18' 	class='textbox' > <!-- �� -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>�׷���ī��</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='graphic' 		name='graphic' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- �׷���ī�� -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>�Ŀ����ö���</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='powersupply' 		name='powersupply' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- �Ŀ����ö��� -->
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>DVD</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='dvd' 		name='dvd' 		value='' maxlength='50' size='18' 	class='textbox' > <!-- DVD -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>������_KEY</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='win_serial' 		name='win_serial' 		value='' maxlength='30' size='18' 	class='textbox' > <!--������ PRODUCT KEY-->
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>���</td>
												<td  bgcolor='#FFFFFF' colspan='3'>
													&nbsp;&nbsp;<input type='text' id='remarks' 		name='remarks' 		value='' maxlength='200' size='63' 	class='textbox'> <!--���-->
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height='10px'></td>
								</tr>

							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
        <%
        /*=============================================================================
                                Bind ����
        =============================================================================*/
        %>
        <%=HDConstant.COMMENT_START%>
        <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
            <param name="DataId" value="ds1">
            <param name=BindInfo    value="
                    <C>Col=item_sid      		Ctrl=item_sid 	    	    Param=value </C>
                    <C>Col=item_cd         	Ctrl=item_cd      	    	Param=value </C>
                    <C>Col=asset_cd         Ctrl=asset_cd            	Param=value </C>
                    <C>Col=item_nm       	Ctrl=item_nm		          	Param=value </C>
                    <C>Col=model_nm        Ctrl=model_nm         		Param=value </C>
                    <C>Col=made_company        Ctrl=made_company          Param=value </C>
                    <C>Col=cpu         		Ctrl=cpu            			Param=value </C>
                    <C>Col=mainboard     	Ctrl=mainboard      		Param=value </C>
                    <C>Col=hdd           		Ctrl=hdd            			Param=value </C>
                    <C>Col=ram      			Ctrl=ram       				 	Param=value </C>
                    <C>Col=graphic          	Ctrl=graphic            		Param=value </C>
                    <C>Col=powersupply     Ctrl=powersupply       	Param=value </C>
                    <C>Col=dvd      			Ctrl=dvd        				Param=value </C>
                    <C>Col=win_serial       	Ctrl=win_serial        		Param=value </C>
                    <C>Col=remarks    		Ctrl=remarks      			Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%>
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

