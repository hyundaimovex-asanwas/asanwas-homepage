<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : erp ����� ���� ����
 * ���α׷�ID  	: SY010I
 * J  S  P   	: Sy010i
 * �� �� ��     : Sy010I
 * �� �� ��     : �ɵ���
 * �� �� ��     : 2014-07-10
 * �������     : 
 * [ �������� ][������] ����
 * [2014-07-10][�ɵ���] erp �α� ����ڰ���
 *						�� ������� ���� �� COMMON.GD0083�� ���� �̷��� ���´�.
 *						�� ���� ���� �� COMMON.GD0083�� ���� �̷��� ���´�.
 *			�ű� ���� ������
 * [2015-06-12][�ɵ���] ��й�ȣ �ʱ�ȭ
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="config.common.*"%>

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
		
	}
	
   
   //����ȸ
   function fnInit(){
	   
        v_job = "H";
        
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        

 		//�۾�����1 - SY011�� ���(Y)/�ߴ�(N) 2���� �ִ�. 
        ds_use.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY011&s_Item2=Y";
        ds_use.Reset();
 		
        
   }

   
   
   
   
	<%//������ȸ%>
    function fnSelect() {
    	
		v_job = "S";
		
           msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           
           var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			           + ",sEmpno=" + v_empno.Text
			           + ",sStatus="+ lc_status1.ValueOfIndex("detail", lc_status1.Index);

           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_SY%>Sy010I",
               "JSP(O:Main=ds1)",
               v_param);
           
           tr_post(tr1);
           
    }


	<%// ���%>
	function fnCancel() {
		
        ds1.undoall();
        
		msgTxt.innerHTML="������ ������ ��ҵǾ����ϴ�.";
		
		return;		
		
	}

	
	
	<%// �׸��� �����%>
	function fnAddRow() {
		
		ds1.AddRow();
		
	}
	
	
	
	<%// �׸��� �����%>
	function fnDeleteRow() {
		
		ds1.DeleteRow(ds1.RowPosition);
		
	}
	
	
	
	<%//���� (�űԸ޴� ���� ��û)- �����ڰ� Ȯ�� �� ������ �������ִ� ��.. ��û �ǰ�������.. ;; %>
	function fnApply() {
		
		if (ds1.IsUpdated) {
			
			v_job = "A";
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy010I",
			    "JSP(I:DS1=ds1)",
			    param);
			
			tr_post(tr1);  
			

		} else {
			alert("������ ���� �����ϴ�.");

		};
	}

	
	
	<%// pw�ʱ�ȭ%>	
	function fnReset(empid) {
		
		v_job = "R";
		
		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
			+ ",sEmpno=" + empid;
		
		
		ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy010I",
		    "JSP(I:DS2=ds1)",
		    param);
		
		
		tr_post(tr1);  	
		
		
		
	}	

	
	
	
	
    <%//���� ��- �˻����� ó���� : �����ڸ� �����ϰ�%>
    function fnEmpNoPopup(dirPath){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		
    		v_empno.text = arrParam[1];
    		//v_eno_nm.value = arrParam[0];

    		
        } else {
        	
			//fnEmpNoCleanup();
			
        }               
    	
    }		
	
	
</script>

<%
/*=============================================================================
         Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
		if(colid=="PW_RESET"){
			if(confirm( "��� ["+ds1.NameValue(row, "EMPID")+ "] �� �ʱ�ȭ�Ͻðڽ��ϱ�?" )){
				fnReset(ds1.NameValue(row, "EMPID"));
			};
		}
	</script>
<%
/*=============================================================================
         Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">
	msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    if(v_job=="A"){
    	alert("����Ǿ����ϴ�.");
	    //for(var i=1; i<=ds1.CountRow; i++){
	        //ds1.NameValue(i, "CHK") = "T";
	    //}    	
    }
    if(v_job=="R"){
    	alert("�ʱ�ȭ�Ǿ����ϴ�.");
    }
</script>

<script language="javascript" for="tr1" event="OnFail()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";

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


<%
/*=============================================================================
         DataSet Components(DS) ����
=============================================================================*/
%>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_use classid=<%=HDConstant.CT_DATASET_CLSID%>>
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

</head>
<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td>
		<table border="0" width="1000px"  cellpadding="0" cellspacing="0">
		  <tr>
			<td align="right">
				<table border="0"  cellpadding="0" cellspacing="0" width="100%">
				  <tr>
					<td align="right" height="30px">
					    <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRow()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDeleteRow()" >
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer" onclick="fnCancel()">
						<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:pointer" onclick="fnApply()">
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		  <tr>
			<td height='5px'></td>
		  </tr>
		  <tr>
			<td>
			  <table width=1000 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
				<tr height="25px">
                  <td width="100px" class="text">���
                  </td>
                  <td align="left" bgcolor="#ffffff">&nbsp;
                    <object id=v_empno classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>
                        <param name=Format      value="0000000">
                        <param name=Alignment   value=1>
                        <param name=ClipMode    value=true>
                        <param name=Border      value=false>
                        <param name=SelectAll   value=true>
                        <param name=SelectAllOnClick      value=true>
                        <param name=SelectAllOnClickAny   value=false>
                    </object>
	  				<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle onclick="fnEmpNoPopup('<%=dirPath%>');" alt="���� ã��" style="cursor:hand;">
                  </td>
				  <td align="center" width="70px"  class="text">��� ����</td>
				  <td align="center" bgcolor=#ffffff>
                    <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=80 width=80 border="0" align=absmiddle>
						<param name=ComboDataID		value=ds_use>
						<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
						<param name=ListExprFormat  value="detail_nm^0^80">
					</object>	
				  </td>
				</tr>
			  </table>
			</td>
		  </tr>
		  <tr>
			<td height='5px'></td>
		  </tr>		  
		  <tr>
			<td width="845px">
				<table  border="0" cellpadding="0" cellspacing="0" >
				  <tr valign="top"">
					<td width=845>
					    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=1000px; height:530px" border="1">
					        <param name="DataID"            value="ds1">
					        <param name="BorderStyle"       value="0">
					        <param name="ColSizing"         value="true">
					        <param name="editable"          value="True">
					        <Param Name="UsingOneClick"     value="1">
					        <Param Name="AllShowEdit"       value="True">
					        <param name="SuppressOption"    value="1">
					        <param name="ViewSummary"   	value="1">
					        <param name="SortView"			value="Right">
					        <param name="Format"            value="
					            <C> name='üũ'      	ID='CHK'   	 	Width=50  	align=center 	EditStyle=CheckBox edit=True </C>
					            <C> name='���'     	ID='EMPID'   	Width=80  	align=center 	Sort=True</C>
					            <C> name='���̵�'      	ID='AED'     	Width=100  	align=center 	Sumtext=@cnt bgColor={IF(AED='aed','#FFFF00','#FFFFFF')}</C>
					            <C> name='�̸�'      	ID='EMPNM'   	Width=80  	align=center  </C>
					            <C> name='�����Ͻ�'    	ID='I_TIME'   	Width=140  	align=center  	edit=none</C>
					            <C> name='���' 	    ID='YN_USE'    	Width=70  	align=center 	editstyle=lookup data='ds_use:detail:detail_nm' bgColor={IF(YN_USE='N','#FFFF00','#FFFFFF')} </C>
					            <C> name='�μ�'      	ID='DPT_NM'   	Width=120  	align=center  	edit=none Sort=True</C>
					            <C> name='����'      	ID='JOB_NM'   	Width=110  	align=center  	edit=none</C>
					            <C> name='�����'      	ID='RET_YMD'   	Width=90  	align=center  	edit=none</C>
					            <C> name='����'      	ID='USE_YN'  	Width=50  	align=center  	edit=none bgColor={IF(USE_YN='N','#FFFF00','#FFFFFF')}</C>
					            <C> name='PW�ʱ�ȭ'    	ID='PW_RESET' 	Width=80  	align=center 	edit=none </C>
					        ">
					    </object>
					</td>
				  </tr>
				</table>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
  <tr>
	<td style="padding-top:6px">�� ��� �÷��� �����ϸ� �� COMMON.GD0083�� ���� �̷��� ����<br>
	�� ������ �����ϸ� �� COMMON.GD0083�� ���� �̷��� ����<br>
	�����̵� = "aed" �� ���� ���� �� �ش� ������ ���̵� ������ ���� ����Դϴ�.<br>
	�� ������ ������ �� : ���=�ߴ����� ��ȸ �� ���, ���̵�, �̸��� �Է� �� ����<br>
	���� COMMON.GD0083�� ���� �̷��� ����<br>
	�� PW�ʱ�ȭ �÷��� ����Ŭ���ϸ� �� hda���! �� �ʱ�ȭ�˴ϴ�. �� ���� �� �� �����մϴ�.^^<br>
	��
	��

	</td>
  </tr>

</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

