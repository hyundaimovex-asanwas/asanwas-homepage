<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ü����Ȳ
 * ���α׷�ID 	: AC020S
 * J  S  P		: ac020s
 * �� �� ��		: Ac020S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-08-07
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
		/*
		 * �������ε�
		 */
    	var v_job="";		 
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			cfStyleGrid(getObjectFirst("gr4"), "comn");
			cfStyleGrid(getObjectFirst("gr5"), "comn");
			cfStyleGrid(getObjectFirst("gr6"), "comn");
			cfStyleGrid(getObjectFirst("gr7"), "comn");
			
			
			fnInit(); 
		}		

		/*
		 * �ʱ��۾�
		 */
		function fnInit(){

    	   	
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_SY%>Sy520B",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
		}

		/**
		 * �������� 
		 * ���� ���ε� �Ŀ� ��ȸ 
		 */
		 
		function fnExcelApply()  {
			v_job="E";
			tempExcelDs.addrow();
		 	
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy520B",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS1=ds1,O:EXCELDS2=ds2,O:EXCELDS3=ds3,O:EXCELDS4=ds4,O:EXCELDS5=ds5,O:EXCELDS6=ds6,O:EXCELDS7=ds7)",
                "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>");
            tr_post(tr1);
		}
		
		
		
		
			
		/*
		 * ����
		 */
		function fnApply() {
			var param1="";
			if(selExl[0].checked){
				param1="JSP(I:EXCELDS1=ds1,O:RESULT=ds_result)";
			}else if(selExl[1].checked){
				param1="JSP(I:EXCELDS2=ds2,O:RESULT=ds_result)";
			}else if(selExl[2].checked){
				param1="JSP(I:EXCELDS3=ds3,O:RESULT=ds_result)";
			}else if(selExl[3].checked){
				param1="JSP(I:EXCELDS4=ds4,O:RESULT=ds_result)";
			}else if(selExl[4].checked){
				param1="JSP(I:EXCELDS5=ds5,O:RESULT=ds_result)";
			}else if(selExl[5].checked){
				param1="JSP(I:EXCELDS6=ds6,O:RESULT=ds_result)";
			}else if(selExl[6].checked){
				param1="JSP(I:EXCELDS7=ds7,O:RESULT=ds_result)";
			};
			
			v_job="U";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
						 
			if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated || ds4.IsUpdated|| ds5.IsUpdated|| ds6.IsUpdated|| ds7.IsUpdated) {
				 ln_TRSetting(tr1, 
                	"<%=dirPath%><%=HDConstant.PATH_SY%>Sy520B",param1,
               	 //"JSP(I:EXCELDS2=ds2,I:EXCELDS3=ds3,I:EXCELDS4=ds4,O:RESULT=ds_result)",
               	 //"JSP(I:EXCELDS1=ds1,I:EXCELDS2=ds2,I:EXCELDS3=ds3,I:EXCELDS4=ds4,I:EXCELDS5=ds5,I:EXCELDS6=ds6,I:EXCELDS7=ds7, O:RESULT=ds_result)",
               	 param);
               	 
            	tr_post(tr1);
			}	
		}
		
		/*
		 * ���������� ���� 
		 */
			
			
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		
  		if(v_job=="E"){ 	// ���� �ε�
	        alert("���� ���� �Ϸ�");	          	
        }  else if(v_job == "U") {	// ������ ��
            alert("������ ���� �Ϸ�");
       	}		
		
		
		
	</script>	
			<script language="javascript" for="gcip_file" event=OnClick()>
		    if (fn_trim(gcip_file.value)!="") {
		    
		    	//alert(gcip_file.value);
		    	file_path.value = gcip_file.value;
		    }
		</script>
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
		if (ds1.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds1.countrow; i++) {
			ds1.namevalue(i, "yn") = "U";
		}
	</script>
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
		if (ds2.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds2.countrow; i++) {
			ds2.namevalue(i, "yn") = "U";
		}
	</script>
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
		if (ds3.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds3.countrow; i++) {
			ds3.namevalue(i, "yn") = "U";
		}
	</script>	
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
		if (ds4.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds4.countrow; i++) {
			ds4.namevalue(i, "yn") = "U";
		}
	</script>	
	<script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
		if (ds5.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds5.countrow; i++) {
			ds5.namevalue(i, "yn") = "U";
		}
	</script>	
	<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
		if (ds6.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds6.countrow; i++) {
			ds6.namevalue(i, "yn") = "U";
		}
	</script>	
	<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
		if (ds7.countrow <= 0) {
			return;
		}
		for(i = 1; i <= ds7.countrow; i++) {
			ds7.namevalue(i, "yn") = "U";
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
		
<%



/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>


<object id=tempExcelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!--  ����� -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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


	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr height="30px">
			<td bgcolor="#ffffff">
				<table border='0' cellpadding='0' cellspacing='1' width='445' bgcolor="#666666">
					<tr height="30px">
						<td align="center" width="85px" height="30px" class="text">��������</td>       
						<td width=350 bgcolor=#ffffff  valign="middle">&nbsp;
							<input type="text" name="file_path" value="" >&nbsp;
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;"  >
									<param name="Text"		value="ã�ƺ���">
								</OBJECT>&nbsp;
								<img src="<%=dirPath%>/Sales/images/excel_apply.gif" style="cursor:hand"  border='0' onClick='javascript:fnExcelApply();'>
								<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
			<td align='right'>�ڷ�
				<input type=radio name=selExl>1
				<input type=radio name=selExl>2
				<input type=radio name=selExl>3
				<input type=radio name=selExl>4
				<input type=radio name=selExl>5
				<input type=radio name=selExl>6
				<input type=radio name=selExl>7
				
				<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
			</td>
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
									<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:140; width:845; height:20">
										<param name="BackColor"			value="#00ffff">
										<param name="DisableBackColor"	value="#ffffee">
										<param name="Format"			value='
											<T>divid="mxTab_page1"	title="������:TCU010"</T>
											<T>divid="mxTab_page2"	title="��������:TRV010"</T>
											<T>divid="mxTab_page3"	title="����������:TRV020"</T>
											<T>divid="mxTab_page4"	title="������:TRV030"</T>
											<T>divid="mxTab_page5"	title="�����:TCM010"</T>
											<T>divid="mxTab_page6"	title="����ڿ���:TCM040"</T>
											<T>divid="mxTab_page7"	title="RF�߱�:RF_TAG_H"</T>

											'>	
																												
									</object>
									<%=HDConstant.COMMENT_END%>	
									<div class=page id="mxTab_page1" style="position:absolute; left:170; top:160; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
									
	                        			<param name="DataID"		VALUE="ds1">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
							               		<C> name='��SID'	ID='CUST_SID'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='��û����ȣ'	ID='GROUP_CD'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�ֹ�/���ǹ�ȣ'	ID='MANAGE_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�׷��ȣ'		ID='GROUP_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='�ֹι�ȣ'		ID='REGI_NO'	 width=100 align=left editlimit=13 show=true</C>
												<C> name='�Ǹ�Ȯ��'	ID='REGI_YN_T'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='������'		ID='CUST_GU'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='��������'		ID='COUNTRY_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='�������'		ID='SAUP_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='������'		ID='CUST_TYPE'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='�ѱۼ���'		ID='CUST_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='������'	ID='LAST_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='��������'	ID='FIRST_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='�����ڵ�'	ID='COUNTRY_CD'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='�����ڵ�'	ID='NATION_CD'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='�������'	ID='BIRTHDAY'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='����'		ID='SEX'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='������ȭ'	ID='TEL_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�ڵ���'	ID='MOBILE_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�̸���'	ID='E_MAIL'	 width=100 align=left editlimit=40 show=true</C>
												<C> name='FAX��ȣ'	ID='FAX_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�����ȣSID'	ID='ZIP_SID'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='�����ȣ'	ID='ZIP_CD'	 width=100 align=left editlimit=6 show=true</C>
												<C> name='�ּ�1'	ID='ADDRESS1'	 width=100 align=left editlimit=80 show=true</C>
												<C> name='�ּ�2'	ID='ADDRESS2'	 width=100 align=left editlimit=60 show=true</C>
												<C> name='�ܱ������ȣ'	ID='ENG_ZIP_CD'	 width=100 align=left editlimit=10 show=true</C>
												<C> name='�����ּ�1'	ID='ENG_ADDR1'	 width=100 align=left editlimit=60 show=true</C>
												<C> name='�����ּ�2'	ID='ENG_ADDR2'	 width=100 align=left editlimit=60 show=true</C>
												<C> name='��������'	ID='PASS_TYPE'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='���ǹ�ȣ'	ID='PASS_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='���Ǹ�����'	ID='PASS_EXPIRE_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='���ǹ�����'	ID='PASS_ISSUE_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='���ǹ�����'	ID='PASS_AREA'	 width=100 align=left editlimit=22 show=true</C>
												<C> name='�����'	ID='COMPANY_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='����'	ID='POSITIONS'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='���������'	ID='ENG_COMPANY_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='��������'	ID='ENG_POSITION'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='���ѹ湮Ƚ��'	ID='NORTH_CNT'	 width=100 align=left editlimit=7 show=true</C>
												<C> name='����óSID'	ID='CLIENT_SID'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='����'	ID='HEIGHT'	 width=100 align=left editlimit=5 show=true</C>
												<C> name='����'	ID='JOB_CD'	 width=100 align=left editlimit=2 show=true</C>
										
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page2" style="position:absolute; left:170; top:160; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds2">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           				<C> name='��ûSID'	ID='ACCEPT_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='��û����ȣ'	ID='ACCEPT_NO'	 width=100 align=left editlimit=14 show=true</C>
												<C> name='��û����'	ID='ACCEPT_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='�������'	ID='DEPART_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='�����SID'	ID='SAUP_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='��ǰSID'	ID='GOODS_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='����óSID'	ID='CLIENT_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='���SID'	ID='EVENT_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='�۾�����'	ID='JOB_GUBUN'	 width=100 align=left editlimit=1 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page3" style="position:absolute; left:170; top:160; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds3">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           				<C> name='����SID'	ID='RSV_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='�ֿ���SID'	ID='M_RSV_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='KEY-MAN'	ID='KEY_MAN'	 width=100 align=left editlimit=13 show=true</C>
												<C> name='��ûSID'	ID='ACCEPT_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='����SID'	ID='UPJANG_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												
												<C> name='��û����Ÿ��SID'	ID='A_ROOM_TYPE_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='��û����SID'	ID='A_ROOM_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='����Ÿ��SID'	ID='ROOM_TYPE_SID'	width=100  align=left editlimit=12 show=true dec=0</C>
												<C> name='����SID'	ID='ROOM_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='����ROOM NO'	ID='OLD_ROOM_NO'	width=100  align=left editlimit=5 show=true dec=0</C>
												
												<C> name='���SID'	ID='BLOCK_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='����Ÿ��'	ID='RSV_TYPE'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='�����ڷ����'	ID='STATUS_CD'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='�������'	ID='DEPART_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='��߽ð�'	ID='DEPART_TIME'	 width=100 align=left editlimit=4 show=true</C>

												<C> name='�ڼ�'	ID='NIGHTS'	 width=100 align=left editlimit=5 show=true dec=0</C>
												<C> name='�԰�����'	ID='ARRIVE_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='�԰�ð�'	ID='ARRIVE_TIME'	 width=100 align=left editlimit=4 show=true</C>
												<C> name='��SID'	ID='CUST_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='������'	ID='CUST_TYPE'	 width=100 align=left editlimit=3 show=true</C>

												<C> name='������'	ID='CUST_GU'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='�������'	ID='SAUP_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='�����ڵ�'	ID='AGE_CD'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='�����ڵ�'	ID='JOIN_CD'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='�ڵ���'	ID='MOBILE_NO'	 width=100 align=left editlimit=15 show=true</C>

												<C> name='�����'	ID='COMPANY_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='����'	ID='POSITIONS'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='�ּ�SID'	ID='ZIP_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
												<C> name='�ּ��ڵ�'	ID='ZIP_CD'	 width=100 align=left editlimit=6 show=true</C>
												<C> name='�ּ�1'	ID='ADDRESS1'	 width=100 align=left editlimit=60 show=true</C>

												<C> name='��'	ID='CLASS'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='��'	ID='TEAMS'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='������NO'	ID='PAGE_NO'	 width=100 align=left editlimit=5 show=true dec=0</C>
												<C> name='��ϸ���'	ID='NORTH_PURPOSE'	 width=100 align=left editlimit=62 show=true</C>
												<C> name='��������'	ID='DRIVE_YN'	 width=100 align=left editlimit=1 show=true</C>

												<C> name='��һ����ڵ�'	ID='CANCEL_CD'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='��������ȣ'	ID='TOUR_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='������üũ'	ID='MOJ_CHECK_YN'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='�����̼�����'	ID='EDUC_FINISH_YN'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='�����������'	ID='ORG_SUBMIT_DATE'	 width=100 align=left editlimit=8 show=true</C>

												<C> name='���Ϻ��Ϸù�ȣ'	ID='UNITY_NO'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='����㰡����[����]'	ID='SOUTH_PERMIT_YN'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='�����������'	ID='NORTH_SUBMIT_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='�������ð�'	ID='NORTH_SUBMIT_TIME'	 width=100 align=left editlimit=4 show=true</C>
												<C> name='�����Ա��㰡'	ID='NORTH_PERMIT_YN'	 width=100 align=left editlimit=1 show=true</C>

												<C> name='�����û���'	ID='RSV_WAY_CD'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='�������'	ID='REMARKS'	 width=100 align=left editlimit=200 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page4" style="position:absolute; left:170; top:160; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds4">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='����SID'		ID='RSV_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='�������'		ID='USE_DATE'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='����'		ID='KEY_SEQ'	 width=100 align=left editlimit=5 show=true dec=0</C>
											<C> name='�޴�SID'		ID='MENU_SID'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='ǥ�ؿ��'		ID='STD_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='�̿���'		ID='USE_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='�Ǹż���'		ID='SALE_QTY'	 width=100 align=left editlimit=5 show=true dec=0</C>
											<C> name='�ɼǻ�ǰ����'	ID='OPTION_YN'	 width=100 align=left editlimit=1 show=true</C>
											<C> name='����ð��翩��'	ID='RSV_PAY_YN'	 width=100 align=left editlimit=1 show=true</C>
											<C> name='�������'		ID='REMARKS'	 width=100 align=left editlimit=100 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>	
									<div class=page id="mxTab_page5" style="position:absolute; left:170; top:160; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr5 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds5">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
											<C> name='��SID' 			ID='CUST_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='����������⿩��' ID='VISIT_K_LIST'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�ǹ���ȣ' 		ID='WORK_NO'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�Ҽӻ�' 			ID='CLIENT_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='���δ�ȸ��' 	ID='REAL_CLIENT'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='��ϱ����̼�����' ID='N_EDUC_YN'	 width=100 align=left editlimit=8 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>

									<div class=page id="mxTab_page6" style="position:absolute; left:170; top:160; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr6 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds6">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
											<C> name=' ����SID' ID='RSV_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' �����SID' ID='CUST_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' �������Ÿ��' ID='A_ROOM_TYPE_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' ������� �������' ID='REMARKS'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' ���������' ID='N_CARD_GU'	 width=100 align=left editlimit=8 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>

									<div class=page id="mxTab_page7" style="position:absolute; left:170; top:160; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr7 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds7">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
											<C> name='�±׽ø���'      ID='TAG_SER'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱޼���'        ID='TAG_SEQ'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱ޱ���'        ID='TAG_ISSUE_KIND' 	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱޺��'        ID='COMMENT'       	 width=100 align=left editlimit=8 show=true</C>
											<C> name='ȸ��Ű'          ID='MEMBER_NO'      	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�����'          ID='MEM_GROUP'      	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�̸�'            ID='NAME'           	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�ֹε�Ϲ�ȣ'    ID='PS_NO'          	 width=100 align=left editlimit=8 show=true</C>
											<C> name='��ϱ���'        ID='MEMBER_KIND'    	 width=100 align=left editlimit=8 show=true</C>
											<C> name='ī�屸��'        ID='RF_KIND'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='��� ������'     ID='USE_FROM'       	 width=100 align=left editlimit=8 show=true</C>
											<C> name='��� ������'     ID='USE_TO'         	 width=100 align=left editlimit=8 show=true</C>
											<C> name='Ű����'          ID='KEY_VER'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱������ڵ�'    ID='ISSUE_AUTH_CODE'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱���'          ID='USER_ID'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱�����'        ID='UDATE'        	 width=100 align=left editlimit=8 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
																		
																	
							</td>		
						</tr>
					</table>
						</td>
					</tr>
				</table>
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

