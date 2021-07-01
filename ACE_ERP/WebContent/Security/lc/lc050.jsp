<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 자원>자원예약>차량예약>배차관리
* 프로그램 ID	: lc050.jsp
* 기 능 정 의	: 배차관리
* 작  성   자 : 이 동 훈
* 작 성 일 자 : 2017.6.15
-----------------------------------------------------------------------------
*	S1, S2 스타렉스     - 2020.03.24 비활성화
*	A1, A2 코나_0989
*	A3, A4 코나CS_3260  - 2020.03.24 추가됨
*   T1, T2 산타페_0796  - 2020.06.17 비활성화
*   C1, C2 카니발1_0623
*   C3, C4 카니발2_0887
*   C5, C6 카니발3_0702 - 2020.06.17 비활성화
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
  String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>배차관리</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//트리초기화 호출
	
	gcem_yyyymm.text = gcurdate.substr(0,7);	
	
	gcem_yyyymmdd.text = gcurdate;

    fnInit();

	//fnSelect();
    
}

/******************************************************************************
	Description : 초기화 
****************************************************************************/
function fnInit(){

		//var yymm = gcem_yyyymmdd.text.substring(0,6);
		
		var yymm = gcem_yyyymm.text;
		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_staxdate=" +yymm;		

	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc050",  "JSP(O:DS_CALENDAR=ds_calendar)",  param);
	    
	    tr_post(tr1);

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function fnSelect() {

	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_staxdate=" +gcem_yyyymmdd.text;		
	
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc050",  "JSP(O:DS_DEFAULT=ds_default)",  param);
    
    tr_post(tr1);

}

/******************************************************************************
Description : 조회
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
    <Param Name="UseChangeInfo"   		Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_calendar classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   		Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_artificial classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   		Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
    <param name="SuppressOption" 		value="1">
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
		ds_artificial.AddRow();
		ds_artificial.AddRow();
		ds_artificial.AddRow();
		ds_artificial.AddRow();				
		
	
		ds_artificial.namevalue(1,"CAR_NO") = "A1";		    		//코나_0989	
		ds_artificial.namevalue(2,"CAR_NO") = "A2";		
		ds_artificial.namevalue(3,"CAR_NO") = "C1";		    		//카니발1_0623
		ds_artificial.namevalue(4,"CAR_NO") = "C2";	
		ds_artificial.namevalue(5,"CAR_NO") = "C3";		    		//카니발2_0887
		ds_artificial.namevalue(6,"CAR_NO") = "C4";	
		ds_artificial.namevalue(7,"CAR_NO") = "A3";		    		//코나CS_3260
		ds_artificial.namevalue(8,"CAR_NO") = "A4";			
		
		
		ds_artificial.namevalue(1,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");		    		
		ds_artificial.namevalue(2,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");		
		ds_artificial.namevalue(3,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");		    		
		ds_artificial.namevalue(4,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");			
		ds_artificial.namevalue(5,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");		    		
		ds_artificial.namevalue(6,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");		
		ds_artificial.namevalue(7,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");		    		
		ds_artificial.namevalue(8,"DRIVE_DT") = ds_calendar.NameValue(ds_calendar.rowPosition, "REG_YMD");	



    	    for(i=1; i<=23; i++){
    	    	
	    		for(j=1; j<=21; j++){	  

	    			
	    				//코나_0989	
		    			if(ds_default.NameValue(i, "CAR_NO") == 'A1'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(1, "TIME"+j)  = "승인";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(1, "TIME"+j)  = "예약";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(1, "TIME"+j)  = "반송";				    					
			    				}
		
			    			}				    			
			    		
		    			}else if(ds_default.NameValue(i, "CAR_NO") == 'A2'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(2, "TIME"+j)  = "승인";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(2, "TIME"+j)  = "예약";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(2, "TIME"+j)  = "반송";				    					
			    				}
		
			    			}				    			
			    			
			    			
			    			
		    			//카니발1_0623
		    			}else if(ds_default.NameValue(i, "CAR_NO") == 'C1'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(3, "TIME"+j)  = "승인";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(3, "TIME"+j)  = "예약";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(3, "TIME"+j)  = "반송";				    					
			    				}
		
			    			}				    			
			    			
		    			}else if(ds_default.NameValue(i, "CAR_NO") == 'C2'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(4, "TIME"+j)  = "승인";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(4, "TIME"+j)  = "예약";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(4, "TIME"+j)  = "반송";				    					
			    				}
		
			    			}				    			
			    			
		    			//카니발2_0887
		    			}else if(ds_default.NameValue(i, "CAR_NO") == 'C3'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(5, "TIME"+j)  = "승인";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(5, "TIME"+j)  = "예약";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(5, "TIME"+j)  = "반송";				    					
			    				}
		
			    			}	
			    			
			    			
		    			}else if(ds_default.NameValue(i, "CAR_NO") == 'C4'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(6, "TIME"+j)  = "승인";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(6, "TIME"+j)  = "예약";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(6, "TIME"+j)  = "반송";				    					
			    				}
		
			    			}		
			    			
				    			

			    		//코나CS_3260
		    			}else if(ds_default.NameValue(i, "CAR_NO") == 'A3'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(7, "TIME"+j)  = "승인";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(7, "TIME"+j)  = "예약";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(7, "TIME"+j)  = "반송";				    					
			    				}
		
			    			}				    			
			    		
		    			}else if(ds_default.NameValue(i, "CAR_NO") == 'A4'){
			    			
			    			if(ds_default.NameValue(i, "FROM_TM") <= j && ds_default.NameValue(i, "TO_TM") >= j+1){
		
			    				if(ds_default.NameValue(i, "STATUS") == 'Y'){
				    				
			    					ds_artificial.NameValue(8, "TIME"+j)  = "승인";
			    				
			    				}else if(ds_default.NameValue(i, "STATUS") == 'S'){
			    					
			    					ds_artificial.NameValue(8, "TIME"+j)  = "예약";			    					
			    					
			    				}else if(ds_default.NameValue(i, "STATUS") == 'N'){
			    					
			    					ds_artificial.NameValue(8, "TIME"+j)  = "반송";				    					
			    				}
		
			    			}				    			
			    			
			    			
		    			}

		    	}
    	    
    	    }
    	    //prompt(this, ds_artificial.text);

		ds_artificial.AddRow();		
    	
	window.status="조회가 완료 되었습니다.";
	
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
		
	
		if(book != "승인" && book != "예약" && book != "반송"){	
			
			alert("예약이 되어 있지 않습니다.");
			
			return;
			
		}
		
		
		
		//if(row == "1"){	
		//	carno = 'G1';
		//}else if (row == "2"){
		//	carno = 'G2';			
		//}else if (row == "3"){
		//if (row == "1"){	
		//	carno = 'S1';				
		//}else if (row == "2"){
		//	carno = 'S2';					
		if (row == "1"){			
			carno = 'A1';					
		}else if (row == "2"){
			carno = 'A2';				
		}else if (row == "3"){			
			carno = 'C1';					
		}else if (row == "4"){			
			carno = 'C2';		
		}else if (row == "5"){			
			carno = 'C3';					
		}else if (row == "6"){			
			carno = 'C4';	
		}else if (row == "7"){			
			carno = 'A3';					
		}else if (row == "8"){			
			carno = 'A4';				
		}
		
		sendParam[0] = ds_artificial.NameValue(1, "DRIVE_DT"); 
		sendParam[1] = carno; 
		sendParam[2] = time; 	
	
		//alert(sendParam);
		
		strURL = "../../Security/lc/lc025.jsp";
		strPos = "dialogWidth:400px;dialogHeight:500px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,sendParam,strPos);
		
		ds_default.ClearAll();
		ds_artificial.ClearAll();	
		//fnInit();
		fnSelect();			
		
 </script>


<!-- 그리드 선택일괄 체크 이벤트 -->
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
	
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>해당월</td> 
		<td class="tab24" width="100px;">&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_yyyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM">
							<param name=PromptChar	  		value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>			
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>일자</td> 
		<td class="tab24" >&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_yyyymmdd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  		value="_">					
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
					<param name="IndWidth"		 		value='0'>
					<param name="BorderStyle"  			value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="HeadBorder"	 		value="5">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="20">					
					<param name="Format"	 	 		value=" 
					<C> Name='일자'  	    ID=REG_YMD		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 		align=center mask='XXXX-XX-XX' BgColor={Decode(HOL_YN,'Y','#FAED7D')}</C>
										
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
					<param name="IndWidth"		 		value='0'>
					<param name="BorderStyle"  			value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 			value="true">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="20">
                    <param name="SuppressOption"   		value="1">						
					<param name="Format"	 	 		value=" 
					<C> Name='일자'		  		ID=DRIVE_DT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 		align=center mask ='XXXX-XX-XX' suppress=1</C>
					<C> Name='차량'		  		ID=CAR_NO 	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 		align=center value={Decode(CAR_NO,'A1','코나_0989','A2','코나_0989','A3','코나CS_3260','A4','코나CS_3260','T1','산타페_0796','T2','산타페_0796','C1','카니발1_0623','C2','카니발1_0623','C3','카니발2_0887','C4','카니발2_0887','C5','카니발3_0702','C6','카니발3_0702')} suppress=2</C>
                    <C> Name='8'  	        	ID=TIME8		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME8,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>
					<C> Name='9'      			ID=TIME9		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME9,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>                    
					<C> Name='10'         		ID=TIME10		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME10,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>                    
					<C> Name='11'  	      		ID=TIME11		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center BgColor={Decode(TIME11,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>
                    <C> Name='12'  	        	ID=TIME12		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME12,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>
					<C> Name='13'      			ID=TIME13		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME13,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>                    
					<C> Name='14'         		ID=TIME14		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME14,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>                    
					<C> Name='15'  	      		ID=TIME15		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME15,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>
                    <C> Name='16'  	        	ID=TIME16		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME16,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>
					<C> Name='17'      			ID=TIME17		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME17,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>                    
					<C> Name='18'  	      		ID=TIME18		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME18,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>
                    <C> Name='19'  	        	ID=TIME19		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME19,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>
					<C> Name='20'      			ID=TIME20		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center BgColor={Decode(TIME20,'승인','#1DDB16','예약','#FAED7D','반송','#FFA7A7')} </C>                    
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



