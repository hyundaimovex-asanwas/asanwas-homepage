<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <jsp:include page="/Pms/common/include/head.jsp"/>
    <title>��������</title>
    
<%
    /***************************************************************************
     *                            ����� ���� Java Script                       *
     ***************************************************************************/
%>

<script language="javascript">

			var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

			var  gusrid  	="<%=(String)session.getAttribute("vusrid")%>";
			var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";

    	
        	<%//������ �·ε� %>
            function fnOnLoad() {

            	fnSelect();

            }
            

            <%//�ʱ��۾� %>
        	function fnInit(){

        		v_job ="I";

        	}
        	
        	
        	
            <%//�⺻ ��ȸ  %>
            function fnSelect() {

                v_job="S";

            	// �˻� �� ���� 
            	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"  	
            										;

        		ln_TRSetting(tr1, 
        	        	"<%=dirPath%><%=HDConstant.PATH_BID%>Bid012",
        	            "JSP(O:DS_DEFAULT=ds_default)",
        	            param);

        		tr_post(tr1);                
                
               	    
            }
            

            <%//����ó ��ȸ  %>
      		function popup(){

	      		 	var arrParam	= new Array();
	      	    	var arrResult	= new Array();
	      	    	var strURL;	
	      	    	var strPos;
	      			
	      	    	strURL = "<%=dirPath%>/Pms/new/pro/gczm_vender_popup.jsp";
	      	    	
	      	    	strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:no";
	      	    	
	      	    	arrResult = showModalDialog(strURL,'',strPos);
	      	    	
	      	    	if (arrResult != null) {

	      	    		arrParam = arrResult.split(";");

	      	    		order_cd.value = arrParam[0];
	      	    		order_nm.value = arrParam[1];
	      	    		
	      	    		//alert("order_cd = "+arrParam[1]+" order_nm = "+arrParam[0]);
	      	    		
	      	        } else {
	      	        	
	      	        	document.getElementById("order_cd").value="";
	      	        	document.getElementById("order_nm").value="";
	      	        }           	    	
	      	    
      			
      		}

      		
      		
            <%//�⺻ ����  %>
      		function fnSave(){
      			
                v_job="A";
                
          		var estimate_amt =	document.getElementById("estimate_amt").value;      		

          		//ȭ�� �޸� ������ ���̺� ���� 
          		estimate_amt = uncomma(estimate_amt);
    	      		
          		ds_default.NameValue(ds_default.rowposition,"estimate_amt") = estimate_amt;

    	  		 
	      		var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
	      		
	      		
	      		//����
	   			ln_TRSetting(tr1, 
			   	        	"<%=dirPath%><%=HDConstant.PATH_BID%>Bid012",
			   	            "JSP(I:DS_DEFAULT=ds_default)",
			   	            param);
	     		

	   	        tr_post(tr1);
    	        
   	        
      		}
      	
      		
      		
      		
      	  //������ �ĸ� �۾� 	
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
        
        
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">

	if(v_job=="S"){
		bid_cd.value = ds_default.NameValue(ds_default.rowposition,"BID_CD");
        bid_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        txt_empno.value = gusrid;
    	txt_empnmk.value = gusrnm;	
	}
	
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
		fnClose();
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
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
                        <tr>
                            <td colspan=2 height=25>
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:120;height:15;left:5px;">���� ���� ����</font>
                            </td>
                        </tr>
                     </table>
                </td>
                <td>

                </td>
            </tr>
        </table>
        
        
        
		<table border="0" cellpadding="0" cellspacing="0" >
			  <tr>
				<td height="25px" width="120px" style="border:1 solid #708090;border-width:1 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;���� CODE</td>			  

				<td width="350px" style="border:1 solid #708090;border-left-width:0px">&nbsp;
					<input id="bid_cd"    type="text"   class="txtbox"  style= "position:relative;width:150px;height:20px;text-align:left;background-color:#d7d7d7" readonly="readonly" >
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;������</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="bid_nm"    type="text"   class="txtbox"  style= "position:relative;width:150px;height:20px;">
				</td>
			  </tr>		  
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;��������</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<object  id=bid_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  		value="_">
							<param name=Enable				value="true">
					</object>
				</td>
			  </tr>


			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;����ó</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="order_cd"    type="text"   class="txtbox"  style= "position:relative;width:50px;height:20px;">&nbsp;				
					<input id="order_nm"    type="text"   class="txtbox"  style= "position:relative;width:200px;height:20px;">&nbsp;&nbsp;
					<button onclick ="popup()"> ����ó </button>		
				</td>
			  </tr>
			  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;������</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="estimate_amt"    type="text"   class="txtbox"  style= "position:relative;width:150px;height:20px;" onkeydown="inputNumberFormat(this)" >		
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;�����</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">
				
					<input type="text" class="txt11" id="txt_empno"  style="width:60px;background-color:#d7d7d7" readOnly> &nbsp;
				    <input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="width:90px;" style="width:60px;background-color:#d7d7d7" readOnly> 
				

				</td>
			  </tr>		

			</table>
			<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px" align="center">
			
                        <tr>
                            <td align="right">
                                <img name="btn_save border="0" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnSave()"> &nbsp;                         
                            </td>
                            
                            <td align="left">
                                <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
                            </td>
                        </tr>
            </table>
</div>
</body>
<!-- BODY END -->


<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" 			value="ds_default">
	             <param name=BindInfo    		value="
					<C>Col=BID_NM	 			Ctrl=bid_nm       				Param=value </C>
					<C>Col=BID_DT       	 	Ctrl=bid_dt        				Param=Text  </C>
					<C>Col=ORDER_CD	 			Ctrl=order_cd       			Param=value </C>
					<C>Col=ORDER_NM     	 	Ctrl=order_nm     				Param=value </C>		
				
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 

</html>



