<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: �ڿ�>�ڿ�����>��������>������û
* ���α׷� ID	: lc010.jsp
* �� �� �� ��	: ������û
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2017.5.12
-----------------------------------------------------------------------------
*	S1, S2 ��Ÿ����     - 2020.03.24 ��Ȱ��ȭ
*	A1, A2 �ڳ�_0989
*	A3, A4 �ڳ�CS_3260  - 2020.03.24 �߰���
*   T1, T2 ��Ÿ��_0796  - 2020.06.17 ��Ȱ��ȭ
*   C1, C2 ī�Ϲ�1_0623
*   C3, C4 ī�Ϲ�2_0887
*   C5, C6 ī�Ϲ�3_0702 - 2020.06.17 ��Ȱ��ȭ
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
%>
<%	// ContextPath ���� ����.
  String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>������û</title>

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
			ds_artificial.setDataHeader("DRIVE_DT:STRING, TIME1:STRING, CAR_NO11:STRING, BOOKING11:STRING, REMARK11:STRING, CAR_NO12:STRING, BOOKING12:STRING, REMARK12:STRING, CAR_NO21:STRING, BOOKING21:STRING, REMARK21:STRING, CAR_NO22:STRING, BOOKING22:STRING, REMARK22:STRING, CAR_NO31:STRING, BOOKING31:STRING, REMARK31:STRING, CAR_NO32:STRING, BOOKING32:STRING, REMARK32:STRING, CAR_NO33:STRING, BOOKING33:STRING, REMARK33:STRING, CAR_NO34:STRING, BOOKING34:STRING, REMARK34:STRING, CAR_NO41:STRING, BOOKING41:STRING, REMARK41:STRING, CAR_NO42:STRING, BOOKING42:STRING, REMARK42:STRING, CAR_NO43:STRING, BOOKING43:STRING, REMARK43:STRING, CAR_NO44:STRING, BOOKING44:STRING, REMARK44:STRING, CAR_NO51:STRING, BOOKING51:STRING, REMARK51:STRING, CAR_NO52:STRING, BOOKING52:STRING, REMARK52:STRING, CAR_NO53:STRING, BOOKING53:STRING, REMARK53:STRING, CAR_NO54:STRING, BOOKING54:STRING, REMARK54:STRING");
		}
		

        for(i=8; i<=20; i++){
        		
			// �� �߰�
			ds_artificial.AddRow();
		        
		    //���� �ʱ�ȭ		        
		    ds_artificial.NameString(ds_artificial.RowPosition, "DRIVE_DT")    = gcem_staxdate.text;
		    
		    if(i == '8'){
		    	ds_artificial.NameString(ds_artificial.RowPosition, "TIME1")         = '08'; 
        	}else if(i=='9'){
        		ds_artificial.NameString(ds_artificial.RowPosition, "TIME1")         = '09'; 
        	}else{
        		ds_artificial.NameString(ds_artificial.RowPosition, "TIME1")         = i; 
        	}

		    
		    //��Ÿ����
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO21")    = 'S1'; 
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO22")    = 'S2';
		    
		    
		    //�ڳ�_0989
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO31")    = 'A1'; 
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO32")    = 'A2';
		    
		    
		    //�ڳ�CS_3260
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO53")    = 'A3'; 
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO54")    = 'A4';	
		    
		    
		    //��Ÿ��_0796
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO33")    = 'T1'; 
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO34")    = 'T2';		    
		    
		    
		    //ī�Ϲ�1_0623
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO41")    = 'C1'; 
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO42")    = 'C2';		    

		    
		    //ī�Ϲ�2_0887
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO51")    = 'C3'; 
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO52")    = 'C4';	

		    
		    //ī�Ϲ�3_0702
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO43")    = 'C5'; 
		    ds_artificial.NameString(ds_artificial.RowPosition, "CAR_NO44")    = 'C6';	
		    
		    
        }
		
        
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function fnSelect() {

		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_staxdate=" + gcem_staxdate.text;
		
	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc010",  "JSP(O:DS_DEFAULT=ds_default)",  param);
	    
	    tr_post(tr1);
   
}

/******************************************************************************
Description : ��ȸ
******************************************************************************/
function fn_Select2() {

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
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_artificial classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
    <param name="SuppressOption" 			value="1">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
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

	    	
	    	//��Ÿ����
	    	if(ds_default.NameValue(i, "CAR_NO") == 'S1'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){

	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK21") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING21")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK21") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING21")  = 'Y';
	    				}	    
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK21") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING21")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;	    		
	    	}	 	    	
	    	
	    	if(ds_default.NameValue(i, "CAR_NO") == 'S2'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){

	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK22") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING22")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK22") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING22")  = 'Y';
	    				}	    
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK22") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING22")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;	
	    	}	 	    	
	    	
	    	
	    	
	    	//�ڳ�_0989
	    	if(ds_default.NameValue(i, "CAR_NO") == 'A1'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK31") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING31")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK31") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING31")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK31") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING31")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;		    		
	    	}	 	    	
	    	
	    	if(ds_default.NameValue(i, "CAR_NO") == 'A2'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK32") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING32")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK32") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING32")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK32") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING32")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;			    		
	    	}	 	    	
	    	
	    	
	    	
	    	
	    	//�ڳ�CS_3260
	    	if(ds_default.NameValue(i, "CAR_NO") == 'A3'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK53") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING53")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK53") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING53")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK53") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING53")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;		    		
	    	}	 	    	
	    	
	    	if(ds_default.NameValue(i, "CAR_NO") == 'A4'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK54") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING54")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK54") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING54")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK54") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING54")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;			    		
	    	}	 
	    	
	    	
	    	
	    	
	    	
	    	//��Ÿ��_0796
	    	if(ds_default.NameValue(i, "CAR_NO") == 'T1'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK33") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING33")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK33") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING33")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK33") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING33")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;		    		
	    	}	 	    	
	    	
	    	if(ds_default.NameValue(i, "CAR_NO") == 'T2'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK34") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING34")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK34") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING34")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK34") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING34")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;			    		
	    	}	 		    	
	    	
	    	
	    	//ī�Ϲ�1_0623
	    	if(ds_default.NameValue(i, "CAR_NO") == 'C1'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK41") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING41")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK41") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING41")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK41") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING41")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;		    		
	    	}	 	    	
	    	
	    	if(ds_default.NameValue(i, "CAR_NO") == 'C2'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK42") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING42")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK42") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING42")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK42") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING42")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;	    		
	    	}	 	   	    	
	    	
	    	
	    	
	    	//ī�Ϲ�2_0887
	    	if(ds_default.NameValue(i, "CAR_NO") == 'C3'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK51") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING51")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK51") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING51")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK51") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING51")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;		    		
	    	}	 	    	
	    	
	    	if(ds_default.NameValue(i, "CAR_NO") == 'C4'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK52") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING52")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK52") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING52")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK52") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING52")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;	    		
	    	}	 
	    	
	    	
	    	//ī�Ϲ�3_0702
	    	if(ds_default.NameValue(i, "CAR_NO") == 'C5'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK43") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING43")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK43") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING43")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK43") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING43")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;		    		
	    	}	 	    	
	    	
	    	if(ds_default.NameValue(i, "CAR_NO") == 'C6'){
	    		
	    		for(j=1; j<=21; j++){
	    			
	    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'S'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK44") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING44")  = 'S';
	    				}
	    				
	    				if(ds_default.NameValue(i, "STATUS") == 'Y'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK44") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '����]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING44")  = 'Y';
	    				}	    	    				

	    				if(ds_default.NameValue(i, "STATUS") == 'N'){	 	    				
	    					if(check == '0'){	 
		    	    			ds_artificial.NameValue(j-7, "REMARK44") = '[' +ds_default.NameValue(i, "ENO_NM") + ds_default.NameValue(i, "JOB_NM") + '�ݼ�]';
	    	    				check = 1;		    	    			
	    					}
	    	    			ds_artificial.NameValue(j-7, "BOOKING44")  = 'N';		    	    			
	    				}		    				
	    				
	    			}
	    		}
	    		check=0;	    		
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
	
	if(colid == "REMARK11"){
		if(ds_artificial.NameValue(row, "BOOKING11") == "S" || ds_artificial.NameValue(row, "BOOKING11") == "Y" || ds_artificial.NameValue(row, "BOOKING11") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}
	}else if (colid == "REMARK12"){
		if(ds_artificial.NameValue(row, "BOOKING12") == "S" || ds_artificial.NameValue(row, "BOOKING12") == "Y" || ds_artificial.NameValue(row, "BOOKING12") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}
	}else if (colid == "REMARK21"){
		if(ds_artificial.NameValue(row, "BOOKING21") == "S" || ds_artificial.NameValue(row, "BOOKING21") == "Y" || ds_artificial.NameValue(row, "BOOKING21") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}		
	}else if (colid == "REMARK22"){
		if(ds_artificial.NameValue(row, "BOOKING22") == "S" || ds_artificial.NameValue(row, "BOOKING22") == "Y" || ds_artificial.NameValue(row, "BOOKING22") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}		
	}else if (colid == "REMARK31"){
		if(ds_artificial.NameValue(row, "BOOKING31") == "S" || ds_artificial.NameValue(row, "BOOKING31") == "Y" || ds_artificial.NameValue(row, "BOOKING31") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}	
	}else if (colid == "REMARK32"){
		if(ds_artificial.NameValue(row, "BOOKING32") == "S" || ds_artificial.NameValue(row, "BOOKING32") == "Y" || ds_artificial.NameValue(row, "BOOKING32") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}		
		
	}else if (colid == "REMARK33"){
		if(ds_artificial.NameValue(row, "BOOKING33") == "S" || ds_artificial.NameValue(row, "BOOKING33") == "Y" || ds_artificial.NameValue(row, "BOOKING33") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}	
	}else if (colid == "REMARK34"){
		if(ds_artificial.NameValue(row, "BOOKING34") == "S" || ds_artificial.NameValue(row, "BOOKING34") == "Y" || ds_artificial.NameValue(row, "BOOKING34") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}			
		
	}else if (colid == "REMARK41"){
		if(ds_artificial.NameValue(row, "BOOKING41") == "S" || ds_artificial.NameValue(row, "BOOKING41") == "Y" || ds_artificial.NameValue(row, "BOOKING41") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}	
	}else if (colid == "REMARK42"){
		if(ds_artificial.NameValue(row, "BOOKING42") == "S" || ds_artificial.NameValue(row, "BOOKING42") == "Y" || ds_artificial.NameValue(row, "BOOKING42") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}	
		
	}else if (colid == "REMARK43"){
		if(ds_artificial.NameValue(row, "BOOKING43") == "S" || ds_artificial.NameValue(row, "BOOKING43") == "Y" || ds_artificial.NameValue(row, "BOOKING43") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}	
	}else if (colid == "REMARK44"){
		if(ds_artificial.NameValue(row, "BOOKING44") == "S" || ds_artificial.NameValue(row, "BOOKING44") == "Y" || ds_artificial.NameValue(row, "BOOKING44") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}			
		
	}else if (colid == "REMARK51"){
		if(ds_artificial.NameValue(row, "BOOKING51") == "S" || ds_artificial.NameValue(row, "BOOKING51") == "Y" || ds_artificial.NameValue(row, "BOOKING51") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}	
	}else if (colid == "REMARK52"){
		if(ds_artificial.NameValue(row, "BOOKING52") == "S" || ds_artificial.NameValue(row, "BOOKING52") == "Y" || ds_artificial.NameValue(row, "BOOKING52") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}			
		
		
	}else if (colid == "REMARK53"){
		if(ds_artificial.NameValue(row, "BOOKING53") == "S" || ds_artificial.NameValue(row, "BOOKING53") == "Y" || ds_artificial.NameValue(row, "BOOKING53") == "N"){
			check = 'Y';
		}else{
			check = 'N';
		}	
	}else if (colid == "REMARK54"){
		if(ds_artificial.NameValue(row, "BOOKING54") == "S" || ds_artificial.NameValue(row, "BOOKING54") == "Y" || ds_artificial.NameValue(row, "BOOKING54") == "N"){
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
	
	strURL = "../../Security/lc/lc020.jsp";
	strPos = "dialogWidth:400px;dialogHeight:500px;status:no;scroll:no;resizable:no";
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
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fn_Select2()">
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
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:1000px; height:330px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_artificial">
					<param name="IndWidth"		 		value='0'>
					<param name="BorderStyle"  			value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 			value="true">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="20">
                    <param name="SuppressOption"   		value="1">						
					<param name="Format"	 	 		value=" 
					<C> Name='�ð�'		  			ID=TIME1 	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=center	 value={Decode(TIME1,'08','08�� - 09��','09','09�� - 10��','10','10�� - 11��','11','11�� - 12��','12','12�� - 13��','13','13�� - 14��','14','14�� - 15��','15','15�� - 16��','16','16�� - 17��','17','17�� - 18��','18','18�� - 19��','19','19�� - 20��','20','20�� - 21��',TIME1)}</C>

                    <G> name='�ڳ�_0989' 			BgColor='#B9D4DC'
					<C> Name='����1'         			ID=REMARK31	HeadAlign=Center HeadBgColor=#B9D4DC Width=110 	align=center BgColor={Decode(BOOKING31,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>                    
					<C> Name='����2'         			ID=REMARK32	HeadAlign=Center HeadBgColor=#B9D4DC Width=110 	align=center BgColor={Decode(BOOKING32,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>                    
					</G>
					
					
                    <G> name='ī�Ϲ�1_0623' 		BgColor='#B9D4DC'
					<C> Name='����1'  	      		ID=REMARK41 HeadAlign=Center HeadBgColor=#B9D4DC Width=110 	align=center BgColor={Decode(BOOKING41,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>
					<C> Name='����2'  	      		ID=REMARK42 HeadAlign=Center HeadBgColor=#B9D4DC Width=110 	align=center BgColor={Decode(BOOKING42,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>
					</G>
					
                    <G> name='ī�Ϲ�2_0887' 		BgColor='#B9D4DC'
					<C> Name='����1'  	      		ID=REMARK51 HeadAlign=Center HeadBgColor=#B9D4DC Width=110 	align=center BgColor={Decode(BOOKING51,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>
					<C> Name='����2'  	      		ID=REMARK52 HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=center BgColor={Decode(BOOKING52,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>
					</G>						
					

					
                    <G> name='�ڳ�CS_3260' 		BgColor='#B9D4DC'
					<C> Name='����1'  	      		ID=REMARK53 HeadAlign=Center HeadBgColor=#B9D4DC Width=110 	align=center BgColor={Decode(BOOKING53,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>
					<C> Name='����2'  	      		ID=REMARK54 HeadAlign=Center HeadBgColor=#B9D4DC Width=110 	align=center BgColor={Decode(BOOKING54,'S','#FAED7D','Y','#1DDB16','N','#FFA7A7')} </C>
					</G>			
					
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
			<font color="red" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� �ߺ���û �� �������� �켱���� : ���Ÿ� > �ټ������� > ȭ������ > ���������� </font> 	
			<br><br>			
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� �������� �� ���� �������� �ۼ� : �����Է�[���� �����ۼ�]</font>	
			<br><br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� ������������ �ۼ���� : ERP > �ڿ� > �������� > �������� > ��ȸ(�ش���) Ŭ�� �� �ۼ�</font>	
			<br><br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� �������� �� ����</font> 
			<font color="red" size="2" bold="5" face = "Verdana"">No-show</font><font color="blue" size="2" bold="5" face = "Verdana"">/</font>
			<font color="red" size="2" bold="5" face = "Verdana"">�������� ���ۼ�</font><font color="blue" size="2" bold="5" face = "Verdana"">/</font>
			<font color="red" size="2" bold="5" face = "Verdana"">��������</font> 
			<font color="blue" size="2" bold="5" face = "Verdana"">���� </font>
			<font color="red" size="2" bold="5" face = "Verdana"">���� 1���� �������� �Ұ�</font>			
			<br><br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� ���� Key �μ� �� �ݳ��� ���� ������忡 ����</font>		
			<br><br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� �������� �� �������� �� ���� ��</font>
			<font color="red" size="2" bold="5" face = "Verdana"">�ݿ�</font> 
			<font color="blue" size="2" bold="5" face = "Verdana"">�ؼ�</font>										
			<br><br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� ��Ÿ ���ǻ��� : ������ ����(3900), ��â�� ���(3903)</font>				
		</td>
	 </td>
	</tr>
	
</table> 


</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



