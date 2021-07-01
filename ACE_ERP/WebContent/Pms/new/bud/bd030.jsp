<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ǰ���ڵ� ��������
 * ���α׷�ID 	 : PMS/Itm
 * J  S  P		 : Bd030.jsp
 * �� �� ��		 : Bd030
 * �� �� ��		 : �� �� ��
 * �� �� ��		 : 2018-06-12
 * �������		 : ǰ���ڵ� ��������
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
    	
		    var project_txt = document.getElementById("projectTxt").value;
			    v_job="S";
			    
	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  + ",v_project=" + project_txt
	                  + ",v_stat="  + v_rqst_status.value;
	                  ;
	    	
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd030",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        

    }    
    

	<%//���� %>
	function fnApply(){
		
		v_job = "A";
		var cost_cd = ds_default.NameValue(ds_default.rowposition,"COST_CD");
		var no_budget =  ds_default.NameValue(ds_default.rowposition,"NO_BUDGET");	
		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
			            + ",v_cost_cd=" + cost_cd
			            + ",v_no_budget="  + no_budget;
            
	//	alert(cost_cd+no_budget);
		
		if (ds_default.IsUpdated) {
			
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd030",
			     "JSP(I:DS_DEFAULT=ds_default)",
			     param);
			  
			   //prompt(this, ds_default.text);
			  
			   tr_post(tr1);

        }else{
        	
     		alert("������ �ڵ带 �������ֽñ� �ٶ��ϴ�.");
		
        }
		
		
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

	if(v_job=="A"){
		
		alert("���������� ���εǾ����ϴ�.");
		fnSelect();
	}
	
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    
    
    
</script>


<script language=JavaScript for=tr1 event=OnFail()>
alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gr_default event=OnPopup(Row,Colid,data,xpos,ypos)>

		var cost_cd = ds_default.NameValue(ds_default.rowposition,"COST_CD");
		var no_budget =  ds_default.NameValue(ds_default.rowposition,"NO_BUDGET");	
		
		
		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;
		arrParam[0] = cost_cd;
		arrParam[1] = no_budget;
		
		strURL = "<%=dirPath%>/Pms/new/bud/bd031.jsp";
		strPos = "dialogWidth:1100px;dialogHeight:800px;status:yes;scroll:yes;resizable:yes";
		
		arrResult = showModalDialog(strURL,arrParam,strPos);
		
		sApproveLine = arrResult; 
		
		<%-- if(Colid == "DS_BUDGET"){
			
			strURL = "<%=dirPath%>/Pms/new/bud/bd020.jsp";
			strPos = "dialogWidth:1000px;dialogHeight:900px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
		} --%>
		
</script>

<!-- ����Ŭ�� �߰� �� ����  ���� for=gr_default  -->
 <script language=JavaScript for=gr_default event=OnDblClick(row,colid)>
 

			var cost_cd = ds_default.NameValue(ds_default.rowposition,"COST_CD");
			var no_budget =  ds_default.NameValue(ds_default.rowposition,"NO_BUDGET");	 
			
			var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
	
		 	arrParam[0] = cost_cd;
		 	arrParam[1] = no_budget;
		 
		 	//alert("����� �Ѿ� ������?"+arrParam[0] +arrParam[1] );
	
			strURL = "<%=dirPath%>/Pms/new/bud/bd032.jsp";
		
			strPos = "dialogWidth:1050px;dialogHeight:900px;status:no;scroll:no;resizable:no";
		
			arrResult = showModalDialog(strURL,arrParam,strPos);

	 
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
	

	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
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


<jsp:include page="/Common/sys/body_s11.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
   <br>
    <table border='0' cellpadding='0' cellspacing='0' width="1000px"> 
    
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1050px'>
                    <tr>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/btn_ConsentOn.gif"		style="cursor:pointer" onClick="fnApply();">

						</td>
                    </tr>
                </table>
            </td>
        </tr>
        
        <tr>
            <td width='1050px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='1050px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1050px'>
                    			<tr>
			                        <td align=left class="text"  width="100">PROJECT ��</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;
			                        	<input type="text" value="" width="150px" id="projectTxt" onkeydown="if(event.keyCode==13) fnSelect(); " placeholder="Project�� �˻�" >               
			                        </td>
			                        <td align=left class="text">ó������</td>
									<td align="left" bgcolor="#ffffff" WIDTH="220">&nbsp;
										<select name="v_rqst_status" id="v_rqst_status" onChange="fnSelect();">
											<option value="A">��ü</option>
											<option value="R">���ο�û</option>
											<option value="Y">���οϷ�</option>
										</select>		
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
                        <td valign='top' width="1050px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1050px' height='600px' border='1'>
                                <param name="DataID"            	value="ds_default">
                                <param name="ColSizing"         	value="true">
                                <param name="Editable"          	value="false">
                                <param name="SuppressOption"    	value="1">
                                <param name="BorderStyle"       	value="0">
                                <!-- <param name="ViewSummary"       value="1"> -->
                                <param name="Format"            	value="
                                     <C> name='CHK'					ID='CHK'    		width=30 	align=CENTER	EditStyle='CheckBox' CheckBoxText=''</C>
                                     <C> name='NO'					ID='{CurRow}'	  	width=40 	align=CENTER	Edit=None 	</C>
			                         <C> name='�������' 			ID='TY_APPROVAL'    width=80 	align=CENTER	 edit=none</C>
			                         <C> name='������Ʈ' 			ID='COST_CD'    	width=70 	align=CENTER 	edit=none	 	show=true</C>
			                         <C> name='����' 				ID='NO_BUDGET'    	width=50 	align=CENTER	show=true</C>
			                         <C> name='����' 				ID='TY_BUDGET'    	width=60 	align=CENTER   	edit=none    bgColor=<%=HDConstant.GRID_ITEM%></C> <!-EditStyle=Combo	Data='A:������,B:��������,C:���࿹��'	-  -->
			                         <C> name='PROJECT_NAME' 		ID='PLJ_NM'   		width=150 	align=LEFT 		</C> 
			                         <C> name='����' 				ID='DS_BUDGET'   	width=110 	align=LEFT	 	edit=none </C> <!-- EditStyle=Popup -->
			                         <C> name='���ޱݾ�' 			ID='ORDER_AMT'   	width=80 	align=right	 	edit=none decao=0</C>
			                         <C> name='����ݾ�' 			ID='EXE_AMT'   		width=80 	align=right	 	edit=none decao=0</C>
			                         <C> name='��û��'    			ID='DT_REQUEST'    	width=70 	align=CENTER	 edit=none show=true   mask='XXXX-XX-XX'</C>
			                         <C> name='��û��'   			ID='NM_REQUEST'   	width=70 	align=CENTER	 show=true edit=none		 </C>
			                         <C> name='������' 				ID='DT_CONFIRM'    	width=70 	align=CENTER	 edit=none mask='XXXX-XX-XX'</C>
			                         <C> name='������' 				ID='NM_CONFIRM'    	width=70 	align=CENTER	 edit=none	</C>

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