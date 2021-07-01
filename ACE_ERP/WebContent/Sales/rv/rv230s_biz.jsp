<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ��Ͻ�û��Ȳ
 * ���α׷�ID   : RV230S
 * J  S  P      : rv230s
 * �� �� ��        : Rv230S
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-07-14
 * �������     :
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-09-28][�ɵ���] �׸��� ���� ����ϴ� ������ ����
 * [2011-06-22][�ڰ汹] ���뿡 ��Ͻ��ν�û �� �ο� �ϰ�������� ���� ���ε� �� �� �ְ� 
 								   ��ȸ �� �߰�.
 * [2015-08-20][�ɵ���] ���� ǥ�ؽ� ���� �ݿ�
 *						����Ʈ ��� ���� �ʿ�~
 * [2015-09-18][�ɵ���] �湮��û ��� �ϰ����
 * [2015-09-30][�ɵ���] �ּҺκ� ���� 
 * 						���� ��û��Ȳ ��Ʈ �߰�
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
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
            var div = "";
            var jobFlag = "";
        /*
         * �������ε�
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		cfStyleGrid(getObjectFirst("gr_cust"), "comn");
		cfStyleGrid(getObjectFirst("gr2"), "comn1");
		cfStyleGrid(getObjectFirst("gr_car"), "comn");
		cfStyleGrid(getObjectFirst("gr_car2"), "comn1");
		fnInit(); 
	} 
        
        /*
         * �ʱ��۾�
         * Header ���� 
         * ����
         */
        function fnInit() {
            div = 'init';
            ds_business.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_business.Reset(); //�����ڵ�
	        ds_dp_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM014&s_item1=Y";
	        ds_dp_time.Reset();	//���ð�
	        ds_ar_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_item1=Y";
	        ds_ar_time.Reset();	//�԰�ð�
			
            v_fr_depart_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
            v_to_depart_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        }
        //��ǰ��ȸ
		function fnSelectLcGoods() {
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			    + ",sSaupSid=" + v_business.ValueOfIndex("saup_sid", v_business.Index)
					+ ",sDepartDate=";
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			    "JSP(O:S_GOODS_DS=ds_goods)",
			    param);
			tr_post(tr1);
		};
        /*
         * ���� ��ȸ
         */
        function fnSelect() {
            var fr_date = v_fr_depart_date.Text.trim();
            var to_date = v_to_depart_date.Text.trim();
            if(fr_date.length!=8) {
                alert("�������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
                return;
            }
            if(to_date.length!=8) {
                alert("�������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
                return;
            }
        
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ v_business.ValueOfIndex("saup_sid", v_business.Index)
                      + ",v_goods_sid=" + v_goods_sid.ValueOfIndex("goods_sid", v_goods_sid.Index)
                      + ",v_client_sid=" + v_client_sid.value
                      + ",v_fr_depart_date=" + v_fr_depart_date.Text
                      + ",v_to_depart_date=" + v_to_depart_date.Text
                      + ",v_accept_no=" + v_accept_no.Text;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv230S",
                "JSP(O:DS_CUST=ds_cust,O:DS2=ds2,O:DS_CAR=ds_car,O:DS_CAR2=ds_car2)",
                param);
               
            tr_post(tr1);
        }
         
        function fnExcelDs1() {
            if(ds_cust.CountRow==0 && ds_tour.CountRow==0){
                alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                return;
            }
            getObjectFirst("gr_cust").SetExcelTitle(0, "");
            getObjectFirst("gr_cust").SetExcelTitle(1, "value:��� ��û��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_cust").GridToExcel("��� ��û��Ȳ", "��� ��û��Ȳ.xls", 8);        
            
            if(ds2.RowCount==0){
	            return;
	        }else{
		        getObjectFirst("gr2").SetExcelTitle(0, "");
		        getObjectFirst("gr2").SetExcelTitle(1, "value:�湮��û ��� �ϰ����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr2").GridToExcel("�湮��û ��� �ϰ����","�湮��û ��� �ϰ����.xls", 8);
	        }
            if(ds_car.RowCount==0){
	            return;
	        }else{
		        getObjectFirst("gr_car").SetExcelTitle(0, "");
		        getObjectFirst("gr_car").SetExcelTitle(1, "value:���� ��û��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr_car").GridToExcel("���� ��û��Ȳ","���� ��û��Ȳ.xls", 8);
	        }
            if(ds_car2.RowCount==0){
	            return;
	        }else{
		        getObjectFirst("gr_car2").SetExcelTitle(0, "");
		        getObjectFirst("gr_car2").SetExcelTitle(1, "value:���� �Ű� �ϰ����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr_car2").GridToExcel("���� �Ű� �ϰ����","���� �Ű� �ϰ����.xls", 8);
	        }
            
            
        }

        /**
         * �˻����� �븮��  �˾� 
         */
        function fnSelClientPopup(dirPath, servletPath) {
            v_cust_row = 0;
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            
            arrResult = fnClientPop(dirPath,'2');
        
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                v_client_sid.value = arrParam[0];
                v_client_nm.value = arrParam[1];
                v_client_cd.value = arrParam[2];
            } else {
                v_client_sid.value = "";
                v_client_nm.value  = "";
                v_client_cd.value = "";
            }               
        }

        /**
         * ��û�� ��ȣ ��ȸ
         */
        function fnAcceptNoPopup(dirPath, servletPath){
            v_cust_row = 0;
            var arrResult   = new Array();
            arrResult = fnAcceptNoPop(dirPath);
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                getObjectFirst("v_accept_sid").value = arrParam[0];
                getObjectFirst("v_accept_no").Text   = arrParam[1];
            }
        }

        </script>
        

<%
/****************************************************************************
            ���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language=JavaScript	for=ds_business event="OnLoadCompleted(row)">
		fnSelectLcGoods();
	</script>
	<script language=JavaScript for=v_business event=OnSelChange()>
		fnSelectLcGoods();//��ǰ ��˻�
	</script>
	<script language=JavaScript  for=ds_cust event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
        document.all.LowerFrame.style.visibility="visible"; 
    </script>
 
    <script language=JavaScript  for=ds_cust event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        document.all.LowerFrame.style.visibility="hidden";
        
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
        }
    </script>
    
    <script language="javascript" for="tr1" event="onsuccess()">
        msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
    </script>   
    
    
    <script language="javascript" for="tr1" event="OnFail()">
        document.all.LowerFrame.style.visibility="hidden";
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    
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

	<script language=JavaScript for=v_fr_depart_date event=OnKillFocus()>
		if( v_fr_depart_date.Modified == true )
			v_to_depart_date.text = v_fr_depart_date.text;
	</script>
<%
/*******************************************************************************
            ���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>

<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--��Ͻ��ν�û-->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_car classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_car2 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_business classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_dp_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���ð� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_ar_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �԰�ð� -->
    <param name="SyncLoad"  value="True">
</object>


<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ�ڵ� -->
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border='0' cellpadding='0' cellspacing='0'>	
  <tr>
	<td align='right'>
		<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:pointer"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
		<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
	</td>
  </tr>
  <tr height="5px">
	<td></td>
  </tr>
  <tr height="30px">
	<td>
		<table border='0' cellpadding='0' cellspacing='1' width='1002px' bgcolor="#666666">
		  <tr height='25px'>
			<td height="20" class="text">���»�</td>
		                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_client_cd' id='v_client_cd' style="width:60px;" class='input01' readOnly>
		           <input type="hidden" name='v_client_sid' id='v_client_sid'><img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelClientPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');">
		           <input type="text" name='v_client_nm' id='v_client_nm' style="width:120px;" class='input01' readOnly>
		       </td>
		       <td height="25" class="text">��û����ȣ</td>
		       <td bgcolor="#FFFFFF">&nbsp;
		           <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='110px' align='absmiddle' class='textbox'>            
		               <param name=Format      value="00000-000000000">
		               <param name=Alignment   value=1>
		               <param name=ClipMode    value=true>
		               <param name=Border      value=false>
		               <param name=Enable      value=true>
		               <param name=SelectAll   value=true>
		               <param name=SelectAllOnClick      value=true>
		               <param name=SelectAllOnClickAny   value=false>
		           </object>
		           <input type="hidden" name='v_accept_sid' id='v_accept_sid'>
		           <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onClick="fnAcceptNoPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')" id="v_accept_btn">
		       </td>
		   </tr>
		   <tr height='20px'>
		       <td align=left class="text" width="70">����</td>
		       <td align=left bgcolor="#ffffff">&nbsp;
		           <object id=v_business classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
		               <param name=ComboDataID     value=ds_business>
		               <param name=BindColumn      value="saup_sid">
		               <param name=BindColVal      value="saup_sid">
		               <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
		               <param name=ListExprFormat  value="saup_nm^0^120">
		           </object>
		           
		       </td>   
		       <td align=left class="text"  width="70">�������</td>
		       <td align=left bgcolor="#ffffff">&nbsp;
		           <object id=v_fr_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
		                        <param name=Text        value="">
		                        <param name=Alignment   value=1>
		<param name=Format      value="YYYY-MM-DD">
		                        <PARAM NAME=InputFormat value="YYYYMMDD">
		                        <param name=Cursor      value="iBeam">
		                        <param name=Border      value="false">      
		                        <param name=InheritColor      value="true">                                                                                                                                                                                                             
		                        <param name=ReadOnly    value="false">
		                        <param name=SelectAll   value="true">
		                        <param name=SelectAllOnClick    value="true">
		                        <param name=SelectAllOnClickAny   value=false>
		                    </object> ~ 
		                    <object id=v_to_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
		                        <param name=Text        value="">
		                        <param name=Alignment   value=1>
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
		                                                                                                 
		                </td>                                                                                           
		                <td align=left class="text" width="70">��ǰ����</td>
		                <td align=left bgcolor="#ffffff">&nbsp;
		                    <object id=v_goods_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
		                <param name=ComboDataID     value=ds_goods>
		                <param name=ListExprFormat  value="goods_nm^0^150"></object>
		            &nbsp;   
		        </td>
		    </tr>
		</table>
    </td>
  </tr> 
  <tr height='30px'>
	<td>&nbsp;</td>
  </tr>
  <tr>
	<td valign="top" height='360px'>
		<table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
		  <tr>
			<td valign='top'>
                           
			<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:12; top:180; width:1002; height:20">
				<param name="BackColor"			value="#00ffff">
				<param name="DisableBackColor"	value="#ffffee">
				<param name="Format"			value='
					<T>divid="mxTab_page1"	title="��� ��û��Ȳ"</T>
					<T>divid="mxTab_page2"	title="�湮��û ��� �ϰ����"</T>
					<T>divid="mxTab_page3"	title="���� ��û��Ȳ"</T>
					<T>divid="mxTab_page4"	title="�ڵ������� �Ű��� �ϰ����"</T>
					'>
			</object>
	
			<div class=page id="mxTab_page1" style="position:absolute; left:12; top:200; width:1002; height:300">
				<object id=gr_cust classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='350px' border='1'>
					<param name="DataID"            value="ds_cust">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="true">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name=ViewSummary  value="1">
					<param name=SortView  value="right">
					<param name="Format"        value="
						<C> name='��'			ID='{CURROW}'			width=40 align=center Edit=None</C>
						<C> name='����'		ID='COMPANY_NM'		width=100 align=left Edit=None suppress=1 sumtext=�� sort = true</C>
						<C> name='����'		ID='POSITIONS'			width=60 align=left Edit=None </C>
						<C> name='����'		ID='CUST_NM'				width=60 align=center Edit=None sumtext=@count sort = true</C>
						<C> name='�������'		ID='BIRTH_DATE'	width=70 align=left Edit=None sumtext=�� sort = true</C>
						<C> name='��� ��'			ID='ADDRESS1'	width=80 align=left Edit=None </C>
						<C> name='�湮����'		ID='VISIT_AIM'		width=100 align=left Edit=None sort = true</C>
						
						<C> name='�湮�Ⱓ'		ID='VISIT_DATES'	width=130 align=center Edit=None</C>
						 <G> name='�ⱹ����'
						<C> name='����'				ID='DEPART_DATE'	width=50 align=center Edit=None</C>
						<C> name='�ð�'				ID='DEPART_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_dp_time:detail:detail_nm' </C>
						 </G>
						 <G> name='�Ա�����'
						<C> name='����'				ID='ARRIVE_DATE'	width=50 align=center Edit=None</C>
						<C> name='�ð�'				ID='ARRIVE_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_ar_time:detail:detail_nm' </C>
						 </G>	
						<C> name='�������\\���⿩��'	ID='VISIT_K_LIST'	width=60 align=center Edit=None bgColor={IF(VISIT_K_LIST='����','#ffcccc','#FFFFFF') }</C>
						<C> name='�ǹ���ȣ'		ID='WORK_NO'			width=100 align=center Edit=None</C>
						<C> name='����'				ID='GENDER'			width=40 align=center Edit=None</C>
						<C> name='�Է���'			ID='I_EMPNM'			width=60 align=center Edit=None</C>
						<C> name='�ֹ�/����'		ID='MANAGE_NO'		width=100 align=center Edit=None</C>
						<C> name='��ǰ��'			ID='GOODS_NM'		width=100 align=left Edit=None </C>
						<C> name='���ǵ��'		ID='ROOM_TYPE_CD'	width=60 align=center Edit=None</C>
						<C> name='���ǹ�ȣ'		ID='ROOM_NO'			width=60 align=center Edit=None</C>
						<C> name='�Է��Ͻ�'		ID='I_DATE'					width=80 align=left Edit=None</C>
						<C> name='�����Ͻ�'		ID='U_DATE'					width=80 align=left Edit=None</C>
						<C> name='�����ȣ'		ID='RSV_SID'				width=80 align=left Edit=None</C>
						<C> name='�����\\����'	ID='n_card_gu'		width=60 align=left Edit=None</C>
					">                             
				</object>   
			</div>
			<div class=page id="mxTab_page2" style="position:absolute; left:12; top:200; width:845; height:300">
				<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='350px' border='1'>
					<param name="DataID"            value="ds2">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="FALSE">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name=ViewSummary  value="1">
					<param name=SortView  value="right">
					<param name="Format"        value="
						<C> name='��ܱ���\\����(*)'  	ID='LIVE_OUT_YN'  	width=70 align=center editlimit=30 show=true  SumText=@count SumTextAlign=right</C>
						<C> name='�ֹε�Ϲ�ȣ'			ID='REGI_NO'		width=100 align=center Edit=None SumText='��' SumTextAlign=left</C>
						<C> name='���ǹ�ȣ'				ID='PASS_NO'		width=100 align=center Edit=None</C>
						<C> name='����(*)'				ID='CUST_NM'		width=70 align=center Edit=None  sort = true</C>
						<C> name='����\\(����)'			ID='NAME_CHINESE'	width=60 align=center Edit=None  </C>
						<C> name='����\\(����)'			ID='NAME_ENG'		width=60 align=center Edit=None  </C>
						<C> name='����ȭ(*)'			ID='TEL_NO'			width=100 align=center Edit=None</C>
						<C> name='�޴���ȭ'				ID='MOBILE_NO'		width=100 align=center Edit=None</C>
						<C> name='�����(*)'			ID='COMPANY_NM'		width=100 align=center Edit=None sort = true</C>
						<C> name='����(*)'				ID='POSITIONS'		width=60 align=center Edit=None </C>
						<C> name='������ȭ'				ID='TEL_CM'			width=100 align=center Edit=None</C>
						<C> name='�������ȣ(*)'		ID='ZIP_CD'			width=80 align=center Edit=None</C>
						<C> name='���ּ�1(*)'    		ID='ADDRESS1'   	width=150 align=center editlimit=50 show=true</C>
						<C> name='���ּ�2(*)'    		ID='ADDRESS2'   	width=150 align=center editlimit=50 show=true</C>
						<C> name='�湮����'				ID='NORTH_CNT'		width=60 align=center Edit=None</C>
						<C> name='����(cm)'				ID='HEIGHT'			width=60 align=center Edit=None </C>
						<C> name='���Դ�ü��'			ID='FAX_NO'			width=70 align=center Edit=None</C>
						<C> name='��ü��å'				ID='FAX_NO'			width=60 align=center Edit=None</C>
						<C> name='�������'    			ID='BIRTH_DATE'   	width=60 	align=center editlimit=50 show=true</C>
						<C> name='����'					ID='GENDER'			width=40 align=center Edit=None</C>
						<C> name='����'     			ID='NATION_NM'    	width=50 	align=center editlimit=60 show=true </C>
						<C> name='������ȿ�Ⱓ\\������'	ID='PASS_ISSUE_DATE'		width=90 align=center Edit=None</C>
						<C> name='������ȿ�Ⱓ\\������'	ID='PASS_EXPIRE_DATE'		width=90 align=center Edit=None</C>
						<C> name='������������\\���ǿ���(*)'	ID='PRVC_AGREE'		width=80 align=left Edit=None</C>
					">                             
				</object>
			</div>   

			<div class=page id="mxTab_page3" style="position:absolute; left:12; top:200; width:1002; height:300">
				<object id=gr_car classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='350px' border='1'>
					<param name="DataID"            value="ds_car">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="false">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name=ViewSummary  value="1">
					<param name=SortView  value="right">
					<param name="Format"        value="
						<C> name='��'			ID='{CURROW}'			width=40 align=center Edit=None sumtext=�� </C>
					  <G> name='���»�'
						<C> name='�ڵ�'		ID='CLIENT_CD'		width=50 align=center Edit=None suppress=1 sumtext=@CNT </C>
						<C> name='�̸�'		ID='CLIENT_NM'		width=80 align=left Edit=None suppress=1 sumtext='��' SumTextAlign=left sort=true</C>
					  </G>
					  <G> name='�ⱹ����'
						<C> name='����'				ID='DEPART_DATE'	width=60 align=center Edit=None </C>
						<C> name='�ð�'				ID='DEPART_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_dp_time:detail:detail_nm'  sort=true</C>
						<C> name='������'			ID='DP_DRIVER'		width=60 align=center Edit=None </C>
					  </G>
					  <G> name='�Ա�����'
						<C> name='����'				ID='ARRIVE_DATE'	width=60 align=center Edit=None</C>
						<C> name='�ð�'				ID='ARRIVE_TIME'	width=80 align=center Edit=None editstyle=lookup data='ds_ar_time:detail:detail_nm'  sort=true</C>
						<C> name='������'			ID='AR_DRIVER'		width=60 align=center Edit=None </C>
					  </G>
					    <C> name='�Ҽ�'       		ID='tt_client_nm'   align=left	width=80 	show=true   sort=true </C>
		                <C> name='����SID'      	ID='car_sid'    	align=left width=100 	show=false</C>
						<C> name='����'       		ID='car_nm'      	align=center width=80 	show=true  	</C>
						<C> name='����\\��Ϲ�ȣ'	ID='CAR_NO'	  		align=center Width=60   Edit=None 	sort=false</C>
						<C> name='����' 			ID='CAR_TYPE' 	  	align=left Width=70   	Edit=None</C>
						<C> name='�������' 		ID='car_desc'       align=left width=110 	editlimit=100 	show=true  </C>
					">                             
				</object>   
			</div>

			<div class=page id="mxTab_page4" style="position:absolute; left:12; top:200; width:1002; height:300">
				<object id=gr_car2 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='350px' border='1'>
					<param name="DataID"            value="ds_car2">
					<param name="ColSizing"         value="true">
					<param name="Editable"          value="false">
					<param name="SuppressOption"    value="1">
					<param name="BorderStyle"       value="0">
					<param name=ViewSummary  value="1">
					<param name=SortView  value="right">
					<param name="Format"        value="
						<C> name='������Ϲ�ȣ\\(*)'	 ID='CAR_NO'		width=80 align=center Edit=None suppress=1 sumtext='��' </C>
						<C> name='������Ī'				 ID='CAR_NM'		width=80 align=left Edit=None suppress=1 sumtext=@cnt SumTextAlign=center sort=true</C>
						<C> name='����\\����'			 ID='TT_CAR_TYPE'	width=40 align=center Edit=None sumtext='��' SumTextAlign=left </C>
						<C> name='�����߷�\\(��)(*)'	 ID='TT_CAR_KG'		width=60 align=center Edit=None </C>
						<C> name='��������\\(��)'		 ID='TT_CAR_PERSONS'	width=60 align=center Edit=None </C>
						<C> name='����Ⱓ\\������(*)'	 ID='TT_BGNDATE'	width=70 align=center Edit=None</C>
						<C> name='����Ⱓ\\������'		 ID='TT_ENDDATE'	width=70 align=center Edit=None</C>
						<C> name='�����Ҽ�'				 ID='TT_CLIENT_NM'	width=100 align=left Edit=None </C>
						<C> name='����\\����'			 ID='TT_GUBN'		width=40 align=center Edit=None </C>
					    <C> name='����\\Ƚ��'     		 ID='TT_COUNT'   	align=center	width=40 	show=true </C>
		                <C> name='����\\�뵵(*)'       ID='TT_USE'    	align=center width=50 	show=true</C>
						<C> name='������\\�����(*)'   ID='TT_START'     	align=center width=70 	show=true</C>
						<C> name='������\\��������(*)' ID='TT_SITE'	 	align=center Width=70   Edit=None</C>
						<C> name='����������\\����ó(*)' ID='TT_ISSUE' 	  	align=center Width=70   	Edit=None</C>
						
					">                             
				</object>   
			</div>


		</td>
	  </tr>
	</table>
	</td>
  </tr>
  <tr>
	<td>�� �ش� ���ڿ� �湮 ��û�Ǿ� �ִ� �ο�, ������ ������ ǥ���մϴ�.<br>
		�� ������ ����, ���� ������ ����>���԰�ȹ>���� ž��(���), ���� ž��(�԰�) �޴����� ó���մϴ�.<br>
		�� ��� ��û��Ȳ : �Ϲ� �����<br>
		�� �湮��û ��� �ϰ���� : �Ϲ� ����� + ���� + ��û �����

	</td>
  </tr>
</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>