<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������� ��������(��ȸ)
 * ���α׷�ID 	: AC071I
 * J  S  P		: ac071I
 * �� �� ��		: Ac071I
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-12-13
 * [��  ��   ��  ��][������] ����
 * [2007-12-10][�ɵ���] KCP�� ������� [�������>���Ը�������] ���� �Ϻ� ���������� �׼��� �ٿ�ε� > ���ε��Ͽ� ���� ����

 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

	//��¥ ����.
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
   String firsttime = m_today.format(date.getTime()).substring(8,12);
	 
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
		//��ü���� �� : ��ȸ�����ϱ� ���ؼ�
		
	        var v_job = "I";		
	        
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn1");
			cfStyleGrid(getObjectFirst("gr2"), "comn1");
			cfStyleGrid(getObjectFirst("gr1_1"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");

									
			fnInit(); 

		}		

		/*
		 * �ʱ��۾�
		 */
		function fnInit(){
			sBgnDate.text='<%=firstday%>';
			sEndDate.text='<%=firstday%>';
		    	   
			//2007-12-11 ����Ʈ�ڵ�  by �ɵ��� 
			sSiteCode.Index=0;
			
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_SAUP_DS_ALL=codeDs1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);            
		}

	
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			 v_job = "S";
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
		            + ",sBgnDate=" + sBgnDate.text
		            + ",sEndDate=" + sEndDate.text
		            + ",sTr_Order_Nm=" + sTr_Order_Nm.value
                    + ",sSiteCode=" + sSiteCode.ValueOfIndex("siteCode", sSiteCode.Index)
                    + ",sSAUP_SID=" + lc1.ValueOfIndex("saup_sid", lc1.Index);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac071I", 
	            "JSP(O:MAIN_DS1=acctDs1,O:MAIN_DS2=acctDs2,O:MAIN_DS3=acctDs3)",//
	            v_param);
	        tr_post(tr1);
		}
		
	
	
		
		/*
		 * ����
		 */
		function fnExcelDs1() {
	        if(acctDs1.CountRow==0){
    	        alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
        	    return;
        	};

			gr3.runexcelsheet("����Ȯ��2");
			gr1_1.runexcelsheet("����Ȯ��1");
			gr2.runexcelsheet("Join��Ȳ");	
			gr1.runexcelsheet("������Ȳ");	

			/*        	   
	        getObjectFirst("gr3").SetExcelTitle(0, "");
	        getObjectFirst("gr3").SetExcelTitle(1, "value:������� ����Ȯ��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr3").GridToExcel("����Ȯ��2","������� �ŷ�����.xls", 24);
	        
	        getObjectFirst("gr1_1").SetExcelTitle(0, "");
	        getObjectFirst("gr1_1").SetExcelTitle(1, "value:������� ����Ȯ��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1_1").GridToExcel("����Ȯ��1","������� �ŷ�����.xls", 24);
	        
	        getObjectFirst("gr2").SetExcelTitle(0, "");
	        getObjectFirst("gr2").SetExcelTitle(1, "value:������� Join��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr2").GridToExcel("Join��Ȳ","������� �ŷ�����.xls", 24);
	
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:������� ������Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("������Ȳ","������� �ŷ�����.xls", 24);*/
		}
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>


	<script language=JavaScript  for=acctDs1 event="OnLoadCompleted(row)">
		if(acctDs1.countrow <= 0) {
			return;
		}
				
/*        if(v_job=="I"){ 	// �Է��� ��.
			for(i = 1; i <= acctDs1.countrow; i++){
				acctDs1.namevalue(i, "TR_SID") = 0;
			}			*/
		};
	</script>

	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';
        if(v_job=="I"){ 	// �Է��� ��.
	        window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            //�޽��� ó��
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);
	          	
        }  else if(v_job == "H" || v_job=="S") {	// ��ȸ�� ��.
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
	</script>
		

	<script language=JavaScript for=tr2 event=OnFail()>
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
	
	<script language=JavaScript for=tr1 event=OnFail()>
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

	<script language="javascript" for="gcip_file" event=OnClick()>
		    if (fn_trim(gcip_file.value)!="") {
//		    	alert(gcip_file.value);
		    	file_path.value = gcip_file.value;
		    }
	</script>
	
	<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
	    if(ds_result.CountRow>0){
	        var v_result_msg = "";
	        for(var i=1; i<=ds_result.CountRow; i++){
	            if(ds_result.NameValue(i, "MSG_CD")!="0000")
	                v_result_msg += ds_result.NameValue(i, "MSG")+"\n";
	        }
	
	        if(v_result_msg!="")
	            alert(v_result_msg);
	    }
	</script>
	
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
	   if( sBgnDate.Modified == true )
			sEndDate.text = sBgnDate.text;
	</script>		
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object id=acctDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=acctDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=acctDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=tempExcelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=excelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	
									
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td><img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand" align=absmiddle onClick="fnExcelDs1();">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<tr height="35px">
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
					<tr>
                        <td align="center" width="90px" height="30px" class="text">���±���</td>
						<td align="left" bgcolor="#ffffff" width=300>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sSiteCode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=170 border="0" align=absmiddle>
								<param name=CBData			value="W6677^�������,W8253^������">
								<param name=CBDataColumns	value="siteCode,siteNm">
								<param name=SearchColumn	value=siteNm>
								<param name=Sort			value=True>
								<param name=ListExprFormat	value="siteNm^1^70,siteCode^1^70">								
								<param name=BindColumn		value="siteCode">								
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>
                        <td class="text" width="90px">����</td>
                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                <param name=ComboDataID     value=codeDs1>
                                <param name=ListExprFormat  value="saup_nm^1^80,saup_sid^1^40">
								<param name=SearchColumn	value="saup_nm">
								<param name=BindColumn		value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                            &nbsp;(Join��Ȳ���� ����˴ϴ�.)
                        </td>					

					</tr>
				</table>
			</td>
		</tr>
		<tr height="35px">
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
					<tr>
						<td align=left width=90 class="text">��������</td>
						<td align=left bgcolor="#ffffff" width=300>&nbsp;
						     <%=HDConstant.COMMENT_START%>
						     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="0">
								<param name=InheritColor      value="true">
								<param name=ReadOnly  	value="false">
								<param name=SelectAll   value="true">
								<param name=SelectAllOnClick   value="true">
								<param name=SelectAllOnClickAny  	value="false">
							</object>
							<%=HDConstant.COMMENT_END%>&nbsp;-
						     <%=HDConstant.COMMENT_START%>
						     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="0">
								<param name=InheritColor      value="true">
								<param name=ReadOnly  	value="false">
								<param name=SelectAll   value="true">
								<param name=SelectAllOnClick   value="true">
								<param name=SelectAllOnClickAny  	value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align="center" width="90px" height="30px" class="text">�ֹ��ڸ�</td>       
						<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_Order_Nm id=sTr_Order_Nm  onkeydown="if(event.keyCode==13) fnSelect();"></td>
						
					</tr>
				</table>
			</td>
		</tr>
		<tr height=10><td></td></tr>
		<tr height=420>
			<td>
				<table border="0" cellpadding="0" cellspacing="0" width="845px">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:190; width:845; height:20">
								<param name="BackColor"			value="#00ffff">
								<param name="DisableBackColor"	value="#ffffee">
								<param name="Format"			value='
									<T>divid="mxTab_page1"	title="������Ȳ"</T>
									<T>divid="mxTab_page2"	title="Join��Ȳ"</T>
									<T>divid="mxTab_page3"	title="����Ȯ��"</T>									
									'>
							</object>
							<%=HDConstant.COMMENT_END%>	

							<div class=page id="mxTab_page1" style="position:absolute; left:170; top:210; width:845; height:400">
							<%=HDConstant.COMMENT_START%>
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="845px" height="400px" border="1">
							        <param name="DataID"            value="acctDs1">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
									<param name=VIEWSUMMARY 		value=1>	
							        <param name="Format"            value="
											<C> name='No'			ID='TR_DAY_NO' Width=30 Align=right Show=true decao=0 SUMTEXT=��</C>
											<C> name='����������ȣ'	ID='TR_PAY_MANAGE_NO' Width=80 Align=center Show=true SUMTEXT=@CNT</C>
											<C> name='�ֹ��ڸ�'		ID='TR_ORDER_NM' Width=100 Align=left Show=true	SUMTEXT=��</C>
											<C> name='�ŷ�����'		ID='TR_BANK_NM' Width=70 Align=center Show=true	</C>
											<C> name='�ŷ��ݾ�'		ID='TR_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='���Ա�'		ID='TR_PAY_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='������'			ID='TR_EXTRA' Width=60 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='�ΰ���'			ID='TR_VAT' Width=50 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='������+\\�ΰ���'	ID='TR_EXTVAT' Width=50 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='�Աݾ�'			ID='TR_SALE_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='��������'		ID='TR_PAY_DATE' Width=70 Align=center Show=true	</C>
											<C> name='��������'		ID='TR_SETTLE_DATE' Width=70 Align=center Show=true	</C>
							                <C> name='TR_SID'    	ID='TR_SID' Width=100  align=left  show=FALSE</C>
							        ">
							</object>
							<%=HDConstant.COMMENT_END%>
							</div>		

							<div class=page id="mxTab_page2" style="position:absolute; left:170; top:210; width:845; height:400">
							<%=HDConstant.COMMENT_START%>
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2 width="845px" height="400px" border="1">
							        <param name="DataID"            value="acctDs2">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name="indwidth"			value="20">
									<param name=VIEWSUMMARY 		value=1>	
							        <param name="Format"            value="
											<C> name='No'			ID='TR_DAY_NO2' Width=30 Align=right Show=true decao=0 SUMTEXT=��</C>
											<C> name='����������ȣ'	ID='TR_PAY_MANAGE_NO' Width=80 Align=center Show=true SUMTEXT=@CNT</C>
											<C> name='�ֹ��ڸ�'		ID='TR_ORDER_NM' Width=100 Align=left Show=true	SUMTEXT=��</C>
											<C> name='�ŷ�����'		ID='TR_BANK_NM' Width=70 Align=center Show=true	</C>
											<C> name='�ŷ��ݾ�'		ID='TR_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='���Ա�'		ID='TR_PAY_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='������'			ID='TR_EXTRA' Width=60 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='�ΰ���'			ID='TR_VAT' Width=50 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='������+\\�ΰ���'	ID='TR_EXTVAT' Width=50 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='�Աݾ�'			ID='TR_SALE_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
											<C> name='��������'		ID='TR_PAY_DATE' Width=70 Align=center Show=true	</C>
											<C> name='��������'		ID='TR_SETTLE_DATE' Width=70 Align=center Show=true	</C>
							                <C> name='TR_SID'    	ID='TR_SID' Width=100  align=left  show=false</C>
											<C> name='����'			ID='TR_SAUP_SID' Width=60 Align=center editstyle=lookup data='codeDs1:saup_sid:saup_nm' Show=true </C>
											<C> name='��ǰ'			ID='TR_GOODS_NM' Width=80 Align=center Show=true	</C>
							        ">
							</object>
							<%=HDConstant.COMMENT_END%>
							</div>

							<div class=page id="mxTab_page3" style="position:absolute; left:170; top:210; width:845; height:400">
							<table width=845 height=400 border="0" cellpadding="0" cellspacing="0">
							  <tr>
							  	<td>
								<%=HDConstant.COMMENT_START%>
								<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1_1 width="370px" height="400px" border="1">
								        <param name="DataID"            value="acctDs1">
								        <param name="BorderStyle"       value="0">
								        <param name="ColSizing"         value="true">
								       	<param name="IndWidth"  		value="20">
								        <param name="editable"          value="false">
								        <param name=SortView  			value="Left">
								        <param name="indwidth"			value="20">
										<param name=VIEWSUMMARY 		value=1>	
								        <param name="Format"            value="
								        	<G> name='KCP �ŷ�����'
												<C> name='����������ȣ'	ID='TR_PAY_MANAGE_NO' Width=80 Align=center Show=true SUMTEXT=@CNT</C>
												<C> name='�ֹ��ڸ�'		ID='TR_ORDER_NM' Width=100 Align=left Show=true	SUMTEXT=��</C>
												<C> name='���Ա�'		ID='TR_PAY_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
												<C> name='��������'		ID='TR_PAY_DATE' Width=70 Align=center Show=true	</C>
								                <C> name='TR_SID'    	ID='TR_SID' Width=100  align=left  show=FALSE</C>
											</G>
								        ">
								</object>
								<%=HDConstant.COMMENT_END%>
								</td>
								<td></td>
								<td>
								<%=HDConstant.COMMENT_START%>
								<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr3 width="370px" height="400px" border="1">
								        <param name="DataID"            value="acctDs3">
								        <param name="BorderStyle"       value="0">
								        <param name="ColSizing"         value="true">
								       	<param name="IndWidth"  		value="20">
								        <param name="editable"          value="false">
								        <param name=SortView  			value="Left">
								        <param name="indwidth"			value="20">
										<param name=VIEWSUMMARY 		value=1>	
								        <param name="Format"            value="
								        	<G> name='ERP ��������'
												<C> name='����������ȣ'	ID='PAY_MANAGE_NO' Width=80 Align=center Show=true SUMTEXT=@CNT</C>
												<C> name='�ֹ��ڸ�'		ID='ORDER_NM' Width=100 Align=left Show=true	SUMTEXT=��</C>
												<C> name='���Ա�'		ID='PAY_AMT' Width=80 Align=right Show=true	decao=0 SUMTEXT=@SUM</C>
												<C> name='��������'		ID='PAY_DATE' Width=70 Align=center Show=true	</C>
												<C> name='�Աݿ���'		ID='PAY_YN' Width=70 Align=center Show=FALSE BgColor={IF(PAY_YN='Y','#fefec0','' )}</C>
								                <C> name='VIRTUAL_SID'  ID='VIRTUAL_SID' Width=100  align=left  show=FALSE</C>
											</G>
								        ">
								</object>
								<%=HDConstant.COMMENT_END%>
								
								</td>
							  </tr>
							</table>
							</div>												
						</td>
					</tr>				
				</table>
			</td>
		</tr>
		<tr>
			<td><br>�� ������Ȳ : KCP���� ���� ������ ������ Tab�Դϴ�.<br>
			�� Join��Ȳ : KCP�� ERP�� �ŷ������� Join�Ͽ� ���������� �߰��� ǥ���� Tab�Դϴ�.<br>
			�� ����Ȯ�� : KCP�� ERP�� �ŷ������� ���� ��ȸ�Ͽ� ���� �� �ִ� Tab�Դϴ�.<br>
			��KCP�� = ERP�� : ������ ��Ȳ  <br>
			��KCP�� > ERP�� : �Աݳ����� ������ �ý��ۿ� �Ա��� ������ ���� ����. �Ա�ǥ�� �޾� ���� �����մϴ�.(��κ��� ���) <br>
			��KCP�� < ERP�� : �Աݳ����� ���µ� �ý��ۿ� ���� �ִ� �ſ� �������� ����. �ݵ�� Ȯ���ؾ� �մϴ�.
			
			</td>
		</tr>
	</table>
	<%=HDConstant.COMMENT_START%>	
	<object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="tempExcelDs">
             <param name=BindInfo    value="
                <C>Col=EXCEL_INFO     Ctrl=gcip_file          Param=value</C>
                <C>Col=EXCEL_URL      Ctrl=gcip_file          Param=value</C>
              ">
    </object>		
   	<%=HDConstant.COMMENT_END%>				

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

