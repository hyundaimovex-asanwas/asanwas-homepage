<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������������
 * ���α׷�ID 	: RV300I
 * J  S  P		: rv300i
 * �� �� ��		: Rv300I
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2010-05-17
 * [ �������� ][������] ����
 * [2010-05-17][�ɵ���] ���� ����.
 *						��ǰ������ "��ü"�� 1�� �ν��ؼ� �״�� �������� �ҷ�����..
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

			cfStyleGrid(getObjectFirst("gr1"), "comn");
				
			fnInit();
		} 
		 
		function fnInit() {
			div = 'init';
		}
		
		// ���� ��ȸ
		function fnSelect() {
        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sClient_sid=" + sClientSid.value
			          + ",v_accept_no=" + v_accept_no.Text
			          + ",v_bound_seq=" + v_bound.ValueOfIndex("bound_seq", v_bound.Index)
			          + ",v_pay_seq=" + v_payseq.ValueOfIndex("pay_seq", v_payseq.Index)
						;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv300I",
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
	            
	            fnSelectBound();
	        }
	    }

		//��ǰ����
		function fnSelectBound(){
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                  + ",v_accept_no=" + v_accept_no.Text;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv300I",
	            "JSP(O:DS_BOUND=ds_bound)",
	            param);
	           
	        tr_post(tr1);
	    }
	    
		//��������
		function fnSelectPayseq(){
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                  + ",v_accept_no=" + v_accept_no.Text
				          + ",v_bound_seq=" + v_bound.ValueOfIndex("bound_seq", v_bound.Index)
		                  ;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv300I",
	            "JSP(O:DS_PAYSEQ=ds_payseq)",
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
	
	<script language=JavaScript	for=v_accept_no event="OnKillFocus()">
		fnSelectBound();
	</script>
	<script language=JavaScript for=v_bound event=OnSelChange()>
	 	if( div !="loadBound"){
			fnSelectPayseq();
		}
	</script>
	
	 <script language=JavaScript  for=ds_bound event="OnLoadCompleted(row)">
	 	div = "loadBound";	
 		ds_bound.insertrow(1);
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_SEQ") = "0";
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_NM") = "��ü";
		v_bound.Index = 0; 
		div="";		
    </script>
	<script language=JavaScript  for=ds_payseq event="OnLoadCompleted(row)">
 		ds_payseq.insertrow(1);
		ds_payseq.namevalue(ds_payseq.rowposition, "PAY_SEQ") = "0";
		ds_payseq.namevalue(ds_payseq.rowposition, "PAY_NM") = "��ü";
		v_payseq.Index = 0;
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


<object id=ds_bound classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ���� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_payseq classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
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
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
						</td>
					</tr>
					<tr>
						<td>
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
                                    <td width="60" height="25" class="text" >��������</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_payseq classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=50 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_payseq>
                                            <param name=SearchColumn	value="PAY_NM">
                                            <param name=BindColumn  	value="PAY_SEQ">
                                            <param name=ListExprFormat  value="PAY_NM^0^50">
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
						              <FC> name='�븮���ڵ�'    ID='client_cd'   	width=80	align=left editlimit=5 show=false edit=none</FC>
									  <FC> name='��������'     	ID='pay_seq'       	width=60	align=center editlimit=2 show=true </FC>
						              <FC> name='�븮����'    	ID='client_nm'   	width=100 	align=left editlimit=50 show=true suppress=1 edit=none</FC>
						              <FC> name='��û����ȣ'    ID='accept_no'   	width=100 	align=left editlimit=16 show=true edit=none</FC>

						              <FC> name='�����'    	ID='depart_date'   	width=60 	align=center editlimit=16 show=true edit=none</FC>
						              <FC> name='��ǰ��'      	ID='goods_nm'     	width=80 	align=left editlimit=30 show=true edit=none</FC>
						              <FC> name='����'      	ID='cust_nm'     	width=60 	align=left editlimit=30 show=true edit=none</FC>
						              <C> name='������'    		ID='m_cust_nm'   	width=60 	align=left editlimit=30 show=true edit=none</C>
						              <C> name='����'      		ID='join_cd'     	width=40 	align=left editlimit=50 show=true edit=none</C>
						              <C> name='����/����'   		ID='company_nm'  	width=200 	align=left editlimit=61 show=true edit=none</C>
						              <C> name='��������ȣ'    	ID='manage_no'   	width=100	align=left editlimit=14 show=true edit=none</C>
						              <C> name='�ּ�'     		ID='address1'    	width=150 	align=left editlimit=60 show=true edit=none</C>
						              <C> name='��/��'        	ID='class'       	width=80 	align=left editlimit=54 show=true edit=none</C>
						              <C> name='���ǵ��' 		ID='room_type_cd' 	width=60 	align=left editlimit=10 show=true edit=none</C>
						              <C> name='���ȣ'      	ID='room_no'     	width=60 	align=left editlimit=10 show=true edit=none</C>
						              <C> name='�������' 		ID='tot_tour_amt' 	width=80 	align=right editlimit=12 show=true decao=0 edit=none</C>
						              <C> name='�ɼǿ��' 		ID='tot_opt_amt' 	width=80 	align=right editlimit=12 show=true decao=0 edit=none</C>
						              <C> name='����ó(����)'    	ID='tel_no'      	width=150 	align=left editlimit=20 show=true edit=none</C>
						              <C> name='����ó(�ڵ���)'    	ID='mobile_no_full'      	width=150 	align=left editlimit=20 show=true edit=none</C>
						              <C> name='�Է���'			ID='i_empnm'		width=60	align=left show=true	 edit=none</C>
 						              <C> name='������'			ID='u_empnm'		width=60	align=left show=true	 edit=none</C>
						              <C> name='M_RSV_SID'    	ID='m_rsv_sid'   	width=100 	align=left editlimit=12 show=false edit=none</C>
						              <C> name='RSV_SID'      	ID='rsv_sid'     	width=100 	align=left editlimit=12 show=false edit=none</C>
   						              <C> name='�湮Ƚ��'		ID='north_cnt'		width=60	align=right show=true dec=0 edit=none</C>
   						              <C> name='������'		ID='cust_gu'		width=60	align=left show=true dec=0 edit=none</C>
                                      <C> name='��������'       ID='regi_yn_t_name' width=70 	align=CENTER	Edit=None</C>
                                      <C> name='��������'       ID='arrive_date' 	width=60 	align=CENTER	Edit=None</C>
                                      <C> name='���ͽð�'       ID='arrive_time' 	width=60 	align=CENTER	Edit=None</C>
						              <C> name='�������'   	ID='remarks'  		width=200 	align=left editlimit=61 show=true edit=none</C>
						              <C> name='��ġ��'        ID='empnm'       	width=50 	align=left editlimit=20 show=true edit=none</C>
               					">
							</object>   
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>

			</td>
		</tr>

		<tr>
			<td>�� ���������� �⺻������ <b>1</b>�� �����˴ϴ�. <br>
			�� ���� ��û����ȣ�� ��ǰ������ ���������鼭 ���� �ٸ� ������ ��� ������ ��������(2,3, ... , 99 )�� �����ϸ� �˴ϴ�.
			</td>
		</tr>

	</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

