<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : �ǹ���ȣ���
 * ���α׷�ID 	 : CU011I
 * J  S  P		 : cu011i
 * �� �� ��		 : CU011I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-07-25
 * �������		 :  �ǹ���ȣ��� (��ȸ,����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-10-22][�ɵ���] ����� �߰����� ���̺� ���� ���� �� �ݿ�
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
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";

	/* �������ε� */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}
			
	/* ����ȸ	 */
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";   
        //�븮��
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();         

        lkDS_visit_k_list.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=S&s_Head=CU025&s_item1=Y";
        lkDS_visit_k_list.Reset(); //�����������
	}
	/* ������ȸ	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {        
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sClientSid=" + sClientSid.value + ","
	            + "sWorkNo=" +sWorkNo.value + ","
	            + "sWorkNoChk=" + sWorkNoChk.checked + ","
	            + "sCustNm=" + sCustNm.value + ","
	            + "sManageNo=" + sManageNo.value +","
	            + "sDepartDate=" +sDepartDate.Text;

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu011I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * ����
	 */
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_CU%>Cu011I",
	             "JSP(I:DEFAULT=ds1)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
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

	/*
	 * ��ȣ ����
	 */
	function fnCreate() {
		//dataset�� row�� ������ ���� ����.
        if(ds1.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
		
		if (ds1.isUpdated ){// ������Ʈ(����üũ)�� ���� ������.
			v_job = "C";	
			window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
			        + "sCreateCond=" + sCreateCond.value;
			     ln_TRSetting(tr1, 
			         "<%=dirPath%><%=HDConstant.PATH_CU%>Cu011I",
			         "JSP(I:CREATE=ds1)",
			         param);
			tr_post(tr1);
		} else {
			alert("������ ����� ������ �ֽñ� �ٶ��ϴ�.");
		};
	};
	
	
	
	/*
	 * �븮���˾�
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sClientSid.value = arrParam[0];
				sClientCd.value = arrParam[2];
				sClientNm.value = arrParam[1];					
			} else {
		    	sClientSid.value = 0;
				sClientCd.value = '';
				sClientNm.value = '';
			}
	} 	
	/*
	 * �븮�� �ڵ�����(����)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {
		var exit=false;	
		if ( dataSet == 'ds_client' ) {	//�븮��
			for ( i=1; i<=ds_client.CountRow; i++ ) {
				if ( ds_client.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds_client.namevalue(i,"client_sid");
					sClientNm.value = ds_client.namevalue(i,"client_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = '';
				sClientNm.value = '';
			}			
		}
	} 	
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>



<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
    if(Row==0) {	//�������� Ŭ��������.
        if(ds1.CountRow<=1) return;
        gr1.Redraw = "False";
        

        //���� 
        if(Colid=="JOB_SEL"){
            for(var i=2; i<=ds1.CountRow; i++){
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
            }
        }
        
        //��������
        if(Colid=="VISIT_K_LIST"){
            for(var i=2; i<=ds1.CountRow; i++){
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
            }
        }
        gr1.Redraw = "True";
        return;
    }
	

</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="C") {	// ���� �Ŀ��� ���� ��ȸ
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
            fnSelect();
        }  else if(v_job == "I") {	// ���� �Ŀ��� �� �״��
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S") {	// �ʱ�ȭ�� ��ȸ �Ŀ��� ��Ī.
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
        }
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
         window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds_client event="OnLoadCompleted(row)">
	    window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
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
	<!--  �븮��  -->
	<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value=false>
	</object>

	<!-- GRID LOOKUP DS �����������  -->	
	<object id=lkDS_visit_k_list classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value=false>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->										

  <table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<%
	/*---------------------------------------------------------------------------->
	HTML Desc	: �˻� �κ� 
				: ����ڸ�, ������ڵ�
	-----------------------------------------------------------------------------*/
	%>
	<tr>
	  <td align="right" colspan="2">
		<table border="0"  cellpadding="0" cellspacing="0" width="100%">
		  <tr>
			<td align="right" height="30px">		
				<img src="<%=dirPath%>/Sales/images/n_create.gif"   style="cursor:hand" onclick="fnCreate()">
				<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
			</td>
		  </tr>	
		</table>
	  </td>											
	</tr>
	<tr height="50px">
	  <td align="left"  colspan='2' width="845px">
		<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
		  <tr> 
			<td  width="845px">
		      <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
		      	<tr bgcolor="#6f7f8d">
		          <td align=left width=70 class="text">&nbsp;�븮��</td>
		          <td align=left width=240 bgcolor="#ffffff">&nbsp;
					<input id="sClientSid" type="hidden" value="0">
					<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
					<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�븮���� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
					<input id="sClientNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" maxlength="50" onBlur="" readOnly>																						
				  </td>	
		          <td align=left class="text"  width="80">����ǹ���ȣ</td>
		          <td align=left width=250 bgcolor="#ffffff">&nbsp;																							
					<input id="sWorkNo" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;">
				  </td>
		          <td align=left class="text" width="150">�ǹ���ȣ ���� �����</td>
		          <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
					<input id="sWorkNoChk" type="checkbox" style= "position:relative;left:-0px;top:2px">		          
				  </td>
				</tr>
			  </table>
			</td>
		  </tr>
		  <tr>
			<td height=6></td>
		  </tr>
		  <tr>
			<td>
		      <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
		      	<tr bgcolor="#6f7f8d">
				  <td bgcolor="#FFFFFF" class="text" width="70">�������</td>
				  <td  bgcolor="#FFFFFF" align="center">
					<%=HDConstant.COMMENT_START%>
					<object id=sDepartDate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>			
						<param name=Alignment 	value=1>
						<param name=Format      value="YYYY-MM-DD">
                        <PARAM NAME=InputFormat value="YYYYMMDD">
                        <param name=Cursor      value="iBeam">
                        <param name=Border      value="false">
                        <param name=InheritColor      value="true">
                        <param name=ReadOnly    value="false">
                        <param name=SelectAll   value="true">
                        <param name=SelectAllOnClick    value="true">
                        <param name=SelectAllOnClickAny   value=false>
					</object>
					<%=HDConstant.COMMENT_END%>
				  </TD>
		          <td align=left class="text" width="70">����</td>
		          <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
					<input id="sCustNm" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;">
				  </td>
		          <td align=left class="text" width="80">�ֹ�/���ǹ�ȣ</td>
		          <td align=left bgcolor="#ffffff">&nbsp;																										
					<input id="sManageNo" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;">
				  </td>											                            

		          <td align=left width=70 class="text">&nbsp;��������</td>
		          <td align=left bgcolor="#ffffff">&nbsp;
		          	<select name="sCreateCond">
		          		<option value=1>�ǹ�</option>
		          		<option value=2>����</option>
		          	</select>
				  </td>	
				</tr>
			  </table>
			  			  
			</td>
		  </tr>															
		</table>	
	  </td>											
	</tr>
	<tr height="10">
	  <td colspan='2'></td>
	</tr>													
	<tr>
	  <td width="845px" colspan='2'>
		<table  border="0" cellpadding="0" cellspacing="0">
		  <tr valign="top"">
			<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
			<%
			/*---------------------------------------------------------------------------->
			HTML Desc	: �˻� ���� - 
			Object ID 	: �׸��� , gr1
			Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>							
			<%=HDConstant.COMMENT_START%>
			<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:380" border="1" >
               	<param name="DataID"		VALUE="ds1">
               	<param name="BorderStyle"   VALUE="0">
               	<param name=ColSizing       value="true">
               	<param name="editable"      value="true">
               	<param name=UsingOneClick  	value="1">
               	<param name="SortView"      value="Right">
				<param name=SuppressOption 	value=1>
				<param name=ViewSummary 	value=1>
                <Param Name="AllShowEdit"       value="True">
                <param name="ViewSummary"       value="1">
				<param name="Format" 			value="
					<FC> name='���á�'		ID='JOB_SEL' 	Width=35   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</FC>
			    	<C> name='��SID'     ID='cust_sid'    align=left editlimit=12 show=false </C>
			    	<FC> name='����'      	ID='cust_nm'	BgColor=#fefec0 width=60  align=left editlimit=30 edit=none sort=true show=true sumtext='��'</FC>
			    	<C> name='�ֹ�/���ǹ�ȣ'		ID='manage_no'		width=110	align=center editlimit=20 edit=none sort=true show=true sumtext=@cnt BgColor=#fefec0</C>
			    	<C> name='����ǹ���ȣ'		ID='work_no'		width=100	align=left		editlimit=20 sort=true	show=true </C>
			    	<C> name='������� ���⿩�Ρ�'	ID='VISIT_K_LIST'	width=140   align=CENTER	editlimit=20 show=true  editstyle=lookup  data='lkDS_visit_k_list:detail:detail_nm' bgColor={IF(VISIT_K_LIST='N','#ffcccc','#FFFFFF') }</C>
			    	<C> name='�̼�����'   ID='educ_yn_nm' BgColor=#fefec0 width=60 align=left editlimit=8 edit=none show=true</C>
			    	<C> name='��������' ID='educ_saup_nm'    BgColor=#fefec0 width=60    align=left editlimit=50 edit=none show=false</C>
			    	<C> name='������'      ID='educ_dt'   BgColor=#fefec0 width=70  align=left editlimit=8 edit=none show=false mask=XXXX-XX-XX</C>
			    	<C> name='�������'    ID='status'   BgColor=#fefec0 width=70  align=CENTER editlimit=8 edit=none show=True</C>
				">
			</object>
			<%=HDConstant.COMMENT_END%>
			</td>		
		  </tr>
		</table>
	  </td>
	</tr>
	<tr>
	  <td><BR>�� ������̸鼭 ��ȸ�� �ȵǴ� ��쿡�� <A HREF="cu010i_biz.jsp?idx=484" TARGET="_BLANK">[����ڵ��]</A> �޴��� ���� �����ڵ带 �˻� �Է� �� �������ֽñ� �ٶ��ϴ�.<br>
	  �� [��Ͻ�û��Ȳ], [Ȯ�����(�����)]���� ���̴� ���ں��� �Ϲ������� ���ƾ� �����Դϴ�.<BR>
	  �� ����ڰ� ����� ��� [������� ���⿩��]�� "����"�� �����˴ϴ�.
	  </td>
	</tr>
	
  </table>	
											
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


