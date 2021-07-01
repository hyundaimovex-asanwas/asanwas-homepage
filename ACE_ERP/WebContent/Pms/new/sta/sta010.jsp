<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : �ڵ���ǥ �а�����
 * ���α׷�ID 	 : PMS/Sta
 * J  S  P		 : Sta010.jsp
 * �� �� ��		 : Sta010
 * �� �� ��		 : �� �� ��
 * �� �� ��		 : 2018-06-15
 * �������		 : �ڵ���ǥ �а�����
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


	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  								+ ",v_journal="  + v_journal.value;
	    	
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_STA%>Sta010",
				            "JSP(O:DS_DEFAULT=ds_default)",
				            param);
	           
	        tr_post(tr1);
	        

    }    
    

	<%//���� %>
	function fnApply(){
		
		v_job = "A";
		
		if (ds_default.IsUpdated) {
			
			  ln_TRSetting(tr1, 
					  
                "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm030",
			                "JSP(I:DS_DEFAULT=ds_default)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
			  
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

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
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
							<img src="<%=dirPath%>/Sales/images/save.gif"				style="cursor:pointer" onClick="fnApply();">

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
			                        <td align=left class="text"  width="70">�а�����</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;
                                       <input type="text" name='v_journal' id="v_journal" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">                               
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
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
								<C> Name='����'       	ID=SORTSEQ         Width=30 	    align=center  	    </FC>
								<G> Name='�а�����'     
									<C> Name='�а�NO'  		ID=JOUNO	         Width=50     	align=center 	  EditStyle=Popup</C>
								    <C> Name='�а���'	  	ID=JOU_NAME	   	  	Width=100  	    align=left  	  edit=none  bgcolor='#eeeeee'</C>
								</G>
								
								<G> Name='��������'	  
								<C> Name='�ڵ�'	     		ID=ATCODE 	         Width=50     	align=center 	  EditStyle=Popup</C>
								<C> Name='������'	     	ID=ATKORNAM	   		 Width=100  	align=left  	  edit=none  bgcolor='#eeeeee'</C>
								<C> Name='����'	     		ID=ATDECR  	   		 Width=50    	align=center 	  EditStyle=Combo, Data='1:����,2:�뺯'</C>
								<C> Name='üũ'  	 		ID=ACCCHK		     Width=30    	align=left  	  </C>
								<C> Name='üũ��'  	 		ID=CHKNAME  	     Width=100    	align=left  	  </C>
								</G>
								
								<G> Name='�ŷ�ó����'     
								<C> Name='�ڵ�'	      		ID=VENDCD	         Width=55    	align=center	  EditStyle=Popup </FC>
								<C> Name='�ŷ�ó��'	  		ID=VENDNM 	     	Width=100    	align=left  	  edit=none bgcolor='#eeeeee'</FC>
								</G>
								
								<G> Name='��������(�����׸�)'	   
								<C> Name='�ڵ�1'       		ID=FSREFCD1  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='�ڵ��1'     		ID=FSREFCDNM1      		Width=80     	align=left  	   </C>
								<C> Name='�׸�1'	  		ID=FSREFVAL1       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='�׸񰪸�1'	  	ID=FSREFVALNM1     		Width=80    	align=left  	   </C>
								<C> Name='�ڵ�2'       		ID=FSREFCD2  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='�ڵ��2'     		ID=FSREFCDNM2      		Width=80     	align=left  	   </C>
								<C> Name='�׸�2'	  		ID=FSREFVAL2       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='�׸񰪸�2'	  	ID=FSREFVALNM2     		Width=80    	align=left  	   </C>
								<C> Name='�ڵ�3'       		ID=FSREFCD3  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='�ڵ��3'     		ID=FSREFCDNM3      		Width=80     	align=left  	   </C>
								<C> Name='�׸�3'	  		ID=FSREFVAL3       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='�׸񰪸�3'	  	ID=FSREFVALNM3     		Width=80    	align=left  	   </C>
								<C> Name='�ڵ�4'       		ID=FSREFCD4  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='�ڵ��4'     		ID=FSREFCDNM4       	Width=80     	align=left  	   </C>
								<C> Name='�׸�4'	  		ID=FSREFVAL4       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='�׸񰪸�4'	  	ID=FSREFVALNM4     		Width=80    	align=left  	   </C>
								<C> Name='�ڵ�5'       		ID=FSREFCD5  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='�ڵ��5'     		ID=FSREFCDNM5       	Width=80     	align=left  	   </C>
								<C> Name='�׸�5'	  		ID=FSREFVAL5       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='�׸񰪸�5'	  	ID=FSREFVALNM5     		Width=80    	align=left  	   </C>
								<C> Name='�ڵ�6'       		ID=FSREFCD6  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='�ڵ��6'     		ID=FSREFCDNM6       	Width=80     	align=left  	   </C>
								<C> Name='�׸�6'	  		ID=FSREFVAL6       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='�׸񰪸�6'	  	ID=FSREFVALNM6     		Width=80    	align=left  	   </C>
								<C> Name='�ڵ�7'       		ID=FSREFCD7  	     	Width=40    	align=left  	  EditStyle=Popup </C>
								<C> Name='�ڵ��7'     		ID=FSREFCDNM7       	Width=80     	align=left  	   </C>
								<C> Name='�׸�7'	  		ID=FSREFVAL7       		Width=50    	align=left  	  EditStyle=Popup </C>
								<C> Name='�׸񰪸�7'	  	ID=FSREFVALNM7     		Width=80    	align=left  	   </C>
								</G>
								<C> Name='���\\����'    	ID=USEGB 	     		Width=50    	align=center	  EditStyle=Combo, Data='T:���,F:�̻��' </C> 
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