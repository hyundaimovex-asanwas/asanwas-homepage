<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���� ���� ��!
 * ���α׷�ID 	: AC910I
 * J  S  P		: ac910i
 * �� �� ��		: Ac910I
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-06-13
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
//	    date.add(java.util.Calendar.DATE, -28);
	    String thisMonth = m_today.format(date.getTime()); 
//	    date.add(java.util.Calendar.DATE, +30);
//	    String endday = m_today.format(date.getTime());  
   
 		 
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
		/*
		 * �������ε� 
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			fnInit();
			sMonth.Text='<%=thisMonth%>';
		} 
		 
		function fnInit() {
	
		}
		 
		//����
		function fnApply() {
			v_job = "I";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac910I",
			    "JSP(I:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
            if(ds1.IsUpdated){     
                alert("�������� �����Ͱ� �ֽ��ϴ�.");
                return;    
            } 
			
			v_job = "S";
			            
            if(getObjectFirst("sMonth").Text.trim()=="" 
                || getObjectFirst("sMonth").Text.trim().length!=6){
                alert("���� ��)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("sMonth").Focus();
                return;
            }
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			          + ",sFr_date=" + sMonth.Text+"01"
			          + ",sTo_date=" + sMonth.Text+"31"
			      
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac910I",
			    "JSP(O:DS1=ds1,O:DS2=ds2)",
			    param);
			   
			tr_post(tr1);
		}
		
		 /*
		 * ����
		 */
		function fnCreate() {
			
		}
		
	
		</script>

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {	//�μ�Ʈ�� ��..
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            fnSelect();
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";	
	</script>	
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && colid=='close_yn' ) {
		     	if ( ds1.namevalue(1,colid) == 'T' ) {
				   	for(i=1;i<=ds1.CountRow;i++)
			     		ds1.namevalue(i,colid) = 'F';
			    } else {
				   	for(i=1;i<=ds1.CountRow;i++)
			     		ds1.namevalue(i,colid) = 'T';			    
			    }
		   }
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

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
			<td>
				<table border='0' cellpadding="0" cellspacing="0" width="545"> 
					<tr height="30px">
						<td width=545>
							<table border='0' cellpadding="0" cellspacing="1" width="345" bgcolor="#666666">
								<tr>
									<td align=left class="text"  width="110">���� ��</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sMonth classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											 <param name=Format      value="YYYY-MM">
                                            <PARAM NAME=InputFormat value="YYYYMM">
                                            <param name=Alignment   value=1>
                                            <param name=ClipMode    value=true>
                                            <param name=Border      value=false>
                                             <param name=SelectAll   value=true>
	                                        <param name=SelectAllOnClick      value=true>
	                                        <param name=SelectAllOnClickAny   value=false>																			
										</object>
										<%=HDConstant.COMMENT_END%>
								 	</td>
								</tr>
							</table>
						</td>
					 	<td width='500' align=right>
							<table width='500'>
								<tr>
									<td align=right>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
										<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand"	align=absmiddle onClick="fnApply()">		<!--  -->
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
			<td>
				<table border='0' cellpadding="0" cellspacing="0" width=100%> 
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="true">
								<param name=UsingOneClick  	value="1">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								  <C> name='�������'    	ID='DEPART_DATE'   		width=90 	align=center 	edit=none   editlimit=8 mask=XXXX-XX-XX show=true suppress=11</C>
								  <C> name='��ǰ'  		ID='GOODS_NM' 			width=120	align=center	edit=none 	editlimit=10 show=true</C>
								  <C> name='�������Ρ�'	ID='CLOSE_YN'    		width=65 	align=center 	editlimit=1 show=true editstyle=checkbox</C>
								  <C> name='��ǰSID'		ID='GOODS_SID' 			width=120	align=center	edit=none 	editlimit=10 show=false</C>
								 ">
							</object>   
							<%=HDConstant.COMMENT_END%>		
						</td>
						<td width=10></td>
						<td align=right>
							<%=HDConstant.COMMENT_START%>
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='500px' height='370px' border='1'>
								<param name="DataID"		value="ds2">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="true">
								<param name=UsingOneClick  	value="1">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								  <C> name='�������'    	ID='DEPART_DATE'   	width=90 	align=center 	edit=none   editlimit=8 mask=XXXX-XX-XX show=true suppress=11</C>
								  <C> name='2N'  		ID='G2N' 			width=55	align=center	edit=none 	editlimit=10 show=true</C>
								  <C> name='1NA'  		ID='G1NA' 			width=55	align=center	edit=none 	editlimit=10 show=true</C>
								  <C> name='1NB'  		ID='G1NB' 			width=55	align=center	edit=none 	editlimit=10 show=true</C>
								  <C> name='D'  		ID='GD' 			width=55	align=center	edit=none 	editlimit=10 show=true</C>
								  <C> name='S1'  		ID='GS1N' 			width=55	align=center	edit=none 	editlimit=10 show=true</C>
								  <C> name='S2'  		ID='GS2N' 			width=55	align=center	edit=none 	editlimit=10 show=true</C>
								  <C> name='2N(N)'  	ID='G2NN' 			width=55	align=center	edit=none 	editlimit=10 show=true</C>
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

