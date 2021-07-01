<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<!-- <meta charset=euc-kr"> -->
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta http-equiv="Cache-control" content="no-cache"/>
	<meta http-equiv="Cache-control" content="no-store"/>
	<meta http-equiv="pragma" content="no-cache" />
	<meta name="viewport" content="width=1080" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	
	<jsp:include page="/Pms/common/include/head.jsp"/>
<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	var menuWin;	//��â �����.
	var Tabvalue = 1;
    var seq = 0;
	
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		cfStyleGrid(getObjectFirst("grd_ITEM"), "comn");	//list detail

		fnInit();
		
	}
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
	    
        var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�
        
    	strParam=window.dialogArguments;

		document.getElementById("v_project").value    = strParam[0];				
		document.getElementById("v_project_nm").value = strParam[1];				 
		document.getElementById("v_ds_budget").value  = strParam[2];				

        fnSelect();
        
    }
    

    
    <%//���� ��ȸ %>
    function fnSelect() {

    	v_job="S";

    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								            + ",v_project="   + document.getElementById("v_project").value
								            + ",v_ds_budget=" + document.getElementById("v_ds_budget").value
    										;
   		
	   	ln_TRSetting(tr1, 
	            	"<%=dirPath%><%=HDConstant.PATH_BUD%>Bud050",
		            "JSP(O:DS_DEFAULT=ds_default)",
		            param);

        tr_post(tr1);        
        
    }    
    


	<% //����  %>
	function fnApply(){
		
		v_job = "A";

		if (ds_default.IsUpdated) {

			  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bud050",
				                "JSP(I:DS_DEFAULT=ds_default)",
				                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				                );
			  
			  //prompt(this, ds_default.text);
			  
			  tr_post(tr1);

			  
        }else{
        	
     		alert("������ Data�� �����ϴ�.");
		
        }
		
		
	 }




	<% //���߰� %>
      function fnAdd() {
    	  
          ds_default.AddRow(); 

          
          var temp = ds_default.namevalue(ds_default.CountRow-1,"CD_COST").substr(10,2);
          
          //�����ϱⰡ �ʹ� �ȴ�.
	      if(temp == "") {
          		temp = "01";
	      }else if(temp == "01"){
	    		temp = "02";
	      }else if(temp == "02"){
		    	temp = "03";	    	
	      }else if(temp == "03"){
		    	temp = "04";	    	
	      }else if(temp == "04"){
		    	temp = "05";	      
	      }else if(temp == "05"){
		    	temp = "06";	      
	      }else if(temp == "06"){
		    	temp = "07";	      
	      }else if(temp == "07"){
		    	temp = "08";	      
	      }else if(temp == "08"){
		    	temp = "09";	      
	      }else if(temp == "09"){
		    	temp = "10";	   
	      }else if(temp == "10"){
	    		temp = "11";
	      }else if(temp == "11"){
	    		temp = "12";	    		
	      }else if(temp == "12"){
		    	temp = "13";	    	
	      }else if(temp == "13"){
		    	temp = "14";	    	
	      }else if(temp == "14"){
		    	temp = "15";	      
	      }else if(temp == "15"){
		    	temp = "16";	      
	      }else if(temp == "16"){
		    	temp = "17";	      
	      }else if(temp == "17"){
		    	temp = "18";	      
	      }else if(temp == "18"){
		    	temp = "19";	      
	      }else if(temp == "19"){
		    	temp = "20";	 	
	      }else if(temp == "20"){
	    		temp = "21";
	      }else if(temp == "21"){
	    		temp = "22";	    		
	      }else if(temp == "22"){
		    	temp = "23";	    	
	      }else if(temp == "23"){
		    	temp = "24";	    	
	      }else if(temp == "24"){
		    	temp = "25";	      
	      }else if(temp == "25"){
		    	temp = "26";	      
	      }else if(temp == "26"){
		    	temp = "27";	      
	      }else if(temp == "27"){
		    	temp = "28";	      
	      }else if(temp == "28"){
		    	temp = "29";	      
	      }else if(temp == "29"){
		    	temp = "30";			    	
	      }else{
	    	  alert("�ڵ����� 30���� �����߽��ϴ�.\n\n�����ڿ��� �����Ͻñ� �ٶ��ϴ�.");
	    	  return;
	      }

            
          ds_default.namevalue(ds_default.rowposition,"COST_CD")   = document.getElementById("v_project").value;
          ds_default.namevalue(ds_default.rowposition,"NO_BUDGET") = document.getElementById("v_ds_budget").value;

          ds_default.namevalue(ds_default.rowposition,"CD_COST")   = document.getElementById("v_project").value + document.getElementById("v_ds_budget").value + temp;          
          
          seq = seq + 1;
          
      }

	      
  	<% //����� %>
    function fnDelete() {
  	  
		ds_default.DeleteRow(ds_default.RowPosition);
		
		alert("����� �Ǿ����ϴ�\n\n������� �ϼž� ������ �ݿ��˴ϴ�.");

    }  

    
	    
</script>

    <!--**************************************************************************************
    *                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)  *
    *                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : ds_default                          |
    +----------------------------------------------->

	<object id=ds_default classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : tr1                  				|
    +----------------------------------------------->
    
	<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
	    <param name="KeyName"    value="toinb_dataid4"/>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>





<!--*************************************
*                                       *
*  Component���� �߻��ϴ� Event ó����  *
*                                       *
**************************************-->

<!-------------------------------------------------+
| �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
+-------------------------------------------------->




 <!-----------------------------+
 | Transaction Successful ó��      |
 +------------------------------>
 <script for=tr1 event="OnSuccess()">
 
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
		fnSelect(); // �����ϵ� ��ȸ�ϱ�
	}

    
 </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->


</head>

<jsp:include page="/Common/sys/body_s11.jsp"/>



<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:3px">
    <tr>
        <td height="35" class="paddingTop5" align="right">
        	<img src="<%=dirPath%>/Sales/images/refer.gif"					style="cursor:pointer" onclick="fnSelect()">&nbsp;
        	<img src="<%=dirPath%>/Sales/images/plus.gif"					style="cursor:pointer" onclick="fnAdd()">&nbsp;
        	<img src="<%=dirPath%>/Sales/images/minus.gif"					style="cursor:pointer" onclick="fnDelete()">&nbsp;      	
        	<img src="<%=dirPath%>/Sales/images/save.gif"					style="cursor:pointer" onclick="fnApply()">	       	
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->
	


<!-- input ��  ���� --> 
<table width="1000" border="1" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
	<tr>
		<td align="center" class="text" width="80">Project</td>
		<td bgcolor='#ffffff' >&nbsp;
		    <input type="text"  name='v_project'   		id='v_project'  	style="width:50px;"   	class='input01' readOnly="readonly">
		    <input type="text"  name='v_project_nm'   	id='v_project_nm'  	style="width:300px;"   	class='input01' readOnly="readonly">	
		    <input type="text"  name='v_ds_budget'   	id='v_ds_budget'  	style="width:50px;"   	class='input01' readOnly="readonly">		    
		</td>				
	</tr>
</table>
<!-- input ��  �� --> 

<br>
	
	<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:10px">
		<tr>
			<td>
				<!-- ���� ��ȸ �׸��� ���̺� ����-->
				<table width="1000" height = "520" border="0" cellspacing="0" cellpadding="0">
				    <tr>
						<td class="paddingTop8">
	                        <object id="grd_ITEM" classid=<%=HDConstant.MxGrid_CLSID_S%>" style="width:1000px;height:520px;">
	                            <param name="DataID"						value="ds_default">
	                            <param name="EdiTABLE"						value="true">
	                            <param name="DragDropEnable"				value="true">
	                            <param name="SortView"						value="Left">
								<param name="ViewSummary"       			value="1">
								<param name="ColSizing"        				value="true">
								<param name=ColSelect    					value="True">								                            
	                            <param name="Format"						value="
                					<C> ID='{CurRow}'				name='NO' 			width=50 			align=CENTER</C>
	                                <C> id='COST_CD'				name='COST_CD'		width=50			show=false</C>						                            
	                                <C> id='NO_BUDGET'				name='NO_BUDGET'	width=50			show=false</C>                  					
	                                <C> id='CD_COST'				name='CODE'			width=150			align=left</C>						                            
	                                <C> id='DS_KSITEM'				name='Content'		width=550			align=left SumText='��' </C>     
	                                <C> id='EXE_ACT_AMT'			name='����ݾ�'		width=200			align=right decao = 0 sumtext=@sum</C>
	                            ">
	                        </object>
				        </td>
				    </tr>
				</table>
				<!-- ���� ��ȸ �׸��� ���̺� ��-->
			</td>
		</tr>
	</table>

</form>
<!-- form �� -->



</form>
<!-- form �� -->


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

