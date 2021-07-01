<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: �ڿ�>�ڿ�����>ȸ�ǽǿ���>ȸ�ǽǰ���
* ���α׷� ID	: lm050.jsp
* �� �� �� ��	: ȸ�ǽǰ���
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2017.8.8
-----------------------------------------------------------------------------
* �� �� �� �� : 
* ��   ��  �� :
* �� �� �� �� : 
-----------------------------------------------------------------------------
*	31 3�� ��ȸ�ǽ� 2020.12.07�Ϻη� ������
*   41 4�� ��ȸ�ǽ� 2020.12.07�Ϻη� ������
*   42 4�� ��ȸ�ǽ�1
*   43 4�� ��ȸ�ǽ�2
*   33 3�� ��ȸ�ǽ�3
*   34 3�� ��ȸ�ǽ�4	
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>
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
<title>ȸ�ǽǰ���</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
	gcem_yyyymm.text = gcurdate.substr(0,7);	
	
	gcem_yyyymmdd.text = gcurdate;

    fnInit();

	//fnSelect();
    
}

/******************************************************************************
	Description : �ʱ�ȭ 
****************************************************************************/
function fnInit(){

		//var yymm = gcem_yyyymmdd.text.substring(0,6);
		
		var yymm = gcem_yyyymm.text;
		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_staxdate=" +yymm;		

	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lm050",  "JSP(O:DS_CALENDAR=ds_calendar)",  param);
	    
	    tr_post(tr1);

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function fnSelect() {

	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_staxdate=" +gcem_yyyymmdd.text;		
	
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lm050",  "JSP(O:DS_DEFAULT=ds_default)",  param);
    
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

<object  id=ds_calendar classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<script language="javascript" for="ds_calendar" event="onloadCompleted(row,colid)">
	
	    var yymm = gcurdate.substring(8,10);

	    ds_calendar.RowPosition = yymm;		
	    
	    fnSelect();
	
</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">


		
		if (ds_artificial.CountColumn == 0) {
			ds_artificial.setDataHeader("DRIVE_DT:STRING, CAR_NO:STRING, TIME8:STRING, TIME9:STRING, TIME10:STRING, TIME11:STRING, TIME12:STRING, TIME13:STRING, TIME14:STRING, TIME15:STRING, TIME16:STRING, TIME17:STRING, TIME18:STRING, TIME19:STRING, TIME20:STRING, TIME21:STRING");
		}
				
		ds_artificial.AddRow();
		ds_artificial.AddRow();
		ds_artificial.AddRow();
		ds_artificial.AddRow();		
	
		
		
		ds_artificial.namevalue(1,"CAR_NO") = "33";		    		
		ds_artificial.namevalue(2,"CAR_NO") = "34";		
		ds_artificial.namevalue(3,"CAR_NO") = "42";		    		
		ds_artificial.namevalue(4,"CAR_NO") = "43";			
	
		
		ds_artificial.namevalue(1,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");		    		
		ds_artificial.namevalue(2,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");		
		ds_artificial.namevalue(3,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");		    		
		ds_artificial.namevalue(4,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");			

		

    	    for(i=1; i<=23; i++){
    	    	
	    		for(j=1; j<=21; j++){	  
	    			
		    			if(ds_default.NameValue(i, "CAR_NO") == '33'){

			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
			    				
			    					ds_artificial.NameValue(1, "TIME"+j)  = "����";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(1, "TIME"+j)  = "����";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(1, "TIME"+j)  = "�ݼ�";				    					
			    				}

			    			}	   
		    				   

		    			}else if(ds_default.NameValue(i, "CAR_NO") == '34'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(2, "TIME"+j)  = "����";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(2, "TIME"+j)  = "����";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(2, "TIME"+j)  = "�ݼ�";				    					
			    				}
		
			    			}			
			    			
		    			}else if(ds_default.NameValue(i, "CAR_NO") == '42'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(3, "TIME"+j)  = "����";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(3, "TIME"+j)  = "����";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(3, "TIME"+j)  = "�ݼ�";				    					
			    				}
		
			    			}					    			
						
		    			}else if(ds_default.NameValue(i, "CAR_NO") == '43'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(4, "TIME"+j)  = "����";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(4, "TIME"+j)  = "����";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(4, "TIME"+j)  = "�ݼ�";				    					
			    				}
		
			    			}	
			    		
		    			}

		    			
		    	}
    	    
    	    }
            

		ds_artificial.AddRow();		
    	
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
</script>



<script language=JavaScript for=gcem_yyyymm event=onKeyDown(kcode,scode)>

	if (kcode == 13){
		
		ds_default.ClearData();
		
		ds_artificial.ClearData();	
		
		fnInit();
		
		ds_calendar.RowPosition = 1;
		
		fnSelect();
		

	}

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnClick(row,colid)>

	ds_default.ClearData();
	ds_artificial.ClearData();	

	var day = ds_calendar.NameValue(row, "REG_YMD");

	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_staxdate=" +day;		
	
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc050",  "JSP(O:DS_DEFAULT=ds_default)",  param);
    
    tr_post(tr1);

 </script>



<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>


		var sendParam	= new Array();
		var arrParam	= new Array();
		var arrResult	= new Array();
		var carno;
		var time = colid.substring(4,6);	
		
		var strURL;	
		var strPos;
		
		//alert(time);
		
		var book = ds_artificial.NameValue(row, colid);
		
	
		if(book != "����" && book != "����" && book != "�ݼ�"){	
			
			alert("������ �Ǿ� ���� �ʽ��ϴ�.");
			
			return;
			
		}
		
		
		
		if(row == "1"){	
			carno = '33';
		}else if (row == "2"){
			carno = '34';			
		}else if (row == "3"){
			carno = '42';				
		}else if (row == "4"){
			carno = '43';								
		}
		
		sendParam[0] = ds_artificial.NameValue(1, "DRIVE_DT"); 
		sendParam[1] = carno; 
		sendParam[2] = time; 	
	
		//alert(sendParam);
		
		strURL = "../../Security/lc/lm025.jsp";
		strPos = "dialogWidth:400px;dialogHeight:320px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,sendParam,strPos);
		
		ds_default.ClearAll();
		ds_artificial.ClearAll();	
		//fnInit();
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


<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
	
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>�ش��</td> 
		<td class="tab24" width="100px;">&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_yyyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>			
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>����</td> 
		<td class="tab24" >&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_yyyymmdd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">					
							<param name=Enable				value="false">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>			
		
		<td align=left width="80px;">
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fn_Select2();">
		</td>		
		
	</tr>
</table>

<br>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:100px; height:640px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_calendar">
					<param name="IndWidth"		 	value='0'>
					<param name="BorderStyle"  		value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="HeadBorder"	 		value="5">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="20">					
					<param name="Format"	 	 		value=" 
					<C> Name='����'  	    ID=REG_YMD		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 		align=center mask='XXXX-XX-XX' BgColor={Decode(HOL_YN,'Y','#FAED7D')}</C>
										
					">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>

		<td>

<table width="880px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  style="position:relative;left:0px;width:880px; height:640px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_artificial">
					<param name="IndWidth"		 	value='0'>
					<param name="BorderStyle"  		value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 		value="true">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="20">
                    <param name="SuppressOption"   value="1">						
					<param name="Format"	 	 		value=" 
					<C> Name='����'		  		ID=DRIVE_DT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 		align=center	 mask ='XXXX-XX-XX' suppress=1</C>
					<C> Name='ȸ�ǽ�'		  		ID=CAR_NO 	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=140 		align=center value={Decode(CAR_NO,'33','3�� ��ȸ�ǽ�3','34','3�� ��ȸ�ǽ�4','42','4�� ��ȸ�ǽ�1','43','4�� ��ȸ�ǽ�2')}</C>
                    <C> Name='8'  	        	ID=TIME8		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 		align=center BgColor={Decode(TIME8	,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>
					<C> Name='9'      			ID=TIME9		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 		align=center BgColor={Decode(TIME9	,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>                    
					<C> Name='10'         		ID=TIME10		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 		align=center BgColor={Decode(TIME10,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>                    
					<C> Name='11'  	      		ID=TIME11		HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=center BgColor={Decode(TIME11,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>
                    <C> Name='12'  	        	ID=TIME12		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 		align=center BgColor={Decode(TIME12,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>
					<C> Name='13'      			ID=TIME13		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 		align=center BgColor={Decode(TIME13,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>                    
					<C> Name='14'         		ID=TIME14		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 		align=center BgColor={Decode(TIME14,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>                    
					<C> Name='15'  	      		ID=TIME15		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 		align=center BgColor={Decode(TIME15,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>
                    <C> Name='16'  	        	ID=TIME16		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 		align=center BgColor={Decode(TIME16,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>
					<C> Name='17'      			ID=TIME17		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 		align=center BgColor={Decode(TIME17,'����','#1DDB16','����','#FAED7D','�ݼ�','#FFA7A7')} </C>                    
					">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>

</table> 

		</td>
	</tr>
</table>



<comment id="__NSID__">
<object  id=gcbn_02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_calendar>
	<param name=BindInfo  value='  
		<C>Col=REG_YMD	  Ctrl=gcem_yyyymmdd   Param=TEXT </C>
	'>
</object>
</comment><script>__ws__(__NSID__);</script>

</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



