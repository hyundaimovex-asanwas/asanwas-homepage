<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: �����
 * ���α׷�ID 	: CU010i
 * J  S  P		: cu010i
 * �� �� ��		: Cu010i
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-05-30
 * �������		: ����� 
 * [��  ��   ��  ��][������] ����
 * [2007-09-17][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-02-26][�ɵ���] �� ���߰�
 *						�븮�� = �˻����ǿ��� ������
 *						�ּ�1,�ּ�2,������ȭ, �ڵ��� = ���� input���� �����س��Ҵ� ���� ������ ��� ���..;
 * [2009-03-05][�ɵ���] �����ǸŴ��, ��õ��÷���� �߰�.
 * [2009-04-17][�ɵ���] plz�� �����2
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


<%
	String basePath =  request.getServerName();

    //�븮�� ����
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

    <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i2.js"></script>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
	<script language="javascript">
	    var v_job = "";
	/* �������ε� */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit(); 
		
		lc_cust.Index = 1;
		lc_country.Index = 1;
	}
	 
	/* ������ �ʱ�ȭ : �⺻ �ڵ������� ���´�	 */
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I2",
            "JSP(O:DEFAULT=ds1,O:CUSTALL=searchds1,O:NATIONALL=searchds2,O:NATION=initds1,O:AUTH=initds2,O:SEX=initds3,O:PASS=initds6)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}

	/* ��ȸ */
	function fnSelect() {
        v_job = "S";
        if(ds1.IsUpdated!=false && confirm("���� ���� �۾����� �����Ͱ� �ֽ��ϴ�. �����Ͻðڽ��ϱ�")==false){
            return;
		}
		if(sAccpt_no.value == "" &&sCustNm.value == "" && sManegeNo.value == ""){
			alert("��û����ȣ, ���� �Ǵ� �ֹ�/���ǹ�ȣ �Ѱ����� �ݵ�� �ԷµǾ� �մϴ�.")
			return;
		}
	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                  + ",sClientSid="+ sClientSid.value
                  + ",sCustGu=" + lc_cust.ValueOfIndex("detail", lc_cust.Index)
                  + ",sCountryGu=" + lc_country.ValueOfIndex("detail", lc_country.Index)
                  + ",sCustNm=" + sCustNm.value
                  + ",sAcceptNo=" + sAccpt_no.value
                  + ",sManegeNo=" + sManegeNo.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I2",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
	}


	/* �׸��� ���߰�*/
	function fnAddRow() {
		ds1.addRow();
		ds1.namevalue(ds1.rowposition,"group_cd") = sAccpt_no.value;
		ds1.namevalue(ds1.rowposition,"cust_nm") = sCustNm.value;
		ds1.namevalue(ds1.rowposition,"regi_no") = sManegeNo.value;
		ds1.namevalue(ds1.rowposition,"cust_gu") = "1";	// �⺻ ������.. 
		ds1.NameValue(ds1.rowposition,"PASS_TYPE") ="2" ;	//�⺻�� �Ϲݿ���
		
		getObjectFirst("regi_no").Focus();
        lc_pass_type.Index = 0;	//0��° �� , �Ϲݿ���(2) ���� ����. �̰� 2�� = �ڵ� 30 �������
        lc_regi_yn.Index = 0;
        
        
	}

	/* �׸��� ����� */
	function fnDeleteRow() {
		if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        		alert("������ �ڷ��Դϴ�. �����Ҽ� �����ϴ�");
        		
        		ds1.undo(ds1.rowposition);
        		return;
        	}
		ds1.DeleteRow(ds1.RowPosition);
	}

	/* �׸��� ���� ���*/
	function fnCancel() {
        ds1.undoall();
		window.status="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}

    /* ����(������Ʈ/�μ�Ʈ) �Լ�  */
    function fnApply() {    
        if (ds1.IsUpdated) {
        	if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        		alert("������ �ڷ��Դϴ�\n\n�����Ҽ�  �����ϴ�");
        		
        		ds1.undo(ds1.rowposition);
        		return;
        	}
        	
            if(fnCustInfoCheck()!=true) return;
            fnOnProgressStart();
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I2",
                "JSP(I:REGIST=ds1,O:RESULT=ds_result)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            tr_post(tr_save);
        } else {
            alert("�� ������ ���� ������ �����ϴ�.");
        }
    }
    
    
    /* ��û����ȣ     */
	function fnSelectAcceptNo() {
	
		if(sClientNm.value != "") {
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
	                  + ",sClientSid="+ sClientSid.value
	        fnOnProgressStart();
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I2",
	            "JSP(O:SEARCH_DS4=searchds4)",
	            param);
	        tr_post(tr1);
	       } else {
	       		alert("�븮���� �������ּ���!");
	       		return;
	       }
	}
	
	
	/* �븮���� ��û�� ��ȣ ����	 */
	 
	 function fnAcceptApply() {
	 	if (sAccpt_no.value == "") {
	 		alert("������ ��û�� ��ȣ�� �����ϴ�!");
	 		return;
	 	}
	 	group_cd.value = sAccpt_no.value;
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
	<script language="javascript" for="tr1" event="OnSuccess()">
	    fnOnProgressEnd();
	    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    	    
	    if(ds1.CountRow>0)
	        fnScreenDisplay(ds1.NameValue(ds1.RowPosition, "COUNTRY_GU"));
	    else
	        fnScreenDisplay("");
	
	    var info_cnt = tr1.SrvErrCount("INFO");
	    var info_msg = "";
	    for(var i=0; i<info_cnt; i++){
	        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
	    }
	    if(info_msg!="") 
	        alert("============= �ȳ� �޽���=============\n\n" + info_msg);
	        
	</script>
	
	<script language="javascript" for="tr1" event="OnFail()">
	    fnOnProgressEnd();
	    
	    var error_cnt = tr1.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert("�����κ��� ������ ���� ���� �޽����� ����߽��ϴ�.\n\n" + error_msg);
	    else
	        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	
	</script>
	
	<script language="javascript" for="tr_save" event="OnSuccess()">
	    fnOnProgressEnd();
	    
	    if(ds_result.CountRow>0){
	        for(var i=1, j=1; i<=ds1.CountRow; i++){
	            if(ds1.RowStatus(i)==1){
	                ds1.NameValue(i, "CUST_SID")=ds_result.NameValue(j, "CUST_SID");
	                j++;
	            }
	        }
	    }
	    ds1.ResetStatus();
	    
	    if(ds1.CountRow>0)
	        fnScreenDisplay(ds1.NameValue(ds1.RowPosition, "COUNTRY_GU"));
	    else
	        fnScreenDisplay("");
	
	    var info_cnt = tr_save.SrvErrCount("INFO");
	    var info_msg = "";
	    for(var i=0; i<info_cnt; i++){
	        info_msg += tr_save.SrvErrMsg("INFO", i) + "\n";
	    }
	    if(info_msg!="") 
	        alert("============= �ȳ� �޽���=============\n\n" + info_msg);
	        
	</script>
	
	<script language="javascript" for="tr_save" event="OnFail()">
	    fnOnProgressEnd();
	    
	    var error_cnt = tr_save.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
	
	</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  ��ȸ�� 
	%>
	<script language=JavaScript  for=ds1 event="OnLoadError()">
	</script>
	<script language=JavaScript  for=searchds4 event="OnLoadCompleted(row)">
		sAccpt_no.value = searchds4.namevalue(searchds4.rowposition,"ACCEPT_NO");
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
		
	    fnOnProgressEnd();
	     
	    if (ds1.countrow == 2000) {
			alert("�����ʹ� "+ ds1.countrow + "�� �̻� ��ȸ �� �� �����ϴ�!");
		}
	    if(v_job == "H") return;
	    if( row < 1){
	        alert(row + " �˻��� ����Ÿ�� �����ϴ�."); 
	    }
	</script>
	
	<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
	    fnScreenDisplay(ds1.NameValue(Row, "COUNTRY_GU"));
	</script>
	
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
	        if(row==0){
	            if(ds1.CountRow==0) return;
	            
	            if(colid=="GROUP_CD"){
	                for(var i=1; i<=ds1.CountRow; i++){
	                    ds1.NameValue(i, "GROUP_CD") = ds1.NameValue(1, "GROUP_CD");
	                }
	            } 
	            return;
	        }
	 </script>
	

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=gcds_data00 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=searchds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=searchds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=searchds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	
	<object id=searchds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��û�� ��ȣ -->
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	
	<object id=ds_zip_temp classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����ȣ -->
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	    <param name="StatusResetType" value="2">
	</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr height="50px">
		<td>
			<table  border="0" cellpadding="0" cellspacing="0"  width="845px">
				<tr>
					<td colspan='8'>
						<table  width='345px' border="0" cellspacing="0" cellpadding="0" align="right">
							<tr>
								<td align='right'>
								<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
								<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow()">
<!--								<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()">-->
								<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
								<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
							
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="10px">
					<td ></td>
				</tr>
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
							<tr>
								<td align="center" width="100px" height="30px" class="text" >�븮��</td>
								<td align="left"  bgcolor="#ffffff" >&nbsp;
		                                                   <input type="text" name='sClientNm' id='sClientNm' value='<%=c_nm%>' size='20' readonly='readonly'  class='textbox'>
		                                                   <input type="hidden" name='sClientSid' id='sClientSid' value='<%=c_sid%>'>
		                                                   <%if(v_ut.equals("")){%>
		                                                   <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
		                                                   <%}%>
								</td>
								<td align="center" width="100px" height="30px" class="text" >��û����ȣ</td>
								<td align="left"  bgcolor="#ffffff" >&nbsp;
		                                                   <input type="text" name='sAccpt_no' id='sAccpt_no' value='' size='20'   class='textbox'>
		                                                   <img src="<%=dirPath%>/Sales/images/help.gif" border="0" 		ALT="��û����ȣ��  �˻��մϴ�"  style="cursor:hand"  onclick="javascript:fnAcceptNoPopup('<%=dirPath%>');" align='absmiddle'>
		                                                   <img src="<%=dirPath%>/Sales/images/n_create.gif" border="0" 	ALT="��û����ȣ����"  		style="cursor:hand"  onclick="javascript:fnSelectAcceptNo();" align='absmiddle'>
								</td>
							</tr>
						</table>
					</td>
					
				</tr>
				<tr height="5px">
					<td></td>
				</tr>
				<tr>
					<td colspan='5'>
						<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" width='845px'>
							<tr>
								<td align="center" width="100px" height="30px" class="text">������</td>
								<td align="center" bgcolor="#ffffff">
									<%=HDConstant.COMMENT_START%>
									<object id=lc_cust classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=searchds1>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
							
								<td align="center" width="100px"  class="text">��������</td>
								<td align="center" bgcolor="#ffffff">
									<%=HDConstant.COMMENT_START%>
                                       	<object id=lc_country classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=searchds2>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
								<td align="center" width="100px" class="text">����</td>
								<td align="center" bgcolor="#ffffff"><input type="text" name="sCustNm" value="" size="15" maxlength="10" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"></td>
							
								<td align="center" width="100px" class="text">�ֹ�/���ǹ�ȣ</td>
								<td align="center" bgcolor="#ffffff"><input type="text" name="sManegeNo" value="" size="15" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" value="7512011042715"></td>
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
	
	<tr>
	  <td width="845" colspan="6">
		<table border="0" cellpadding="1" cellspacing="0" width="100%" >
		  <tr>
			<td  valign="top">
			  <table border="0" cellpadding="0" cellspacing="1" width="400px" >
				<tr>
				  <td>
					<%=HDConstant.COMMENT_START%>
					<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=400px; height:442px" border="1">
				    <param name="DataID"           value="ds1">
				    <param name="BorderStyle"      value="0">
				    <!-- param name="Fillarea"     value="true"-->
				    <param name="ColSizing"        value="true">
				    <param name="editable"         value="false">
				    <param name="viewsummary"      value="1">
				    <param name=SortView  value="Right">
                    <param name="Format"            value=" 
                        <FC>name='�ѱۼ���'       ID='CUST_NM'      Width=80  align=Left sort=true sumtext='��'</FC>
                        <C> name='�ֹ�/���ǹ�ȣ'    ID='MANAGE_NO'  Width=120 align=Left sort=true sumtext=@cnt</C>
                        <C> name='��û����ȣ'    ID='GROUP_CD'      Width=110 align=Left show=true</C>
				        <C> name='����'      	ID='REGI_YN_NAME'   Width=60  align=center show=false </C>
				        <C> name='��'      	ID='CUST_GU_NAME'   Width=50  align=center show=false</C>
				        <C> name='����'         ID='COUNTRY_CD' 	Width=50  align=center show=false</C>
				        <C> name='����'       	ID='NATION_CD_NAME' Width=40  align=center show=false</C>
				        <C> name='����'       	ID='nation_cd'     	Width=40  align=center show=false</C>
				        <C> name='����'  		ID='SEX_GU_NAME'    Width=40  align=center show=true</C>
						<C> name='����'    	ID='MOBILE_NO'  	Width=100 align=Left show=true</C>
				        <C> name='�븮����'    	ID='CLIENT_NM'  	Width=100 align=Left show=false</C>
				    ">
					</object>
					<%=HDConstant.COMMENT_END%>										
				  </td>
				</tr>
			  </table>
			</td>
			<td width="15px"></td>
			<td valign="top" ALIGN=RIGHT>
			  <table border="0" cellpadding="0" cellspacing="0" bgcolor="#666666">
				<tr>
				  <td valign="top" >
					<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
					  <tr bgcolor="#ffffff">
						<td width='130px' height='25px' class='boardt02'>��������</td>
						<td width='290px' align=absmiddle>&nbsp;&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=lc_country_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=initds1>
							<param name=BindColumn      value="detail">
							<param name=BindColVal      value="detail">
							<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>	
                              <script language=JavaScript for=lc_country_gu event=OnSelChange()>
                                  if (lc_country_gu.Text != "") {
                                      ds1.NameValue(ds1.RowPosition, "country_gu_name") = lc_country_gu.Text;
                                      
                                      fnScreenDisplay(lc_country_gu.ValueOfIndex("detail", lc_country_gu.Index));
                                  }
                              </script>
						</td>
					  </tr>
					  <tr height='22px'>
			    		<td class='boardt02'>�ѱۼ���</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp; <input type=text name=txt_cust_nm id=txt_cust_nm size=30 class="textbox" OnKeyUp="cfLengthCheck(this, 30);"></td>
					  </tr>		
					  <tr id=inner_person style="display:inline" height='22px'>
						<td class='boardt02'>�ֹι�ȣ</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
							<%=HDConstant.COMMENT_START%>
                            <object id=regi_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
	                          <param name=Format      value="000000-0000000">
	                          <param name=Alignment   value=1>
	                          <param name=ClipMode    value=true>
	                          <param name=Border      value=false>
	                          <param name=MaxLength   value="13">
	                          <param name=SelectAll   value=true>
	                          <param name=SelectAllOnClick      value=true>
	                          <param name=SelectAllOnClickAny   value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>
                              <script language=javascript for=regi_no event="OnKillFocus()">
                                  if(getObjectFirst("regi_no").Text!="" && fnJuminNoCheck(getObjectFirst("regi_no").Text)!=true) {
                                      getObjectFirst("birthday").Text = "";
                                      getObjectFirst("regi_no").Text = "";
                                      getObjectFirst("regi_no").Focus();
                                      return;
                                  }
                                     
                                  if(getObjectFirst("regi_no").Text.length==13){
                                      var v_sex_gubn = getObjectFirst("regi_no").Text.substr(6, 1);
                                      if(v_sex_gubn=="1" || v_sex_gubn=="2")
                                          getObjectFirst("birthday").Text = "19" + getObjectFirst("regi_no").Text.substr(0, 6);
                                      else 
                                         getObjectFirst("birthday").Text = "20" + getObjectFirst("regi_no").Text.substr(0, 6);
                                      
                                      if(v_sex_gubn=="1" || v_sex_gubn=="3") ds1.NameValue(ds1.RowPosition, "SEX") = "M";
                                      else ds1.NameValue(ds1.RowPosition, "SEX") = "F";
                                  }
                              </script>
							&nbsp;&nbsp;
						</td>
					  </tr>	
					  <tr id=inner_person style="display:inline" height='22px'>
						<td class='boardt02'>���Ϻ� ��������</td>
						<td bgcolor='#ffffff' >&nbsp;&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=lc_regi_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=initds2>
		                    <param name=BindColumn      value="detail">
		                    <param name=BindColVal      value="detail">
							<param name=ListExprFormat  value="detail_nm^0^100">
							<param name=ReadOnly 		value="true">
							</object>
							<%=HDConstant.COMMENT_END%>
		                    <script language=JavaScript for=lc_regi_yn event=OnSelChange()>
	                          if (lc_regi_yn.Text != "")
	                              ds1.NameValue(ds1.RowPosition, "regi_yn_name") = lc_regi_yn.Text;
		                    </script>
						</td>																								
					  </tr>
                      <tr id=outer_person style="display:none" height='22px'>
						<td class='boardt02'>���ǹ�ȣ</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
							<%=HDConstant.COMMENT_START%>
                            <object id=pass_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                              <param name=Format      value="###############">
                              <param name=Alignment   value=1>
                              <param name=ClipMode    value=true>
                              <param name=UpperFlag   value=1>
                              <param name=Border      value=false>
                              <param name=MaxLength   value="15">
                              <param name=SelectAll   value=true>
                              <param name=SelectAllOnClick      value=true>
                              <param name=SelectAllOnClickAny   value=false>
	                        </object>
	                        <%=HDConstant.COMMENT_END%>
						</td>
					  </tr>
					  <tr id=outer_person style="display:none" height='22px'>
						<td class='boardt02'>��������</td>
						<td bgcolor='#ffffff'>
	                        <table border=0 cellspacing=0 cellpadding=0>
	                          <tr>
	                            <td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
	                              <%=HDConstant.COMMENT_START%>
	                              <object id=lc_pass_type classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
	                                  <param name=ComboDataID     value=initds6>
	                                  <param name=BindColumn      value="detail">
	                                  <param name=BindColVal      value="detail">
	                                  <param name=ListExprFormat  value="detail_nm^0^150">
	                              </object>
	                              <%=HDConstant.COMMENT_END%>
	                            </td>       
	                            <td bgcolor='#ffffff' height='22px' class='boardt02'>���Ǹ�����</td>
	                            <td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
	                              <%=HDConstant.COMMENT_START%>
	                              <object id=pass_expire_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>            
	                                  <param name=Format      value="YYYY-MM-DD">
	                                  <PARAM NAME=InputFormat value="YYYYMMDD">
	                                  <param name=Alignment   value=1>
	                                  <param name=ClipMode    value=true>
	                                  <param name=Border      value=false>
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
                      <tr>
						<td height='22px'  class='boardt02'>�������</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
							<%=HDConstant.COMMENT_START%>
                              <object id=birthday classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>            
                                  <param name=Format      value="YYYY-MM-DD">
                                  <PARAM NAME=InputFormat value="YYYYMMDD">
                                  <param name=Alignment   value=1>
                                  <param name=ClipMode    value=true>
                                  <param name=Border      value=false>
                                  <param name=SelectAll   value=true>
                                  <param name=SelectAllOnClick      value=true>
                                  <param name=SelectAllOnClickAny   value=false>
                              </object>
                              <%=HDConstant.COMMENT_END%> 
						</td>																		
					  </tr>
                      <tr>
                      	<td class='boardt02'>��û����ȣ</td>
                        <td bgcolor='#ffffff'>&nbsp;&nbsp;
                            <input type="text" name='group_cd' id='group_cd' value='' class='textbox' size='15'>
                            <img src="<%=dirPath%>/Sales/images/apply.gif" border="0" ALT="��û����ȣ�� �����մϴ�"  style="cursor:hand"  onclick="javascript:fnAcceptApply();" align='absmiddle'>
                        </td>
                      </tr>
                    </table>
                  </td>
              	</tr>
				<tr height="2px"  bgcolor="#ffffff">
					<td bgcolor="#ffffff"></td>
				</tr>
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="1">
							<tr>
								<td width='130px' class='boardt02'>����</td>
								<td width='290px'bgcolor='#ffffff'>&nbsp;&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=lc_sex classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=initds3>
                                        <param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
									<%=HDConstant.COMMENT_END%>
	                                  <script language=JavaScript for=lc_sex event=OnSelChange()>
	                                      if (lc_sex.Text != "")
	                                          ds1.NameValue(ds1.RowPosition, "sex_gu_name") = lc_sex.Text;
	                                  </script>
								</td>		
							</tr>
							<tr>
								<td class='boardt02'>�ڵ���</td>
								<td bgcolor='#ffffff'>&nbsp;&nbsp;
									<%=HDConstant.COMMENT_START%>
                                      <object id=mobile_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                          <param name=Format      value="99999999999999999999">
                                          <param name=Alignment   value=1>
                                          <param name=ClipMode    value=true>
                                          <param name=Border      value=false>
                                          <param name=SelectAll   value=true>
                                          <param name=SelectAllOnClick      value=true>
                                          <param name=SelectAllOnClickAny   value=false>
                                          <param name=UpperFlag   value=1>
                                      </object>
                                    <%=HDConstant.COMMENT_END%>
								</td>
							</tr>																																																						
							<tr>
							 	<td class='boardt02'>�븮��</td>
								<td bgcolor='#ffffff' >&nbsp;&nbsp;
                                  <input type="text" name='client_nm' id='client_nm' value='' size='11' readonly='readonly'  class='textbox'>
                                  <input type="hidden" name='client_sid' id='client_sid' value=''>
                                  <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:hand" id="client_btn" onclick="javascript:fnClientPopup('<%=dirPath%>');" align='absmiddle'></td>
							</tr>
						</table>
					</td>
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
	                <C>Col=country_gu       Ctrl=lc_country_gu      Param=BindColVal </C>
	                <C>Col=CUST_NM          Ctrl=txt_cust_nm        Param=Value</C>
	                <C>Col=regi_no          Ctrl=regi_no            Param=Text</C>
	                <C>Col=pass_no          Ctrl=pass_no            Param=Text</C>
	                <C>Col=pass_expire_date Ctrl=pass_expire_date   Param=Text</C>
	                <C>Col=regi_yn_t        Ctrl=lc_regi_yn	 	    Param=BindColVal </C>
	                <C>Col=birthday         Ctrl=birthday            Param=Text</C>
	                <C>Col=group_cd         Ctrl=group_cd           Param=Value</C>
	                <C>Col=sex              Ctrl=lc_sex             Param=BindColVal</C>
	                <C>Col=mobile_no        Ctrl=mobile_no          Param=Text</C>
	                <C>Col=client_sid       Ctrl=client_sid       Param=Value</C>
	                <C>Col=client_nm		Ctrl=client_nm			Param=Value</C>

	              ">
	      </object>
	<%=HDConstant.COMMENT_END%>      

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

