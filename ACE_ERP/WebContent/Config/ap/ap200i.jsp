<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: �̰��� - �޴�����
 * ���α׷�ID 	: ap200i
 * J  S  P		: ap200i
 * �� �� ��		: Ap200I
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2011-08-31
 * [ �������� ][������] ����
 * [2010-08-20][�ɵ���] ���� ����.
 * [2010-08-20][�ɵ���] ���� ����.
 *						���񽺿�û�� ���ڰ����� �̰��� - �α� ����ڰ� ������ ������ ������ ��ȸ
 *						�׸��� ���� ����Ŭ���ϸ� ���� �� �� ~ ���� ��ܺ�= ���������, �ߴ��� ���繮���� ����
 *						 �ϴ��� ÷������ ���(�� ���ϵ��� �����ζ� �뷮�� ������)
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

		//��Ű�ҷ����� ����
		String v_login_name ="";
		String v_login_id = "";
		Cookie cookies[] = request.getCookies();
	     if(cookies != null) {
	          for(int i=0; i<cookies.length; i++){
	               if(cookies[i].getName().equals("vusrid") ) {
	                    v_login_id = cookies[i].getValue() ;	//=> cookie���� �� �����Ҷ� ���                             
	               }
	               if(cookies[i].getName().equals("vusrnm") ) {
	                    v_login_name = cookies[i].getValue() ;	//=> cookie���� �� �����Ҷ� ���                             
	               }
	          }
	     } 
		//��Ű�ҷ����� ��
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

			cfStyleGrid(getObjectFirst("gr1"), "comn");
				
			fnInit();
		} 
		 
		function fnInit() {
			div = 'init';
			
			ds_doc_gu.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=AP001&s_item1=Y";
            ds_doc_gu.Reset();	//���� ��������
			
		}
		
		// ���� ��ȸ
		function fnSelect() {
        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",v_empno="+ sNowEmpno.value
			          + ",v_fr_date=" + getObjectFirst("v_fr_input_date").Text
			          + ",v_to_date=" + getObjectFirst("v_to_input_date").Text
			          + ",v_doc_gu=" + v_doc_gu.ValueOfIndex("detail", v_doc_gu.Index)
			          + ",v_client_sid=" + sClientSid.value
			          + ",v_accept_no=" + getObjectFirst("v_accept_no").Text
						;
						
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_MY%>My400I",
			    "JSP(O:MASTER=ds1)",
			    param);
			   
			tr_post(tr1);
		}
			

		// ����
		function fnApply() {
			if (ds1.isUpdated ){ 
		        v_job = "I";	
		         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
		
		         ln_TRSetting(tr1, 
		             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv300I",
		             "JSP(I:MASTER=ds1,O:msgDS=msgDS)",
		             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
		         tr_post(tr1);
	         }
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
	            
	            //fnSelectBound();
	        }
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
	

<%
/****************************************************************************
			���콺 ������Ʈ �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
<script language=javascript for=gr1 event="OnDblClick(Row,Colid)">
    if(Row==0) return;
	var apURL ="../help/my400h.jsp?ap_m_sid="+ds1.namevalue(Row,"ap_m_sid");
   	window.open(apURL,"ap_doc_service","width=720,height=585,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
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


<object id=ds_doc_gu classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
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
						<td style="padding-bottom:6px" align=right>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	onclick="fnSelect()">&nbsp;
						</td>
					</tr>
					<tr>
						<td>
							<table border='0' cellpadding='0' cellspacing='1' bgcolor='#666666' width=845>
							  <tr>
								<td align="center" width="70px" height="30px" class="text" >������</td>
								<td width=160 align="left"  bgcolor="#ffffff">&nbsp;
		                            <input type="text" name='sNowEmpnm' id='sNowEmpnm' value='<%=v_login_name%>' size='8' readonly='readonly'  class='boardt04'>
		                            <input type="text" name='sNowEmpno' id='sNowEmpno' value='<%=v_login_id%>' size='7' readonly='readonly'  class='boardt04'>
								</td>
								 <td width="70px" height="25px" class="text">�������</td>
	                             <td width=260 align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=v_fr_input_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
		                                <param name=Text        value="">
		                                <param name=Alignment   value=1>
		                                <param name=Format      value="0000-00-00">
		                                <param name=Cursor      value="iBeam">
		                                <param name=Border      value="false">      
		                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
		                                <param name=ReadOnly    value="false">
		                                <param name=SelectAll   value="true">
		                                <param name=SelectAllOnClick    value="true">
		                                <param name=SelectAllOnClickAny   value=false>
		                            </object>&nbsp;~&nbsp;
		                            <object id=v_to_input_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
		                                <param name=Text        value="">
		                                <param name=Alignment   value=1>
		                                <param name=Format      value="0000-00-00">
		                                <param name=Cursor      value="iBeam">
		                                <param name=Border      value="false">      
		                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
		                                <param name=ReadOnly    value="false">
		                                <param name=SelectAll   value="true">
		                                <param name=SelectAllOnClick    value="true">
		                                <param name=SelectAllOnClickAny   value=false>
		                            </object>
		                            <%=HDConstant.COMMENT_END%> 
                                </td>
                                <td align=left class="text" width="60">��������</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_doc_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
                                    	<param name=ComboDataID     value=ds_doc_gu>
                                    	<param name=ListExprFormat  value="detail_nm^0^70">                                        
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
				              </tr>
							</table>
							<table border='0' cellpadding='0' cellspacing='1' bgcolor='#666666' width=845>
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

                              <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
								<%=HDConstant.COMMENT_END%>
                              </td>

				            </tr>					              
						  </table>
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
								<param name="Editable"		value="true">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              <C> name='����SID'    	ID='ap_m_sid'   	width=80	align=left editlimit=5 show=FALSE edit=none</C>
									  <C> name='��������'     	ID='doc_gu'       	width=60	align=center show=FALSE </C>
						              <C> name='��������'    	ID='doc_gu_nm'   	width=70 	align=center editlimit=50 show=true suppress=1 edit=none</C>
						              <C> name='������ȣ'		ID='doc_no'   		width=100 	align=left editlimit=20 show=true edit=none</C>
						              <C> name='�������'    	ID='ap_status_m'   	width=60 	align=center editlimit=16 show=FALSE edit=none</C>
						              <C> name='�������'     	ID='ap_status_m_nm'	width=60 	align=center editlimit=30 show=true edit=none</C>
						              <G> name='����������'
						              	<C> name='���' 		ID='l_empno'     	width=60 	align=center editlimit=30 show=true edit=none</C>
						             	<C> name='����'  	  	ID='l_empnm'   		width=60 	align=center editlimit=30 show=true edit=none</C>
									  </G>
						              <C> name='�� ���缱'      ID='cnt_all_ap'     width=60 	align=center editlimit=50 show=false edit=none</C>
						              <C> name='�̰� ����'   	ID='cnt_not_ap'  	width=60 	align=center editlimit=61 show=false edit=none</C>
						              <G> name='�����'
							          	<C> name='���'  		ID='i_empno'    	width=60 	align=center editlimit=10 show=true edit=none</C>
							            <C> name='����'     	ID='i_empnm'       	width=60 	align=center editlimit=10 show=true edit=none</C>
									  </G>
						              <C> name='����Ͻ�' 		ID='i_date' 		width=80 	align=left editlimit=10 show=true edit=none</C>
						              <C> name='�ǰ� ��'    	ID='cnt_desc'   	width=50	align=center editlimit=14 show=true edit=none</C>
						              <C> name='�븮��'     	ID='client_nm'		width=100 	align=left editlimit=30 show=true edit=none</C>
						              <C> name='��û����ȣ'    	ID='accept_no'		width=100 	align=center editlimit=30 show=true edit=none mask='XXXXX-XXXXXXXXX'</C>
						              <G> name='������'
							          	<C> name='���'     	ID='u_empno'     	width=60 	align=center editlimit=10 show=false edit=none</C>
						              	<C> name='����' 		ID='u_empnm' 		width=60 	align=center editlimit=12 show=false edit=none</C>
									  </G>
               					">
							</object>   
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>

			</td>
		</tr>

		<tr>
			<td>�� �̰��� : �ڽ��� ������ ������ ��ȸ�˴ϴ�.<br>
			�� 
			</td>
		</tr>

	</table>
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

