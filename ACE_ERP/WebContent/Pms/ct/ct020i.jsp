<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: �����ݵ��(���ް��)
 * ���α׷�ID 	: CT020 (�ڵ�� �빮��)
 * J  S  P		: ct020 (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��		: Ct020
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-07-28
 * �������	: �����ݵ��(���ް��) ���/��ȸ/����
 * ��������	: �ű�
 * [��  ��   ��  ��][������] ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>	
	<script language="javascript">
	
		get_cookdata();
		var gs_userid = gusrid;
		var gs_fdcode = gfdcode;
		var v_default_row = 1;

	   	/*
	 	 * ������ �ε�
	 	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			fnInit();
			cfStyleGrid(getObjectFirst("gr1"), "comn");	//�����ݵ��(���ް��) ����
		}

		/*
		 * �ʱ�ȭ �۾�
		 */
		function fnInit(){ 
		
		    //�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct020I",
	            "JSP(O:DS1=ds1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
	        
		}

		/*
		 * �����ͼ� ��� ���� (����)
		 */	
		/*
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				+
				"site_sid:INT,site_cd:STRING,site_nm:STRING,site_joint_nm:STRING,site_main_nm:STRING,site_attr1_nm:STRING,site_attr2_nm:STRING,site_joint:STRING,site_main:STRING,site_attr1:STRING,site_attr2:STRING,orderer_sid:INT,vend_cd:STRING,orderer_nm:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}
		*/
		
		/*
		 * �����ݵ��(���ް��) ������ȸ
		 */
		function fnSelect(){   
		
			if(getObjectFirst("v_site_nm").value.trim()==""){
                alert("����� <%=HDConstant.A_MSG_MUST_INPUT%>");
                //getObjectFirst("v_site_nm").Focus();
                return;
            }
            
			if (ds1.IsUpdated) {
				alert("�������� ���� �ֽ��ϴ�.");
			} else {
					    //gr1.ReDraw = "False";
				        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                    + ",dsType=1"  
				                    + ",v_site_sid="+ v_site_sid.value
									+ ",v_site_seq_ct=" + v_site_seq_ct.value
									; 
						//alert(v_param);
				        ln_TRSetting(tr1, 
				            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct020I",
				            "JSP(O:DS1=ds1)",
				            v_param);
				        tr_post(tr1);
			}
		} 
		
		/*
		 * �����ݵ��(���ް��)  ���� 
		 * ���� �׼ǽ� �ٷ� ����
		 */
		function fnDeleteRowDs1() {			
		
			if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")) {
				ds1.deleterow(ds1.rowposition);
				fnApply();
				window.status="�����ݵ��(���ް��) �������� �����Ǿ����ϴ�.";
			
				return;
			}
		}

		/*
		 * ����
		 * 
		 */
		function fnApply(){
		
			var row=ds1.countRow;
			
			if(getObjectFirst("amt_ac_tot").value.trim()==""){
                alert("������ <%=HDConstant.A_MSG_MUST_INPUT%>");
                return;
            }
            if(getObjectFirst("date_rqst").text.trim()==""){
                alert("û������ <%=HDConstant.A_MSG_MUST_INPUT%>");
                return;
            }
			
			if (ds1.IsUpdated) {
				if(ln_Chk()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_CT%>Ct020I",
	                "JSP(I:DS1=ds1)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
	                //prompt('ds1',ds1.text);
            		tr_post(tr1);
            	}
			}else {
         		alert("������Ʈ�� ���� �����ϴ�.");
		 	}
		}

		/*
		 * ��� 
		 * ���ް��, ��������, ���ް�ຯ��
		 */
		function fnCancel(){
		
			if(ds1.IsUpdated) {
				ds1.undoall();
			}
			window.status="������ ������ ��ҵǾ����ϴ�.";
			return;
		}

		/*
		 * ���� 
		 */
		/*
		function fnExcelGr1(){
			gr2.runexcel("�����ڵ����");
		}
		*/
		
		<%//���� ��%>
	    function fnSelSitePopup(dirPath) {
	        v_cust_row = 0;
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	
	        
	        arrResult = fnCtSitePop(dirPath);
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            //v_coop_cd.value = arrParam[0];	//CD
	            v_site_nm.value = arrParam[1];	//NM
	            v_site_sid.value = arrParam[2];	//SID
	        } else {
				fnSelSiteCleanup();
	        }               
	    }
	    
		/*
		 * �Է°� üũ 
		 */
		function ln_Chk() {
			
			var row1=ds1.countrow;
			for(i=1;i<=row1;i++) {
				if(ds1.namevalue(i,"site_seq_ct")=="") {
					alert("��������� �Է��� �ֽʽÿ�");
					site_seq_ct.focus();
					return;
				}
			}		
			return true;
		}
		
	     function fnSelSiteCleanup(){
	        v_site_nm.value = "";
	        v_site_sid.value  = "";
  		 }
   
</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--������ ���(���ް��)-->
	<param name="SyncLoad" 	value="true">
</object>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--�������-->
	<param name="SyncLoad" 	value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
		<!-- 
			������ �۾� �Ϸ�
		-->
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
		<!-- 
			������ �۾� ����
		-->
		<script language="javascript" for="tr1" event="onfail()">
			window.status="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>
</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border='0' cellpadding='0' cellspacing='0' width="845px"> 
 	<tr>
    	<td align='right'>
        	<table border='0' cellpadding='0' cellspacing='0' width='845px'>
            	<tr>
                	<td height='25px' align='right'>
                        <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" 	onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" 	onClick="fnApply();">
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"   onclick="fnCancel()">
                    </td>
              </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width='845px'>
            <table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
            	<tr>
                	<td align="center" class="text" width="100">�����</td>
                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup('<%=dirPath%>');" alt="��ȸâ ��">
                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSiteCleanup();" alt="�� �����">
                    </td>
                    <td align="center" class="text" width="100">�������</td>
                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="txt_head" name='v_site_seq_ct' id="v_site_seq_ct" style="width:200px;" class="textbox"  onkeydown="if(event.keyCode==113) fnCtOrdererPopup('<%=dirPath%>');" >
                    </td>
                </tr>					
			</table>
		</td>
	</tr>
	<tr height="15">
		<td></td>
	</tr>	
	<tr>
		<td>
			<table  width="845px"  cellpadding="0" cellspacing="0">
				<tr>
					<td valign='top' colspan="0"  align="left">
						<table width=290px; border="0" cellpadding="0" cellspacing="0" >
							<tr>
								<td align="left" valign="top" width=290px; >
									<%=HDConstant.COMMENT_START%>
									<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=290px; height:300px" border="1">
										<param name="DataID"				value="ds1">
										<param name="BorderStyle"   	value="0">
										<param name="Fillarea"			value="true">
										<param name="ColSizing"     	value="true">
										<param name="IndWidth"     		value="0">
										<param name="editable"      		value="true">
										<param name="ViewSummary"       value="1">
										<param name="LineColor" 		value="#dddddd">
										<param name="Format"		value="  
										
											<C> name='������sid' 	ID='ac_sid' 	Width=70  align=left editlimit=100	SumText='��' decao=0</C>
											<C> name='����sid'  		ID='site_sid'  	Width=70  align=left editlimit=50	decao=0</C>			
											<C> name='�������' 		ID='site_seq_ct'    	width=80   align=CENTER	decao=0</C>
											<C> name='�������' 		ID='date_ct'    		width=90 	align=CENTER	</C>
											<C> name='����'			ID='amt_ct_tot'    	width=120 	align=CENTER	Edit=None decao=0	SumText=@count</C>
											<C> name='������'			ID='rate_ac'    		width=80 	align=CENTER	Edit=None decao=0</C>
											<C> name='����Ƚ��' 		ID='seq_ac'   	width=60   align=CENTER	decao=0</C>											
											<C> name='�������Ѿ�'	ID='amt_ac_tot'    	width=120 	align=CENTER	Edit=None decao=0</C>
											<C> name='�����ݰ��ް�'		ID='amt_ac'    width=80 	align=CENTER	Edit=None decao=0</C>
											<C> name='�����ݺΰ���' 		ID='amt_ac_vat'    		width=80 	align=CENTER	decao=0</C>
											<C> name='��û����' 				ID='date_rqst'    			width=60 	align=CENTER	</C>
											<C> name='�Ա�����' 				ID='date_rcv'  		  	width=60 	align=CENTER	</C>
											<C> name='����' 					ID='remarks' 			   	width=100 	align=CENTER	</C>
                                         ">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
							</tr>
						</table>
					</td>
					<td width=55px;></td>
					<td valign='top' colspan="0"  align="left">
						<table width="500px" border="0" cellpadding="0" cellspacing="1" >
							<tr>
								<td width='500px'height='96px' valign='top' align="left" >
									<table border='0' cellpadding='0' cellspacing='1' width='500px' height='96px' bgcolor="#666666">
										<tr>
											<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">����</td>
					                        <td height="24px"  colspan="1"	bgcolor="#FFFFFF" align=left>&nbsp;
												<input id="amt_ct_tot" type="text" class="input01"   readonly="true" value="" size="20" maxlength="50" onBlur="bytelength(this,this.value,10);">
											</td>
					                        <td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">������</td>
					                        <td height="24px"  colspan="1"	bgcolor="#FFFFFF" align=left>&nbsp;
												<input id="rate_ac" type="text" class="input01"   readonly="true" value="" size="20" maxlength="50" onBlur="bytelength(this,this.value,10);">
											</td>
										</tr>
										<tr>
											<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">������</td>
											<td  height="24px"  colspan="3"  bgcolor="#FFFFFF" align="left">&nbsp;
												<input id="amt_ac_tot" type="text" class="textbox"   size="20" value="" maxlength="100" onBlur="bytelength(this,this.value,100);">
											</td>
										</tr>
										<tr>
											<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">���ް���</td>
					                        <td height="24px"  colspan="1"	bgcolor="#FFFFFF" align=left>&nbsp;
												<input id="amt_ac" type="text" class="input01"   readonly="true" value="" size="20" maxlength="50" onBlur="bytelength(this,this.value,10);">
											</td>
					                        <td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">�ΰ���</td>
					                        <td height="24px"  colspan="1"	bgcolor="#FFFFFF" align=left>&nbsp;
												<input id="amt_ac_vat" type="text" class="input01"   readonly="true" value="" size="20" maxlength="50" onBlur="bytelength(this,this.value,10);">
											</td>
										</tr>
										<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">û������</td>
					                    <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=date_rqst classid=<%=HDConstant.CT_EMEDIT_CLSID%> width=150 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:128px; height:17px;">
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
				                            <%=HDConstant.COMMENT_END%>&nbsp;&nbsp;                                                                             
				                        </td>
										<td  height="24px" width="60px" bgcolor="#eeeeee" align="center" class="boardt02">�Ա�����</td>
					                    <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=date_rcv classid=<%=HDConstant.CT_EMEDIT_CLSID%> width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:128px; height:17px;">
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
				                            <%=HDConstant.COMMENT_END%>&nbsp;&nbsp;                                                                             
				                        </td>
			                      	</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>											
<input type="hidden" name="row" value="">	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>	
<%=HDConstant.COMMENT_START%>
        <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
            <param name="DataId" value="ds1">
            <param name=BindInfo    value="
                    <C>Col=ac_sid 	 	    	Ctrl=ac_sid		 	       Param=value </C>
                    <C>Col=site_sid 	 	    	Ctrl=site_sid	 	       Param=value </C>
                    <C>Col=seq_ct		   	  	Ctrl=seq_ct			       Param=value </C>
                    <C>Col=date_ct 		  	  	Ctrl=date_ct		       Param=value </C>                    
                    <C>Col=amt_ct_tot     	    Ctrl=amt_ct_tot            Param=value </C>
                    <C>Col=rate_ac	 		    Ctrl=rate_ac	   		   Param=value </C>
                    <C>Col=seq_ac  	        Ctrl=seq_ac	           Param=value </C>
                    <C>Col=amt_ac_tot 	    Ctrl=amt_ac_tot           Param=value </C>
                    <C>Col=amt_ac	    	 	Ctrl=amt_ac	    	   Param=value </C>
                    <C>Col=amt_ac_vat 		Ctrl=amt_ac_vat          Param=value </C>
                    <C>Col=date_rqst    	    Ctrl=date_rqst	 	       Param=text </C>
                    <C>Col=date_rcv		    Ctrl=date_rcv		       Param=text </C>
                    <C>Col=remarks	   	        Ctrl=remarks	           Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%> 
		<input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		