<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ����Ȯ�����
 * ���α׷�ID 	: RV810S
 * J  S  P		: rv810s
 * �� �� ��		: Rv810S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-06
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2010-03-15][�ڰ汹] ���ѹ湮��û�� [���] ��� �߰�.
 * [2010-08-02][�ڰ汹] 3�� �׸��� 1�� �׼��� �ٿ�ε��ϰ� ����
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
		 var div='';
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			fnInit();
			codeDs3.deleterow(1);
		} 
		 
		function fnInit() {
			sBgnDate.text='<%=firstday%>';	
			div = 'init';
	        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds2.Reset(); //�����ڵ�
			
	        ds_code2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ004&s_item1=Y";
	        ds_code2.Reset();	//��������

	   }
		
		/*
		 * ���ð�, ��ǰ��ȸ
		 */		
		function fnSelectDs3() {
		
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            + "sSaupSid=" + lc1.ValueOfIndex("saup_sid",lc1.Index) + ","
				+ "sDepartDate=" + sBgnDate.text;
				
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
	            param);
	        tr_post(tr1);
		}	
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",dsType=1"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sDepart_date=" + sBgnDate.Text
			          + ",sDepart_time=" + lc2.ValueOfIndex("depart_time", lc2.Index)
			          + ",sGoods_sid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sClient_sid=" + sClientSid.value
			          + ",v_accept_no=" + v_accept_no.Text
			          + ",sJobsel=" + sJobsel.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv811S",
			    "JSP(O:DS1=ds1,O:DS_GR2=ds_gr2,O:DS_GR3=ds_gr3)",
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:�ο����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("�ο����","����Ȯ�����(�����).xls", 32);

	        getObjectFirst("gr2").SetExcelTitle(0, "");
	        getObjectFirst("gr2").SetExcelTitle(1, "value:�������; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr2").GridToExcel("�������","����Ȯ�����(�����).xls", 32);

	        getObjectFirst("gr3").SetExcelTitle(0, "");
	        getObjectFirst("gr3").SetExcelTitle(1, "value:�ο�+����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr3").GridToExcel("�ο�+����","����Ȯ�����(�����).xls", 32);




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
	    /**
	     * ��û�� ��ȣ ��ȸ
    	 */
	    function fnAcceptNoPopup(){
    	    v_cust_row = 0;
	        var arrResult   = new Array();
    	    arrResult = fnAcceptNoPop("<%=dirPath%>");
        	if (arrResult != null) {
	            arrParam = arrResult.split(";");
    	        getObjectFirst("v_accept_sid").value = arrParam[0];
        	    getObjectFirst("v_accept_no").Text   = arrParam[1];
	        }
	    }
    /*
	 * ����Ʈ
	 */
	function fnPrint() {
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",dsType=2"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sDepart_date=" + sBgnDate.Text
			          + ",sDepart_time=" + lc2.ValueOfIndex("depart_time", lc2.Index)
			          + ",sGoods_sid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sClient_sid=" + sClientSid.value
			          + ",v_accept_no=" + v_accept_no.Text
			          + ",sJobsel=" + sJobsel.value;
			          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv811S",
			   "JSP(O:REPORT=ds9)",
			    param);
			tr_post(tr1);
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
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		
			if ( sBgnDate.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
	</script>
	<script language=JavaScript for= lc1 event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';			
			fnSelectDs3();
		}
	</script>	
	<script language=JavaScript for= lc2 event=OnSelChange()>
		if ( div != 'init' ) {	//���ð�
			div = 'init';					
		}
	</script>		
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
			fnSelectDs3();
	</script>
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
		div = "";		
	</script>	
	<script language=JavaScript  for=ds9 event="OnLoadCompleted(row)">
	pr1.PreView();
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
<object id=ds_gr2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_gr3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ--%>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_code2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table   border='0' cellpadding='0' cellspacing='1' width='650' bgcolor='#666666'>
								<tr>
									<td align="center" width="70px" height="30px" class="text" >�븮��</td>
									<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
			                            <input type="text" name='sClientNm' id='sClientNm' value='' size='15' readonly='readonly'  class='textbox'>
			                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
			                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
									</td>
									 <td width="80px" height="25px" class="text">��û����ȣ</td>
		                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
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
					            <td align=left class="text" width="40px">�ź�</td>
					            <td align="left" bgcolor="#ffffff" colspan=3>&nbsp;
			    					<select name="sJobsel">
										 <option value="1">������</option>
										 <option value="2" SELECTED>�����</option>
										 <option value="3">���������</option>
									</select>
								</td>

								</tr>
							</table>
						</td>
						<td>
							<table   border='0' cellpadding='0' cellspacing='0' width='195'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
										<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:hand" align=absmiddle onclick="fnPrint()">
										<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
									</td>
								</tr>
							</table>
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
						<td align=left class="text" width="100px">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds2>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align=left class="text"  width="110">�������</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
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
						<td align=left class="text" width="110">��ǰ����</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
								<%=HDConstant.COMMENT_START%>
	                        <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds4>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^140"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td height=360>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=mxTab classid=<%=HDConstant.CT_TAB_CLSID%> style="position:absolute; left:170; top:170; width:845; height:20">
								<param name="BackColor"			value="#00ffff">
								<param name="DisableBackColor"	value="#ffffee">
								<param name="Format"			value='
									<T>divid="mxTab_page1"	title="�ο� ���"</T>
									<T>divid="mxTab_page2"	title="���� ���"</T>
									<T>divid="mxTab_page3"	title="�ο�+����"</T>'>
							</object>
							<%=HDConstant.COMMENT_END%>						

							<div class=page id="mxTab_page1" style="position:absolute; left:170; top:190; width:845; height:330">
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='330px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              <FC> name='�븮���ڵ�'    	ID='client_cd'   	width=80		align=left 	editlimit=5 show=false </FC>
						              <FC> name='�븮����'    		ID='client_nm'   	width=80 		align=left 	editlimit=50 show=true suppress=1</FC>
						              <FC> name='��ġ��'        		ID='empnm'       	width=60 		align=left 	editlimit=20 show=true</FC>
						              <C> name='�����'    	   			ID='depart_date'   width=60 		align=center editlimit=16 show=true</C>
						              <C> name='�湮�Ⱓ'    	   		ID='arrive_date'    width=80 		align=center editlimit=16 show=false</C>
						              <C> name='��ǰ��'      			ID='goods_nm'     width=80 		align=left 	editlimit=30 show=true suppress=2</C>
						              <FC> name='��û����ȣ'    	ID='accept_no'   	width=100 	align=left 	editlimit=16 show=true suppress=3</FC>
						              <FC> name='����'      			ID='cust_nm'     	width=60 		align=left 	editlimit=30 show=true</FC>
						              <C> name='����/����'   			ID='company_nm'  	width=100 align=left 	editlimit=61 show=true</C>
						              <C> name='�ֹε�Ϲ�ȣ'    	ID='manage_no'  width=80		align=left 	editlimit=14 show=true</C>
						              <C> name='�ּ�'     				ID='address1'    	width=150 	align=left 	editlimit=60 show=true</C>
						              <C> name='������'    				ID='m_cust_nm'   width=60 		align=left 	editlimit=30 show=true</C>
						              <C> name='����'      				ID='join_cd'     		width=40 		align=left 	editlimit=50 show=true</C>
						              <C> name='��/��'        			ID='class'       		width=60 		align=left 	editlimit=54 show=true</C>
						              <C> name='���ǵ��' 			ID='room_type_cd' 	width=60 	align=left 	editlimit=10 show=true</C>
						              <C> name='���ȣ'      			ID='room_no'     	width=60 		align=left 	editlimit=10 show=true</C>
						              <C> name='���Ǹž�' 			ID='tot_tour_amt' 	width=80 		align=right editlimit=12 show=true dec=0</C>
						              <C> name='����ó(����)'    	ID='tel_no'      		width=80 		align=left 	editlimit=20 show=true</C>
						              <C> name='����ó(�ڵ���)'     ID='mobile_no'     width=80 		align=left 	editlimit=20 show=true</C>
						              <C> name='�Է���'					ID='i_empnm'		width=60		align=left 	show=true	</C>
						              <C> name='������'					ID='u_empnm'		width=60		align=left 	show=true	</C>
						              <C> name='M_RSV_SID'    	ID='m_rsv_sid'   	width=100 	align=left 	editlimit=12 show=false</C>
						              <C> name='RSV_SID'      		ID='rsv_sid'     		width=100 	align=left 	editlimit=12 show=false</C>
						   			  <C> name='�ñ��'					ID='PAY_PRE' 		Width=45 		align=left	editstyle=lookup data='codeDs3:detail:detail_nm'	BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )} 	show=false </C>
									  <C> name='����'     				ID='PAY_SAUP'   	Width=45   	align=Left	editstyle=lookup data='codeDs4:detail:detail_nm'	BgColor={IF(ACCT_CLOSE_YN='Y','#fefec0','' )}  show=false</C>
               					">
							</object>   
							<%=HDConstant.COMMENT_END%>
							</div>
							<div class=page id="mxTab_page2" style="position:absolute; left:170; top:190; width:845; height:330">
							<%=HDConstant.COMMENT_START%>
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width=845 height=330 border=1 style="display:;">
			                    <param name="DataID"            value="ds_gr2">
			                    <param name="BorderStyle"       value="0">
			                    <param name="ColSizing"         value="true">
			                    <param name="editable"          value="True">
			                    <param name="SuppressOption"    value="1">
			                    <param name="Format"            value=" 
								<G> name='��������'
									<C> name='��û����ȣ'   ID='ACCEPT_NO'  	width=95 	align=center editlimit=15 edit=none show=true suppress=1 mask='XXXXX-XXXXXXXXX'</C>
									<C> name='��ǰ��'    	ID='GOODS_NM'  		width=55 	align=left editlimit=15 edit=none show=true suppress=2 </C>
									<C> name='�������'    	ID='DEPART_DATE'    width=65 	align=CENTER	Edit=None suppress=3 mask='XXXX-XX-XX'</C>
									<C> name='�ð�'    		ID='DEPART_TIME'	width=35 	align=center	Edit=None suppress=4 mask='XX:XX'</C>
									<C> name='��������'     ID='arrive_date' 	width=65 	align=CENTER	Edit=None suppress=5 mask='XXXX-XX-XX'</C>
									<C> name='�ð�'     	ID='arrive_time' 	width=35 	align=CENTER	Edit=None suppress=6 mask='XX:XX'</C>
								</G>
								<G> name='���Խ� ��������'
									<C> name='ȣ��' 		ID='RIDE_CAR_NUM'	Width=35   Edit=true align=CENTER  show=true BgColor='#fefec0'</C>
									<C> name='��Ī' 		ID='RIDE_CAR_NM'	Width=70   Edit=true align=CENTER  show=true BgColor='#fefec0'</C>
								</G>
			                        <C> name='���¾�ü��'   ID='CLIENT_NM'		Width=100  Edit=none align=Left</C>
			                        <C> name='�ڵ�'    		ID='CLIENT_CD'		Width=40   Edit=none align=Left </C>
									<C> name='��������ID' 		ID='CAR_RSV_SID'    Width=80   Edit=none align=Left show=false</C>
								<G> name='��������'
			                        <C> name='��Ϲ�ȣ'     ID='CAR_NO'             Width=80   Edit=none align=Left</C>
			                        <C> name='����'             ID='CAR_NM'             Width=80   Edit=none align=Left</C>
			                        <C> name='����'             ID='CAR_FORM'           Width=80   Edit=none align=Left</C>
			                        <C> name='����'             ID='CAR_TYPE'           Width=80   Edit=none align=Left</C>
			                        <C> name='����'             ID='CAR_YEAR'           Width=40   Edit=none align=Right</C>
			                        <C> name='��ⷮ(cc)'       ID='CAR_CC'             Width=80   Edit=none align=Right</C>
			                        <C> name='�����ο�'         ID='CAR_PERSONS'        Width=60   Edit=none align=Right</C>
			                        <C> name='�ִ����緮(kg)'   ID='MAX_KG'             Width=100  Edit=none align=Right</C>
			                        <C> name='����1'            ID='CAR_TYPE_CD_NAME'   Width=80   Edit=none align=Left</C>
			                        <C> name='�����ȣ'         ID='CAR_DNO'            Width=80   Edit=none align=Left</C>
			                        <C> name='���'         ID='CAR_DESC'            Width=80   Edit=none align=Left</C>
								</G>
			                    ">
							</object>
							<%=HDConstant.COMMENT_END%>
							</div>
							<div class=page id="mxTab_page3" style="position:absolute; left:170; top:190; width:845; height:330">
							<%=HDConstant.COMMENT_START%>
							<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> width=845 height=330 border=1 style="display:;">
			                    <param name="DataID"            value="ds_gr3">
			                    <param name="BorderStyle"       value="0">
			                    <param name="ColSizing"         value="true">
			                    <param name="editable"          value="True">
								<param name="SuppressOption"    value="1">
	                            <param name="ViewSummary"       value="1">
			                    <param name="Format"            value=" 
								   	<C> name='No'           ID='{STRING(CURROW)}'   Width=30    align=center</C>
									<C> name='��û����ȣ'   ID='ACCEPT_NO'  	width=95 	align=center editlimit=15 edit=none show=true suppress=1 mask='XXXXX-XXXXXXXXX' SUMTEXT=@CNT</C>
									<C> name='��ǰ��'    	ID='GOODS_NM'  		width=55 	align=left editlimit=15 edit=none show=true suppress=2 SUMTEXT=��</C>
									<C> name='�������'    	ID='DEPART_DATE'    width=65 	align=CENTER	Edit=None suppress=3 mask='XXXX-XX-XX'</C>
									<C> name='�ð�'    		ID='DEPART_TIME'	width=35 	align=center	Edit=None suppress=4 mask='XX:XX'</C>
									<C> name='��������'     ID='arrive_date' 	width=65 	align=CENTER	Edit=None suppress=5 mask='XXXX-XX-XX'</C>
									<C> name='�ð�'     	ID='arrive_time' 	width=35 	align=CENTER	Edit=None suppress=6 mask='XX:XX'</C>
									<C> name='����'      	ID='CUST_NM'   		width=50 	align=left editlimit=30  edit=none show=true sort=true</C>
								<G> name='���Խ� ��������'
									<C> name='ȣ��' 		ID='RIDE_CAR_NUM'	Width=30   Edit=none align=CENTER  show=true</C>
									<C> name='��Ī' 		ID='RIDE_CAR_NM'	Width=70   Edit=none align=CENTER  show=true</C>
									<C> name='��Ϲ�ȣ'     ID='CAR_NO'         Width=80   Edit=none align=Left</C>
								</G>
									<C> name='����' 		ID='DONGSEUNG'     	width=45   	align=center editlimit=10   editstyle=lookup  data='ds_code2:detail:detail_nm' edit=none show=true  BgColor={IF(DONGSEUNG='Y','#fefec0','' )} </C>
									<C> name='��������ID'	ID='CAR_RSV_SID'    width=80   	align=center editlimit=10  edit=TRUE show=false</C>
									<C> name='����'   		ID='COMPANY_NM'  	width=80 	align=left editlimit=30  edit=none show=true</C>
									<C> name='����'    		ID='POSITIONS'   	width=50 	align=left editlimit=30  edit=none show=true</C>
									<C> name='��'        	ID='CLASS'       	width=25 	align=right editlimit=2 	show=true</C>
									<C> name='��'        	ID='TEAMS'      	width=25  	align=right editlimit=2 	show=true</C>
									<C> name='�ֹ� /\\����' ID='MANAGE_NO'  	width=75  	align=left editlimit=20  edit=none show=true </C>

			                    ">
							</object>
							
							<%=HDConstant.COMMENT_END%>
							</div>

						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>-. �ο� ��� : �ο� ���� Ȯ������Դϴ�.<br>
			-. ���� ��� : ���� ���� Ȯ������Դϴ�. �˻����� [�ź�]�� <b>����</b>�մϴ�.<br>
			-. �ο�+���� : �ο��� ������ ������ �Բ� ǥ�õ˴ϴ�.<br>
			��������|ž�� ������ ǥ�õǸ�, ������ �������� �����˴ϴ�.<br>

			</td>
		</tr>
		
	</table>
<%
/*=============================================================================
			����Ʈ ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
		<object id=pr1 classid=<%=HDConstant.CT_REPORT_CLSID%>> 
		<PARAM NAME="MasterDataID"          VALUE="ds9">
		<PARAM NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="Format"                value="
<X>left=0 ,top=0 ,right=1905 ,bottom=2870,penwidth=5 </X>
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=259 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='�� �� �� �� �� û ��' ,left=519 ,top=75 ,right=1482 ,bottom=225 ,face='Tahoma' ,size=30 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=10 ,top=245 ,right=1945 ,bottom=245 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=10 ,top=245 ,right=10 ,bottom=2405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1945 ,top=245 ,right=1945 ,bottom=2405 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=1200,PageSkip=false
	<R>id='north_1.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=1200
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=164 ,face='Tahoma' ,size=10 ,penwidth=1
			<L> left=10 ,top=0 ,right=10 ,bottom=164 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1945 ,top=0,right=1945 ,bottom=164 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<X>left=40 ,top=101 ,right=1916 ,bottom=164 ,backcolor=#66CDFF </X>
			<L> left=1916 ,top=101 ,right=1916 ,bottom=164 </L>
			<L> left=1400 ,top=101 ,right=1400 ,bottom=164 </L>
			<L> left=1000 ,top=101 ,right=1000 ,bottom=164 </L>
			<L> left=728 ,top=101 ,right=728 ,bottom=164 </L>
			<L> left=130 ,top=101 ,right=130 ,bottom=164 </L>
			<L> left=40 ,top=164 ,right=1916 ,bottom=164 </L>
			<L> left=336 ,top=101 ,right=336 ,bottom=164 </L>
			<L> left=1660 ,top=101 ,right=1660 ,bottom=164 </L>
			<L> left=40 ,top=101 ,right=40 ,bottom=164 </L>
			<L> left=40 ,top=101 ,right=1916 ,bottom=101,,penwidth=3 </L>
			<T>id='�湮����' ,left=1000 ,top=101 ,right=1400 ,bottom=164,backcolor=#66CDFF,size=12</T>
			<T>id='��' ,left=32 ,top=101 ,right=127 ,bottom=164,backcolor=#66CDFF,size=12</T>
			<T>id='����' ,left=127 ,top=101 ,right=339 ,bottom=164,backcolor=#66CDFF,size=12</T>
			<T>id='����/����' ,left=336 ,top=101 ,right=730 ,bottom=164,backcolor=#66CDFF,size=12</T>
			<T>id='�ֹι�ȣ' ,left=680 ,top=101 ,right=1035 ,bottom=164,backcolor=#66CDFF,size=12</T>
			<T>id='1. �湮��û��' ,left=37 ,top=19 ,right=434 ,bottom=85 ,align='left' ,face='Tahoma' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�湮�Ⱓ' ,left=1400 ,top=101 ,right=1650 ,bottom=161,backcolor=#66CDFF,size=12</T>
			<T>id='���' ,left=1670 ,top=106 ,right=1900 ,bottom=161,backcolor=#66CDFF,size=12</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=63 ,face='Tahoma' ,size=10 ,penwidth=1
			<L> left=10 ,top=0 ,right=10 ,bottom=63 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1945 ,top=0,right=1945 ,bottom=63 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1916 ,top=0 ,right=1916 ,bottom=63 </L>
			<L> left=728 ,top=0 ,right=728 ,bottom=63 </L>
			<L> left=336 ,top=0 ,right=336 ,bottom=63 </L>
			<L> left=1000 ,top=0 ,right=1000 ,bottom=63 </L>
			<L> left=1400 ,top=0 ,right=1400 ,bottom=63 </L>
			<L> left=130 ,top=0 ,right=130 ,bottom=63</L>
			<L> left=40 ,top=0 ,right=40 ,bottom=63 </L>
			<L> left=728 ,top=0 ,right=728 ,bottom=63 </L>
			<L> left=1660 ,top=0 ,right=1660 ,bottom=63 </L>
			<L> left=40 ,top=0 ,right=1916 ,bottom=0 </L>
			<L> left=40 ,top=63 ,right=1916 ,bottom=63</L>
			<C>id='{CURROW}', left=32, top=3, right=127, bottom=69</C>
			<C>id='cust_nm', left=127, top=3, right=339, bottom=69</C>
			<C>id='manage_no', left=678, top=3, right=1032, bottom=69</C>
			<C>id='company_nm', left=336, top=3, right=728, bottom=69</C>
			<C>id='CUST_TYPE_NM', left=1670, top=3, right=1900, bottom=69</C>
			<C>id='north_purpose', left=1000, top=3, right=1400, bottom=69</C>
			<C>id='arrive_date', left=1400, top=8, right=1650, bottom=61</C>
		</B>
	</R>
</A>
<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=1200,PageSkip=false
	<R>id='north_2.sbt' ,left=11 ,top=5 ,right=1984 ,bottom=1200 ,DetailDataID='ds9'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=235 ,face='Tahoma' ,size=10 ,penwidth=1
			<L> left=0 ,top=0 ,right=0 ,bottom=235 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1934 ,top=0,right=1934 ,bottom=235 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<X>left=30 ,top=120 ,right=1905 ,bottom=235 ,backcolor=#66CDFF </X>
			<T>id='2. �湮���' ,left=37 ,top=40 ,right=426 ,bottom=106 ,align='left' ,face='Tahoma' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=37 ,top=106 ,right=119 ,bottom=238,backcolor=#66CDFF,size=12</T>
			<T>id='����' ,left=119 ,top=106 ,right=283 ,bottom=238,backcolor=#66CDFF,size=12</T>
			<T>id='����' ,left=280 ,top=106 ,right=574 ,bottom=172,backcolor=#66CDFF,size=12</T>
			<T>id='    �湮���' ,left=574 ,top=34 ,right=1730 ,bottom=241,align='left',backcolor=#66CDFF,size=12 </T>
			<T>id=' �����' ,left=926 ,top=201 ,right=1140 ,bottom=232,backcolor=#66CDFF,size=12</T>
			<T>id='����' ,left=929 ,top=153 ,right=1143 ,bottom=201,backcolor=#66CDFF,size=12</T>
			<T>id='������' ,left=730 ,top=198 ,right=926 ,bottom=232,backcolor=#66CDFF,size=12 </T>
			<T>id='  ���  ' ,left=730 ,top=153 ,right=929 ,bottom=201,backcolor=#66CDFF,size=12 </T>
			<T>id='�Ĵ�' ,left=1135 ,top=124 ,right=1437 ,bottom=235 ,backcolor=#66CDFF,size=12 </T>
			<T>id='�ļ�' ,left=1336 ,top=183 ,right=1431 ,bottom=225,backcolor=#66CDFF,size=12</T>
			<T>id='���ں�' ,left=1429 ,top=124 ,right=1728 ,bottom=235 ,backcolor=#66CDFF,size=12 </T>
			<T>id='�ڼ�' ,left=1635 ,top=188 ,right=1728 ,bottom=230,backcolor=#66CDFF,size=12</T>
			<T>id='���' ,left=442 ,top=175 ,right=574 ,bottom=233,backcolor=#66CDFF,size=12</T>
			<T>id='    �ñ�' ,left=283 ,top=175 ,right=434 ,bottom=235,backcolor=#66CDFF,size=12</T>
			<T>id='���' ,left=1728 ,top=114 ,right=1889 ,bottom=235,backcolor=#66CDFF,size=12</T>
			<L> left=30 ,top=120 ,right=30 ,bottom=235 </L>
			<L> left=325 ,top=120 ,right=325 ,bottom=235 </L>
			<L> left=574 ,top=120,right=574 ,bottom=235 </L>
			<L> left=1725 ,top=120 ,right=1725 ,bottom=235 </L>
			<L> left=929 ,top=153 ,right=929 ,bottom=235 </L>
			<L> left=1429 ,top=151 ,right=1429 ,bottom=235 </L>
			<L> left=1138 ,top=153 ,right=1138 ,bottom=235 </L>
			<L> left=1632 ,top=188 ,right=1632 ,bottom=235 </L>
			<L> left=437 ,top=169 ,right=437 ,bottom=235 </L>
			<L> left=119 ,top=120, right=119 ,bottom=235 </L>
			<L> left=1336 ,top=183 ,right=1336 ,bottom=235 </L>
			<L> left=746 ,top=153 ,right=746 ,bottom=235 </L>
			<L> left=1905 ,top=120 ,right=1905 ,bottom=235 </L>
			<L> left=1725 ,top=186 ,right=1630 ,bottom=186 </L>
			<L> left=30 ,top=120,right=1905 ,bottom=120,penwidth=3 </L>
			<L> left=30 ,top=235 ,right=1905 ,bottom=235 </L>
			<L> left=325 ,top=169 ,right=574 ,bottom=169 </L>
			<L> left=746 ,top=151 ,right=1725 ,bottom=151 </L>
			<L> left=1429 ,top=184 ,right=1333 ,bottom=184 </L>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=63 ,face='Tahoma' ,size=10 ,penwidth=1
			<L> left=0 ,top=0 ,right=0 ,bottom=63 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1934 ,top=0 ,right=1934 ,bottom=63 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=30 ,top=0 ,right=30 ,bottom=63 </L>
			<L> left=119 ,top=0 ,right=119 ,bottom=63 </L>
			<L> left=325 ,top=0 ,right=325 ,bottom=63 </L>
			<L> left=437 ,top=0 ,right=437 ,bottom=63 </L>
			<L> left=574 ,top=0 ,right=574 ,bottom=63 </L>
			<L> left=746 ,top=0 ,right=746 ,bottom=63 </L>
			<L> left=929 ,top=0 ,right=929 ,bottom=63 </L>
			<L> left=1138 ,top=0 ,right=1138 ,bottom=63 </L>
			<L> left=1336 ,top=0 ,right=1336 ,bottom=63 </L>			
			<L> left=1429 ,top=0 ,right=1429 ,bottom=63 </L>
			<L> left=1632 ,top=0 ,right=1632 ,bottom=63 </L>
			<L> left=1725 ,top=0 ,right=1725 ,bottom=63 </L>
			<L> left=1905 ,top=0 ,right=1905 ,bottom=63 </L>
			<L> left=30 ,top=0 ,right=1905 ,bottom=0 </L>
			<L> left=30 ,top=63 ,right=1905 ,bottom=63 </L>
			<C>id='{CURROW}', left=42, top=5, right=119, bottom=61</C>
			<C>id='cust_nm', left=127, top=5, right=270, bottom=71</C>
			<C>id='PAY_PRE', left=300, top=5, right=431, bottom=71</C>
			<C>id='PAY_SAUP', left=450, top=5, right=572, bottom=71</C>
			<C>id='TOT_TOUR_AMT', left=587, top=5, right=741, bottom=71	Decao=0</C>
			<C>id='BIZ_AMT4', left=757, top=8, right=915, bottom=69	Decao=0</C>
			<C>id='BIZ_AMT3', left=942, top=5, right=1122, bottom=66	Decao=0</C>
			<C>id='BIZ_AMT2', left=1146, top=5, right=1328, bottom=66	Decao=0</C>
			<C>id='BIZ_QTY2', left=1341, top=5, right=1423, bottom=66	Decao=0</C>
			<C>id='BIZ_AMT1', left=1437, top=8, right=1627, bottom=69	Decao=0</C>
			<C>id='BIZ_QTY1', left=1638, top=8, right=1720, bottom=66	Decao=0</C>
			<C>id='remarks', left=1733, top=8, right=1897, bottom=69</C>
		</B>
	</R>
</A>
<B>id=Footer ,left=0 ,top=2407 ,right=2000 ,bottom=2870 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='  ���� ���� ���� �湮�� ��û�մϴ�.                     ��             ��           ��' ,left=40 ,top=19 ,right=1345 ,bottom=66,align='left',size=12 </T>
	<T>id='��' ,left=46 ,top=283 ,right=99 ,bottom=341,size=12 </T>
	<T>id='' ,left=46 ,top=400 ,right=99 ,bottom=442 </T>
	<T>id='��' ,left=46 ,top=341 ,right=99 ,bottom=402 ,size=12</T>
	<T>id='û' ,left=46 ,top=222 ,right=99 ,bottom=283,size=12 </T>
	<T>id='' ,left=46 ,top=111 ,right=99 ,bottom=161 </T>
	<T>id='��' ,left=46 ,top=161 ,right=99 ,bottom=222,size=12</T>
	<T>id='       ��      ��       ��      (���:                     )' ,left=99 ,top=111 ,right=900 ,bottom=177,size=12</T>
	<T>id='����' ,left=697 ,top=177 ,right=900 ,bottom=243,size=12</T>
	<T>id='Ȯ��' ,left=498 ,top=177 ,right=697 ,bottom=243,size=12</T>
	<T>id='���' ,left=99 ,top=177 ,right=297 ,bottom=243,size=12</T>
	<T>id='����' ,left=297 ,top=177 ,right=498 ,bottom=243,size=12</T>
	<T>id=' / ' ,left=99 ,top=376 ,right=297 ,bottom=442</T>
	<T>id=' / ' ,left=297 ,top=376 ,right=496 ,bottom=442</T>
	<T>id=' / ' ,left=496 ,top=376 ,right=694 ,bottom=442</T>
	<T>id=' / ' ,left=694 ,top=376 ,right=900 ,bottom=442</T>
	<T>id='' ,left=697 ,top=243 ,right=900 ,bottom=376</T>
	<T>id='' ,left=496 ,top=243 ,right=694 ,bottom=376</T>
	<T>id='' ,left=297 ,top=243 ,right=496 ,bottom=376</T>
	<T>id='' ,left=99 ,top=243 ,right=297 ,bottom=378</T>
	<T>id='' ,left=1004 ,top=394 ,right=1057 ,bottom=437 </T>
	<T>id='' ,left=1004 ,top=106 ,right=1057 ,bottom=156 </T>
	<T>id='       ��      ��       ��      (���:                     )' ,left=1047 ,top=106 ,right=1858 ,bottom=172,size=12</T>
	<T>id='����' ,left=1655 ,top=172 ,right=1858 ,bottom=238,size=12</T>
	<T>id='Ȯ��' ,left=1456 ,top=172 ,right=1655 ,bottom=238,size=12</T>
	<T>id='���' ,left=1057 ,top=172 ,right=1255 ,bottom=238,size=12</T>
	<T>id='����' ,left=1255 ,top=172 ,right=1456 ,bottom=238,size=12</T>
	<T>id=' / ' ,left=1047 ,top=370 ,right=1255 ,bottom=437</T>
	<T>id=' / ' ,left=1265 ,top=370 ,right=1453 ,bottom=437</T>
	<T>id=' / ' ,left=1453 ,top=370 ,right=1652 ,bottom=437</T>
	<T>id=' / ' ,left=1652 ,top=370 ,right=1858 ,bottom=437</T>
	<T>id='' ,left=1655 ,top=238 ,right=1858 ,bottom=370</T>
	<T>id='' ,left=1453 ,top=238 ,right=1652 ,bottom=370</T>
	<T>id='' ,left=1255 ,top=238 ,right=1453 ,bottom=370</T>
	<T>id='' ,left=1047 ,top=238 ,right=1255 ,bottom=373</T>
	<T>id='��' ,left=1012 ,top=164 ,right=1057 ,bottom=225,size=12 </T>
	<T>id='��' ,left=1009 ,top=225 ,right=1057 ,bottom=294 ,size=12</T>
	<T>id='��' ,left=1009 ,top=294 ,right=1057 ,bottom=360,size=12 </T>
	<T>id='' ,left=1009 ,top=360 ,right=1057 ,bottom=397 </T>
	<L> left=46 ,top=111 ,right=46 ,bottom=442 </L>
	<L> left=900 ,top=111 ,right=900 ,bottom=442 </L>
	<L> left=46 ,top=111 ,right=900 ,bottom=111 </L>
	<L> left=99 ,top=111 ,right=99 ,bottom=442 </L>
	<L> left=99 ,top=175 ,right=900 ,bottom=175 </L>
	<L> left=99 ,top=378 ,right=900 ,bottom=378 </L>
	<L> left=99 ,top=243 ,right=900 ,bottom=243 </L>
	<L> left=46 ,top=442 ,right=900 ,bottom=442 </L>
	<L> left=297 ,top=177 ,right=297 ,bottom=442 </L>
	<L> left=697 ,top=175 ,right=697 ,bottom=442 </L>
	<L> left=496 ,top=177 ,right=496 ,bottom=442 </L>
	<L> left=1004 ,top=111 ,right=1856 ,bottom=111 </L>
	<L> left=1004 ,top=442 ,right=1856 ,bottom=442 </L>
	<L> left=1057 ,top=111 ,right=1057 ,bottom=442 </L>
	<L> left=1057 ,top=169 ,right=1856 ,bottom=169 </L>
	<L> left=1057 ,top=373 ,right=1856 ,bottom=373 </L>
	<L> left=1057 ,top=238 ,right=1856 ,bottom=238 </L>
	<L> left=1255 ,top=172 ,right=1255 ,bottom=442 </L>
	<L> left=1655 ,top=169 ,right=1655 ,bottom=442 </L>
	<L> left=1453 ,top=172 ,right=1453 ,bottom=442 </L>
	<L> left=1856 ,top=111 ,right=1856 ,bottom=442 </L>
	<L> left=1004 ,top=111 ,right=1004 ,bottom=442 </L>
	<L> left=10 ,top=462 ,right=1945 ,bottom=462 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=10 ,top=0 ,right=10 ,bottom=462 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1945 ,top=0 ,right=1945 ,bottom=462 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>

">
</object> 
<%=HDConstant.COMMENT_END%>
<script language=JavaScript for=pr1 event=OnError()>
    alert(pr1.ErrorMsg);
</script>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

