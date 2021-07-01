<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ����Ȯ�����_PLZ
 * ���α׷�ID 	: RV810S_N
 * J  S  P		: rv810s_n
 * �� �� ��		: Rv810S_N
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-06
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-04-15][�ڰ汹] PLZ������..����Ȯ�����.
 * [2009-04-15][�ڰ汹] ��ǰ����, ��ü��� ��ȸ���� �߰�. 
 * [2009-11-17][�ɵ���] �丮������ ���� ���ǹ�ȣ, ���Ǹ�����,����(����)
 * [2009-12-24][�ɵ���] ���Ǹž� �� ������� + �ɼǿ������ �и�~
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
	
    <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
    <script language=javascript src="<%=dirPath%>/Sales/common/js/rv200i.js"></script>
    
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		 var div='';
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
				
			fnInit();
		} 
		 
		function fnInit() {
			sBgnDate.text='<%=firstday%>';	
			div = 'init';
	        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds2.Reset(); //�����ڵ�	        
		}
		
		/*
		 * ���ð�, ��ǰ��ȸ
		 */		
		function fnSelectDs3() {
		
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
				+ "sDepartDate=" + sBgnDate.text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
	            param);
	        tr_post(tr2);
		}	
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			if(sBgnDate.Text =="20081111") {
            	    alert("�ش� ���ڴ� ��ȸ �� �� �����ϴ�. ������ȸ(�����Ǹſ�) �޴��� �̿��� �ּ���.");
                	return;
	        }
        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sDepart_date=" + sBgnDate.Text
			          + ",sDepart_time=" + lc2.ValueOfIndex("depart_time", lc2.Index)
			          + ",sGoods_sid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sClient_sid=" + sClientSid.value
			          + ",v_accept_no=" + v_accept_no.Text
			          + ",sJobsel=" + sJobsel.value
			          + ",v_bound_seq=" + v_bound.ValueOfIndex("bound_seq", v_bound.Index)
			          + ",v_event_sid=" + v_event_sid.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv810S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
			
		/*
		 * ����
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:����Ȯ�����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("����Ȯ�����","����Ȯ�����.xls", 8);
		}
    	
		/**
	     * �˻����� �븮��  �˾� 
	     */
	    function fnSelectClientPopup(dirPath) {
	        
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	        
	        arrResult = fnClientPop(dirPath,'');
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            sClientNm.value = arrParam[1];
	            sClientSid.value = arrParam[0];
	        } else {
	          sClientNm.value = "";
	          sClientSid.value = "";
	        }               
	    }   

	// ��û�� ��ȣ ��ȸ
    function fnAcceptNoPopup(){
        v_cust_row = 0;
        var arrResult   = new Array();
        arrResult = fnAcceptNoPop("<%=dirPath%>");
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("v_accept_no").Text   = arrParam[1];
            
            fnSelectBound();
        }
    }

	//��ǰ����
	function fnSelectBound(){
	
	var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                  + ",v_accept_no=" + v_accept_no.Text;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv810S",
            "JSP(O:DS_BOUND=ds_bound)",
            param);
           
        tr_post(tr1);
    }
    
	//����Ȯ����  �˾�
	function popConfirm(rsv_sid){
		var receiptURL ="http://www.mtkumgang.com/preserv/res_print.jsp?rsv_sid=" + rsv_sid;
	   	window.open(receiptURL,"rsvConfirm","width=730,height=670,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize");

	}    
</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
	</script>	
	
	<script language=JavaScript	for=v_accept_no event="OnKillFocus()">
		fnSelectBound();
	</script>
	
	 <script language=JavaScript  for=ds_bound event="OnLoadCompleted(row)">
 		ds_bound.insertrow(1);
 		
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_SEQ") = "0";
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_NM") = "��ü";
		
		v_bound.Index = 0; 
    </script>
    
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		if ( sBgnDate.Modified ) {
//				div = 'init';
				fnSelectDs3();			
		}
	</script>

	<script language=JavaScript for= lc1 event=OnSelChange()>
//		if ( div != 'init' ) {	//����
//			div = 'init';			
			fnSelectDs3();
//		}
	</script>	
	
	<script language=JavaScript for= lc2 event=OnSelChange()>
//		if ( div != 'init' ) {	//���ð�
//			div = 'init';					
//		}
	</script>		
	
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
			fnSelectDs3();
	</script>
	
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
		div = "";		
	</script>	


	
	<script language=javascript for="gr1" event="OnDblClick(Row, Colid)">
		//����Ŭ�� >> �˾�ȣ��
	    if(Row==0) return;
	    popConfirm(ds1.namevalue(Row, "RSV_SID"));
	</script>

<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ð� -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ -->
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_bound classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ���� -->
    <param name="SyncLoad"  value="True">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td style="padding-bottom:6px"><img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=right onClick="fnExcelDs1()">		<!-- ���� -->
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=right onclick="fnSelect()"> 		<!-- ��ȸ -->
						</td>
					</tr>
					<tr>
						<td>
							<table border='0' cellpadding='0' cellspacing='1' bgcolor='#666666'>
								<tr>
									<td align="center" width="70px" height="30px" class="text" >�븮��</td>
									<td width=160 align="left"  bgcolor="#ffffff">&nbsp;
			                            <input type="text" name='sClientNm' id='sClientNm' value='' size='16' readonly='readonly'  class='textbox'>
			                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
			                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
									</td>
									 <td width="70px" height="25px" class="text">��û����ȣ</td>
		                             <td width=160 align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
		                                        <param name=Format      value="00000000000000">
		                                        <param name=Alignment   value=1>
		                                        <param name=ClipMode    value=true>
		                                        <param name=Border      value=false>
		                                        <param name=SelectAll   value=true>
		                                        <param name=SelectAllOnClick      value=true>
		                                        <param name=SelectAllOnClickAny   value=false>
		                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                                  </td>
                                  <td align=left class="text" width="60">��ǰ����</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_bound classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=50 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_bound>
                                            <param name=SearchColumn	value="BOUND_NM">
                                            <param name=BindColumn  	value="BOUND_SEQ">
                                            <param name=ListExprFormat  value="BOUND_NM^0^50">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                    <td width="60" height="25" class="text" >��ü���</td>
                                	<td width="200" colspan="4" bgcolor="#FFFFFF">&nbsp;<input name="v_event_no" id="v_event_no" type="text" style="width:60px;" class="input01" readOnly>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand;display:" id="v_event_btn" onclick="fnGroupPopup('<%=dirPath%>');">
                                    <input type=hidden name="v_event_sid" id="v_event_sid">
                                    <input name="v_event_nm" type="text" style="width:80px;" class="input01" readOnly>
                                    </td>  
					              </tr>
							</table>
						</td>
						<td>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text"  width="80">�������</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="YYYY-MM-DD">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny   value="false">																			
							</object>&nbsp;
						
	                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds3>
								<param name=BindColumn      value="depart_time">
	                            <param name=BindColVal      value="depart_time">
								<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
								<param name=ListExprFormat  value="depart_time_nm^0^50">
							</object>
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
						<td align=left class="text" width="80px">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds2>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align=left class="text" width="80">��ǰ����</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
								<%=HDConstant.COMMENT_START%>
	                        <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=90 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds4>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^140"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
						</td>
						<td align=left class="text" width="80px">������</td>
					    <td align="left" bgcolor="#ffffff">&nbsp;
			    				<select name="sJobsel"> 
				    				<option value="0" SELECTED>��ü</option>
									<option value="1">������</option>
									<option value="2">�����</option>
									<option value="3">���������</option>
								</select>
						</td>                                  
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              <FC> name='�븮���ڵ�'    	ID='client_cd'   	width=80	align=left editlimit=5 show=false </FC>
						              <FC> name='�븮����'    	ID='client_nm'   	width=100 	align=left editlimit=50 show=true suppress=1</FC>
						              <FC> name='��ġ��'        ID='empnm'       	width=50 	align=left editlimit=20 show=true</FC>
						              <FC> name='�����'    	ID='depart_date'   	width=50 	align=center editlimit=16 show=true</FC>
						              <FC> name='��ǰ��'      	ID='goods_nm'     	width=80 	align=left editlimit=30 show=true</FC>
						              <FC> name='��û����ȣ'    ID='accept_no'   	width=100 	align=left editlimit=16 show=true</FC>
						              <FC> name='����'      	ID='cust_nm'     	width=60 	align=left editlimit=30 show=true</FC>
						              <C> name='����/����'   		ID='company_nm'  	width=200 	align=left editlimit=61 show=true</C>
						              <C> name='��������ȣ'    	ID='manage_no'   	width=100	align=left editlimit=14 show=true</C>
						              <C> name='�ּ�'     		ID='address1'    	width=150 	align=left editlimit=60 show=true</C>
						              <C> name='������'    		ID='m_cust_nm'   	width=60 	align=left editlimit=30 show=true</C>
						              <C> name='����'      		ID='join_cd'     	width=40 	align=left editlimit=50 show=true</C>
						              <C> name='��/��'        	ID='class'       	width=80 	align=left editlimit=54 show=true</C>
						              <C> name='���ǵ��' 		ID='room_type_cd' 	width=60 	align=left editlimit=10 show=true</C>
						              <C> name='���ȣ'      	ID='room_no'     	width=60 	align=left editlimit=10 show=true</C>
						              <C> name='�������' 		ID='tot_tour_amt' 	width=80 	align=right editlimit=12 show=true decao=0</C>
						              <C> name='�ɼǿ��' 		ID='tot_opt_amt' 	width=80 	align=right editlimit=12 show=true decao=0</C>
						              <C> name='����ó(����)'    	ID='tel_no'      	width=150 	align=left editlimit=20 show=true</C>
						              <C> name='����ó(�ڵ���)'    	ID='mobile_no_full'      	width=150 	align=left editlimit=20 show=true</C>
						              <C> name='�Է���'			ID='i_empnm'		width=60	align=left show=true	</C>
 						              <C> name='������'			ID='u_empnm'		width=60	align=left show=true	</C>
						              <C> name='M_RSV_SID'    	ID='m_rsv_sid'   	width=100 	align=left editlimit=12 show=false</C>
						              <C> name='RSV_SID'      	ID='rsv_sid'     	width=100 	align=left editlimit=12 show=false</C>
   						              <C> name='�湮Ƚ��'		ID='north_cnt'		width=60	align=right show=true dec=0</C>
   						              <C> name='������'		ID='cust_gu'		width=60	align=left show=true dec=0</C>
                                      <C> name='��������'       ID='regi_yn_t_name' width=70 	align=CENTER	Edit=None</C>
                                      <C> name='��������'       ID='arrive_date' 	width=60 	align=CENTER	Edit=None</C>
                                      <C> name='���ͽð�'       ID='arrive_time' 	width=60 	align=CENTER	Edit=None</C>
						              <C> name='�������'   	ID='remarks'  		width=200 	align=left editlimit=61 show=true</C>
                                     <C> name='������'     	   ID='last_nm' 	width=60 	align=CENTER	Edit=None</C>
                                     <C> name='�����̸�'       ID='first_nm' 	width=60 	align=CENTER	Edit=None</C>
                                     <C> name='���ǹ�ȣ'       ID='pass_no' 	width=60 	align=CENTER	Edit=None</C>
                                     <C> name='���Ǹ���'       ID='pass_expire_date' 	width=60 	align=CENTER	Edit=None</C>

               					">
							</object>   
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>

			</td>
		</tr>

	</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

