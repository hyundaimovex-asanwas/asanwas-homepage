<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: �������
 * ���α׷�ID 	: CQ020S
 * J  S  P		: cq020s
 * �� �� ��		: Cq020S
 * �� �� ��		: ������
 * �� �� ��		: 2006-06-22
 * �������		: ������� ��ȸ,����
 * ��������		: �˻����Ǻ���
 * �� �� ��		: �ɵ���
 * ������������ 	: 2006-10-23
 * TODO			: �׸��忡 ���°� �߰�
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-12-04][�ɵ���] ���� ������� �׼� ��� �κ� �߰�..��_��;; 
 * [2008-09-04][�ɵ���] ���� ������� �׼� ��� �̳� ����
 * [2008-11-05][�ɵ���] ���� ������� �׼� ��� : ������� ���� �������� 42�� ������ ����. �޿�..
 *						ASP���� ���� ������ ������ ǥ�ô� �ǳ� �̹����� ��ü�� �������� ����..
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
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
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
        var v_job = "H";
        var div='';

		get_cookdata();
	/*
	 * Description 	:  ������ �ε� 
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		txt_depart_date.text='<%=firstday%>';
		fnInit();
	}

	/*
	 * Description : �ʱ�ȭ
	 * �������� ���´�
	 */
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //�����ڵ�
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS5=ds5)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
        //�������
          ds8.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=CU001&s_item1=Y";
          ds8.Reset();

		drp_cust.style.display="none";
		bizChk.style.display="none";          
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	: 
%>
	function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {        
			if ( txt_depart_date.text.trim() == '' ) {
				alert("������ڸ� �Է����ּ���.");
				return;
			}			
	        v_job = "S";
	      
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
			       	+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
					+ "sDepartDate=" + txt_depart_date.text + ","
					+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
					+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
					+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
					+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
					+ "sPageNo=" + txt_page_no.value + ","
					+ "sCustGu=" + drp_cust.ValueOfIndex("detail",drp_cust.Index);
					
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq020S",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
	}

	/*
	 * ���ð�, ��ǰ��ȸ
	 */		
	function fnSelectDs3() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + txt_depart_date.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
            param);
        tr_post(tr2);
	}	
	/*
	 * ����ȸ
	 */		
	function fnSelectDs6() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + txt_depart_date.text + ","	            
			+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
			 + "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time", drp_depart_time.Index);
            			
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS6=ds6)",
            param);
        tr_post(tr3);
	}	  

	/*
	 * �� ��ȸ
	 */		
	function fnSelectDs7() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
          + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
            + "sDepartDate=" + txt_depart_date.text + ","	
           + "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time", drp_depart_time.Index) + "," 
            + "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","     
            + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS7=ds7)",
            param);
        tr_post(tr4);
	}		

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	: 
%>
	function fnAddRow() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����� (�׸��庰)
// Parameter 	: 
%>
	function fnDeleteRow() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
	function fnApply() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
%>
	function fnCancel() {

	}		
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �μ�(�ݰ��길)
%>
	function fnPrint() {
		if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==1){//�ݰ����̸�
	        v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2,"
				+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
				+ "sDepartDate=" + txt_depart_date.text + ","
				+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
				+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
				+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
				+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
				+ "sPageNo=" + txt_page_no.value;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq020S",
	            "JSP(O:DEFAULT=ds9)",
	            param);
			 fnOnProgressStart();
	        tr_post(tr1);
		}else if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==2){//�����̸�
			alert("���� ��������� �μ���� �ʽ��ϴ�.");		
			return;
		}
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description : ���Ϻ��� (������)
%>
	function fnCopy() {
		if(ds1.RowCount==0){
			alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
			return;
		}

		if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==1){//�ݰ����̸�
			alert("���� ��ǰ�� ���� �����մϴ�.");
		}else if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==2){//�����̸�
		  //���� ��� �ٲ�鼭 42�� ���� asp�� ����
	      var param = "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + "&"
					+ "sDepartDate=" + txt_depart_date.text + "&"
					+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + "&"
					+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + "&"
					+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + "&"
					+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + "&"
					+ "sPageNo=" + txt_page_no.value + "&"
					+ "sCustGu=" + drp_cust.ValueOfIndex("detail",drp_cust.Index) + "&"
					+ "sBizChk=" + bizChk.checked	//true||false
					+ "&UID=" + GetCookie("vusrid");	
		
		  var url = "http://203.242.32.42/pic_copy.asp?"
					+ param;
	
//			windows.open window.location= url;	//�̷��� �ϸ� xml�� �ؼ� �׼��� ���� �� �ֽ��ϴ�.~

		  sw = screen.width;  // to center: use desired width
		  sh = screen.height;  // to center: use desired height
		  cx = (sw-300) * 0.5  // to center: (.5*sw) - (w*.5)
		  cy = (sh-80) * 0.5  // to center: (.5*sh) - (h*.5)
		  window.open(url,"fotoCopy","width=300,height=80,top="+cy+",left="+cx+",titlebar=0");
		}
	}


<%
///////////////////////////////////////////////////////////////////////////////
// Description : ����(�ݰ���=�׸��� �ٿ�, ����=������� ���� �ۼ�)
%>
	function fnExcel() {
		if(ds1.RowCount==0){
			alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
			return;
		}

		if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==1){//�ݰ����̸�
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:�������; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("�������", "�������.xls", 8);
		}else if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==2){//�����̸�
		  //���� ��� �ٲ�鼭 42�� ���� asp�� ����
/*	      var param = "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + "&"
					+ "sDepartDate=" + txt_depart_date.text + "&"
					+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + "&"
					+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + "&"
					+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + "&"
					+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + "&"
					+ "sPageNo=" + txt_page_no.value + "&"
					+ "sCustGu=" + drp_cust.ValueOfIndex("detail",drp_cust.Index) + "&"
					+ "sBizChk=" + bizChk.checked	//true||false
					+ "&i=1";	
		
		  var url = "http://203.242.32.42/ks_pic_list.asp?"
					+ param;
			window.location= url;	//�̷��� �ϸ� xml�� �ؼ� �׼��� ���� �� �ֽ��ϴ�.~*/
		
	      var param = "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + "&"
					+ "sDepartDate=" + txt_depart_date.text + "&"
					+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + "&"
					+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + "&"
					+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + "&"
					+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + "&"
					+ "sPageNo=" + txt_page_no.value + "&"
					+ "sCustGu=" + drp_cust.ValueOfIndex("detail",drp_cust.Index) + "&"
					+ "sBizChk=" + bizChk.checked;	//true||false			
	        var stat = "resizable=yes,scrollbars=yes,status=no,toolbar=no,personalbar=yes,menubar=no,locationbar=yes,top=10,left=172,width=720,height=700";
	        var url =  "cq021s.jsp?"+param;	        
			window.open(url,'PSN', stat );
		}
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �з��� �˾� (������)
%>
	function fnPopup() {
		
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �Է°� üũ 
%>
	function fnCheck() {
	
	}	
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ȭ�ϸ� üũ
%>
	function fnDivide(str, delim){

	}

<%
//////////////////////////////////////////////////////////////////////////////
//	Description : Dataset Head ����
%>
	function fnSetDataHeader() {

	}


	//�������ý� �߰� �˻����� ���̱�
	function fnShow(){
		if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==1){
			drp_cust.style.display="none";
			bizChk.style.display="none";          
		}else if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==2){
			drp_cust.style.display="";
			bizChk.style.display="";          
		}
	}
	</script>
	
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=txt_depart_date event=OnKillFocus()>
		if ( div != 'init' ) {	//�������
			if ( txt_depart_date.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
		}				
	</script>

	<script language=JavaScript for=drp_saup_sid event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';			
			fnSelectDs3();
			fnShow();		//�����߰� �˻����� ���̱�.
		}
	</script>	
	<script language=JavaScript for=drp_goods_sid event=OnSelChange()>
		if ( div != 'init' ) {	//��ǰ 
			div = 'init';
			fnSelectDs6();		
		}
	</script>	
	<script language=JavaScript for=drp_depart_time event=OnSelChange()>
		//if ( div != 'init' ) {	//���ð�
		//	div = 'init';
		//	fnSelectDs6();		
	//	}
	</script>	

	<script language=JavaScript for=drp_class event=OnSelChange()>
		if ( div != 'init' ) {	//��
			div = 'init';					
			fnSelectDs7();		
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
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onsuccess()">
		div='';
        document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        document.all.LowerFrame.style.visibility="hidden";	                	
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>		
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	fnSelectDs3();
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	//fnSelectDs6();
</script>
<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)"> 
	fnSelectDs6();
</script>

<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
	fnSelectDs7();
</script>

<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
	div='';
</script>

<script language=JavaScript  for=ds9 event="OnLoadCompleted(row)">
	//ds9.namevalue(ds9.rowposition,"depart_date")=txt_depart_date.text;
	//ds9.namevalue(ds9.rowposition,"arrive_date")=txt_arrive_date.value;
	pr1.preview();
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ--%>

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
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
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


<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="840px"  cellpadding="0" cellspacing="0">
				<tr>
					<td align="right" colspan="2">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:pointer" align=absmiddle onclick="fnPrint()">
									<img src="<%=dirPath%>/Sales/images/download_no.gif"	style="cursor:pointer" align=absmiddle onClick="fnCopy();">
									<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:pointer" align=absmiddle onClick="fnExcel();">&nbsp;&nbsp;
					 			</td>
							</tr>	
						</table>
					</td>											
				</tr>
				<tr>
					<td align="left"  colspan='2' width="845px">
						<table width="840px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="840px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
											<td align="center" width="80px" class="text">����</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
		                             			<%=HDConstant.COMMENT_START%>
												<object id=drp_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
		                                        	<param name=SearchColumn    value="saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^80">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">�������</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
					                 			<%=HDConstant.COMMENT_START%>
					             				<object id=txt_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>            
						               				<param name=Format      value="YYYY-MM-DD">
					                   				<PARAM NAME=InputFormat value="YYYYMMDD">
					                 				<param name=Alignment   value=1>
				                    				<param name=ClipMode    value=true>
						               				<param name=Border      value=false>
						              			</object>&nbsp;
												<object id=drp_depart_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
   							                     	<param name=SearchColumn    value="depart_time_nm">
													<param name=ListExprFormat  value="depart_time_nm^0^60">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text" >��ǰ����</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_goods_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
          							              	<param name=SearchColumn    value="goods_nm">
													<param name=ListExprFormat  value="goods_nm^0^100">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">��/��</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
                						        	<param name=SearchColumn    value="class_nm">
													<param name=ListExprFormat  value="class_nm^0^60">
												</object>
												<object id=drp_teams classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds7>
          							              	<param name=SearchColumn    value="teams_nm">
													<param name=ListExprFormat  value="teams_nm^0^60">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>																				
			            				</tr>
			                            <tr bgcolor="#6f7f8d">
											<td align="center" width="80px" class="text">Page</td>
											<td align="left" bgcolor="#ffffff" colspan="3"><nobr>&nbsp;
												<input type="text" name="txt_page_no" size="11" maxlength="20" class="textbox">
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">���强��</td>
											<td align="center" bgcolor="#ffffff"><input type=checkbox name=bizChk id=bizChk></td>
											<td align="center" width="80px" class="text">������</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_cust classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=50 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds8>
                						        	<param name=SearchColumn    value="detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^80">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>																					
			            				</tr>
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr> 
					<td height='5px'></td>
				</tr>												
				<tr>
					<td width="840px" colspan='2'>
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="840px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=840px; height:420px" border="1">
									    <param name="DataID"            value="ds1">
									    <param name="BorderStyle"       value="0">
									    <!-- param name="Fillarea"          value="true"-->
									    <param name="ColSizing"         value="true">
									    <param name="editable"          value="true">
										<param name="Format"            value=" 
                                            <C> name='����'         ID='{CURROW}'            Width=40  align=center edit=none</C>
                                            <C> name='��'           ID='class'              Width=50  align=center edit=none</C>
									        <C> name='��'           ID='teams'          	Width=50  align=center edit=none</C>
									         <C> name='������'         ID='tour_no'            Width=40  align=center edit=none</C>
									         <C> name='Page'         ID='page_no'            Width=40  align=center edit=none</C>
									        <C> name='����'         ID='STATUS_CD'        	Width=40  align=center edit=none</C> 
									        <C> name='����'         ID='cust_nm'        	Width=70  align=left edit=none</C>
									        <C> name='����'      	ID='sex'            	Width=45  align=center edit=none</C>
									        <C> name='�������'     ID='birthday'       	Width=75  align=center edit=none mask=XXXX.XX.XX</C>
									        <C> name='����/����'    ID='comp_nm'            Width=100  align=left edit=none</C>
                                            <C> name='��°�'       ID='address1'           Width=120  align=Left edit=none</C>
									        <C> name='����/����'    ID='country_cd'       	Width=80  align=left edit=none</C>
									        <C> name='���ǹ�ȣ'     ID='pass_no'        	Width=95  align=left edit=none</C>
									        <C> name='������ȣ'     ID='tour_code'       	Width=95  align=left edit=none</C>
									        <C> name='��û����ȣ'     ID='ACCEPT_NO'       	Width=120  align=left edit=none mask=XXXXX-XXXXXXXXX</C>
									        <C> name='�븮����'     ID='CLIENT_NM'       	Width=120  align=left edit=none</C>
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
		<td><br>
		�� ���强��, ������ �����׸��� ����=������ ������ ��Ÿ���ϴ�.<br>
		�� ��=��ü + ������=���� : ��ü ����� ��µ˴ϴ�. [���� ���� ���� ��� (YYYY.MM.DD)]<br>
		�� ��=���� : �ش� ���� ��µ˴ϴ�. [���� ���� ������ ��� �ݸ� xx�� (YYYY.MM.DD)]<br>
		�� ���强�� ���� + ������=����� : ���强���� ���� ��µ˴ϴ�. [���� ���� ���强�� ��� (YYYY.MM.DD)]<br>
		</td>
	</tr>
	
</table>

<!-----------------------------------------------------------------------------
					��¹� ���Ǻκ�
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
		<param name="SuppressColumns"		value="1:pageskip,skip">
		<PARAM NAME="Format"                VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=154 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='doc_title' ,left=705 ,top=11 ,right=1344 ,bottom=92 ,face='����' ,size=16 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=175 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1958 ,top=16 ,right=24 ,bottom=16 </L>
	<L> left=1958 ,top=95 ,right=24 ,bottom=95 </L>
	<L> left=1961 ,top=175 ,right=26 ,bottom=175 </L>
	<L> left=688 ,top=16 ,right=688 ,bottom=175 </L>
	<L> left=26 ,top=16 ,right=26 ,bottom=175 </L>
	<L> left=1958 ,top=16 ,right=1958 ,bottom=175 </L>
	<T>id='��  ��  ��  ��' ,left=185 ,top=108 ,right=532 ,bottom=164 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='~' ,left=1217 ,top=106 ,right=1246 ,bottom=161 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='arrive_date', left=1244, top=106, right=1458, bottom=161 ,mask='XXXX.XX.XX', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1005, top=106, right=1220, bottom=161 ,mask='XXXX.XX.XX', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��  ��  ü  ��' ,left=185 ,top=29 ,right=532 ,bottom=85 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='nights_days', left=1455, top=106, right=1643, bottom=161, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='team_nm1', left=826, top=29, right=1892, bottom=85, face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=478 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1958 ,top=476 ,right=24 ,bottom=476 </L>
	<L> left=344 ,top=397 ,right=26 ,bottom=397 </L>
	<L> left=1958 ,top=357 ,right=341 ,bottom=357 </L>
	<L> left=1961 ,top=238 ,right=344 ,bottom=238 </L>
	<L> left=344 ,top=0 ,right=344 ,bottom=479 </L>
	<L> left=609 ,top=0 ,right=609 ,bottom=479 </L>
	<L> left=26 ,top=0 ,right=26 ,bottom=476 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=479 </L>
	<L> left=1958 ,top=119 ,right=344 ,bottom=119 </L>
	<L> left=1588 ,top=241 ,right=1588 ,bottom=479 </L>
	<L> left=1588 ,top=0 ,right=1588 ,bottom=119 </L>
	<T>id='����' ,left=384 ,top=32 ,right=572 ,bottom=87 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������' ,left=1360 ,top=32 ,right=1553 ,bottom=87 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='birthday', left=1614, top=32, right=1934, bottom=87 ,mask='XXXX.XX.XX', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����/����' ,left=384 ,top=151 ,right=572 ,bottom=209 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1323 ,top=241 ,right=1323 ,bottom=479 </L>
	<T>id='��°�' ,left=386 ,top=270 ,right=574 ,bottom=328 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='address1', left=635, top=270, right=1299, bottom=325, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����/����' ,left=1363 ,top=270 ,right=1550 ,bottom=331 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='country_cd', left=1614, top=270, right=2134, bottom=325, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��������' ,left=384 ,top=392 ,right=572 ,bottom=447 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='pass_type', left=635, top=392, right=955, bottom=447, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���ǹ�ȣ' ,left=1363 ,top=389 ,right=1550 ,bottom=447 ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='pass_no', left=1614, top=392, right=1934, bottom=447, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1323 ,top=0 ,right=1323 ,bottom=119 </L>
	<C>id='cust_enm', left=635, top=58, right=1299, bottom=114, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm2', left=635, top=5, right=1299, bottom=61, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm1', left=635, top=32, right=1299, bottom=87, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comp_nm2', left=635, top=127, right=1299, bottom=183, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comp_enm', left=635, top=180, right=1599, bottom=235, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='tour_no', left=26, top=410, right=347, bottom=466, face='����', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=40 ,top=13 ,right=336 ,bottom=389</I>
	<C>id='comp_nm1', left=635, top=153, right=1299, bottom=209, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='skip', left=1318, top=151, right=1929, bottom=206, supplevel=1, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#FFFFFF, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2815 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='page_no', left=712, top=0, right=1323, bottom=56, supplevel=2, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	">
	</object> 

<%=HDConstant.COMMENT_END%>      

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

