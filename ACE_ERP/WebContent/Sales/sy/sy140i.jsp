<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ��ü �޴� ��ȸ �� ���� ��û!
 * ���α׷�ID  	: SY140I
 * J  S  P   	: Sy140i
 * �� �� ��     : Sy120I
 * �� �� ��     : ������
 * �� �� ��     : 2006-09-10
 * �������     : �޴���ȸ ���� ��û
 * [ �������� ][������] ����
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
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
        <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>	
<script language="javascript">
    var v_job = "H";

    var v_Main_row = 0;

   //�������ε�
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
		fnSelect();
	}
	
   //����ȸ
   function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        cfStyleGrid(getObjectFirst("gr2"), "comn");
        
		fnSetHeader(); //ds2 ������� 
		
 		//�۾�����1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_Item1=Y";
        ds_status1.Reset();
 		
   }

   /*
    * ������ȸ
    */
    function fnSelect() {
      if (ds1.isUpdated) {
         alert("�������� ���� �ֽ��ϴ�.");
            return;
      } else {
		v_job = "S";
           window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1";

           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_SY%>Sy140I",
               "JSP(O:Main=ds1,O:Sub=ds2)",
               v_param);
           tr_post(tr1);
       }
    }


	// ���
	function fnCancel() {
        ds2.undoall();
		window.status="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}

	//���� (�űԸ޴� ���� ��û)- �����ڰ� Ȯ�� �� ������ �������ִ� ��.. ��û �ǰ�������.. ;;
	function fnApply() {
		if (ds2.IsUpdated) {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy140I",
			    "JSP(I:DS2=ds2,O:RESULT=ds_result)",
			    param);
			   
			tr_post(tr1);  
			
			fnSelect();
		} else {
			alert("������ ������ �����ϴ�.");
		};
	}


	// ����
	function fnExcelDs1() {
		if(ds1.RowCount==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        } 
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:�޴������ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�޴������ȸ","�޴������ȸ.xls", 8);
	}

	// ����Ÿ�� ��� ����
	function fnSetHeader(){
		if (ds2.countrow < 1){
			var s_temp1 = "AUTH_RQ:STRING,TREE_IDX:INTEGER,TREE_NM4:STRING,U_DATE:STRING";
			
			ds2.SetDataHeader(s_temp1);
		}
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
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="OnFail()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr2.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="")
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);
</script>


<%
/*=============================================================================
         DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=javascript for=ds2 event="OnLoadCompleted(Row)">
    if(Row==0) return;
</script>

<script language=javascript for="gr1" event="OnDblClick(Row, Colid)">
    if(Row<1) return;
	
	if(ds1.namevalue(Row,"TREE_LV")=="4" && "F"==ds1.namevalue(Row,"AUTH_RQ") ){
		if(ds2.countrow>0){
			var exsts ="n";
	    	for (i = 1; i <= ds2.countrow; i++) {//ds2 ���� 
	    		if(ds2.namevalue(i,"TREE_IDX")==ds1.namevalue(Row, "TREE_IDX")) {
	 	   			alert("�̹� ��û�� �޴��Դϴ�.");
	 	   			exsts ="y";
	 	   			return;
	 	   		};
			};
			
			if(exsts="n"){
				ds2.addRow();
				ds2.namevalue(ds2.rowposition,"AUTH_RQ") 	= "RR";
				ds2.namevalue(ds2.rowposition,"TREE_IDX") 	= ds1.namevalue(Row, "TREE_IDX");
				ds2.namevalue(ds2.rowposition,"TREE_NM4") 	= ds1.namevalue(Row, "TREE_NM4");
				ds2.namevalue(ds2.rowposition,"U_DATE") 	= "<%=firstday%>";
	    	};
	    }else{
				ds2.addRow();
				ds2.namevalue(ds2.rowposition,"AUTH_RQ") 	= "RR";
				ds2.namevalue(ds2.rowposition,"TREE_IDX") 	= ds1.namevalue(Row, "TREE_IDX");
				ds2.namevalue(ds2.rowposition,"TREE_NM4") 	= ds1.namevalue(Row, "TREE_NM4");
				ds2.namevalue(ds2.rowposition,"U_DATE") 	= "<%=firstday%>";
	    };
	}else{
		alert("4�����̰� ������ ���� �޴��� �����մϴ�.");
	}


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
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

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
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td>
		<table border="0" width="845px"  cellpadding="0" cellspacing="0">
		  <tr>
			<td align="right" colspan="2">
				<table border="0"  cellpadding="0" cellspacing="0" width="100%">
				  <tr>
					<td align="right" height="30px">
					    <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
						<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->					    
						<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply()">
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		  <tr>
			<td height='5px'></td>
		  </tr>
		  <tr>
			<td width="845px" colspan='2'>
				<table  border="0" cellpadding="0" cellspacing="0" >
				  <tr valign="top"">
					<td width=535>�� ��ü �޴� ����Ʈ<br>
					    <%=HDConstant.COMMENT_START%>
					    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=535px; height:360px" border="1">
					        <param name="DataID"            value="ds1">
					        <param name="BorderStyle"       value="0">
					        <param name="ColSizing"         value="true">
					        <param name="editable"          value="false">
					        <Param Name="UsingOneClick"     value="1">
					        <Param Name="AllShowEdit"       value="True">
					        <param name="SuppressOption"    value="1">
					        <param name="ViewSummary"    value="1">
					        <param name="Format"            value="
					            <C> name='����'      	ID='AUTH_RQ'   Width=40  align=center EditStyle=CheckBox Sumtext=��</C>
					            <C> name='����'     	ID='TREE_LV'   Width=40  align=center Sumtext=@cnt</C>
					            <C> name='�޴�ID'       ID='TREE_ID'      Width=60  align=left </C>
					            <C> name='�޴���ȣ'     ID='TREE_IDX'     Width=60  align=center </C>
					            <C> name='�޴���1'      ID='TREE_NM1'     Width=70  align=left suppress=1</C>
					            <C> name='�޴���2'      ID='TREE_NM2'     Width=70  align=left suppress=2</C>
					            <C> name='�޴���3'      ID='TREE_NM3'     Width=70  align=left suppress=3</C>
					            <C> name='�޴���4'      ID='TREE_NM4'     Width=100  align=left </C>
					        ">
					    </object>
					    <%=HDConstant.COMMENT_END%>
					</td>
					<td width=10></td>					
					<td width=300>�� ���� ��û<br>
					    <%=HDConstant.COMMENT_START%>
					    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2  style="width=300px; height:360px" border="1">
					        <param name="DataID"            value="ds2">
					        <param name="BorderStyle"       value="0">
					        <param name="ColSizing"         value="true">
					        <param name="editable"          value="salse">
					        <Param Name="UsingOneClick"     value="1">
					        <Param Name="AllShowEdit"       value="True">
					        <param name="Format"            value="
					            <C> name='����'     	ID='AUTH_RQ'	Width=50  align=center editstyle=lookup data='ds_status1:detail:detail_nm' edit=none</C>
					            <C> name='�޴���ȣ'     ID='TREE_IDX'	Width=60  align=center </C>
					            <C> name='�޴���4'      ID='TREE_NM4'   Width=100  align=left </C>
					            <C> name='��û��¥'     ID='U_DATE'		Width=70  align=center </C>
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
	<td style="padding-top:6px">�� ���� [��ü �޴� ����Ʈ]���� �ʿ��� �޴��� ����Ŭ���ϸ� ���� [���� ��û]�� ����� �����˴ϴ�.<br>
		�� �ʿ��� �޴��� �߰��Ͻ� �� ������ ������ �����ڿ��� ��û�˴ϴ�.<br>
		�� �� �޴��� �������� ��û�� ���� ������ �帮�� ���� ���� �ֽ��ϴ�.<br>
		����) <b>���Ȯ��, ȯ��ó��, ���� ����</b> ��
	</td>
  </tr>

</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

