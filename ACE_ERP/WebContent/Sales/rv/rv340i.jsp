<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������� �Աݾ״�ü
 * ���α׷�ID 	: rv340i
 * J  S  P		: rv340i
 * �� �� ��		: Rv340I
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2008-09-24
 * [��  ��   ��  ��][������] ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());			
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
	 var v_job='';
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr1"), "comn1");
		sSDate.Text = '<%=firstday%>';	
		sEDate.Text = '<%=firstday%>';
		fnInit();

	} 
		 
	function fnInit() {
		// ����
		v_job = 'init';
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_GOODS_DS=codeDs2)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
		codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		codeDs1.Reset(); //�����ڵ�

		// ������
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
            "JSP(O:CUSTALL=codeDs3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);
        
        //���� �ڵ� �ҷ�����
 		codeDs4.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=AC001";
		codeDs4.Reset(); //��ϸ���		

		getObjectFirst("sCustGu").index = 1; // ������ ���������� default        
	}
	
	/*
	 * ���� ��ȸ
	 */
	function fnSelect() {
		v_job = "S";
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoods_sid=" + lc2.ValueOfIndex("goods_sid", lc2.Index)
					  + ",sClient_sid=" + sClientSid.value
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text
			          + ",v_out_gubn="+ v_out_gubn.value
			          + ",sCustGu=" + sCustGu.ValueOfIndex("detail", sCustGu.Index);

			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv340I",
		    "JSP(O:DS1=ds1)",
		    param);
		   
		tr_post(tr1);
	}
		
	/*
	* �ο� �˾� : �ο� �׸��忡�� 
	*/
	function fnCustPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rv004h_01.jsp"
		strPos = "dialogWidth:570px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"D_CUST_NM") = arrParam[0];
	   		ds1.namevalue(ds1.rowposition, "D_RSV_SID") = arrParam[3];
	   		ds1.namevalue(ds1.rowposition, "D_TOT_PAY_AMT") = arrParam[2];
		} else {
			ds1.namevalue(ds1.rowposition,"D_CUST_NM") = "";
	   		ds1.namevalue(ds1.rowposition, "D_RSV_SID") = "";
			ds1.namevalue(ds1.rowposition,"D_TOT_PAY_AMT") = "";
   		}				
		
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
        getObjectFirst("gr1").SetExcelTitle(1, "value:�Աݾ� ��ü  ����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�Աݾ� ��ü","�Աݾ״�ü.xls", 8);
	}

	//ó����ư : �Աݾ� ��ü ����� ȭ�鿡 �����ش�.
	function fnSettle() {
		if(ds1.ConutRow <1) return;
		
		if(v_job!="calc"){
			for( i=1; i<=ds1.CountRow; i++ ) {
				var tour_amt 	= 0; //�ǸŰ�
				var sale_amt_tot= 0; //�������
				var remain_amt	= 0; //�ܾ�(=�Աݾ�-ȯ�Ҿ�-ȯ�Ծ�-�������)
				var D_PAY_AMT	=0; //��ü�� �ݾ�
				var D_TOT_PAY_AMT	=0; //��ü�޴� ���  �ݾ�
				tour_amt 	= getObjectFirst("ds1").NameValue(i,"tour_amt");
				sale_amt_tot= getObjectFirst("ds1").NameValue(i,"sale_amt_tot");
				remain_amt 	= getObjectFirst("ds1").NameValue(i,"remain_amt");
				D_PAY_AMT 	= getObjectFirst("ds1").NameValue(i,"D_PAY_AMT");
				D_TOT_PAY_AMT 	= getObjectFirst("ds1").NameValue(i,"D_TOT_PAY_AMT");


				if(getObjectFirst("ds1").NameValue(i, "D_PAY_AMT")!=0){
				  if(getObjectFirst("ds1").NameValue(i, "remain_amt") - getObjectFirst("ds1").NameValue(i, "D_PAY_AMT")>=0){
					//�ܾ��� ��ü�׺��� ũ�� �ܾ�= �ܾ�-��ü�� ,  ��ü�� �ݾ�=�����ݾ�+��ü�޴±�
					getObjectFirst("ds1").NameValue(i, "remain_amt")=getObjectFirst("ds1").NameValue(i, "remain_amt") - getObjectFirst("ds1").NameValue(i, "D_PAY_AMT");
                    getObjectFirst("ds1").NameValue(i, "D_TOT_PAY_AMT")=getObjectFirst("ds1").NameValue(i, "D_TOT_PAY_AMT") +++ getObjectFirst("ds1").NameValue(i, "D_PAY_AMT");
		       	  }else{ 
		        	alert("�ܾ��� �ʰ��Ͽ����ϴ�");
		          }

				  if(ds1.namevalue(i, "D_RSV_SID")==""){
					alert("��ü ���� ����� �������ֽñ� �ٶ��ϴ�.");
					return false;
				  };
		    	}
		    }
			v_job="calc"; //1�� ó���ϸ� ������ calc�� �־��ش�.2008-07-10
		}else{
		 alert("�̹� ó����ư�� �����̽��ϴ�.\n���� �Ǵ� ��� ��ư�� �����մϴ�.");
		 }
	}

	//����
	function fnApply() {
		if ( ds1.isUpdated ) {
            v_job = "I";
            window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv340I",
                "JSP(I:DS1=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
         } else {
         	alert("������Ʈ�� ���� �����ϴ�.");
		 }
	}	


	//���
	function fnCancel(){

		if(ds1.IsUpdated){
			ds1.undoall();
			v_job=""; //��Ҵ����� ���� �ʱ�ȭ
		}
		window.status="�Աݾ� ��ü�� ��ҵǾ����ϴ�.";
		return;
	}


	
	/**
     * �˻����� �븮��  �˾� 
     */
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
//		fnHideLoading();		
		if(v_job=="I"){
			fnSelect();
		};
	</script>	

	<script language=JavaScript for=sSDate event=OnKillFocus()>
	   if( sSDate.Modified == true )
			sEDate.text = sSDate.text;
	</script>	

	<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if (colid=="D_CUST_NM") {
			fnCustPopup();
		}
		if (colid=="n_card_no") {
			fnNcardPopup();
		}		                              

        if (colid=="room_type_cd") {		
			fnRoomTypePopup();
		}
	</script>        
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ������� -->
    <param name="SyncLoad"  value="False">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
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
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table border='0' celpadding='0' cellspacing='1' bgcolor='#666666'>
								<tr>
									<td align=left class="text" width="50">����</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs1>
											<param name=BindColumn      value="saup_sid">
				                            <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^80">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
									<td align="center" width="50" height="30px" class="text" >�븮��</td>
									<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
			                            <input type="text" name='sClientNm' id='sClientNm' value='' size='10' readonly='readonly'  class='textbox'>
			                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
			                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
			                            &nbsp;
									</td>
									<td align=CENTER class="text" width="65">��ǰ����</td>
				                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=80 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs2>
											<param name=BindColumn      value="goods_sid">
				                            <param name=BindColVal      value="goods_sid">
											<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
											<param name=ListExprFormat  value="goods_nm^0^120"></object>
										<%=HDConstant.COMMENT_END%>&nbsp;	
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
										<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
				                        <img src="<%=dirPath%>/Sales/images/settle.gif" 	style="cursor:hand" align=absmiddle onClick="fnSettle();">
				                        <img src="<%=dirPath%>/Sales/images/save.gif" 		style="cursor:hand" align=absmiddle onClick="fnApply();">
				                        <img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" align=absmiddle onclick="fnCancel()">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td align=CENTER class="text"  width="70">�������</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sSDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny   value="false">
							</object>&nbsp;~&nbsp;
	                       	<object id=sEDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">	
								<param name=SelectAllOnClickAny   value="false">
							</object>&nbsp;
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
						<td align=CENTER class="text" width='70'>��汸��</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                        	<select name="v_out_gubn" id="v_out_gubn" class="textbox">
                            	<option value="" selected>��ü
                                <option value="Y">���
                                <option value="N">�����
                            </select>
                        </td>
	                    <td align="center" width="70px" class="text">������</td>
						<td align="center" bgcolor="#ffffff">
							<%=HDConstant.COMMENT_START%>
							<object id=sCustGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs3>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
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
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="True">
								<param name="BorderStyle"	value="0">
								<Param Name="AllShowEdit"   value="True">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name=ViewSummary     value=1>
								<param name="Format" 		value="
									
									<C> name='�������'   	ID='depart_date'  	width=66 	align=CENTER editlimit=61 show=true suppress=1 mask='XXXX-XX-XX' SumText='�հ�' Edit=none</C>
									<C> name='��ǰ'   		ID='goods_sid'  	width=60 	align=left editlimit=61 show=true suppress=2 SUMTEXT=@CNT EditStyle=Lookup Data='codeDs2:goods_sid:goods_nm' Edit=none</C>
									<C> name='�븮��'   	ID='client_nm'  	width=70 	align=left editlimit=61 show=true suppress=3 SUMTEXT=�� Edit=none</C>
									<C> name='��û����ȣ'	ID='accept_no'  	width=90 	align=CENTER editlimit=61 show=true suppress=4  Edit=none</C>
									<C> name='����Ÿ��'   	ID='room_type_nm'	width=55 	align=CENTER editlimit=61 show=true SUPPRESS=5 Edit=none</C>
									<C> name='����'   		ID='cust_nm'  		width=55 	align=LEFT editlimit=61 show=true  SUPPRESS=6 Edit=none</C>
									<C> name='�� ��' 		ID='remain_amt'		width=70 	BgColor=pink align=right editlimit=61 show=true SumText=@sum  decao=0 Edit=none</C>
									<C> name='��ü ��\\�ݾ�'   	ID='D_PAY_AMT'  width=70 	BgColor=pink align=right editlimit=61  show=true SumText=@sum  decao=0 Edit=Numeric	</C>
									<C> name='��ü ����\\���'	ID='D_CUST_NM' width=70    BgColor=#D7FFDA align=left editlimit=61 editstyle=popup show=true SumText=@sum Edit=any	</C>
									<C> name='���� ���\\�Աݾ�'	ID='D_TOT_PAY_AMT' width=70 BgColor=#D7FFDA align=right editlimit=61  show=true SumText=@sum  decao=0 Edit=none</C>
									<C> name='��ü����\\RSV_sid' 		ID='D_RSV_SID'		width=80 	align=center editlimit=61 show=False Edit=none</C>									
									<C> name='��������' 	ID='pay_date'		width=60 	align=CENTER editlimit=61 show=true SUPPRESS=8 Edit=none</C>
									<C> name='�ǸŰ�'   	ID='tour_amt'  		width=60 	align=right editlimit=61 show=true   decao=0 BgColor=#fefec0 Edit=none</C>
									<C> name='�Աݾ�'   	ID='pay_amt'  		width=60 	align=right editlimit=61  show=true SumText=@sum  decao=0 Edit=none</C>
									<C> name='�������' 	ID='sale_amt'  		width=60	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#D7FFDA Edit=none</C>
									<C> name='���꿹����' 	ID='sale_amt_temp'	width=70	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#CCCCFF</C>
									<C> name='ȯ�Ҿ�'   	ID='refund_amt'  	width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0 BgColor=#FED8DB Edit=none</C>
									<C> name='ȯ�Ծ�' 	  	ID='fund_amt'  		width=60 	align=right editlimit=61 show=true SumText=@sum  decao=0 Edit=none</C>
									<C> name='�ֹ�/����'   	ID='manage_no' 		width=90 	align=center editlimit=61 show=true  Edit=none</C>
									<C> name='����������ȣ' ID='pay_manage_no'	width=90 	align=center editlimit=61 show=true  Edit=none</C>
									<C> name='����sid' 		ID='rsv_sid'		width=90 	align=center editlimit=61 show=false Edit=none</C>
								">
							</object>
										<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
1. "�� �� ���"�� ��ȸ�մϴ�.<BR>
2. [�ܾ�] ���� ������ ��ü �� �ݾ��� �Է��մϴ�.<br>
3. [��ü ���� ���]���� [������] ��ư�� ���� "�� ���� ���"�� �����մϴ�.<br>
3-1. ���� ����� ��� 2~3���� �ݺ��մϴ�.<br>
4. [ó��] ��ư�� Ŭ�� �� �ݾ��� Ȯ���մϴ�. (���� ��� �Աݾ� = ���� �Աݾ� + ��ü �� �ݾ�)<br>
5. [����] ��ư�� ������ �ݾ��� ��ü�˴ϴ�.<br>
<br>
�� �� ����� ���� ���� ���� ���� ���� ��� �� �� ���� ǥ�õ˴ϴ�.<br>
�� �� �� ����� "Ÿ�δ�ü", ���� ����� "��ü�Ա�"�̶�� ȸ�豸�� �ڵ�� ����մϴ�.
			</td>
		</tr>
	</table>
	
 <%
/*=============================================================================
                        Bind ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>
        <param name="DataId" value="ds1">
        <param name=BindInfo    value="
            <C>Col=accept_sid               Ctrl=accept_sid         Param=value </C>
            <C>Col=accept_no                Ctrl=accept_no          Param=Text </C>
            <C>Col=accept_date              Ctrl=accept_date        Param=Text </C>
            <C>Col=goods_sid              Ctrl=v_goods        Param=BindColVal </C>
            <C>Col=depart_date              Ctrl=depart_date        Param=Text </C>
        ">
</object>
<%=HDConstant.COMMENT_END%>	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

