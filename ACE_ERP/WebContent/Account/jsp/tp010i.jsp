<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���뿹�� ���� �ŷ����� ���ε�
 * ���α׷�ID 	: TO010I Temporary Receipt
 * J  S  P		: Account/jsp/tp010i.jsp
 * �� �� ��		: Tp010I
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-06-07 
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2015-05-27][�ɵ���] ���� ��  ȸ��� �޴� �̰�������
 *						������ �� java������ sales.�� ������ ����ؾ� �� ��.. 
 *						account���� ���ۼ����� ����;;
 * [2016-04-21][�ɵ���] ����ڰ� ������ �븮�� ����.
 * [2016-06-13][�ɵ���] ��ȯ �ϳ� �պ����� �׼� �ٿ�ε� ��� ����Ǽ� ����
 *						�ŷ����� �÷� ����� �޶�����..^^;
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
				var s_temp = "TR_ACCT_CD:STRING,COL01:STRING,"
						 	+ "COL02:STRING,COL03:STRING,COL04:NUMBER,COL05:NUMBER,COL06:STRING,"
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
            	"<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp010I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
        	
			//2007-06-11 ���¹�ȣ  by �ɵ��� 
			//���¹�ȣ [AC021]
			//dstype=5 : detail_nm�� �����ָ鼭 '��ü'
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC021&s_item1=Y";
            codeDs1.Reset();
		}

		/**
		 * �������� 
		 * ���� ���ε� �Ŀ� ��ȸ 
		 */
		 
		function fnExcelApply()  {
			v_job = "I";
			//alert("***"+sAcctGu.ValueOfIndex("detail", sAcctGu.Index)+"***");
			//alert("***"+file_path.value+"***");
			if(sAcctGu.ValueOfIndex("detail", sAcctGu.Index)==" ") {
				alert("�������� ���� ���¹�ȣ�� ������ �ּ���.");
				sAcctGu.focus();
				return false;
			}
			if(file_path.value=="") {
				alert("���� ������ ã���ּ���.");
				file_path.focus();
				return false;
			}			
			
			tempExcelDs.addrow();
		 	
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",sAcctGu=" + sAcctGu.ValueOfIndex("detail", sAcctGu.Index);
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp010I",
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
		            + ",sTr_Sum=" + sTr_Sum.value
                    + ",sAcctGu=" + sAcctGu.ValueOfIndex("detail", sAcctGu.Index);
                    
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp010I", 
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        tr_post(tr1);
		}
		
	
			
		/*
		 * ����
		 */
		function fnApply() {
			if(sAcctGu.ValueOfIndex("detail", sAcctGu.Index)=="") {
				alert("�����Ͻñ� ���� ���¹�ȣ�� ������ �ּ���.");
				sAcctGu.focus();				
				return false;
			}
			v_job = "A"; //����
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			if (excelDs.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT_TP%>Tp010I",
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:������ �ŷ�����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("Sheet1","������ �ŷ�����.xls", 8);
		}

		<%//ȸ�� �ŷ�ó ��ȸ�ϱ�%>
		function fnPopVC(dirPath,row){	
	   		var arrParam	= new Array();
	   		var arrResult	= new Array();
	   		var strURL;	 
	   		var strPos;
	   		var origin_bp_sid;
	   		var origin_bp_nm;
	   		var origin_bid_site_kind;
	   			
	   		arrParam[0] = "0020";
	   		arrParam[1] = "�Ϲ���";

	   		
	   		strURL = dirPath+"/Account/jsp/gczm_vender_popup.jsp";
			strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	   		arrResult = showModalDialog(strURL,arrParam,strPos);	

	   		if (arrResult != null) {
	   			arrParam = arrResult.split(";");
	   			excelDs.namevalue(excelDs.rowposition, "VEND_CD")  		= arrParam[0];//�ŷ�ó�ڵ�
	   			excelDs.namevalue(excelDs.rowposition, "VEND_NM")  		= arrParam[1];//�ŷ�ó��
	   		} else {
	   			excelDs.namevalue(excelDs.rowposition, "VEND_CD")  		= "Z";
	   			excelDs.namevalue(excelDs.rowposition, "VEND_NM")  		= "�Ϲ���";
	   		}				
	     	
		}
		<%//GRID �ʱ�ȭ%>
		function fnReset(){	
			excelDs.ClearAll();
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
		
		if (v_job == "I"){//�׼�����
			for(i = 1; i <= excelDs.countrow; i++) {
				excelDs.namevalue(i, "TR_SID") = 7;
			}			
		};
	</script>

	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';

        if(v_job=="I") {	// �׼������� ��.
	        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            //�޽��� ó��
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);
        } else if(v_job == "H" || v_job=="S") {	// ��ȸ�� ��.
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	} else if(v_job == "A"){//�� �����
       		msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
       		fnSelect();	//����ȸ
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
	
		

	<%// �ŷ�ó �� %>	
	<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if(colid=="VEND_NM") {
			fnPopVC('<%=dirPath%>', row);
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
									<td><img src="<%=dirPath%>/Sales/images/reset.gif"  style="cursor:pointer" align=absmiddle onclick="fnReset()">
										<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" align=absmiddle onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:pointer" align=absmiddle onClick="fnExcelDs1();">
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
                        <td align="center" width="90px" height="30px" class="text">���¹�ȣ</td>
						<td align="left" bgcolor="#ffffff" width=300>&nbsp;
							
							<object id=sAcctGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=170 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^130">
							</object>
								
						</td>
						<td align="center" width="90px" class="text">��������</td>       
						<td bgcolor=#ffffff  valign="middle" align=left>&nbsp;
							<input type="text" name="file_path" value="" >&nbsp;
							
								<OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;"  >
									<param name="Text"		value="ã�ƺ���">
								</OBJECT>&nbsp;
								<img src="<%=dirPath%>/Sales/images/excel_apply.gif" style="cursor:pointer"  border='0' onClick='javascript:fnExcelApply();'>
							
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="35px">
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
					<tr>
						<td align=left width=90 class="text">�ŷ�����</td>
						<td align=left bgcolor="#ffffff" width=300>&nbsp;
						     
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
							&nbsp;-
						     
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
							
						</td>
						<td align="center" width="90px" height="30px" class="text">�� ��</td>       
						<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_Sum id=sTr_Sum></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height=10><td></td></tr>
		<tr height="100%">
			<td>
				<table border="0" cellpadding="0" cellspacing="0" width="845px" height="100%">
					<tr height="100%">
						<td>
							
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="1004px" height="400px" border="1">
							        <param name="DataID"            value="excelDs">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="true">
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
							        <param name="Format"            value="
											<C> name='���¹�ȣ'    	ID='TR_ACCT_CD' Width=100  align=center  edit=none editstyle=lookup data='codeDs1:detail:detail_nm'</C>
							                <C> name='�ŷ��Ͻ�'    	ID='COL01'  	Width=120  align=center  show=true 	edit=none</C>
							                <C> name='�ŷ�����'  	ID='COL02'    	Width=80  align=center  show=true	edit=none</C>
							                <C> name='����'      	ID='COL03'    	Width=120  align=left  show=true	edit=none</C>
							                <C> name='�ñ�� �ݾ�'  ID='COL04'   	Width=100  align=RIGHT  show=true	DEC=0 edit=none</C>
							                <C> name='���� �ݾ�'  	ID='COL05'  	Width=100  align=RIGHT show=true	DEC=0 edit=none</C>
							                <C> name='�����'   	ID='COL06'   	Width=100  align=center show=true	edit=none</C>
							                <C> name='TR_SID'    	ID='TR_SID'  	Width=100  align=left  show=false	edit=none</C>
							                <C> name='�ŷ�ó'    	ID='VEND_NM'  	Width=90  align=left  show=true	EditStyle=popup </C>
							                <C> name='�ڵ�'  		ID='VEND_CD'  	Width=50  align=left  show=true	edit=none </C>
							                <C> name='��������'		ID='FSDAT'  	Width=66  align=center show=true	edit=none</C>
							                <C> name='������ȣ'		ID='FSNBR'  	Width=60  align=center show=true	edit=none</C>
							        ">
							</object>
							
						</td>
					</tr>				
				</table>
				
			</td>
		</tr>

		<tr>
			<td>�� �׼� ��Ʈ�� �̸��� "<b>Sheet1</b>" �̾�� �մϴ�.(2016.06. KEB�ϳ����� ���� ��)</td>
		</tr>
	</table>
		
	<object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="tempExcelDs">
             <param name=BindInfo    value="
                <C>Col=EXCEL_INFO     Ctrl=gcip_file          Param=value</C>
                <C>Col=EXCEL_URL      Ctrl=gcip_file          Param=value</C>
              ">
      </object>		
      					

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

