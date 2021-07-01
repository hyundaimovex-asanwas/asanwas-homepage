<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������� - ���� ���ε��
 * ���α׷�ID 	: CQ340S
 * �������		: ��������(����)�� ���������� �ٿ�ε� �޴� ȭ��. ���뿡 ���ε��ϸ� ���/���ο� �׼����Ϸ� �ٿ��.
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2010-02-08][�ڰ汹] ����Ȯ������(������ε� ��)ȭ�� �ű�.
 * [2010-03-22][�ɵ���] �� �˻��������� ���� : ����ž�°� �����ϰ�
 * [2011-06-21][�ڰ汹] New ������ε� �� �������԰�ȹȭ��.
 * [2015-09-10][�ɵ���] 15�� ���������� ����: ����ž�� ������ �ݿ� 
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
		// �������ε�
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			cfStyleGrid(getObjectFirst("gr1"), "comn1");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			cfStyleGrid(getObjectFirst("gr4"), "comn");
			fnInit();
		} 
		 
		function fnInit() {
			sDate.text='<%=firstday%>';	
			div = 'init';
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //�����ڵ�

	        ds_code1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ001&s_item1=Y";
	        ds_code1.Reset();	//���Թ���

	   }
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_direction=" + lc_code1.ValueOfIndex("detail", lc_code1.Index)
                      + ",v_date=" + sDate.Text
                      + ",v_time=" + lc_time.ValueOfIndex("detail", lc_time.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",v_class=" + lc_class.ValueOfIndex("class", lc_class.Index)
			          + ",v_team=" + lc_team.ValueOfIndex("teams", lc_team.Index)
			          + ",v_jobsel=" + sJobsel.value
			          + ",v_accept_no=" + v_accept_no.Text;
			          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq360S",
			    "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3,O:DS4=ds4)",
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:������ε�(������û); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("������ε�(������û)","������ε�(������û).xls", 8);
	        /*
	        if(ds2.RowCount==0){
	            return;
	        } 
	        getObjectFirst("gr2").SetExcelTitle(0, "");
	        getObjectFirst("gr2").SetExcelTitle(1, "value:������ε�(��������ȭ������); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr2").GridToExcel("������ε�(��������ȭ������)","������ε�(��������ȭ������).xls", 8);
	        
	         if(ds2.RowCount==0){
	            return;
	        } 
	        getObjectFirst("gr3").SetExcelTitle(0, "");
	        getObjectFirst("gr3").SetExcelTitle(1, "value:������ε�(�¹����޴빰ǰ); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr3").GridToExcel("������ε�(�¹����޴빰ǰ)","������ε�(�¹����޴빰ǰ).xls", 8);
	        
	         if(ds2.RowCount==0){
	            return;
	        } 
	        getObjectFirst("gr4").SetExcelTitle(0, "");
	        getObjectFirst("gr4").SetExcelTitle(1, "value:������ε�(������������); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr4").GridToExcel("������ε�(������������)","������ε�(������������).xls", 8);
			*/
		}
    	
		// ���ð�, ��ǰ��ȸ
		function fnSelectDs3() {
		    msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		     
	 		if(lc_code1.ValueOfIndex("detail", lc_code1.Index)=="AR"){
	 		
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=2"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sArriveDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_ARRIVE_TIME_DS=ds_time,O:S_GOODS_DS=ds_goods)",
			        v_param);		

	 		}else{
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=3"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sDepartDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_GOODS_DS=ds_goods,O:S_DEPART_TIME_DS_NEW=ds_time)",
			        v_param);		

	 		} ;

		        
		    tr_post(tr1);
		}

		
		// ��
		function fnClass() {
			if (div == 'init') {
				ln_TRSetting(tr3, 
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		            "JSP(O:DS6=ds_class)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate=<%=firstday%>,sSaupSid=1,sUpjang="+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid"));
		        tr_post(tr3);
			} else {
				ln_TRSetting(tr3, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:DS6=ds_class)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sDate.Text+",sSaupSid=1,sUpjang="+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid"));
	        	tr_post(tr3);
			}
		}

		
		// �� 	
		function fnTeam() {
			if (div == 'init') {
				ln_TRSetting(tr4, 
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		            "JSP(O:DS7=ds_team)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate=<%=firstday%>,sSaupSid=1,sUpjang="
		            		+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ",sClass=" + lc_class.ValueOfIndex("class", lc_class.Index));
		        tr_post(tr4);
			} else {
				ln_TRSetting(tr4, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:DS7=ds_team)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sDate.Text+",sSaupSid=1,sUpjang="
	            			+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ",sClass=" + lc_class.ValueOfIndex("class", lc_class.Index));
	        	tr_post(tr4);
			}
			div='';
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

		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
	</script>	
	
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
	<script language=JavaScript for=lc_class event=OnSelChange()>
		if ( div != 'init' ) {	//��
			div = 'init';
			fnTeam();// �� ȣ��
		}
	</script>

	<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
		fnSelectDs3();
	</script>
	<script language=JavaScript for=ds_goods event=OnLoadCompleted(rowcnt)> <!-- ��ǰ -->
		fnClass();
	</script>
	<script language=JavaScript for=ds_class event=OnLoadCompleted(rowcnt)> <!-- �� -->
		fnTeam();
	</script>
	<script language=JavaScript  for=ds_team event="OnLoadCompleted(row)"> <!-- �� -->
		div=''
	</script>	
<%



/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--��������-->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--��������ȭ������-->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--�¹����޴빰ǰ-->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--������������-->
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
<object id=ds_class classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_team classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
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

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='1002'>	
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
				<table border='0' cellpadding='0' cellspacing='1' width='1002' bgcolor="#666666">
					<tr height='25px'>
						<td width="70px" height="20px" class="text">��û����ȣ</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>            
                                <param name=Format      value="00000000000000">
                                <param name=Alignment   value=1>
                                <param name=ClipMode    value=true>
                                <param name=Border      value=false>
                                <param name=SelectAll   value=true>
                                <param name=SelectAllOnClick      value=true>
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                        <input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                        </td>
						<td align=left class="text" width="50">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							
	                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^70">
							</object>
							
						</td>
						<td align=left class="text"  width="50">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;
							
                            <object id=lc_code1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_code1>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
							</object>
							
	                    </td>						
						<td align=left class="text"  width="60">��������</td>
	                    <td align=left bgcolor="#ffffff" width=150>&nbsp;
							
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
							
						</td>																							
						<td align=left class="text" width="60">��ǰ(��)</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							
                            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=90 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
                                <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^100">
							</object>
							
						</td>
					</tr>
					<tr height='20px'>
						<td align=left class="text">��/��</td>
                        <td align=left bgcolor="#ffffff" colspan=5>&nbsp;																										
                            <object id=lc_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_class>
								<param name=BindColumn      value="class">
                                <param name=BindColVal      value="class">
								<param name=EditExprFormat	value="%,%;class,class_nm">
								<param name=ListExprFormat  value="class_nm^0^70"></object>
                            <object id=lc_team classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_team>
								<param name=BindColumn      value="teams">
                                <param name=BindColVal      value="teams">
								<param name=EditExprFormat	value="%,%;teams,teams_nm">
								<param name=ListExprFormat  value="teams_nm^0^70"></object>
						</td>	
			            <td align=left class="text">��������</td>
			            <td align="left" bgcolor="#ffffff" colspan=3>&nbsp;
	    					<select name="sJobsel"> 
		    					 <option value="0" SELECTED>��ü</option>
								 <option value="1">������</option>
								 <option value="2">�����</option>
								 <option value="3">���������</option>
								 <option value="4">������</option>
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='30px'>
			<td></td>
		</tr>
		<tr>
			<td height="380">
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr valign="top"">
						<td align="left" width="1002" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
							<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:13; top:180; width:845; height:20">
								<param name="BackColor"			value="#00ffff">
								<param name="DisableBackColor"	value="#ffffee">
								<param name="Format"			value='
									<T>divid="mxTab_page1"	title="������û"</T>
									<T>divid="mxTab_page2"	title="��������ȭ��"</T>
									<T>divid="mxTab_page3"	title="�¹����޴빰ǰ"</T>
									<T>divid="mxTab_page4"	title="���������û"</T>
									'>
							</object>
								
							<div class=page id="mxTab_page1" style="position:absolute; left:13; top:200; width:1002; height:300">
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name=ViewSummary     value=1>
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								  	<C> name='���԰�\\����'    	ID='CQ_GUBN'   		width=50 	align=center editlimit=50 show=true SumText='��' SumTextAlign=right</C>
								  	<C> name='������'	    ID='NORTH_PURPOSE_L_CD'	width=50	align=center editlimit=30 show=true SumText=@count SumTextAlign=right</C>
					                <C> name='������'	    ID='NORTH_PURPOSE_S_CD' width=50	align=center editlimit=30 show=true SumText='��' SumTextAlign=left </C>
								  	<C> name='������'   		ID='NORTH_PURPOSE'	width=140 	align=center 	editlimit=61 show=true </C>
									<C> name='�������'    		ID='DEPART_DATE'   	width=80 	align=center editlimit=50 show=true</C>
									<C> name='���ð�'    		ID='DEPART_TIME'   	width=60 	align=center editlimit=50 show=true</C>
									<C> name='�԰�����'    		ID='ARRIVE_DATE'   	width=80 	align=center editlimit=50 show=true</C>
									<C> name='�԰�ð�'    		ID='ARRIVE_TIME'   	width=60 	align=center editlimit=50 show=true</C>
									<C> name='�����ڼ���'	   	ID='DRIVER_NM' 		width=80 	align=center 		editlimit=61 show=true </C>
									<C> name='������(�������)' ID='DRIVER_BIRTHDAY' width=100 	align=center 		editlimit=61 show=true </C>
									<C> name='������Ϲ�ȣ'		ID='CAR_NO'  		width=100 	align=center	editlimit=61 show=true </C>
									<C> name='������Ī' 		ID='RIDE_CAR_NM'  	width=70 	align=center 	editlimit=61 show=true SORT=TRUE</C>
									<C> name='����ȣ��' 		ID='RIDE_CAR_NUM'  	width=55 	align=center 	editlimit=61 show=true </C>
									<C> name='������'   		ID='TARGET_AREA'  	width=50 	align=center 	editlimit=61 show=true </C>
									<C> name='��������'			ID='TOUR_TYPE'  	width=55 	align=center	editlimit=61 show=true </C>
									<C> name='ž���ο�'   		ID='RIDE_PERSONS'  	width=60 	align=center	editlimit=61 show=true </C>
									<C> name='�ѱ⸶���\\��������' ID='GUN_YN'  	width=80 	align=center 		editlimit=61 show=true </C>
									<C> name='������ ������ǰ\\���Կ���'	ID='OUTSRC_YN' width=100 	align=center 	editlimit=61 show=true </C>
									<C> name='�ɻ翩��'   		ID='AUDIT_YN'  		width=60 	align=center 		editlimit=61 show=true </C>
									<C> name='���'   			ID='REMARKS'  		width=80 	align=center 		editlimit=61 show=true </C>
	               					">
							</object>   
								
							</div>
							<div class=page id="mxTab_page2" style="position:absolute; left:13; top:200; width:845; height:300">	
							
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000' height='370px' border='1'>
								<param name="DataID"		value="ds2">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name=ViewSummary     value=1>
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
									<C> name='�Ϸù�ȣ'    				ID='{CURROW}'   	width=70		align=center 	show=true SumText='�Ѱ�'</C>
								  	<C> name='���౸��'    				ID='CQ_GUBN'   	width=70 	align=center editlimit=50 show=true</C>
									<C> name='������Ϲ�ȣ'   			ID='CAR_NO'  		width=100 	align=center	editlimit=61 show=true SumText=@count</C>
								  	<C> name='���԰���'    				ID='DP_AR_DATE'  	width=80 	align=center editlimit=50 show=true</C>
									<C> name='���԰�ð�'    			ID='DP_AR_TIME'   	width=80 	align=center editlimit=50 show=true</C>
									<C> name='����ȭ���̸�'    		ID='FREIGHT_NAME'   		width=200 	align=center editlimit=50 show=true</C>
									<C> name='����ȭ������'    		ID='FREIGHT_AMOUNT'   	width=100 	align=center editlimit=50 show=true</C>
									<C> name='����ȭ����������'    	ID='FREIGHT_UNIT'   		width=200 	align=center editlimit=50 show=true</C>
		           					">
							</object>   
								
							</div>
							<div class=page id="mxTab_page3" style="position:absolute; left:13; top:200; width:845; height:300">	
							
							<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000' height='370px' border='1'>
								<param name="DataID"		value="ds3">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name=ViewSummary     value=1>
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
									<C> name='�Ϸù�ȣ'    				ID='{CURROW}'   	width=70		align=center 	show=true SumText='�Ѱ�'</C>
								  	<C> name='���౸��'    				ID='CQ_GUBN'   	width=70 	align=center editlimit=50 show=true SumText=@count</C>
									<C> name='������Ϲ�ȣ'   			ID='CAR_NO'  		width=100 	align=center	editlimit=61 show=true </C>
								  	<C> name='���԰���'    				ID='DP_AR_DATE'  	width=80 	align=center editlimit=50 show=true</C>
									<C> name='���԰�ð�'    			ID='DP_AR_TIME'   	width=80 	align=center editlimit=50 show=true</C>
									<C> name='�޴�ǰ��'    				ID='CARRY_NAME'   		width=100 	align=center editlimit=50 show=true</C>
									<C> name='�޴�ǰ�԰�'    			ID='CARRY_STANDARD'   	width=100 	align=center editlimit=50 show=true</C>
									<C> name='�޴�ǰ����'    			ID='CARRY_AMOUNT'   		width=100 	align=center editlimit=50 show=true</C>
									<C> name='���Աݾ�(õ��)'    		ID='SUM'   				width=100 	align=center editlimit=50 show=true</C>
		           					">
							</object>   
							</div>

							<div class=page id="mxTab_page4" style="position:absolute; left:13; top:200; width:845; height:300">	
							<object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> width='1000' height='370px' border='1'>
								<param name="DataID"		value="ds4">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name=ViewSummary     value=1>
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
									<C> name='�������ι�ȣ'   		ID='CAR_PERMIT_NO'	width=80	align=left 		editlimit=61 show=true SumText='�Ѱ�'</C>								
									<C> name='������Ϲ�ȣ'   		ID='CAR_NO'  		width=100 	align=center	editlimit=61 show=true </C>							
									<C> name='������(�ֹι�ȣ)'   	ID='REGI_NO'  		width=100 	align=center 		editlimit=61 show=true SumText=@count</C>								
									<C> name='�Ҽ�'   				ID='COMPANY_NM'  	width=80 	align=left 		editlimit=61 show=true </C>
									<C> name='ž���ο�'   			ID='CAR_PERSONS'  	width=60 	align=center	editlimit=61 show=true </C>
									<C> name='������Ī'   			ID='RIDE_CAR_NM'  	width=70 	align=center 	editlimit=61 show=true </C>
									<C> name='���ļ���'   			ID='{STRING(CURROW)}' 	width=60 	align=center 		editlimit=61 show=true </C>
									<C> name='���'   					ID='REMARKS'  		width=80 	align=center 		editlimit=61 show=true </C>
									<C> name='���繰(ǰ��)'    		ID='FREIGHT_NAME'   		width=100 	align=center editlimit=50 show=true</C>
									<C> name='���繰(����)'    		ID='FREIGHT_AMOUNT'   	width=100 	align=center editlimit=50 show=true</C>
									<C> name='���繰(����)'    		ID='FREIGHT_UNIT'   		width=100 	align=center editlimit=50 show=true</C>
									<C> name='���繰(���/�԰�)'  ID='CQ_GUBN'   	width=120 	align=center editlimit=50 show=true</C>
		           					">
							</object>   
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height=24>�� Ȩ>����>����>���԰�ȹ>���� ž�� (���|�԰�) �޴����� <B>�����ڰ� �������� ���� ����</B>�� ��ȸ���� �����˴ϴ�.<BR>
			�� ������Ī, ����ȣ��, ž���ο��� <B>[���|�԰�]</B> ���ǿ� ���� ��µ˴ϴ�.<BR>
			* �׼� �ٿ� �� ��� �÷��� <B>TEXT</B>�Դϴ�. �Ǿ�� ����~!!
			</td>
		</tr>
		
	</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		