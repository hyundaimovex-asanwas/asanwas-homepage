<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: �ڿ�>�ڿ�����>ȸ�ǽǿ���>ȸ�ǽǿ���
* ���α׷� ID	: lm010.jsp
* �� �� �� ��	: ������û
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2017.7.6
-----------------------------------------------------------------------------
* �� �� �� �� : 
* ��   ��  �� :
* �� �� �� �� : 
-----------------------------------------------------------------------------
* �� �� �� ��	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////

/*******************************************************************************
*	31 3�� ��ȸ�ǽ� 2020.12.07�Ϻη� ������
*   41 4�� ��ȸ�ǽ� 2020.12.07�Ϻη� ������
*   42 4�� ��ȸ�ǽ�1
*   43 4�� ��ȸ�ǽ�2
*   33 3�� ��ȸ�ǽ�3
*   34 3�� ��ȸ�ǽ�4
*******************************************************************************/

%>
<%	// ContextPath ���� ����.
  String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>ȸ�ǽǿ���</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
	gcem_staxdate.text = gcurdate;
	
    fnInit();

	fnSelect();
    
}

/******************************************************************************
	Description : �ʱ�ȭ 
****************************************************************************/
function fnInit(){
		
		if (ds_artificial.CountColumn == 0) {
			ds_artificial.setDataHeader("MEET_DT:STRING, TIME1:STRING, ROOM31:STRING, BOOKING31:STRING, REMARK31:STRING, ROOM41:STRING, BOOKING41:STRING, REMARK41:STRING, ROOM42:STRING, BOOKING42:STRING, REMARK42:STRING, ROOM43:STRING, BOOKING43:STRING, REMARK43:STRING, ROOM33:STRING, BOOKING33:STRING, REMARK33:STRING, ROOM34:STRING, BOOKING34:STRING, REMARK34:STRING");
		}
		
        for(i=8; i<=17; i++){
        		
			// �� �߰�
			ds_artificial.AddRow();
		        
		    //���� �ʱ�ȭ		        
		    ds_artificial.NameString(ds_artificial.RowPosition, "MEET_DT")    = gcem_staxdate.text;
		    
		    if(i == '8'){
		    	ds_artificial.NameString(ds_artificial.RowPosition, "TIME1")         = '08'; 
        	}else if(i=='9'){
        		ds_artificial.NameString(ds_artificial.RowPosition, "TIME1")         = '09'; 
        	}else{
        		ds_artificial.NameString(ds_artificial.RowPosition, "TIME1")         = i; 
        	}

        }
		
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function fnSelect() {

		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_staxdate=" + gcem_staxdate.text;
		
	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lm010",  "JSP(O:DS_DEFAULT=ds_default)",  param);
	    
	    //prompt(this, param);
	    
	    tr_post(tr1);
   
}

/******************************************************************************
Description : ��ȸ
******************************************************************************/
function fn_Select() {

		ds_default.ClearData();
		
		ds_artificial.ClearData();	
		
		fnInit();
		
		fnSelect(); 
	    
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 					VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  			Value="False">
</object>

<object  id=ds_artificial classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 					VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  			Value="False">
    <param name="SuppressOption" 			value="1">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    			value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">

</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">

		var check = 0;
	
	    for(i=1; i<=ds_default.countrow; i++){

	    	if(ds_default.NameValue(i, "ROOM") == '31'){
	    		
	    		for(j=1; j<=18; j++){	    			
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){

	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	 
	    					
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK31") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;		    	    			
	    					}

	    	    			ds_artificial.NameValue(j-7, "BOOKING31")  = 'S';
	    				}

	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK31") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING31")  = 'Y';
	    				}	    
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK31") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' �ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING31")  = 'N';	    	    			
	    				}		    				
	    				
	    				
	    			}
	    		}
	    		check = 0;
	    	}
	    	
	    	if(ds_default.NameValue(i, "ROOM") == '41'){
	    		
	    		for(j=1; j<=18; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){

	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    		
	    					
		    				if(check == '0'){	 	 
	    	    				ds_artificial.NameValue(j-7, "REMARK41") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;
		    				}

	    	    			ds_artificial.NameValue(j-7, "BOOKING41")  = 'S';
	    	    			
	    				}

	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK41") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING41")  = 'Y';
	    				}	    
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK41") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' �ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING41")  = 'N';	    	    			
	    				}			    				
	    				
	    			}	    					
	    		}	    					
	    		check = 0;
	    	}	    	
	    	
	    	
	    	if(ds_default.NameValue(i, "ROOM") == '42'){
	    		
	    		for(j=1; j<=18; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){

	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    	
	    					
		    				if(check == '0'){	 	 
	    	    				ds_artificial.NameValue(j-7, "REMARK42") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;
		    				}
	    	    			
	    	    			ds_artificial.NameValue(j-7, "BOOKING42")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK42") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING42")  = 'Y';
	    				}	    
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK42") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' �ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING42")  = 'N';	    	    			
	    				}			    				
	    				

	    			}
	    		}
	    		check = 0;
	    	}		    	
	    	
	    	if(ds_default.NameValue(i, "ROOM") == '43'){
	    		
	    		for(j=1; j<=18; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){

	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	  

		    				if(check == '0'){	 	 
	    	    				ds_artificial.NameValue(j-7, "REMARK43") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;
		    				}

	    	    			ds_artificial.NameValue(j-7, "BOOKING43")  = 'S';
	    	    			
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK43") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING43")  = 'Y';
	    				}	    
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK43") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' �ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING43")  = 'N';	    	    			
	    				}			    				

	    			}
	    		}
	    		check = 0;
	    	}		    	

	    	
	    	//2020.12.07 �߰���
	    	if(ds_default.NameValue(i, "ROOM") == '33'){
	    		
	    		for(j=1; j<=18; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){

	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    	
	    					
		    				if(check == '0'){	 	 
	    	    				ds_artificial.NameValue(j-7, "REMARK33") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;
		    				}
	    	    			
	    	    			ds_artificial.NameValue(j-7, "BOOKING33")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK33") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING33")  = 'Y';
	    				}	    
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK33") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' �ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING33")  = 'N';	    	    			
	    				}			    				
	    				

	    			}
	    		}
	    		check = 0;
	    	}	
	    	
	    	
	    	
	    	if(ds_default.NameValue(i, "ROOM") == '34'){
	    		
	    		for(j=1; j<=18; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){

	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    	
	    					
		    				if(check == '0'){	 	 
	    	    				ds_artificial.NameValue(j-7, "REMARK34") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;
		    				}
	    	    			
	    	    			ds_artificial.NameValue(j-7, "BOOKING34")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK34") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' ����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING34")  = 'Y';
	    				}	    
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK34") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM")+ ' �ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING34")  = 'N';	    	    			
	    				}			    				
	    				

	    			}
	    		}
	    		check = 0;
	    	}		    	
	    	
	    	
	    	
	    }
    	
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
</script>

<script language=JavaScript for=gcem_staxdate event=onKeyDown(kcode,scode)>

	if (kcode == 13){
		
		ds_default.ClearData();
		
		ds_artificial.ClearData();	
		
		fnInit();
		
		fnSelect();
	}

</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>


	var sendParam	= new Array();
	var arrParam	= new Array();
	var arrResult	= new Array();
	var check;
	
	var strURL;	
	var strPos;
	
	//prompt(this, ds_artificial.text);
	//prompt(this, ds_default.text);
	
	if(colid == "REMARK31"){
		
		if(ds_artificial.NameValue(row, "BOOKING31") == "S"){
			check = 'Y';
		}else if(ds_artificial.NameValue(row, "BOOKING31") == "Y"){
			check = 'Y';			
		}else{
			check = 'N';
		}
		
	}else if (colid == "REMARK41"){
		
		if(ds_artificial.NameValue(row, "BOOKING41") == "S"){
			check = 'Y';
		}else if(ds_artificial.NameValue(row, "BOOKING41") == "Y"){
			check = 'Y';			
		}else{
			check = 'N';
		}
		
	}else if (colid == "REMARK42"){
			
		if(ds_artificial.NameValue(row, "BOOKING42") == "S"){
			check = 'Y';
		}else if(ds_artificial.NameValue(row, "BOOKING42") == "Y"){
			check = 'Y';
		}else{
			check = 'N';
		}		
		
	}else if (colid == "REMARK43"){
		
		if(ds_artificial.NameValue(row, "BOOKING43") == "S"){
			check = 'Y';
		}else if(ds_artificial.NameValue(row, "BOOKING43") == "Y"){
			check = 'Y';			
		}else{
			check = 'N';
		}		
		
		
	}else if (colid == "REMARK33"){
		
		if(ds_artificial.NameValue(row, "BOOKING33") == "S"){
			check = 'Y';
		}else if(ds_artificial.NameValue(row, "BOOKING33") == "Y"){
			check = 'Y';			
		}else{
			check = 'N';
		}	
		
	}else if (colid == "REMARK34"){
		
		if(ds_artificial.NameValue(row, "BOOKING34") == "S"){
			check = 'Y';
		}else if(ds_artificial.NameValue(row, "BOOKING34") == "Y"){
			check = 'Y';			
		}else{
			check = 'N';
		}			

		
	}
	
		

	
	//alert(check);
	
	sendParam[0] = gcem_staxdate.text; 
	sendParam[1] = ds_artificial.namevalue(row, "TIME1"); 
	sendParam[2] = colid; 	
	sendParam[3] = check; 
	sendParam[4] = gusrid;	
	
	//alert(sendParam);
	
	strURL = "../../Security/lc/lm020.jsp";
	strPos = "dialogWidth:400px;dialogHeight:300px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,sendParam,strPos);
	
	ds_default.ClearData();
	ds_artificial.ClearData();	
	fnInit();
	fnSelect();	
	
 </script>

<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fn_Select()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>����</td> 
		<td class="tab24" >&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_staxdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>	
	</tr>
</table>

<BR>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:1000px; height:300px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_artificial">
					<param name="IndWidth"		 		value='0'>
					<param name="BorderStyle"  			value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 			value="true">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="30">
                    <param name="SuppressOption"   		value="1">						
					<param name="Format"	 	 		value=" 
					<C> Name='�ð�'		  					ID=TIME1 	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 	align=center value={Decode(TIME1,'08','08�� - 09��','09','09�� - 10��','10','10�� - 11��','11','11�� - 12��','12','12�� - 13��','13','13�� - 14��','14','14�� - 15��','15','15�� - 16��','16','16�� - 17��','17','17�� - 18��',TIME1)}</C>
					<C> Name='3�� ��ȸ�ǽ�'      				ID=REMARK31	HeadAlign=Center HeadBgColor=#B9D4DC Width=210 	align=center BgColor={Decode(BOOKING31,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} show=false</C>                    
					<C> Name='4�� ��ȸ�ǽ�'      				ID=REMARK41	HeadAlign=Center HeadBgColor=#B9D4DC Width=210 	align=center BgColor={Decode(BOOKING41,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} show=false</C>                    
					<C> Name='4�� ��ȸ�ǽ�1'      				ID=REMARK42	HeadAlign=Center HeadBgColor=#B9D4DC Width=210 	align=center BgColor={Decode(BOOKING42,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>                    
					<C> Name='4�� ��ȸ�ǽ�2'      				ID=REMARK43	HeadAlign=Center HeadBgColor=#B9D4DC Width=210 	align=center BgColor={Decode(BOOKING43,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>   
					<C> Name='3�� ��ȸ�ǽ�3'      				ID=REMARK33	HeadAlign=Center HeadBgColor=#B9D4DC Width=210 	align=center BgColor={Decode(BOOKING33,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>                    
					<C> Name='3�� ��ȸ�ǽ�4'      				ID=REMARK34	HeadAlign=Center HeadBgColor=#B9D4DC Width=210 	align=center BgColor={Decode(BOOKING34,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>  					
					
					                 
					">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	
	<tr>
		<td>&nbsp;
		</td>
	</tr>
	
	<tr>
		<td align="left" class="blueBold">
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� Working Day ����, D-1  17�ÿ� ��û ���� </font>
			<br><br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� ���� ����, ���� ��� ���� �濵�������� ���� </font> 	
			<br><br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� ��� ��, ȸ�� ���̺� �� ���� ����</font>								
			<br><br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� ��Ÿ ���ǻ��� : �濵������   ��â�� ���(3903)</font>				
		</td>
	 </td>
	</tr>
	
</table> 


</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



