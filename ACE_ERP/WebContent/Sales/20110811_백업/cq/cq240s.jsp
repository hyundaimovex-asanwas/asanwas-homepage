<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: Ȯ������ �ڷ�˻�
 * ���α׷�ID 	: cq240s
 * J  S  P			: cq240s
 * �� �� ��		: Cq240s
 * �������		: Ȯ������ �ڷ�˻�
 * [ �������� ][������] ����
 * [2010-04-12][�ڰ汹] �ű�. Ȯ�������� �ڷ�˻�.
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
//   	firstday="20060805";
//   date.add(java.util.Calendar.DATE, +10);         
//   String endday = m_today.format(date.getTime()); 
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
		 var div='';

		// �������ε�
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	        v_job = "H";		
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			sDate.Text = '<%=firstday%>';	
			fnInit()
		} 
		function fnInit() {
			div = 'init';
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //�����ڵ�

	        ds_code1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ001&s_item1=Y";
	        ds_code1.Reset();	//���Թ���

	        ds_code2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ004&s_item1=Y";
	        ds_code2.Reset();	//��������
		}
		// �������� ��ȸ (GR1)
		function fnSelect1() {
			v_job = "S";	//select �ϵ�..
			 if ( sParam01.checked == true ) 
	         	sParam01.value='Y';
	         else
	         	sParam01.value='N';	         
	         if ( sParam02.checked == true ) 
	         	sParam02.value='Y';
	         else
	         	sParam02.value='N';
	        
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_direction=" + lc_code1.ValueOfIndex("detail", lc_code1.Index)
                      + ",v_date=" + sDate.Text
                      + ",v_time=" + lc_time.ValueOfIndex("depart_time", lc_time.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",v_accept_no=" + v_accept_no.Text
					  + ",sParam01=" + sParam01.value 
	            	  + ",sParam02=" + sParam02.value   ;
	        ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq240S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}

		// ���ð�, ��ǰ��ȸ
		function fnSelectDs3() {
		    window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		     
	 		if(lc_code1.ValueOfIndex("detail", lc_code1.Index)=="AR"){
	 		
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sArriveDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_ARRIVE_TIME_DS=ds_time,O:S_GOODS_DS=ds_goods)",
			        v_param);		

	 		}else{
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sDepartDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_DEPART_TIME_DS_NEW=ds_time,O:S_GOODS_DS=ds_goods)",
			        v_param);		
	 		} ;
		    tr_post(tr1);
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
	        }
	    }
	    /*
	 * ����
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("Ȯ������ �ڷ�˻�");
	}		
</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/

///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language=JavaScript for=sDate event=OnKillFocus()>
		if ( div != 'init' ) {	//�������� ��Ŀ�� �̵� 
			if ( sDate.Modified ) {
				div = 'init';
				fnSelectDs3();
			}
		}
	</script>
	<script language=JavaScript for= lc_saup event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';
			fnSelectDs3();
		}
	</script>
	<script language=JavaScript for= lc_code1 event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';
			fnSelectDs3();
		}
	</script>
	<script language=JavaScript for=lc_time event=OnSelChange()>
		if ( div != 'init' ) {	//���ð�
			div = 'init';
			fnClass();
		}
	</script>
    <script language=JavaScript for=lc_goods event=OnSelChange()>
        if ( div != 'init' ) {  //��ǰ
            div = 'init';
            fnClass();
        }
    </script>

	<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
		fnSelectDs3();
	</script>
	
	<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_time classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_code1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_code2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �޼��� -->
    <param name="SyncLoad"  value="false">
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
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
				<table width="845" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #6f7f8d">
					<tr>
						<td width="270" height="20">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="25" height="25"><input name="sParam01" type="checkbox" value="Y"></td>
									<td>&nbsp;���� ������ȣ�� ���� ���</td>
								</tr>
							</table>
						</td>
						<td width="270">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="25" height="25"><input name="sParam02" type="checkbox" value="Y"></td>
									<td >&nbsp;������Ī�� ���� ���</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table  border='0' cellpadding='0' cellspacing='0' width='845' >
					<tr height=50px>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0' width='845px'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect1()"> 		<!-- ��ȸ -->
										<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  	<!-- ���� -->																																																																																		
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
						<td width="70px" height="25px" class="text">��û����ȣ</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>            
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
						<td align=left class="text" width="50">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^70">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td align=left class="text"  width="50">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;
							<%=HDConstant.COMMENT_START%>
                            <object id=lc_code1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_code1>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
							</object>
							<%=HDConstant.COMMENT_END%>
	                    </TD>						
						<td align=left class="text"  width="60">��������</td>
	                    <td align=left bgcolor="#ffffff" width=150>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17  width=65 align=center class="textbox">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny  	value="false">																				
							</object>&nbsp;
                            <object id=lc_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_time>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail_nm">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^50"></object>
							<%=HDConstant.COMMENT_END%>
						</td>																							
						<td align=left class="text" width="60">��ǰ(��)</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
                            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=90 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
                                <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10'>
			<td></td>
		</tr>
		<tr>
			<td align=center>
				<%=HDConstant.COMMENT_START%>
				<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width=845 height=190 border=1 style="display:;">
                    <param name="DataID"            value="ds1">
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
                        <C> name='����'             ID='CAR_NM'             Width=80   Edit=none align=Left		show=false</C>
                        <C> name='����'             ID='CAR_FORM'           Width=80   Edit=none align=Left	show=false</C>
                        <C> name='����'             ID='CAR_TYPE'           Width=80   Edit=none align=Lef	show=false</C>
                        <C> name='����'             ID='CAR_YEAR'           Width=40   Edit=none align=Righ	show=false</C>
                        <C> name='��ⷮ(cc)'       ID='CAR_CC'             Width=80   Edit=none align=Right	show=false</C>
                        <C> name='�����ο�'         ID='CAR_PERSONS'        Width=60   Edit=none align=Right</C>
                        <C> name='�ִ����緮(kg)'   ID='MAX_KG'             Width=100  Edit=none align=Right	show=false</C>
                        <C> name='����1'            ID='CAR_TYPE_CD_NAME'   Width=80   Edit=none align=Left	show=false</C>
                        <C> name='�����ȣ'         ID='CAR_DNO'            Width=80   Edit=none align=Left	show=false</C>
					</G>
                    ">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
		</tr>
	</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

