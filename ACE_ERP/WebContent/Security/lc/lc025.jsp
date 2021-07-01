<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 자원>자원예약>차량예약>배차관리
* 프로그램 ID	: lc025.jsp
* 기 능 정 의	: 배차신청관리
* 작  성   자 : 이 동 훈
* 작 성 일 자 : 2017.6.20
-----------------------------------------------------------------------------
*	S1, S2 스타렉스     - 2020.03.24 비활성화
*	A1, A2 코나_0989
*	A3, A4 코나CS_3260  - 2020.03.24 추가됨
*   T1, T2 산타페_0796
*   C1, C2 카니발1_0623
*   C3, C4 카니발2_0887
*   C5, C6 카니발3_0702
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="security.common.*" %>

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

	var strParam = new Array();	//팝업시 받아오는 파라미터들
	var carno;
	var from_tm;
	
	strParam=window.dialogArguments;
	
/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(){
		
			//alert(strParam);

	    	gcem_staxdate.text		= strParam[0];  //날짜
	    	carno 						= strParam[1];  //carno

	    	if(strParam[2] == '8'){
	    		from_tm 		= '08';  	
	    	}else if(strParam[2] == '9'){
	    		from_tm 		= '09';  
	    	}else{    		
	    		from_tm 		= strParam[2];  //from_tm   
	    	}	    	

    		fnSelect();   	  
	    	
	    	txt_empno.value = ds_default.namevalue(1,"ENO_NO");	    	
	    	txt_empnmk.value = ds_default.namevalue(1,"ENO_NM");	     		
	    	gclx_starttime.BindColVal 	= ds_default.namevalue(1,"FROM_TM"); 
	    	gclx_endtime.BindColVal 	= ds_default.namevalue(1,"TO_TM"); 

	    	if(strParam[1] == 'S1'){
	    		txt_car_nm.value 		= '스타렉스_8196';  
	    	}else if(strParam[1] == 'S2'){
	    		txt_car_nm.value 		= '스타렉스_8196';  
	    	}else if(strParam[1] == 'A1'){
	    		txt_car_nm.value 		= '코나_0989';  
	    	}else if(strParam[1] == 'A2'){
	    		txt_car_nm.value 		= '코나_0989';  
	    	}else if(strParam[1] == 'T1'){
	    		txt_car_nm.value 		= '산타페_0796';  
	    	}else if(strParam[1] == 'T2'){
	    		txt_car_nm.value 		= '산타페_0796';  	    		
	    	}else if(strParam[1] == 'C1'){
	    		txt_car_nm.value 		= '카니발1_0623';  	    		
	    	}else if(strParam[1] == 'C2'){    		
	    		txt_car_nm.value 		= '카니발1_0623';  
	    	}else if(strParam[1] == 'C5'){
	    		txt_car_nm.value 		= '카니발3_0702';  	    		
	    	}else if(strParam[1] == 'C6'){    		
	    		txt_car_nm.value 		= '카니발3_0702';  	    		
	    	}else if(strParam[1] == 'C3'){
	    		txt_car_nm.value 		= '카니발2_0887';  	    		
	    	}else if(strParam[1] == 'C4'){    		
	    		txt_car_nm.value 		= '카니발2_0887';  
	    	}else if(strParam[1] == 'A3'){
	    		txt_car_nm.value 		= '코나CS_3260';  	    		
	    	}else if(strParam[1] == 'A4'){    		
	    		txt_car_nm.value 		= '코나CS_3260';  	    		
	    	}
   	
	    	txt_sayu.value = ds_default.namevalue(1,"SAYU");	
	    	txt_driver_no.value = ds_default.namevalue(1,"DRIVER");
	    	txt_driver_nm.value = ds_default.namevalue(1,"DRIVER_NM");	  	    	
	    	txt_destination.value = ds_default.namevalue(1,"DESTINATION");	   
	    	gclx_fellow.BindColVal 	= ds_default.namevalue(1,"FELLOW"); 
	    	gclx_cargo.BindColVal 	= ds_default.namevalue(1,"CARGO"); 	    	
	    	txt_phone_no.value = ds_default.namevalue(1,"EM_PHN_NO");
	    	txt_remark.value = ds_default.namevalue(1,"REMARK");	 
	    	txt_insert_ymd.value = ds_default.namevalue(1,"INSERT_YMD");
			gclx_status.BindColVal 	= ds_default.namevalue(1,"STATUS");	     		
    		
}

/******************************************************************************
	Description : 초기화 
****************************************************************************/
function fnInit(){
		

		

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function fnSelect() {

		 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	 
																				     + ",v_staxdate="+gcem_staxdate.text
																				     + ",v_carno=" +carno
																				     + ",v_from_tm=" + from_tm;	 	 
		 //prompt(this, param);
	 
	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc025",  "JSP(O:DS_DEFAULT=ds_default)",  param);
	
	    tr_post(tr1);

}

/******************************************************************************
Description : 조회
******************************************************************************/
function fnSelect2() {

		 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	 
																				     + ",v_gusrid=" +gusrid;	 	
	
		 ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc021",  "JSP(O:DS_DEFAULT=ds_default)",  param);
		
		 tr_post(tr1);

}



/******************************************************************************
Description : 저장
******************************************************************************/
function ln_Save() {

			
			if (ds_default2.CountColumn == 0) {
				ds_default2.setDataHeader("DRIVE_DT:STRING, CAR_NO:STRING, FROM_TM:STRING, TO_TM:STRING, REMARK:STRING, STATUS:STRING");
			}
			
			// 행 추가
			ds_default2.AddRow();	

			ds_default2.namevalue(1,"CAR_NO") = strParam[1];	 			
			ds_default2.namevalue(1,"DRIVE_DT") = gcem_staxdate.text;
			ds_default2.namevalue(1,"FROM_TM") = gclx_starttime.BindColVal;	 			
			ds_default2.namevalue(1,"TO_TM")  = gclx_endtime.BindColVal;
			ds_default2.namevalue(1,"REMARK") = txt_remark.value;				
			ds_default2.namevalue(1,"STATUS") = gclx_status.BindColVal;	  	
			 
			
		     ln_TRSetting(tr2, "<%=dirPath%><%=HDConstant.PATH_LI%>Lc025",  "JSP(I:DS_DEFAULT2=ds_default2)",  "proType=A, dsType=1");
		     
		     //prompt(this, ds_default2.text);
		     
		     tr_post(tr2);	 
		     

}


/******************************************************************************
Description : 삭제
******************************************************************************/
function ln_Delete() {

			if(confirm("삭제하시겠습니까?")){				
			
					if (ds_default2.CountColumn == 0) {
						ds_default2.setDataHeader("DRIVE_DT:STRING, CAR_NO:STRING, FROM_TM:STRING, TO_TM:STRING, STATUS:STRING");
					}
					
					// 행 추가
					ds_default2.AddRow();	

					ds_default2.namevalue(1,"CAR_NO") = strParam[1];	 			
					ds_default2.namevalue(1,"DRIVE_DT") = gcem_staxdate.text;
					ds_default2.namevalue(1,"FROM_TM") = gclx_starttime.BindColVal;	 			
					ds_default2.namevalue(1,"TO_TM")  = gclx_endtime.BindColVal;	   	
					ds_default2.namevalue(1,"STATUS") = gclx_status.BindColVal;	 
					
					ds_default2.UserStatus(1) = 2;	
					
				    ln_TRSetting(tr3, "<%=dirPath%><%=HDConstant.PATH_LI%>Lc025",  "JSP(I:DS_DEFAULT2=ds_default2)",  "proType=A, dsType=1");
				     
				    //prompt(this, ds_default2.text);
				     
				    tr_post(tr3);	 
				     
			}

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

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_default3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
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

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>

<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
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
  

</script>

<script language=JavaScript for=gcem_staxdate event=onKeyDown(kcode,scode)>


</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>


 </script>

<!--  -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=tr2  event=OnSuccess()>

	alert("정상적으로 저장되었습니다.");
	
	if (gclx_status.BindColVal == 'Y' || gclx_status.BindColVal == 'N') {

		if(confirm("SMS를 보내시겠습니까?")){		
		
			var date;
			var phone;
			
			if (ds_default3.CountColumn == 0) {
				ds_default3.setDataHeader("DRIVE_DT:STRING, CAR_NO:STRING, FROM_TM:STRING, TO_TM:STRING, EM_PHN_NO:STRING");
			}
			
			// 행 추가
			ds_default3.AddRow();	

			date = gcem_staxdate.text;
			date = date.substring(0,4) + "년" + date.substring(4,6) + "월" + date.substring(6,8) + "일";

			phone = txt_phone_no.value;
			phone = phone.replace("-","").replace("-", ""); 


			 // 기본정보
	         var param = "proType=A"
				 				+ ",v_car="+txt_car_nm.value
				 				+ ",v_drivedt="+date
				 				+ ",v_from_tm="+gclx_starttime.BindColVal   
								+ ",v_to_tm ="+gclx_endtime.BindColVal
				 				+ ",v_status="+gclx_status.BindColVal  	
								+ ",v_phone="+phone;   			 
			
		     ln_TRSetting(tr2, "<%=dirPath%><%=HDConstant.PATH_LI%>Lc025",  "JSP(I:DS_DEFAULT3=ds_default3)",  param);
		     
		     //prompt(this, param);
		     
		     tr_post(tr2);	 			
			
		}
		
	}		
	
	window.close();
	
</script>

<script language=JavaScript for=tr3  event=OnSuccess()>

	alert("정상적으로 삭제되었습니다.");

	window.close();
	
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<body onLoad="fnOnLoad();">


<br>

<table border="0" cellpadding="0" cellspacing="0" width=100%>
	<tr>
		<td class="r">
				  
				<img src="../../Common/img/btn/com_b_delete.gif"		style="cursor:hand" onclick="ln_Delete()"> &nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			
				
				<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()"> &nbsp;
			
		</td>
	</tr>
</table>

<br>

<table>
	<tr> 
		<td>
			<table border="0" cellpadding="0" cellspacing="0" >
			  <tr>
				<td height="25px" width="120px" style="border:1 solid #708090;border-width:1 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;신청자</td>			  
				<td width="300px" style="border:1 solid #708090;border-left-width:0px">
					<input type="text" class="txt11" id="txt_empno"  style="width:60px;background-color:#d7d7d7" readOnly> &nbsp;
				    <input type="text" class="txt11" id="txt_empnmk" maxlength=8 style="width:90px;" style="width:60px;background-color:#d7d7d7" readOnly> 
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;신청일자</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="m l">&nbsp;&nbsp;
					<object  id=gcem_staxdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;top:2px;">		
						<param name=Text						value="">
						<param name=Alignment     			value=0>
						<param name=Border          			value=true>
						<param name=Numeric       			value=false>
						<param name=Format          			value="####-##-##">
						<param name=PromptChar  				value="">
						<param name=BackColor     			value="#CCCCCC">  
						<param name=InheritColor   			value=false>
						<param name=readOnly       			value=true>
						<param name=ReadOnlyBackColor   	value="#d7d7d7">
				   </object>&nbsp;			
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;신청시간</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_starttime classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;top:2px;font-size:12px;width:80px;">
						<param name=CBData			         		value="08^08,09^09,10^10,11^11,12^12,13^13,14^14,15^15,16^16,17^17,18^18,19^19,20^20">
						<param name=CBDataColumns	    		value="CODE,NAME">
						<param name=SearchColumn	    	 	value=NAME>
						<param name=Sort			     			value=false>
						<param name=ListExprFormat       		value="NAME">								
						<param name=BindColumn		     		value="CODE">
						<param name=Enable              			value="false">	
					</object>&nbsp;부터&nbsp;&nbsp;&nbsp;&nbsp; 

					<object id=gclx_endtime classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;top:2px;font-size:12px;width:80px;">
						<param name=CBData			         		value="08^08,09^09,10^10,11^11,12^12,13^13,14^14,15^15,16^16,17^17,18^18,19^19,20^20,21^21">
						<param name=CBDataColumns	    		value="CODE,NAME">
						<param name=SearchColumn	    	 	value=NAME>
						<param name=Sort			     			value=false>
						<param name=ListExprFormat       		value="NAME">								
						<param name=BindColumn		     		value="CODE">
						<param name=Enable              			value="false">						
					</object>&nbsp;까지		

		 		</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;신청차량</td>               
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_car_nm" class="txtbox" type="text" style= "position:relative;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;배차사유</td>
		  		<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_sayu"    type="text"   class="txtbox"  style= "position:relative;width:280px;height:20px;background-color:#d7d7d7" readOnly="true";>
				</td>
			  </tr>				  
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;목적지</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_destination"    type="text"   class="txtbox"  style= "position:relative;width:280px;height:20px;background-color:#d7d7d7" readOnly="true";>
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;운전자</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_driver_no"    type="text"   class="txtbox"  style= "position:relative;width:100px;height:20px;background-color:#d7d7d7" readOnly="true";>		
					<input id="txt_driver_nm"    type="text"   class="txtbox"  style= "position:relative;width:100px;height:20px;background-color:#d7d7d7" readOnly="true";>									
					<img src="../common/img/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" style="cursor:hand;">
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;동승자</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_fellow classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;top:2px;font-size:12px;width:100px;">
						<param name=CBData			         		value="0^0,1^1,2^2,3^3,4^4,5^5,6^6,7^7,8^8">
						<param name=CBDataColumns	    		value="CODE,NAME">
						<param name=SearchColumn	    	 	value=NAME>
						<param name=Sort			     			value=false>
						<param name="Index" 						value="0">						
						<param name=ListExprFormat       		value="NAME">								
						<param name=BindColumn		     		value="CODE">
						<param name=Enable              			value="false">						
					</object>
		 		</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;화물여부</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_cargo classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;top:2px;font-size:12px;width:100px;">
						<param name=CBData			         		value="N^없음,Y^있음">
						<param name=CBDataColumns	    		value="CODE,NAME">
						<param name=SearchColumn	    	 	value=NAME>
						<param name=Sort			     			value=false>
						<param name="Index" 						value="0">							
						<param name=ListExprFormat       		value="NAME">								
						<param name=BindColumn		     		value="CODE">
						<param name=Enable              			value="false">						
					</object>
		 		</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;<font color="#ff0000">*</font>&nbsp;핸드폰</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_phone_no"    type="text"   class="txtbox"  style= "position:relative;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
				</td>
			  </tr>
			  
			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비고</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
                    <textarea id="txt_remark"  name="txt_remark" cols="43" rows="5" maxlength="300" ></textarea>				
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;입력일자</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;
					<input id="txt_insert_ymd"    type="text"   class="txtbox"  style= "position:relative;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
				</td>
			  </tr>

			  <tr>
				<td height="25px" style="border:1 solid #708090;border-width:0 1 1 1;" class="text l" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;상태</td>
				<td style="border:1 solid #708090;border-width:0 1 1 0;" class="l">&nbsp;&nbsp;
					<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;top:2px;font-size:12px;width:100px;">
						<param name=CBData			    	value="S^대기,Y^승인,N^반송">
						<param name=CBDataColumns		value="CODE,NAME">
						<param name=SearchColumn	    value=NAME>
						<param name=Sort			    	value=false>
						<param name=ListExprFormat      	value="NAME">								
						<param name=BindColumn		    value="CODE">
						<param name=Enable              	value="true">
					</object> 
				</td>
			  </tr>
			</table>
			</td>
		  </tr>
        </table>

		</td>
	</tr>
 </table>


</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_DEFAULT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   		Value="ds_default">
	<Param Name="BindInfo", 		Value='
	
		<C>Col=ENO_NO				Ctrl=txt_empno   					Param=text			</C>		
		<C>Col=ENO_NM				Ctrl=txt_empnmk   					Param=value			</C>	
		<C>Col=FROM_TM				Ctrl=gclx_starttime	   				Param=BindColVal	</C>
		<C>Col=TO_TM   		 		Ctrl=gclx_endtime	 				Param=BindColVal	</C>			
		<C>Col=SAYU				    Ctrl=txt_sayu	   					Param=value			</C>
		<C>Col=DRIVER				Ctrl=txt_driver_no	   				Param=value			</C>					
		<C>Col=DESTINATION			Ctrl=txt_destination	   			Param=value			</C>
		<C>Col=FELLOW				Ctrl=gclx_fellow	   				Param=BindColVal	</C>
		<C>Col=CARGO   		 		Ctrl=gclx_cargo	 					Param=BindColVal	</C>
		<C>Col=EM_PHN_NO			Ctrl=txt_phone_no	   				Param=value			</C>
		<C>Col=REMARK				Ctrl=txt_remark	   					Param=value			</C>
		<C>Col=INSERT_YMD			Ctrl=txt_insert_ymd	   				Param=text			</C>
		
		
    '>
</object>

