
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

	
    
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//project list

		fnInit();

	}
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
	    
	    v_fr_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,4)+"01"+"01"%>";
        v_to_date.Text = "<%=DateUtil.getCurrentDate(8)%>";			    
	    
        fnSelect();
        
    }
    
    
    <%//�⺻ ��ȸ  %>
    function fnSelect() {
    	
   	 	v_job="S";


    	// �˻� �� ���� 
    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								            + ",v_frdt=" + v_fr_date.text
								            + ",v_todt=" + v_to_date.text	   	
    										+ ",v_bid=" + v_bid.value						//������
    						                + ",v_status=" + v_status.value			        //����    	
    										;
   		
	   	ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_BID%>Bid020",
		            "JSP(O:DS_DEFAULT=ds_default)",
		            param);
  	

	   	
        tr_post(tr1);
		        
		        
    }
    



    <%//�ű� �۾� %>
    function fnAdd() {
    	
	    v_job ="A";

		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;

		strURL = "<%=dirPath%>/Pms/new/bid/bid012.jsp";
	
		strPos = "dialogWidth:500px;dialogHeight:300px;status:no;scroll:no;resizable:no";
	
		arrResult = showModalDialog(strURL,arrParam,strPos);
	
		fnSelect();	    

        
    }

    <%//�ڷ� ���� �۾� %>
    function fnConfirm() {
    	
		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;

		var bid_cd =ds_default.NameValue(ds_default.rowposition,"BID_CD");
		var bid_nm =ds_default.NameValue(ds_default.rowposition,"BID_NM");
		var order_amt =ds_default.NameValue(ds_default.rowposition,"ESTIMATE_AMT");
		
	 	arrParam[0] = bid_cd;		
	 	arrParam[1] = bid_nm;
	 	arrParam[2] = order_amt;
	 	
		strURL = "<%=dirPath%>/Pms/new/bid/bid015.jsp";
	
		strPos = "dialogWidth:1000px;dialogHeight:800px;status:no;scroll:no;resizable:no";
	
		arrResult = showModalDialog(strURL,arrParam,strPos);
	
		fnSelect();	    

        
    }
    
</script>
    
    
    
    
<!-- ����Ŭ�� �˾�â for=gr_default  -->
 <script language=JavaScript for=gr_default event=OnDblClick(row,colid)>

	  		var bid_cd =ds_default.NameValue(ds_default.rowposition,"BID_CD");

	  		//alert(colid);

			var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
		
		 	arrParam[0] = bid_cd;
		 
		 	//alert("����� �Ѿ� ������?"+arrParam[0]);
	
			strURL = "<%=dirPath%>/Pms/new/bid/bid011.jsp";
		
			strPos = "dialogWidth:500px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		
			arrResult = showModalDialog(strURL,arrParam,strPos);
		
			fnSelect();
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


</head>


<!-- //body_s.jsp -->
<jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->

<!--------------------------------- �ڵ� �κ� ���� ------------------------------>     
<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
			     		<td align=right>
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
        					<img src="<%=dirPath%>/Sales/images/settle_com.gif"			style="cursor:pointer" onClick="fnContract()" >
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
           			
                        <td align=left class="text"  width="100">�������</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>&nbsp;~&nbsp;
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>               			
           			
           			
                        <td align="left" class="text" width="90">������</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                             <input type="text" name='v_bid' id="v_bid" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
                        </td>                         
                        <td align=left class="text">����</td>
						<td align="left" bgcolor="#ffffff" WIDTH="220">&nbsp;
							<select name="v_status" id="v_status" onChange="fnSelect();">
								<option value="A">��ü</option>
								<option value="N">�̰��</option>								
								<option value="Y">���</option>
							
							</select>		
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
                <object id="gr_default" classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='600px' border='1'>
                    <param name="DataID"            	value="ds_default">
                    <param name="ColSizing"         	value="true">
                    <param name="Editable"          	value="false">
                    <param name="ComboDataID"      		value="ds_gc_ccstat">
                    <param name="SuppressOption"    	value="1">
                    <param name="BorderStyle"       	value="0">
                    <param name=ColSelect    			value="True">
                    <param name="Format"            value="
	                     <C> name='NO' 				ID='{CurRow}'	   	width=30 		align=CENTER		</C>
                      <G>name='����'
                         <C> name='�����ڵ�' 		ID='BID_CD'    		width=100 		align=CENTER 		mask='XXXXXXX-XXX'</C>
                         <C> name='������' 			ID='BID_NM'   		width=300 		align=LEFT			</C> 
                      </G>
                         <C> name='����ó' 			ID='ORDER_NM'   	width=150 		align=LEFT			</C>

                         <C> name='������' 			ID='ESTIMATE_AMT'   width=90 		align=RIGHT			DEC=0</C>                         
                         <C> name='��������'    	ID='BID_DT'    		width=80 		align=CENTER	  	mask='XXXX-XX-XX' </C>
                         

                         <C> name='��࿩��' 		ID='DS_RESULT'    	width=100 		align=CENTER	 	</C> 

                         <C> name='�������' 		ID='DS_RESULT'    	width=100 		align=CENTER	 	mask='XXXX-XX-XX' </C> 

                 ">                             
                </object>   
 		    </td>
        </tr>

    </table>
    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		



