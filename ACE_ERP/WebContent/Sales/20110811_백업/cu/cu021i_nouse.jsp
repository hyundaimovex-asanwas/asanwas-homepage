<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: �������۾�
 * ���α׷�ID 	: CU020I
 * J  S  P		: cu020i
 * �� �� ��		: Cu020I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-07 
 * �������		:
 * ��������		: 
 * �� �� ��		:
 * ������������ 	:
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<!-- HEAD ���� -->
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
		function fnOnLoad(){
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit(); 

			if (excelDs.countrow<1){
				var s_temp = "UPLOAD_MSG:STRING,SEQ:STRING,COL01:STRING,"
						 	+ "COL02:STRING,COL03:STRING,COL04:STRING,COL05:STRING,COL06:STRING,"
						 	+ "COL07:STRING,COL08:STRING,COL09:STRING,COL10:STRING,COL11:STRING,"
						 	+ "COL12:STRING,COL13:STRING,COL14:STRING,COL15:STRING,COL16:STRING,"
						 	+ "COL17:STRING,COL18:STRING,COL19:STRING,"
						 	+ "YN:STRING";
									
				excelDs.SetDataHeader(s_temp);
			}
		}		

		/*
		 * �ʱ��۾�
		 */
		function fnInit(){
    	   
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu020I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
		}

		/**
		 * �������� 
		 * ���� ���ε� �Ŀ� ��ȸ 
		 */
		 
		function fnExcelApply()  {

          if (client_nm.value == "") {
            alert("�븮���� �Է��Ͻʽÿ�.");
            return;
          }
     		
      	tempExcelDs.addrow();

		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL")  = file_path.value;
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu020I",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs)",
                "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>");
           tr_post(tr1);
		}
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {

          if (client_nm.value == "") {
            alert("�븮���� �Է��Ͻʽÿ�.");
            return;
          }
          
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",sClientSid="+client_sid.value;
//        alert(client_sid.value);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu020I", 
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        tr_post(tr1);
		}
		
		/*
		 * �ڷ�Ȯ��
		 */
		function fnDataValid() {

          if (client_nm.value == "") {
            alert("�븮���� �Է��Ͻʽÿ�.");
            return;
          }

        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",sClientSid="+client_sid.value;

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu020I", 
	            "JSP(I:DS03=excelDs,O:RESULT=ds_result)",
	            v_param);
	        tr_post(tr1);

	        fnSelect();
		}
		
		/*
		 * �ڷ��̰�
		 */
		function fnTransfer() {

          if (client_nm.value == "") {
            alert("�븮���� �Է��Ͻʽÿ�.");
            return;
          }

        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",sClientSid="+client_sid.value;
        
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu020I", 
	            "JSP(I:DS04=excelDs,O:RESULT=ds_result)",
	            v_param);
	        tr_post(tr1);
	        
	        fnSelect();
		}
		
			
		/*
		 * ����
		 */
		function fnApply() {
			
          if (client_nm.value == "") {
            alert("�븮���� �Է��Ͻʽÿ�.");
            return;
          }

			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
						+ ",sClientSid=" + client_sid.value;
						 
			if (excelDs.IsUpdated) {
				 ln_TRSetting(tr1, 
                	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu020I",
               	 "JSP(I:EXCELDS=excelDs,O:RESULT=ds_result)",
               	 param);
               	 
            	tr_post(tr1);
			}	
		}
		
		function fnAddRow() {
			excelDs.addRow();
		}
		
		
		function fnDeleteRow() {
			excelDs.deleteRow(excelDs.rowposition);
		}
		
		function fnCancel() {
			excelDs.undoAll();
		}
		
		/*
		 * ���� 
		 */
		function fnConfirm(no) {
    		var url = "http://com.hdasan.com/cNameCheckSYS2.asp?Jumin="+ excelDs.namevalue(excelDs.rowposition, "COL03") +"&Name="+ excelDs.namevalue(excelDs.rowposition, "COL02") +"&returnURL=erp.hdasan.com/services/Sales/common/include/confirm2.jsp&no="+no;
			top.confirm = 	window.open(url, "comfirm" ,"width=400,height=280,left=300,top=0,toolbar=yes,status=yes,menubar=no,scrollbars=no,resize=no,resizable=no");    
	  		top.confirm.opener = this;
    		//		location.href=url;
    	}
		 
			
		/*
		 * �븮�� �˾� 
		 */	
		function fnClientPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	 
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);	
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		client_nm.value = arrParam[1];
		   		client_sid.value = arrParam[0];
		   		
			} else {
			  client_nm.value = "";
			  client_sid.value = "";
			}				
		}			
		
		function fnTest(no, value) {
			excelDs.namevalue(no, "COL04") = value;
		}
		
		/*
		 * ����
		 */
		function fnExcelDs1() {
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").GridToExcel("Sheet1","�����.xls", 8);
		}		
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
		<script language=JavaScript  for=excelDs event="OnLoadCompleted(row)">
			if (excelDs.countrow <= 0) {
				return;
			}
			for(i = 1; i <= excelDs.countrow; i++) {
				excelDs.namevalue(i, "yn") = "U";
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
//            alert(gcip_file.value);
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
		
		
	<!--  �˾� ���� -->
	<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if(colid=="COL04") {                            
			fnConfirm(row);   
		}            
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
<%=HDConstant.COMMENT_END%>
	</head>
	
<jsp:include page="/Sales/common/include/body_s.jsp"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
									
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow()">
										<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()">
										<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
										<img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" align=absmiddle"  border='0' onClick='javascript:fnExcelDs1();'>
									
										&nbsp;&nbsp;&nbsp;
										<img src="<%=dirPath%>/Sales/images/data_confirm.gif" style="cursor:hand" align=absmiddle" border='0' onClick='javascript:fnDataValid();'>
									   	<img src="<%=dirPath%>/Sales/images/data_transfer.gif" style="cursor:hand" align=absmiddle" border='0' onClick='javascript:fnTransfer();'>
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
				<table  border="0" cellpadding="0" cellspacing="1" width="710px" bgcolor=#666666>
					<tr>
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
						<td align="center" width="85px" height="30px" class="text">�븮���ڵ�</td>                                                              
						<td align="left"  bgcolor="#ffffff" colspan="3" bgcolor=#ffffff>                                                                           
							&nbsp;<input type="text" id=client_nm name='client_nm' value="" size="14" maxlength="10"  readOnly="true">
						<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle onClick = fnClientPopup();>     
						 <input type='hidden' id='client_sid' name='client_sid' value=''>                                              
						</td>  
								</tr>
							</table>
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
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
							        <param name="editable"          value="true">
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
							        <param name="Format"            value="
							        		<C> name='�ڷ�Ȯ��' 		ID='UPLOAD_MSG' Width=100  align=left  show=true	edit=none bgcolor=#f6f7b4</c>
											<C> name='����'    		ID='SEQ'  	 	Width=100  align=left  show=true	</C>
							                <C> name='��������'    	ID='COL01'  	Width=100  align=left  show=true 	</C>
							                <C> name='����'   		ID='COL02'    	Width=100  align=left  show=true	</C>
							                <C> name='�ֹι�ȣ'      	ID='COL03'    	Width=100  align=left  show=true	</C>
							                <C> name='��������'     	ID='COL04'   	Width=100  align=left  show=true	 editstyle=popup</C>
							                <C> name='�������'  		ID='COL05'  	Width=100  align=left  show=true	</C>
							                <C> name='��û����ȣ'    	ID='COL06'   	Width=100  align=left  show=true	</C>
							                <C> name='����'  		ID='COL07'      Width=100  align=left  show=true	</C>
							                <C> name='������'      	ID='COL08'     	Width=100  align=left  show=true 	</C>
							                <C> name='�������'      	ID='COL09'    	Width=100  align=left  show=true	</C>
							                <C> name='������'      	ID='COL10'    	Width=100  align=left  show=true	</C>
							                <C> name='�����ȣ'      	ID='COL11'    	Width=100  align=left  show=true	</C>
							                <C> name='�ּ�1'   		ID='COL12' 	 	Width=100  align=left  show=true	</C>
							                <C> name='�ּ�2'      	ID='COL13'    	Width=100  align=left  show=true	</C>
							                <C> name='������ȭ'    	ID='COL14'  	Width=100  align=left  show=true	</C>
							                <C> name='�ڵ���'   		ID='COL15' 	 	Width=100  align=left  show=true	</C>
							                <C> name='�����'    	ID='COL16'  	Width=100  align=left  show=true	</C>
							                <C> name='����'    		ID='COL17'  	Width=100  align=left  show=true	</C>
							                <C> name='����'    		ID='COL18'  	Width=100  align=left  show=true	</C>
							                <C> name='����'    		ID='COL19'  	Width=100  align=left  show=true	</C>
							                <C> name='YN'    		ID='YN'  		Width=100  align=left  show=false	</C>
							        ">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>				
				</table>				
			</td>
		</tr>
      <tr><td>&nbsp;</td></tr>
      <tr><td>&nbsp; <font color=blue>* ã�ƺ��� --> �������� --> ���� --> �ڷ�Ȯ�� --> �ڷ��̰�.</font></td></tr>
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

<jsp:include page="/Sales/common/include/body_e.jsp"/>