<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������� �ŷ����� ���ε�
 * ���α׷�ID 	: AC081I
 * J  S  P		: ac081I
 * �� �� ��		: Ac081I
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-12-10 
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

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit(); 
			if (excelDs.countrow<1){
				var s_temp =  "COL01:STRING,COL02:STRING,COL03:STRING,COL04:STRING,COL05:STRING,"
						 	+ "COL06:STRING,COL07:STRING,COL08:STRING,COL09:STRING,COL10:STRING,"
						 	+ "COL11:STRING,COL12:STRING,COL13:STRING,COL14:STRING,COL15:STRING,"
						 	+ "COL16:STRING,COL17:STRING,COL18:STRING,COL19:STRING,"
						 	+ "TR_SID:NUMBER;";
				//����� decimal(10)��  �ϴ°� ������.
/*				var s_temp = "UPLOAD_MSG:STRING,SEQ:STRING,COL01:STRING,"
						 	+ "COL02:STRING,COL03:STRING,COL04:STRING,COL05:STRING,COL06:STRING,"
						 	+ "COL07:STRING,COL08:STRING,COL09:STRING,COL10:STRING,COL11:STRING,"
						 	+ "COL12:STRING,COL13:STRING,COL14:STRING,COL15:STRING,COL16:STRING,"
						 	+ "COL17:STRING,COL18:STRING,COL19:STRING,"
						 	+ "YN:STRING";*/
				excelDs.SetDataHeader(s_temp);
			}
		}		

		/*
		 * �ʱ��۾�
		 */
		function fnInit(){
			sBgnDate.text='<%=firstday%>';
			sEndDate.text='<%=firstday%>';
		    	   
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_AC%>Ac081I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
        	
			//2007-12-11 ����Ʈ�ڵ�  by �ɵ��� 
			sSiteCode.Index=0;
		}

		/**
		 * �������� 
		 * ���� ���ε� �Ŀ� ��ȸ 
		 */
		 
		function fnExcelApply()  {
			if(sSiteCode.ValueOfIndex("siteCode", sSiteCode.Index)=="") {
				alert("�������� ���� ����Ʈ�ڵ带 ������ �ּ���.");
				sSiteCode.focus();
				return false;
			}
			
			if(gcip_file.value=="") {
				alert("������ ������ �ּ���.");
				gcip_file.focus();
				return false;
			}
			
			tempExcelDs.addrow();
		 	
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",sSiteCode=" + sSiteCode.ValueOfIndex("siteCode", sSiteCode.Index);
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac081I",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs)",
	            v_param);                
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
                    + ",sSiteCode=" + sSiteCode.ValueOfIndex("siteCode", sSiteCode.Index);
                    
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac081I", 
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        tr_post(tr1);
		}
		
	
			
		/*
		 * ����
		 */
		function fnApply() {
			if(sSiteCode.ValueOfIndex("siteCode", sSiteCode.Index)=="") {
				alert("�����Ͻñ� ���� ����Ʈ�ڵ带 ������ �ּ���.");
				sSiteCode.focus();				
				return false;
			}
		
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			if (excelDs.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_AC%>Ac081I",
               	  "JSP(I:EXCELDS=excelDs,O:RESULT=ds_result)",
               	  param);
            	tr_post(tr1);
			} else {
				alert("������Ʈ�� ���� �����ϴ�.");
			};	
		}
		
		/*
		 * ����
		 */
		function fnExcelDs1() {
	        if(excelDs.CountRow==0){
    	        alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
        	    return;
        	};
        	   
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:������� �ŷ�����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("Sheet1","������� �ŷ�����.xls", 8);
		}
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>


	<script language=JavaScript  for=excelDs event="OnLoadCompleted(row)">
		if(excelDs.countrow <= 0) {
			return;
		}
				
/*        if(v_job=="I"){ 	// �Է��� ��.
			for(i = 1; i <= excelDs.countrow; i++){
				excelDs.namevalue(i, "TR_SID") = 0;
			}			*/
		};
	</script>

	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';
        if(v_job=="I"){ 	// �Է��� ��.
			for(i = 1; i <= excelDs.countrow; i++){
				excelDs.namevalue(i, "TR_SID") = 0;
			}			

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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

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
										<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
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
                        <td align="center" width="90px" height="30px" class="text">����Ʈ�ڵ�</td>
						<td align="left" bgcolor="#ffffff" width=300>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sSiteCode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=170 border="0" align=absmiddle>
								<param name=CBData			value="W6677^�������,W8253^������">
								<param name=CBDataColumns	value="siteCode,siteNm">
								<param name=SearchColumn	value=siteCode>
								<param name=Sort			value=True>
								<param name=ListExprFormat	value="siteCode^1^70,siteNm^1^70">								
								<param name=BindColumn		value="siteCode">								
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>
						<td align="center" width="90px" class="text">��������</td>       
						<td bgcolor=#ffffff  valign="middle" align=left>&nbsp;
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
						<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_Order_Nm id=sTr_Order_Nm></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height=10><td></td></tr>
		<tr height="100%">
			<td height="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="845px" height="100%">
					<tr height="100%">
						<td height="100%">
							<%=HDConstant.COMMENT_START%>
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="845px" height="400px" border="1">
							        <param name="DataID"            value="excelDs">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
							        <param name="Format"            value="
											<C> name='No'			ID='COL01' Width=30 Align=right Show=true dec=0</C>	
											<C> name='����Ʈ�ڵ�'		ID='COL02' Width=60 Align=center Show=true	</C>
											<C> name='����Ʈ��'		ID='COL03' Width=70 Align=center Show=true	</C>
											<C> name='�����Ͻ�'		ID='COL04' Width=120 Align=center Show=true	</C>
											<C> name='�ֹ���ȣ'		ID='COL05' Width=70 Align=center Show=true	</C>
											<C> name='�ֹ��ڸ�'		ID='COL06' Width=100 Align=left Show=true	</C>
											<C> name='�ŷ�����'		ID='COL07' Width=70 Align=center Show=true	</C>
											<C> name='�ŷ��ݾ�'		ID='COL08' Width=80 Align=right Show=true	dec=0 </C>
											<C> name='�Աݱݾ�'		ID='COL09' Width=80 Align=right Show=true	dec=0 </C>
											<C> name='������'			ID='COL10' Width=60 Align=right Show=true	dec=0 </C>
											<C> name='�ΰ���'			ID='COL11' Width=50 Align=right Show=true	dec=0 </C>
											<C> name='�ŷ�����'		ID='COL12' Width=70 Align=center Show=true	</C>
											<C> name='�ŷ���ȣ'		ID='COL13' Width=100 Align=center Show=true	</C>
											<C> name='��������'		ID='COL14' Width=70 Align=center Show=true	</C>
											<C> name='��������'		ID='COL15' Width=70 Align=center Show=true	</C>
											<C> name='����ũ�μ�����'	ID='COL16' Width=40 Align=right Show=true	dec=0</C>
											<C> name='����ũ�κΰ���'	ID='COL17' Width=40 Align=right Show=true	dec=0</C>
											<C> name='��ǰ��'			ID='COL18' Width=80 Align=left Show=true	</C>
											<C> name='�ŷ�����'		ID='COL19' Width=60 Align=center Show=true	</C>
							                <C> name='TR_SID'    	ID='TR_SID' Width=100  align=left  show=false</C>
							        ">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>				
				</table>
			</td>
		</tr>
		<tr>
			<td><br>�� �׼��� ��Ʈ�� = "������� ���Ը�������(��ü����)" �̾�� �մϴ�. (�� �ٿ���� �⺻ ��)<br>
			�� �����Ͻ� == ����ڰ� ������¸� ������ �Ͻ�<br>
			�� �������� == ����ڰ� ���࿡ �Ա��� ��¥ (�� �Ա�����)<br>
			�� �������� == PG��(KCP)���� ���� �Ա��� ��¥<br>
			
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
