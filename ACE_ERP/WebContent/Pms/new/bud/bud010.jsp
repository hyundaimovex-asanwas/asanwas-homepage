
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
    SmartRequest sr = new SmartRequest(request);
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
%>


<!-- HTML ����-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
	<jsp:include page="/Pms/common/include/head.jsp"/>	
	
<script language="javascript">

	var v_default_row = 1;
	
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	<% //�������ε� %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//project list

		fnInit();

	}
	
	
    <% //�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
	    
        fnSelect();
        
    }
    

    <% //�⺻ ��ȸ %>
    function fnSelect(){
    	
    	v_job="S";

    	// �˻� �� ���� 
    	var pText = document.getElementById("pro_text").value;

    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							    		+ ",v_project=" + pText 					    		
							    		+ ",v_kind=1"
							    		;

    	ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bud010",
                "JSP(O:DS_DEFAULT=ds_default)",
                param);
    	
        tr_post(tr1);
            
    }

    
    
    <% //���߰�%>
    function fnAddRowDt1(){
    	
    	ds_default.addrow();
    	
    	ds_default.NameValue(ds_default.rowposition,"TY_BUDGET")="C";	
    	ds_default.NameValue(ds_default.rowposition,"I_EMPNO")="<%=gusrid%>";		
    	
    	
    }    
    
    
    
    <%//����  %>
    function fnAddSave(){
    	
   		v_job = "A";

    	var V_TY_BUDGET = ds_default.NameValue(ds_default.rowposition,"TY_BUDGET"); //����  ������ (A)��������(B) ���࿹��(C)
 
    	
    	//��� ��� 
		var v_default_row = ds_default.RowPosition;

      	var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
		    		+ ",v_default_row=" + v_default_row;
    	       
    	ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bud010",
	                "JSP(I:DS_DEFAULT=ds_default)",
	                param);
    	
        tr_post(tr1);

   		fnSelect();

    }
    
 
</script>


<!-- �˾�â -->
<script language=JavaScript for=gr_default event=OnPopup(Row,Colid,data,xpos,ypos)>

		var cost_cd = ds_default.NameValue(ds_default.rowposition,"COST_CD");
		var no_budget =  ds_default.NameValue(ds_default.rowposition,"NO_BUDGET");	
		
		
		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;
					
		if(Colid == "PLJ_NM"){
			
				strURL = "<%=dirPath%>/Pms/new/bud/bud015.jsp";
				
				strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				
				arrResult = showModalDialog(strURL,arrParam,strPos);
				
				sApproveLine = arrResult; 

				if (arrResult != null) {

		    		arrParam = arrResult.split(";");
		    		
		    	   	ds_default.namevalue(ds_default.rowposition,"COST_CD") = arrParam[0];		
		    	   	ds_default.namevalue(ds_default.rowposition,"PLJ_NM")  = arrParam[1];	

				}
				
		}	
		
</script>



<!-- ����Ŭ�� -->
 <script language=JavaScript for=gr_default event=OnDblClick(row,colid)>

 		if(colid != "PLJ_NM" && colid != "ORDER_AMT"){
 
		  	var cost_cd_value =ds_default.NameValue(ds_default.rowposition,"PLJ_NM");
			var cost_cd = ds_default.NameValue(ds_default.rowposition,"COST_CD");
			var no_budget =  ds_default.NameValue(ds_default.rowposition,"NO_BUDGET");	  		
		  	
			var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
		
		 	arrParam[0] = cost_cd;
		 	arrParam[1] = cost_cd_value;		 	
		 	arrParam[2] = no_budget;
	
			strURL = "<%=dirPath%>/Pms/new/bud/bud050.jsp";
		
			strPos = "dialogWidth:1050px;dialogHeight:900px;status:no;scroll:no;resizable:no";
		
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
			fnSelect(); // �����ϵ� ��ȸ�ϱ�			
			
 		}
 	

 </script> 


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

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>

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

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

</head>


<jsp:include page="/Common/sys/body_s10.jsp"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------>     
<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
			     		<td align=right>
							<img src="<%=dirPath%>/Sales/images/save.gif" 		style="cursor:pointer" onClick="fnAddSave()" >
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
        					<img src="<%=dirPath%>/Sales/images/plus.gif"		style="cursor:pointer" onClick="fnAddRowDt1()" >
                        </td>								
                    </tr>
                </table>
            </td>
        </tr>
	<tr><td height=4></td></tr>
</table>
        
        
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
		<tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>
                        <td align="left" class="text" width="100">������Ʈ</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                             <input type="text" name='pro_text' id="pro_text" style="width:200px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">                               
                        </td>       
					</tr>
           		</table>
            </td>	
		</tr>
	
		<tr>
			<td height=10>&nbsp;
			</td>
		</tr>
        
        <tr>
            <td valign="top">
                <object id="gr_default" classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='500px' border='1'>
                    <param name="DataID"            	value="ds_default">
                    <param name="ColSizing"         	value="true">
                    <param name="Editable"          	value="true">
                    <param name="ComboDataID"      		value="ds_gc_ccstat">
                    <param name="SuppressOption"    	value="1">
                    <param name="BorderStyle"       	value="0">
                    <param name=ColSelect    			value="True">
                    <param name="Format"           		value="
	                     <C> name='NO' 				ID='{CurRow}'	   	width=30 		align=CENTER		show=TRUE	 		EditStyle = OnDblClick({CurRow}) </C><!--EditStyle = OnDblClick({CurRow})  -->
                      <G>name='PROJECT'
                         <C> name='�ڵ�' 			ID='COST_CD'    	width=100 		align=CENTER 		edit=none	 		show=true</C>
                         <C> name='������Ʈ' 		ID='PLJ_NM'   		width=300 		align=LEFT			EditStyle=Popup 	readonly=true  suppress=1</C> 
                      </G>
                         <C> name='����\\����' 		ID='NO_BUDGET'    	width=50 		align=CENTER 		edit=none</C>                      
                         <C> name='����' 			ID='TY_BUDGET'    	width=80 		align=CENTER  		EditStyle=Combo		Data='C:���࿹��' bgColor=<%=HDConstant.GRID_ITEM%></C>
                         <C> name='���ޱݾ�' 		ID='ORDER_AMT'   	width=100 		align=right	 		decao=0</C>
                         <C> name='����ݾ�' 		ID='EXE_AMT'   		width=100 		align=right	 		edit=none decao=0</C>
                         <C> name='�ۼ���'    		ID='DT_REQUEST'    	width=100 		align=CENTER	  	edit=none mask='XXXX-XX-XX' </C>
                         <C> name='�ۼ���'   		ID='NM_REQUEST'   	width=100 		align=CENTER	 	show=true edit=none	</C>                    
                 ">                             
                </object>   
 		    </td>
        </tr>
    </table>
    
    <BR>
	<font size=2 color=blue face = "����" bold=10>* ���߰� �Ͻ� �� ������Ʈ�� ��ư�� Ŭ���Ͻñ� �ٶ��ϴ�.</font>    
	<BR>
	<BR>
	<font size=2 color=blue face = "����" bold=10>* ����Ŭ���Ͻø� ���࿹�� ȭ���� ��Ÿ���ϴ�.</font>
	    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		




