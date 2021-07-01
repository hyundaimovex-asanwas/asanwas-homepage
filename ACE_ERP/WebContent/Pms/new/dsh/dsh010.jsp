<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Dash Board
 * ���α׷�ID 	 : PMS/dsh
 * J  S  P		 : dsh010.jsp
 * �� �� ��		 : dsh010
 * �� �� ��		 : �� �� ��
 * �� �� ��		 : 2018-06-14
 * �������		 : Dash Board
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
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">

	var v_default_row = 1;
	
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		cfStyleGrid(getObjectFirst("gr_default"), "comn");

		fnInit();
		
	}
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";

		fnSelect();
        
    }
    
    
    <%//���� ��ȸ  %>
    function fnSelect() {

		    v_job="S";
		    
			var v_code = document.getElementById("v_code").value;
			
	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
													+ ",v_code=" + v_code	    	
							                  		+ ",v_project=" + v_project.value 						//project��
							    					;
	    	
	    	
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh010",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        

    }    
    




</script>

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

<script language="javascript" for="tr1" event="OnSuccess()">


</script>


<script language=JavaScript for=tr1 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
    
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
        
    </script>
 
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
	
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";

	</script>
	

	
  <script language="javascript"  for=gr_default event=OnDblClick(Row,Colid)>
  
	  if(Colid=="COST_IN"){
		  
	     	// alert("���� ����׿� ���� ������ ������ �����Դϴ�.");
			
			var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			arrParam[0] = ds_default.NameValue(ds_default.rowposition,"COST_CD");
			
	      	strURL = "<%=dirPath%>/Pms/new/dsh/dsh012.jsp";
	      	
			strPos = "dialogWidth:1000px;dialogHeight:650px;status:yes;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
			sApproveLine = arrResult; 
			
	  }else if(Colid=="COST_OUT"){
		  
		  	//alert("���� ���Ծ׿� ���� ������ ������ �����Դϴ�.");
		  
		 	var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			arrParam[0] = ds_default.NameValue(ds_default.rowposition,"COST_CD");
			
	      	strURL = "<%=dirPath%>/Pms/new/dsh/dsh013.jsp";
	      	
			strPos = "dialogWidth:1000px;dialogHeight:650px;status:yes;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
			sApproveLine = arrResult; 
			
	  }else{
		  
		  
		  	//alert("�󼼺����������� �Ѿ�ϴ�.");
		  
		  	var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			arrParam[0] = ds_default.NameValue(ds_default.rowposition,"COST_CD");
			
	      	strURL = "<%=dirPath%>/Pms/new/dsh/dsh011.jsp";
	      	
			strPos = "dialogWidth:1020px;dialogHeight:800px;status:no;scroll:yes;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
			//sApproveLine = arrResult; 
		  
	  }
  
   
   	
  </script>

	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  		value="false">
    <param name=SubSumExpr          value="total ,    1:GROUP_NM">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>

</head>


<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="1000px"> 
    
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='1000px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
                    			<tr>
                    				 <td align=left class="text"  width="100">����</td>
                    				 <td align=left class="text"  width="150" bgcolor="#ffffff"> 
                    				 	<select id=v_code style="WIDTH:140" onChange="fnSelect();">
					                        <option value="00">����</option> 
					                        <option value="01">����</option>                
					                        <option value="02">MICE</option>                    
					                        <option value="03">�Ǽ�</option>
					                        <option value="04">����</option>
					                        <option value="05">����</option>
					                    </select>
             				        </td>
			                        <td align=left class="text"  width="100">������Ʈ</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;
                                       <input type="text" name='v_project' id="v_project" style="width:200px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">&nbsp;                               
                                       <button type="button" onclick="fnSelect();"> �˻�</button>
			                        </td>
			                        
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="1000px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='600px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
									 <C> name='No'				ID='{CurRow}'		 	width=40 	align=CENTER    </C>
									 <C> name='GROUP'			ID='GROUP_NM'    		width=50 	align=CENTER 	suppress=1  Value={Decode(CurLevel,0,GROUP_NM,1,' �Ұ�',9999,' �Ѱ�')}</C>
                                     <C> name='Code'			ID='COST_CD'    		width=70 	align=CENTER	show=false</C>
                                     <C> name='������Ʈ' 			ID='PLJ_NM'    			width=290 	align=LEFT		</C>                                                              
                                     <C> name='��������'			ID='STARTDT' 			width=100 	align=CENTER	show=false</C>
                                     <C> name='��������'			ID='ENDDT' 				width=100 	align=CENTER	show=false</C>  
                                     <C> name='���ޱݾ�'			ID='ORDER_AMT_NOW'    	width=150 	align=right		DECAO=0 sumtext=@sum</C>                                     
                                     <C> name='����ݾ�'			ID='EXE_ACT_AMT_NOW'    width=150 	align=right		DECAO=0 sumtext=@sum</C>                                                                
                                     <C> name='��������'			ID='COST_IN'    		width=100 	align=right		DECAO=0 sumtext=@sum </C>
                                     <C> name='������Ծ�'			ID='COST_OUT'    		width=100 	align=right		DECAO=0 sumtext=@sum</C>
                                     <C> name='�����ܾ�'			ID='COST'    			width=100 	align=right		DECAO=0 bgColor='#D1B2FF' sumtext=@sum</C>                                     
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