<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%
    // ContextPath
    String dirPath = request.getContextPath();

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
    
    <title>PROJECT SAVE</title>
    
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>

<script language="javascript">
		
		
			var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

            function fnOnLoad() {

                fnInit();
                
            }
            

			
        	function fnInit(){
        		
        		v_job ="I";
        		
        		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>" ;
        		
        		//�ʱ� �ڵ� ��ȣ ���� 
        		ln_TRSetting(tr1, 
        	        	"<%=dirPath%><%=HDConstant.PATH_PRO%>Pr011",
        	            "JSP(O:DS_DEFAULT=ds_default)",
        	            param);
        		
        	    tr_post(tr1);
        	        
        	        
        	    document.getElementById("request_cd").value=ds_default.NameValue(1,"REQUEST_CD");
        	   
        	   
        	}
        	
        	
            function fnSelect() {
            	
            	//�ʱ� ȭ�� �ε�ÿ� ������ ���� ��ȸ
            	
                v_job="S";
            	

            }

            
            
            
            
            
      		function popup(e){

	      		if(e == 'pm'){

	      		 	var arrParam	= new Array();
	      	    	var arrResult	= new Array();
	      	    	var strURL;	
	      	    	var strPos;
	      			var ifVal = e;
	      			
	      	    	strURL = "<%=dirPath%>/Pms/new/pro/empno_popup.jsp";
	      	    	
	      	    	strPos = "dialogWidth:377px;dialogHeight:400px;status:no;scroll:no;resizable:no";
	      	    	
	      	    	arrResult = showModalDialog(strURL,'',strPos);
	      	    	
	      	    	if (arrResult != null) {
	      	    		
	      	    		arrParam = arrResult.split(";");	      	    		

	      	    		eno_no.value = arrParam[0];
	      	    		eno_nm.value = arrParam[1];
	      	    		dept_cd.value = arrParam[2];
	      	    		
	      	        } else {
	      	        	
	      				fnEmpNoCleanup(ifVal);
	      				
	      	        }         	    	
	      	    	
	      		}
      	    	
      		}
      		
      		
      		
      		
      		function fnEmpNoCleanup(e){

      			
      			if(e == "pm"){
      				
      				//�Ѱ����� ���ƿ��� ���� ������ �״�� ���д�. 
     				document.getElementById("suPm").value="";	 
      				
      			}
      			
      		}
      		
      		
      		
      		
      		<%//���� �۾� %>
      		function fnSave(){

      			v_job="A";

	        	ds_default.namevalue(ds_default.RowPosition, "REQUEST_CD") 		= document.getElementById("request_cd").value;
	        	ds_default.namevalue(ds_default.RowPosition, "REQUEST_NM") 		= document.getElementById("request_nm").value;
	        	ds_default.namevalue(ds_default.RowPosition, "PROP1") 			= document.getElementById("bigStatus").value;
	        	ds_default.namevalue(ds_default.RowPosition, "PROP2") 			= document.getElementById("midStatus").value;
	        	ds_default.namevalue(ds_default.RowPosition, "COMPANY_NM") 		= document.getElementById("balJu").value;
	        	ds_default.namevalue(ds_default.RowPosition, "DEPT_CD") 		= document.getElementById("dept_cd").value;  //�����
	        	ds_default.namevalue(ds_default.RowPosition, "PM") 				= document.getElementById("eno_no").value;   //��� ��ȣ�� ���� 



      			//�Է°� üũ
      			if(document.getElementById("bigStatus").value == "00"){
      				alert("��з��� ���õ��� �ʾҽ��ϴ�.");
      				return false;
      			}else if(document.getElementById("midStatus").value == "0000"){
      				alert("�ߺз��� ���õ��� �ʾҽ��ϴ�.");
      	      		return false;
      	      	}
    	  		 

      			//�����ư   
    	 		ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PRO%>Pr011",
		                "JSP(I:DS_DEFAULT=ds_default)",
		                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                	);      			
      			
      			
				ds_default.UserStatus(1) = 1;	
				
      			//prompt(this, ds_default.text);
      			
    	        tr_post(tr1);
    	        
    	        
    	        
      		}
      	
      		
      		
      	  //���޾� �ĸ� �۾� 	
      	  function inputNumberFormat(obj) { 
      		
      	      obj.value = comma(uncomma(obj.value)); 
      	  
      	  } 
		
      	
      	  
      	  function comma(str) { 
      		  
      	      str = String(str); 
      	      
      	      return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'); 
      	      
      	  } 
      	  
      	  
      	  
      	  //�޸�����
      	  function uncomma(str) { 
      		  
      	      str = String(str); 
      	      
      	      return str.replace(/[^\d]+/g, ''); 
      	      
      	  }


            function fnClose() {
            	
                window.close();
                
            }
            

 </script>
 
 
 
<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="A"){
		
		alert("���������� ����Ǿ����ϴ�.");

		fnClose();
		
	}
	

</script>



<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">


	if(v_job=="A"){
		
		alert("���������� ó���Ǿ����ϴ�.");
		
		window.close();
	}
	
	
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



</head> 


        
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
<div>
<br>
		<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:10px;top:7px;">
		
			  <tr>
				<td height="25px" width="100px" style="border:1 solid #708090;border-width:1 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp; ��ûcode</td>			  

				<td width="300px" style="border:1 solid #708090;border-left-width:0px">&nbsp;
					<input id="request_cd"    type="text"   class="txtbox"  style= "position:relative;width:250px;height:20px;text-align: center" readonly="readonly" >
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp; ��û��</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="request_nm"    type="text"   class="txtbox"  style= "position:relative;width:250px;height:20px;">
				</td>
			  </tr>
			  

			   <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��з�</td>               
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					 <select id=bigStatus style="WIDTH:100" >
                        <option value="00">����</option> 
                        <option value="01">����</option>                                  
                        <option value="03">�Ǽ�</option>
                        <option value="04">����</option>
                        <option value="05">����</option>
                    </select>
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ߺз�</td>
		  		<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					 <select id=midStatus style="WIDTH:100" >
                        <option value="0000">�ߺз� ����</option>
                        <option value="0501">MICE</option>
                        <option value="0502">���ϱ���</option>
                        <option value="0503">ũ����</option>
                        <option value="0504">��������</option>
                        <option value="0505">�ؿܰ���</option>
                        <option value="0506">�װ��߱�</option>
                        <option value="0507">������</option>
                        <option value="0508">���������繫��</option>
                        <option value="0509">ODA</option>
                        <option value="0510">PMC</option>
                        <option value="0511">�鼼���</option>
                    </select>
				</td>
			  </tr>				  

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ó</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="balJu"    type="text"   class="txtbox"  style= "position:relative;width:250px;height:20px;">&nbsp;&nbsp;	
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����PM</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="dept_cd"   type="text"   class="txtbox"  style= "position:relative;width:50px;height:20px;">					
					<input id="eno_no"    type="text"   class="txtbox"  style= "position:relative;width:50px;height:20px;">				
					<input id="eno_nm"    type="text"   class="txtbox"  style= "position:relative;width:50px;height:20px;">&nbsp;
					<button onclick ="popup('pm')"> �����˻� Click! </button>		
				</td>
			  </tr>
			</table>
			
<br>
			<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px" align="center">
			
                        <tr>
                            <td align="right">
                                <img name="btn_save" border="0" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnSave()"> &nbsp;                         
                            </td>
                            
                            <td align="left">
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
                            </td>
                        </tr>
            </table>
            
</div>


</body>
<!-- BODY END -->

</html>







