<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: ��Ͻ�û [ȭ��]
 * ���α׷�ID 	: RV250I
 * J  S  P		: rv250i
 * �� �� ��		: Rv250I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-26
 * �������		:
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
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
		var updateFlag = "";
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			
			codeDs3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			codeDs3.Reset(); //�����ڵ�
        	
			fnInit(); 
			
			codeDs1.deleterow(1);
			codeDs2.deleterow(1);
			codeDs4.deleterow(1);
		} 
		 
		/*
		 * �ʱ��۾�
		 * Header ���� 
		 */
		function fnInit(){
       		fnHeaderDs1();
			fnHeaderDs2();
			fnHeaderDs3();
			
			fnToDay("S");
        
			ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv250I",
	            "JSP(O:RM014=codeDs1,O:RM015=codeDs2,O:SY010=codeDs4)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		}
		
		function fnHeaderDs1() {
			if (ds1.countrow<1){
				var s_temp = ""
				s_temp += "ACCEPT_SID:INT,"
						+ "ACCEPT_NO:STRING,"
						+ "ACCEPT_DATE:STRING";

				ds1.SetDataHeader(s_temp);
			}
		}
		
		function fnHeaderDs2() {
			if (ds2.countrow<1){
				var s_temp = ""
					
				 s_temp += "CAR_RSV_SID:INT,"
						+ "ACCEPT_SID:INT,"
						+ "CAR_SID:INT,"
						+ "CAR_NM:STRING,"
						+ "CAR_NO:STRING,"
						+ "DEPART_DATE:STRING,"
						+ "DEPART_TIME:STRING,"
						+ "ARRIVE_DATE:STRING,"
						+ "ARRIVE_TIME:STRING,"
						+ "CARGO:STRING,"
						+ "DRIVE_SID:INT,"
						+ "CUST_NM:STRING,"
						+ "MANAGE_NO:STRING,"
						+ "DRIVE_NO:STRING,"
						+ "CLIENT_SID:INT";

				ds2.SetDataHeader(s_temp);
			}		
		}
		
		function fnHeaderDs3() {
			if (ds3.countrow<1){
				var s_temp = ""
					s_temp += "CAR_RSV_SID:INT,"
							+ "KEY_SEQ:INT,"
							+ "CARGO_NAME:STRING,"
							+ "CARGO_SIZE:STRING,"
							+ "CARGO_UNIT:STRING,"
							+ "CARGO_WEIGHT:INT,"
							+ "CARGO_QTY:INT,"
							+ "CARGO_PRICE:INT,"
							+ "CARGO_AMT:INT";


				ds3.SetDataHeader(s_temp);
			}		
		}
		
		/*
		 * �űԽ� 
		 * ��û���ڸ� ���� ���ڷ� �����Ѵ� 
		 * type S= �˻�����, I= �Է�
		 */
		function fnToDay(type) {
			today = new Date();
			if(today.getMonth()<10) {
				if (type == "S") {
					if (today.getDate() <10 ) {
						to_accept_date.Text=today.getYear()+"0"+(today.getMonth()+1)+"0"+today.getDate();
						from_accept_date.Text=today.getYear()+"0"+(today.getMonth()+1)+"0"+today.getDate();
					} else {
						to_accept_date.Text=today.getYear()+"0"+(today.getMonth()+1)+""+today.getDate();
						from_accept_date.Text=today.getYear()+"0"+(today.getMonth()+1)+""+today.getDate();
					}
				} else if (type == "I") {
					ds1.namevalue(ds1.rowposition, "accept_date") =  today.getYear()+"0"+(today.getMonth()+1)+""+today.getDate();
				}
			 	
			} else {
				if (type== "S") {
					if (today.getDate() <10 ) {
							to_accept_date.Text=today.getYear()+"0"+(today.getMonth()+1)+"0"+today.getDate();
							from_accept_date.Text=today.getYear()+"0"+(today.getMonth()+1)+"0"+today.getDate();
					} else {
						to_accept_date.Text=today.getYear()+"0"+(today.getMonth()+1)+""+today.getDate();
						from_accept_date.Text=today.getYear()+"0"+(today.getMonth()+1)+""+today.getDate();
					}
				} else if (type == "I") {
					ds1.namevalue(ds1.rowposition, "accept_date") =  today.getYear()+""+(today.getMonth()+1)+""+today.getDate();
				}
				
			}
			
		}
		
		function fnSelect() {
			if (sClient_sid.value != null && sClient_sid.value != "" && sClient_sid.value.length >0 ) {
				fnSelectDs1();
			} else {
				alert("��ȸ�Ͻð��� �ϴ� �븮���� �������ּ���!");
				return;
			}
		}
			
		/*
		 * ���� ��ȸ
		 * �ʱ� ��������Ʈ�� �ο�����Ʈ�� ��ȸ�Ѵ� 
		 */			
		function fnSelectDs1() {
		
		 	if (!ds1.IsUpdated && !ds2.IsUpdated && !ds3.IsUpdated) {
		 		updateFlag = "S";
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sClientSid="+ sClient_sid.value				// ���¾�ü �ڵ�
				          + ",sFromAcceptDate=" + from_accept_date.Text		// ��û���� To
				          + ",sToAcceptDate=" + to_accept_date.Text			// ��û���� From
				          + ",sAcceptNo=" + sAcceptNo.value
				          + ",sSaupSid=" + sSaupSid.ValueOfIndex("saup_sid",sSaupSid.Index); 
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv250I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			} else {
				alert("�۾��߿��� ��ȸ�Ҽ� �����ϴ�!");	
				return;			
			}
		}
		
		/*
		 * �������� Ű�� �޾Ƽ� ��ȸ
		 * ��������Ʈ Ŭ���� �ο�����Ʈ ��ȸ 
		 */
		function fnSelectDs2() {
			updateFlag = "S";
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sAcceptSid="+ ds1.namevalue(ds1.rowposition, "ACCEPT_SID");
			        
			
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv250I",
			    "JSP(O:DS2=ds2)",
			    param);
			tr_post(tr1);
		}
		
		
		function fnSelectDs3() {
		
			updateFlag = "S";
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sAcceptSid="+ ds1.namevalue(ds1.rowposition, "ACCEPT_SID")
			          + ",sCarRsvSid=" + ds2.namevalue(ds2.rowposition, "CAR_RSV_SID");
			
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv250I",
			    "JSP(O:DS3=ds3)",
			    param);
			tr_post(tr1);
		}
		
		/*
		 * ����
		 * ��������Ʈ, �ο�����Ʈ�� �����Ѵ� 
		 */
		function fnApply() {
			
			var param= "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
						+ ",sClientSid=" + sClient_sid.value
						+ ",sSaupSid=" + sSaupSid.ValueOfIndex("saup_sid",sSaupSid.Index);
			
				
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv250I",
			    "JSP(I:DS1=ds1,I:DS2=ds2, I:DS3=ds3, O:DS4=ds4)",
			    param);
			tr_post(tr1);			
			
			fnSelectDs3();		
		}
		
		
		/*
		 * ����� 
		 * �ο�����Ʈ ���� 
		 */
		function fnDeleteRowDs3() {
			ds3.DeleteRow(ds3.RowPosition);
		}
		
		
		/*
		 * ���߰� 
		 * �ο�����Ʈ
		 */
		 function fnAddRowDs3() {
		 	//ds3.AddRow();
		 	
			ds3.AddRow();
			ds3.namevalue(ds3.rowposition,"car_rsv_sid") = ds2.namevalue(ds2.rowposition,"car_rsv_sid");
		 }
		 
		/* 
		 * ��� 
		 * �۾���� 
		 */
		 
		 function fnCancel() {
		 	ds3.UndoAll();
		 }
		 
		/*
		 * ���¾�ü
		 */
		function fnClientPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			var dir = '<%=dirPath%>';
			
			arrResult = fnClientPop(dir,'2');
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		sClient_sid.value = arrParam[0];
		   		sClient_nm.value = arrParam[1];
			} else {
			  sClient_nm.value = "";
			  sClient_sid.value = "";
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
//		fnSelectDs3();
	</script>	
	
	<script language=JavaScript for=ds1 event=OnRowPosChanged(row)>
		if(row<1) {
			return;
		}
		
		if (ds3.IsUpdated) {
			alert("�۾��߿��� ��ȸ�Ҽ� �����ϴ�!");
			return;
		}
		fnSelectDs2();
		fnSelectDs3();
	</script>
	
	
<%



/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��������Ʈ  -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �ο�����Ʈ  -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��û����ȣ �űԽ�   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- RM014   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- RM015   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����   -->
	<param name="SyncLoad" 	value="false">
</object>

<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��������   -->
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td>
				<table border='0' cellpadding='0' cellspacing='1' bgcolor="#666666"  width='220px'>
					
					<tr  height="30px">
						<td bgcolor="#FFFFFF"  width="100px" class='text'>����</td>
						<td bgcolor="#ffffff" width='100px'>&nbsp;
							<%=HDConstant.COMMENT_START%>
    						<object id=sSaupSid classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  class="txtbox"  align=absmiddle >
    							<param name=ComboDataID			value=codeDs3>
    							<param name=SearchColumn		value="saup_nm">
    							<param name=Sort				value="false">
    							<param name=ListExprFormat		value="saup_nm^0^140">
    							<param name=BindColumn			value="saup_sid">
    						</object>
                            <%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
			<td align="right" colspan='4'>
				<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
				<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand"	align=absmiddle onClick="fnApply();">			<!-- ���� -->
				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">			<!-- ��� -->
			</td>
		</tr>
		<tr height="10px">
			<td></td>
		</tr>
		<tr>
			<td colspan="3"  border='0' cellpadding='0' cellspacing='0' width='845'>
				<table colspan="3"  border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height="30px">
						<td bgcolor="#FFFFFF" class="text" width="100px" >���¾�ü</td>
						<td  bgcolor="#FFFFFF" align="center" width="200px">
							<input type="text" name="sClient_nm" value="" size="20" readonly="readonly" class="textbox">&nbsp;
							<input type="hidden" name="sClient_sid"  value="" size="5" readonly="readonly" class="textbox">&nbsp;
							<img src="<%=dirPath%>/Sales/images/help.gif" 	style="cursor:hand" 	align=absmiddle onClick="fnClientPopup();" >
						</td>
						<td bgcolor="#FFFFFF" class="text" width="100px">��û����</td>
						<td  bgcolor="#FFFFFF" align="center" width="200px">
							<%=HDConstant.COMMENT_START%>
							<object id=from_accept_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>			
								<param name=Alignment 	value=1>
								<param name=Format 		value="####-##-##">
								<param name=Cursor	 	value="Hand">
								<param name=Enable      value="True">
                                <param name=ReadOnly    value="False">
                                <param name=Border   	value=false>
							</object>
							<%=HDConstant.COMMENT_END%>
							~
							<%=HDConstant.COMMENT_START%>
							<object id=to_accept_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>			
								<param name=Alignment 	value=1>
								<param name=Format 		value="####-##-##">
								<param name=Cursor	 	value="Hand">
								<param name=Enable      value="True">
                                <param name=ReadOnly    value="False">
                                <param name=Border   	value=false>
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#FFFFFF" class="text" width="100px">��û����ȣ</td>
						<td  bgcolor="#FFFFFF" align="center" width="120px">
							<input type="text" name="sAcceptNo" value="" size="15"  class="textbox" maxlength="15">
						</td>
						
					</tr>
				</table>
			</td>
		</tr>
		<tr height="15px">
			<td></td>
		</tr>
		<tr>
			<td width='270' valign="top">
				<table  border='0' cellpadding='0' cellspacing='0' width='270'>
					<%=HDConstant.COMMENT_START%>
					<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='270px' height='400px' border='1'>
						<param name="DataID"			value="ds1">
						<param name="ColSizing"			value="true">
						<param name="Fillarea"			value="false">
						<param name="Editable"  		value="false">
						<param name="BorderStyle"      	value="0">
						<param name=FixSizing  			value="false">
						<param name=IndWidth  			value="20">	
						<param name="Format" 			value="
			               <C> name='��ûSID'   	ID='accept_sid'  	align=left width=60 	editlimit=12 	show=false</C>
			               <C> name='��û����ȣ'	ID='accept_no'   	align=left width=150 	editlimit=15 	show=true mask='XXXXX-XXXXXX-XXX'</C>
			               <C> name='��û����'  	ID='accept_date'	align=left width=100 	editlimit=8 	show=true  mask='XXXX-XX-XX'</C>
						">											
					</object>	
					<%=HDConstant.COMMENT_END%>		
				</table>
			</td>
			<td width='15'>&nbsp;</td>
			<td valign="top">
				<table  border='0' cellpadding='0' cellspacing='0' width='560'>
					<tr>
						<td width='410px' valign="top" bgcolor=#ff0000>
							<table width='410px' border='0' cellpadding='0' cellspacing='1' bgcolor="#666666">
								<tr height="30px"> 
									<td class="boardt02" width="80px">��û����</td>
									<td bgcolor="#FFFFFF" align="center" width="100px">
										<%=HDConstant.COMMENT_START%>
										<object id=accept_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>			
											<param name=Alignment 	value=1>
											<param name=Format 		value="####-##-##">
											<param name=Cursor	 	value="Hand">
											<param name=Enable      value="False">
			                                <param name=ReadOnly    value="True">
			                                <param name=Border   	value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td  class="boardt02"  width="100px">��û����ȣ</td>
									<td  bgcolor="#FFFFFF" width='130px' align="center">
										<!-- <input type="text" name="accept_no" id="accept_no" value="" size="10"  class="textbox" readonly="readonly">&nbsp;-->
										
										
										<%=HDConstant.COMMENT_START%>
										<object id=accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>			
											<param name=Alignment 	value=1>
											<param name=Format 		value="#####-######-###">
											<param name=Cursor	 	value="Hand">
											<param name=Enable      value="False">
                                            <param name=ReadOnly    value="True">
                                            <param name=Border   	value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
										
									</td>
								</tr>
							</table>
						</td>
						<td align="right" width='150px'>
						</td>
					</tr>
					<tr height="5px">
						<td></td>
					</tr>
					<tr>
						<td colspan="2"  width='560px'>
							<%=HDConstant.COMMENT_START%>
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='560px' height='160px' border='1'>
								<param name="DataID"			value="ds2">
								<param name="ColSizing"			value="true">
								<param name="Fillarea"			value="false">
								<param name="Editable"  		value="Fales">
								<param name="BorderStyle"      	value="0">
								<param name=FixSizing  			value="false">
									<param name=IndWidth  			value="20">	
								<param name="Format" 			value="
					               <C> name='��������SID'  	ID='car_rsv_sid'    align=left width=100 editlimit=12 show=false</C>
					               <C> name='��ûSID'   		ID='accept_sid'  	align=left width=100 editlimit=12 show=false</C>
					               <C> name='����SID'      	ID='car_sid'     	align=left width=100 editlimit=12 show=false </C>
					               <C> name='����'       	ID='car_nm'      	align=left width=100 editlimit=32 show=true </C>
					               <C> name='������Ϲ�ȣ'   	ID='car_no'      	align=left width=100 editlimit=30 show=true</C>
					               <C> name='�������'  		ID='depart_date'    align=left width=100 editlimit=8 show=true mask='XXXX-XX-XX'</C>
					               <C> name='���ð�'  		ID='depart_time'    align=left width=100 editlimit=4 show=true  data='codeDs1:detail:detail_nm'</C>
					               <C> name='�԰�����'  		ID='arrive_date'    align=left width=100 editlimit=8 show=true mask='XXXX-XX-XX'</C>
					               <C> name='�԰�ð�'  		ID='arrive_time'    align=left width=100 editlimit=4 show=true  data='codeDs2:detail:detail_nm'</C>
					               <C> name='ȭ��'        	ID='cargo'       	align=left width=100 editlimit=100 show=true</C>
					               <C> name='��������SID'    ID='drive_sid'   	align=left width=100 editlimit=12 show=false</C>
					               <C> name='������'      	ID='cust_nm'     	align=left width=100 editlimit=30 show=true </C>
					               <C> name='�ֹο��ǹ�ȣ'   	ID='manage_no'   	align=left width=100 editlimit=20 show=true</C>
					               <C> name='���������ȣ'   	ID='drive_no'   	align=left width=100 editlimit=20 show=true</C>
					               <C> name='�븮��SID'   	ID='client_sid'  	align=left width=100 editlimit=12 show=false</C>															             
								">											
							</object>	
							<%=HDConstant.COMMENT_END%>	
							
						</td>
					</tr>
					<tr height="5px">
						<td></td>
					</tr>
					<tr height="30px">
						<td colspan="2" align="right"  width='560px'>
							<img src="<%=dirPath%>/Sales/images/plus.gif"		style="cursor:hand" 	align=absmiddle onClick="fnAddRowDs3()" >		<!-- ���߰� -->
							<img src="<%=dirPath%>/Sales/images/minus.gif" 	style="cursor:hand" 	align=absmiddle onClick="fnDeleteRowDs3()" >		<!-- ����� -->
						</td>
					</tr>
					<tr height="5px">
						<td></td>
					</tr>
					<tr>
						<td colspan="2"  width='560px'>
							<%=HDConstant.COMMENT_START%>
							<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> width='560px' height='160px' border='1'>
								<param name="DataID"			value="ds3">
								<param name="ColSizing"			value="true">
								<param name="Fillarea"			value="false">
								<param name="Editable"  		value="True">
								<param name="BorderStyle"      	value="0">
								<param name=FixSizing  			value="false">
								<param name=IndWidth  			value="20">	
								<param name="Format" 			value="
									<C> name='����SID'		ID='car_rsv_sid'  	widthi=100 align=left editlimit=12 show=true</C>
									<C> name='KEY_SEQ'  	ID='key_seq'     	widthi=100 align=left editlimit=5 show=true</C>
									<C> name='ȭ��ǰ��'   	ID='cargo_name'  	widthi=100 align=left editlimit=60 show=true</C>
									<C> name='ȭ���԰�'   	ID='cargo_size'  	widthi=100 align=left editlimit=60 show=true</C>
									<C> name='ȭ������'   	ID='cargo_unit'  	widthi=100 align=left editlimit=6 show=true</C>
									<C> name='ȭ���߷�' 		ID='cargo_weight' 	widthi=100 align=left editlimit=12 show=true</C>
									<C> name='ȭ������'    	ID='cargo_qty'   	widthi=100 align=left editlimit=12 show=true</C>
									<C> name='ȭ���ܰ�'  		ID='cargo_price' 	widthi=100 align=left editlimit=12 show=true</C>
									<C> name='ȭ���ݾ�'    	ID='cargo_amt'   	widthi=100 align=left editlimit=12 show=true</C>			             
								">											
							</object>	
							<%=HDConstant.COMMENT_END%>							
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
            <C>Col=accept_sid               Ctrl=accept_sid         Param=value </C>
            <C>Col=accept_no                Ctrl=accept_no          Param=Text </C>
            <C>Col=accept_date              Ctrl=accept_date        Param=Text </C>
        ">
</object>
<%=HDConstant.COMMENT_END%>	
        
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

