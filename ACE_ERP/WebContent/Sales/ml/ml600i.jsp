<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ��������� �ſ�ī�� �ŷ����� ���ε�
 * ���α׷�ID 	: Ml600I
 * J  S  P		: ml600i
 * �� �� ��		: Ml600I
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2010-12-28 
 * [ �������� ][������] ����
 * [2012-12-28][�ɵ���] ���� ����
 * [2013-12-27][�ɵ���] ���� �׽�Ʈ
 * [2014-01-10][�ɵ���] ��ȸ, ����, �ٿ�, ���ε�! �� �ֳ� ����...
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
			
			fnInit();
			
			if (excelDs.countrow<1){
				var s_temp = "COL00:STRING(2),COL01:STRING(10),COL02:STRING(12),COL03:STRING(8),COL04:STRING(4),COL05:STRING(20),COL06:STRING(13),"
						 	+ "EXCH_RATE:DECIMAL(10.2),COL08:DECIMAL(10),COL09:STRING(10),COL10:STRING(1),"
						 	+ "COL11:DECIMAL(10),COL12:STRING(8),COL13:STRING(20),COL14:STRING(4),"
						 	+ "COL15:STRING(2),COL16:STRING(14),COL17:STRING(8),ORDER_SID:DECIMAL(10)";						 	
				//����� decimal(10)��  �ϴ°� ������.
				excelDs.SetDataHeader(s_temp);
			}
		}		

		/*
		 * �ʱ��۾�
		 */
		function fnInit(){
			sBgnDate.text='<%=firstday%>';
			sEndDate.text='<%=firstday%>';
		    	   
			//�ŷ�����
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML001&s_item1=Y";
            codeDs1.Reset();

        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_ML%>Ml600I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);            
		}

		/**
		 * �������� 
		 * ���� ���ε� �Ŀ� ��ȸ 
		 */
		function fnExcelApply()  {
			v_job = "I";			
//			if(sAcctGu.ValueOfIndex("detail", sAcctGu.Index)=="") {
//				alert("�������� ���� ���¹�ȣ�� ������ �ּ���.");
//				sAcctGu.focus();
//				return false;
//			}
			tempExcelDs.addrow();
		 	
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 	
		 	//alert(file_path.value);	//�̰� ����. ���� tempExcelDs�� �ʱ�ȭ ���� ����. .
		 	//alert("info="+tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO"));//���Ⱑ undefined
		 	//alert("url="+tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL")); 
		 
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	//���Ⱑ Ÿ���� ��ġ��!!!^^
                    + ",sTrGu=01";	//+ sTrGu.ValueOfIndex("detail", sTrGu.Index);
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_ML%>Ml600I",
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
		            + ",sTr_OrderNm=" + sTr_OrderNm.value
                    + ",sTrGu=01"; //+ sTrGu.ValueOfIndex("detail", sTrGu.Index);
                    
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml600I",
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        tr_post(tr1);
		}
		
	
			
		/*
		 * ����
		 */
		function fnApply() {

			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			if (excelDs.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_ML%>Ml600I",
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:���� ������; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("Sheet1","���� ������.xls", 8);
		}
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language=JavaScript  for=excelDs event="OnLoadCompleted(row)">
		//alert("excelDs �ε� ��");
		//alert("v_job==="+v_job);
		if (excelDs.countrow <= 0) {
			return;
		}
		
		if (v_job == "I"){
			//alert("�����?");
			for(i = 1; i <= excelDs.countrow; i++) {
				excelDs.namevalue(i, "ORDER_SID") = 7;	//java���� 10���� ������������ �ڲ� 0���� �޾ƿ�. �׷��� 7�� ����.
			}			
		};
	</script>

	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';

        if(v_job=="I") {	// �Է��� ��.
	        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            //�޽��� ó��
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);
        }  else if(v_job == "H" || v_job=="S") {	// ��ȸ�� ��.
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
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
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>


</head>
<jsp:include page="/Common/sys/body_s05.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	
									
	<table border="0" cellpadding="0" cellspacing="0" width=845>
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td align="right" valign="middle">
							<table>
								<tr>
									<td><img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
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
                        <td align="center" width="90px" height="30px" class="text">�ŷ�����</td>
						<td align="left" bgcolor="#ffffff" width=300>&nbsp;<b>����������</b>
						</td>
						<td align="center" width="90px" class="text">��������</td>       
						<td bgcolor=#ffffff  valign="middle" align=left>&nbsp;
							<input type="text" name="file_path" value="" >&nbsp;
							<OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:70; height:20;" class="textbox">
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
						<td align=left width=90 class="text">�ֹ�����</td>
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
						<td align="center" width="90px" height="30px" class="text">�ֹ��ڸ�</td>       
						<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_OrderNm id=sTr_OrderNm class="textbox"></td>
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
							
							<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1 width="845px" height="400px" border="1">
							        <param name="DataID"            value="excelDs">
							        <param name="BorderStyle"       value="0">
							        <param name="ColSizing"         value="true">
							       	<param name="IndWidth"  		value="20">
							        <param name="editable"          value="false">
							        <param name=SortView  			value="Left">
							        <param name="indwidth"			value="20">
							        <param name="Format"            value="
<C> name='�ŷ�\\����'	ID='COL00'  	Width=40  align=center  show=true 	</C>
<C> name='����ó'    	ID='COL01'  	Width=55  align=center  show=true 	</C>
<C> name='�ֹ���ȣ'    	ID='COL02'  	Width=80  align=center  show=true 	</C>
<C> name='�ֹ�����'    	ID='COL03'  	Width=65  align=center  show=true 	</C>
<C> name='�Ϸ�\\��ȣ'  	ID='COL04'  	Width=50  align=center  show=true 	</C>
<C> name='�ֹ��ڸ�'   	ID='COL05'  	Width=70  align=center  show=true 	</C>
<C> name='����ó1'      ID='COL06'  	Width=80  align=left    show=true 	</C>
<C> name='ȯ��'         ID='EXCH_RATE'  	Width=50  align=right	show=true decao=2</C>
<C> name='�̿�\\����'	ID='COL08'  	Width=45  align=right	show=true decao=0</C>
<C> name='����\\���'   ID='COL09'  	Width=60  align=center  show=true 	</C>
<C> name='����\\����' 	ID='COL10'  	Width=30  align=center  show=true 	</C>
<C> name='���� �ݾ�' 	ID='COL11'  	Width=70  align=right	show=true decao=0	</C>
<C> name='ī���'      	ID='COL12'  	Width=70  align=center  show=true 	</C>
<C> name='ī���ȣ'    	ID='COL13'  	Width=110 align=center  show=true 	</C>
<C> name='��ȿ\\�Ⱓ'   ID='COL14'  	Width=50  align=center  show=true 	</C>
<C> name='�Һ�\\������' ID='COL15'  	Width=50  align=center  show=true 	</C>
<C> name='�����Ͻ�'    	ID='COL16'  	Width=100 align=center  show=true 	</C>
<C> name='���ι�ȣ'    	ID='COL17'  	Width=60  align=center  show=true 	</C>
<C> name='ORDER_SID'   	ID='ORDER_SID' 	Width=70  align=left  	show=true decao=0	</C>
					        ">
							</object>
							
						</td>
					</tr>				
				</table>
				
			</td>
		</tr>

		<tr>
			<td><br>�� �׼� ��Ʈ�� �̸��� <b>"kaesong"</b> �̾�� �մϴ�.</td>
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

