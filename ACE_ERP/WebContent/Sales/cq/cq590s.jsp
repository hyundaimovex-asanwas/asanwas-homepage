<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ȣ������
 * ���α׷�ID 	: CQ210I
 * J  S  P		: cq210i
 * �� �� ��		: Cq210I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-11
 * [��  ��   ��  ��][������] ����
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
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
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
			
			div.value = 'init';
			
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_SAUP_DS=initDs1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		}
		
		/*
		 * ���ð�, ��ǰ��ȸ
		 */		
		function fnSelectDs3() {
		
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            + "sSaupSid=" + initDs1.namevalue(initDs1.rowposition,"saup_sid") + ","
				+ "sDepartDate=" + sBgnDate.text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_DEPART_TIME_DS=initDs2,O:S_GOODS_DS=initDs3)",
	            param);
	        tr_post(tr2);
		}	
		
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoodSid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sDepartDate=" + sBgnDate.text
			          + ",sDepartTime=" + lc2.ValueOfIndex("depart_time",lc2.Index)
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq590S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
   function fnExcelDs() {
        if(ds1.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:�ݰ������ī��߱޿� ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�ݰ������ī��߱޿�", "�ݰ������ī��߱޿�.xls", 8);
    }	
		</script>

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
        document.all.LowerFrame.style.visibility="hidden"; 
	</script>	

    <script language="javascript" for="tr1" event="OnFail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    
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
	
    <script language=JavaScript for=gr1 event="OnPopup(Row,Colid,data)">
        if(Row==0) return;
        if(Colid == "TEAMS_CUST_NM"){
            fnDrivePeoplePopup("50");
        } else if(Colid == "DRIVE_CUST_NM"){
            fnDrivePeoplePopup("60");
        } else if(Colid="CAR_NO"){
            fnCarInfoPopup();
        }
    </script>

    <script language=JavaScript for=gr1 event="OnExit(Row,Colid,olddata)">
        if(Row==0) return;
        if(Colid == "TEAMS_CUST_NM"){
            if(ds1.NameValue(Row, Colid) != olddata){
                ds1.NameValue(Row, "TEAMS_CUST_SID") = 0;
            }
        } else if(Colid == "DRIVE_CUST_NM") {
            if(ds1.NameValue(Row, Colid) != olddata){
                ds1.NameValue(Row, "DRIVE_CUST_SID") = 0;
            }
        } else if(Colid="CAR_NO"){
            if(ds1.NameValue(Row, Colid) != olddata){
                ds1.NameValue(Row, "CAR_SID") = 0;
                ds1.NameValue(Row, "CAR_NM") = "";
            }
        }
    </script>
    
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)"> <!-- ���� -->
			if (row <1) return;
			for (i = 1; i <= ds1.countrow; i++) {
				ds1.namevalue(i, "is_flag") = ds1.namevalue(i,"status_cd");
			}
	</script>
	
	<script language=JavaScript  for=initDs1 event="OnLoadCompleted(row)"> <!-- ���� -->
			fnSelectDs3();
	</script>
	
	<script language=JavaScript  for=initDs2 event="OnLoadCompleted(row)"> <!-- ���ð� -->
			//initDs2.deleteRow(1); <!-- ��ü ���� -->
			//lc2.Index = 0;
	</script>
	
	
	<script language=JavaScript  for=initDs3 event="OnLoadCompleted(row)"> <!-- ��ǰ -->
			div.value = '';
			//initDs3.deleteRow(1);
			//lc3.Index = 0;
	</script>
	
	
	<script language=JavaScript for= lc1 event=OnSelChange()> <!-- ���� ü���� -->
		if ( div.value != 'init') {
			fnSelectDs3();
		}
	</script>
	
	<script language=JavaScript for=sBgnDate event=OnKillFocus()> <!-- ���ð� ���� -->
		if ( div.value != 'init' ) {	//�������
			if ( sBgnDate.Modified ) {
				div.value = 'init';
				fnSelectDs3();			
			}
		}				
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

<object id=initDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=initDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ð� -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=initDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ -->
	<param name="SyncLoad" 	value="true">
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
			<td>
				<table border='0' cellpadding="0" cellspacing="0" width="845"> 
					<tr>
						<td align=right>
							<table width='845'>
									<tr>
										<td align=right>
											<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
											<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:hand"	align=absmiddle onclick="fnExcelDs()"> 		<!-- ���� -->
										</td>
									</tr>
								</table>
						</td>
					</tr>
					<tr height="10px">
						<td></td>
					</tr>
					<tr height="30px">
						<td width=845>
							<table border='0' cellpadding="0" cellspacing="1" width="845" bgcolor="#666666">
								<tr height='30px'>
									<td align=left class="text" width="80px">����</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=initDs1>
											<param name=BindColumn      value="saup_sid">
				                            <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^120">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
									<td align=left class="text"  width="80">�������</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											<param name=Text 				value="">
											<param name=Alignment 			value=1>
											<param name=Format 				value="0000-00-00">
											<param name=Cursor	 			value="iBeam">
											<param name=Border	 			value="false">		
											<param name=InheritColor      	value="true">																																																				
											<param name=ReadOnly  			value="false">
											<param name=SelectAll  			value="true">
											<param name=SelectAllOnClick  	value="false">																					
										</object>&nbsp;
									
				                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
											<param name=ComboDataID		value=initDs2>
											<param name=BindColumn      value="depart_time">
				                            <param name=BindColVal      value="depart_time">
											<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
											<param name=ListExprFormat  value="depart_time_nm^0^50">
										</object>
										<%=HDConstant.COMMENT_END%>																				
									</td>																							
									<td align=left class="text" width="80">��ǰ����</td>
				                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
				                        <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
											<param name=ComboDataID		value=initDs3>
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
				</table>
			</td>
		</tr>
		<tr height="10px">
			<td></td>
		</tr>
		<tr>
			<td colspan=2>
				<table border='0' cellpadding="0" cellspacing="0" width="845"> 
					<tr>
						<td width='845'>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
                                <Param Name="AllShowEdit"   value="True">
								<param name="Format" 			value="
					               	<C> name='��û����ȣ'		ID='ACCEPT_NO'	 	width=100 align=left editlimit=14 show=true</C>
									<C> name='����'			ID='CUST_NM'	 	width=100 align=left editlimit=30 show=true</C>
									<C> name='�ֹε�Ϲ�ȣ'	ID='MANAGE_NO'	 	width=100 align=left editlimit=20 show=true</C>
									<C> name='����'			ID='SEX'	 		width=40 align=center editlimit=1 show=true</C>
									<C> name='�����'		ID='DEPART_DATE'	width=100 align=center editlimit=8 show=true mask='XXXX-XX-XX'</C>
									<C> name='�ڽ�'			ID='COURSE'	 		width=40 align=center editlimit=2 show=true</C>
									<C> name='���ǹ�ȣ'		ID='ROOM_NO'	 	width=70 align=left editlimit=1 show=true</C>
									<C> name='�������'		ID='STATUS'	 		width=70 align=center editlimit=1 show=true</C>
									<C> name='�¼�����'		ID='RIDE_YN'	 	width=70 align=left editlimit=1 show=true</C>
									<C> name='����'			ID='COMPANY_NM'	 	width=100 align=left editlimit=30 show=true</C>
									<C> name='����'			ID='POSITIONS'	 	width=100 align=left editlimit=30 show=true</C>
									<C> name='����ȭ'		ID='TEL_NO'	 		width=100 align=left editlimit=20 show=true</C>
									<C> name='�ּ�1'			ID='ADDRESS1'	 	width=100 align=left editlimit=265 show=true</C>
									<C> name='�ּ�2'			ID='ADDRESS2'	 	width=100 align=left editlimit=60 show=true</C>
									<C> name='��ݱ���'		ID='AGE_CD'			width=70 align=center editlimit=1 show=true</C>
									<C> name='�ǸŰ�'		ID='TOUR_AMT'	 	width=100 align=right editlimit=11 show=true dec=0</C>
									<C> name='�Աݾ�'		ID='PAY_AMT'	 	width=100 align=right editlimit=11 show=true dec=0</C>
									<C> name='������'		ID='CUST_GU'	 	width=70 align=center editlimit=1 show=true</C>
									<C> name='��ü�ڵ�'		ID='GROUP'	 		width=70 align=left editlimit=1 show=true</C>
									<C> name='����㰡'		ID='NORTH_PERMIT'	width=70 align=center editlimit=1 show=true</C>
									<C> name='�븮���ڵ�'		ID='CLIENT_CD'	 	width=80 align=center editlimit=14 show=true</C>
									<C> name='�ڵ���'		ID='MOBILE'	 		width=100 align=left editlimit=20 show=true</C>
									<C> name='�Է���'		ID='WRITER'	 		width=100 align=left editlimit=10 show=true</C>
									<C> name='���ڵ�'		ID='CLASS'	 		width=60 align=center editlimit=3 show=true</C>
									<C> name='���ڵ�'		ID='TEAMS'	 		width=60 align=center editlimit=3 show=true</C>
									<C> name='��������'		ID='TOUR_NO'	 	width=100 align=left editlimit=20 show=true</C>
									<C> name='��ǰ�ڵ�'		ID='GOODS_CD'	 	width=100 align=left editlimit=7 show=true</C>
									<C> name='�������'		ID='BIRTHDAY'	 	width=100 align=center editlimit=8 show=true mask='XXXX-XX-XX'</C>
									<C> name='�ݸ�'			ID='CLASS_NM'		width=100 align=left editlimit=50 show=true</C>
									<C> name='������'		ID='ARRIVE_DATE'	width=100 align=center editlimit=8 show=true mask='XXXX-XX-XX'</C>

								 ">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<input type='hidden' name='div' value=''>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

