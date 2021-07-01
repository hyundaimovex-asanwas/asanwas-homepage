<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 자원>자원예약>차량운행관리>차량운행입력
* 프로그램 ID	: ld020.jsp
* 기 능 정 의	: 차량운행입력
* 작  성   자 : 이 동 훈
* 작 성 일 자 : 2017.8.30
-----------------------------------------------------------------------------
* 수 정 내 용 : 
* 수   정  자 :
* 수 정 일 자 : 
-----------------------------------------------------------------------------
* 서 블 릿 명	: 
* PROCEDURE 	: 
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
<title>차량운행입력</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">


/*----------------------------------------------------------------------------
 * 페이지로딩
----------------------------------------------------------------------------*/

		function fnOnLoad(tree_idx){
			
			fnInit_tree(tree_idx);	//트리초기화 호출
			
			gcem_curdt.Text = gcurdate.substring(0,7);
			
			v_empno.value = gusrid;
			v_empnmk.value = gusrnm;
			
			cfStyleGrid(getObjectFirst("gcgd_disp1"), "comn");  //grid 헤드색 
			cfStyleGrid(getObjectFirst("gcgd_disp2"), "comn");  //grid 헤드색 
			
		    fnInit();

			//fnSelect();
		    
		}



/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function fnSelect(){

			//gcds_car.ClearData();
			
			gcds_data01.ClearData();

	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
	         


		     tr_post(tr1);
		     
}

/*----------------------------------------------------------------------------
	Description : 조회 - Detail
----------------------------------------------------------------------------*/
function ln_Query2(){

			var v_car_sid =  gcds_car.namevalue(gcds_car.rowposition,"CAR_SID");
			
			//alert(v_car_sid);
		
		    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
											            + ",v_car_sid =" + v_car_sid;  // 
		    

		
		    tr_post(tr1);

}

/*----------------------------------------------------------------------------
	Description : 선조회 조건
----------------------------------------------------------------------------*/
function fnInit(){


		gcem_str_dt.Text = gcurdate.substring(0,7)+"01";	

		gcem_end_dt.Text = gcurdate;

	  	//차량
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        
    	ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Ld020",  "JSP(O:gcds_car=gcds_car)",  param);

	    tr_post(tr1);	  	        
        
		ln_SetDataHeader();	    
}



/*----------------------------------------------------------------------------
	Description : 저장 ( 기존데이타 수정)
----------------------------------------------------------------------------*/

function fnSave(){  

	if(!fnSave_Chk()) return;

	if (gcds_data01.IsUpdated) {		

			if(confirm("정보를 저장하시겠습니까?")){			


				
			
			}			
	
	}	

}

/*---------------------------------------------------------------------------
	Description : 저장시 체크  
---------------------------------------------------------------------------*/

function fnSave_Chk(){

	return true;	

}



/*----------------------------------------------------------------------------
	Description : 
----------------------------------------------------------------------------*/

function ln_Settle(){

		gcds_data01.ClearData();		

		//if(!ln_Settle_Chk()) return;

		var str_dt = gcem_str_dt.text;
		var end_dt =  gcem_end_dt.text;
		var str_km = gcem_str_km.text;
		var end_km =  gcem_end_km.text;
		
		var before = 0;
		var after = 0;
		
	  	var distance = end_km - str_km;
	  	
		//요일
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
											            + ",v_fr_inout_dt =" + str_dt
											            + ",v_to_inout_dt =" + end_dt;  //      
					            

					            
	    tr_post(tr1);	  	

		var date = ln_Day_Chk(str_dt,end_dt);
		var date2 = date;

		for(i=1;i<=date;i++){
			if(chkbox_sat.checked && gcds_date.namevalue(i,"YOIL") == 7){
				date2 = date2 -1;				
			}else if(chkbox_sun.checked && gcds_date.namevalue(i,"YOIL") == 1){
				date2 = date2 -1;
			}
		}

		
		for(i=1;i<=date;i++){	

				var dateOfWeek1 = gcds_date.namevalue(i,"YYMMDD");
				var Yoil = gcds_date.namevalue(i,"YOIL"); 

				gcds_data01.addrow();

				//출근일자
				gcds_data01.namevalue(gcds_data01.rowposition,"DRIVE_DT") = gcds_date.namevalue(i,"YYMMDD"); 
				gcds_data01.namevalue(gcds_data01.rowposition,"YOIL") = gcds_date.namevalue(i,"YOIL");

				if(chkbox_sat.checked && Yoil == 7){				

					//before = Math.floor(str_km) + Math.floor((distance/date2));
					//after = Math.floor(before) + Math.floor((distance/date2));					
					
					gcds_data01.namevalue(gcds_data01.rowposition,"ENO_NM") = v_empnmk.value;

					gcds_data01.namevalue(gcds_data01.rowposition,"DRIVE_BEFORE") = before;
					gcds_data01.namevalue(gcds_data01.rowposition,"DRIVE_AFTER") = after;	
					gcds_data01.namevalue(gcds_data01.rowposition,"MILEAGE") = 0;					
	
					gcds_data01.namevalue(gcds_data01.rowposition,"FOR_CMMT") = 0;					
					gcds_data01.namevalue(gcds_data01.rowposition,"FOR_BIZ") = 0;	
					
					str_km = before;					
					
				}else if(chkbox_sun.checked && Yoil == 1){					

					gcds_data01.namevalue(gcds_data01.rowposition,"ENO_NM") = v_empnmk.value;

					gcds_data01.namevalue(gcds_data01.rowposition,"DRIVE_BEFORE") = before;
					gcds_data01.namevalue(gcds_data01.rowposition,"DRIVE_AFTER") = after;	
					gcds_data01.namevalue(gcds_data01.rowposition,"MILEAGE") = 0;					
	
					gcds_data01.namevalue(gcds_data01.rowposition,"FOR_CMMT") = 0;					
					gcds_data01.namevalue(gcds_data01.rowposition,"FOR_BIZ") = 0;	
					
					str_km = before;		
					
				}else{
				
					before = Math.floor(str_km) + Math.floor((distance/date2));
					after = Math.floor(before) + Math.floor((distance/date2));					
					
					gcds_data01.namevalue(gcds_data01.rowposition,"ENO_NM") = v_empnmk.value;

					gcds_data01.namevalue(gcds_data01.rowposition,"DRIVE_BEFORE") = before;
					gcds_data01.namevalue(gcds_data01.rowposition,"DRIVE_AFTER") = after;	
					gcds_data01.namevalue(gcds_data01.rowposition,"MILEAGE") = distance/date2;					
	
					gcds_data01.namevalue(gcds_data01.rowposition,"FOR_CMMT") = 0;					
					gcds_data01.namevalue(gcds_data01.rowposition,"FOR_BIZ") = distance/date2;	
					
					str_km = before;

			}
			
		}
		
}

/******************************************************************************
Description :  사용함.
******************************************************************************/

function ln_SetDataHeader(){

if (gcds_data01.countrow<1){

			var s_temp = "DRIVE_DT:STRING(10),"	
								 + "YOIL:STRING(1),"					

								 + "ENO_NM:STRING(10),"
								 + "DRIVE_BEFORE:INT(10),"
								 + "DRIVE_AFTER:INT(10),"
								 + "MILEAGE:INT(10),"								 
								 + "FOR_CMMT:INT(10),"	
								 + "FOR_BIZ:INT(10),"	
								 
								 + "I_EMPNO:STRING(10),"										 					 
								 + "I_DATE:STRING(50),"
								 + "U_EMPNO:STRING(10),"
								 + "U_DATE:STRING(50)";				
							 					
			gcds_data01.SetDataHeader(s_temp);		
}	
}


/*----------------------------------------------------------------------------
	Description : 근태입력전 체크 
----------------------------------------------------------------------------*/

function ln_Settle_Chk(){

			var chk = 0;
		
			for(i=1;i<=gcds_data.countrow;i++){		
				
				chk = 1;
				
					if(gcem_str_dt.text== "" || gcem_end_dt.text== "" ){		
						
					alert("날짜를 입력하세요");
					
					}
					
			}
			
			if(chk==0){
				
				alert("대상자를 선택하십시요.");
				
				return false;	
				
			}
			
			return true;	
}


/******************************************************************************
	Description : 날짜 사이 조회
	Parameter   : frdt - 출발일, todt - 복귀일
******************************************************************************/

function ln_Day_Chk(frdt,todt) { 

			var fryy =frdt.substring(0,4);
			var frmm =frdt.substring(4,6);
			var frdd =frdt.substring(6,8);
			var toyy =todt.substring(0,4);
			var tomm =todt.substring(4,6);
			var todd =todt.substring(6,8);
		
			frdate=new Date(fryy,frmm-1,frdd); //월에서는 1을 뺀다 
			todate=new Date(toyy,tomm-1,todd); //오늘날짜 
		
			frtime=frdate.getTime(); //출발시각 
			totime=todate.getTime(); //복구시각
			cha=totime-frtime;       //시각차이 
			conv=Math.floor(cha/(60*60*24*1000))+1; //시각차이를 일자차이로 계산 
			
			return conv;
				
}

/******************************************************************************
Description : 날짜 사이 조회
Parameter   : frdt - 출발일, todt - 복귀일
******************************************************************************/

function ln_Day_Chk2(frdt,todt) { 

			var fryy =frdt.substring(0,4);
			var frmm =frdt.substring(4,6);
			var frdd =frdt.substring(6,8);
			var toyy =todt.substring(0,4);
			var tomm =todt.substring(4,6);
			var todd =todt.substring(6,8);
			
			frdate=new Date(fryy,frmm-1,frdd); //월에서는 1을 뺀다 
			todate=new Date(toyy,tomm-1,todd); //오늘날짜 
			
			frtime=frdate.getTime(); //출발시각 
			totime=todate.getTime(); //복구시각
			cha=totime-frtime;       //시각차이 
			conv=Math.floor(cha/(60*60*24*1000))+1; //시각차이를 일자차이로 계산 
			
			return conv;
	
}


</script>


<%
/*=============================================================================
				Developer Java Script 끝
=============================================================================*/
%>
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/
%>

<script language="javascript"  for=gcgd_disp1 event=OnClick(Row,Colid)>
	ln_Query2();
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공-TR1
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
		ln_Query();
	</script>	

<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  작업실패-TR1
%>

	<script language="javascript" for="gctr_data" event="onfail()">
		alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
	</script>



	<script language="javascript" for="gcds_car" event="onloadCompleted(row,colid)">
	
		window.status="조회가 완료 되었습니다.";
		document.all.LowerFrame.style.visibility="hidden";
		ft_cnt1.innerText = "조회건수 : " + row + " 건";
		
		if (row <1) {
		alert("검색된 데이터가 없습니다.");
		}

		 
	</script>

	<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">

		document.all.LowerFrame.style.visibility="hidden";
		ft_cnt2.innerText = "조회건수 : " + row + " 건";

	</script>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>

<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>

<OBJECT id=gcds_car classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_date classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%>
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
		<param name="KeyName"  	 value="toinb_dataid4">
		<param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
<%=HDConstant.COMMENT_END%>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0" style="position:relative;left:3px">
	<tr>
		<td height="30" class="paddingTop5" align="right" valign="top">
			<img src="../../Common/img/btn/com_b_save.gif"		name="Image1"	style="cursor:hand" onclick="fnSave()"> &nbsp;
			<img src="../../Common/img/btn/com_b_query.gif"		name="Image1"	style="cursor:hand" onclick="fnSelect()">
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 --> 


<!-- body table -->
<table cellpadding="0" cellspacing="0" width=1030 height=40 bordercolor=black border="0">
<!-- 테이블 시작 -->
		<tr>
			<td valign="top" colspan="2">
				<table cellpadding=0 cellspacing=1 style="width:1020px;" bgcolor="#708090">
					<tr height="25">  

						<td bgcolor="#eeeeee" width="120" align = center>기준월</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
							<object id="gcem_curdt" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:0px; width:50px; height:20px; font-family:dotum; font-size:9pt; ">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=True>
							<param name=Format			value="YYYY/MM">
							<param name=MaxLength		value=6>
							<param name=PromptChar		value="_">
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td> 

						<td bgcolor="#eeeeee" width="60" align = center>담당자</td>
                        <td bgcolor='#ffffff' >&nbsp;
			                <input type="text"  name='v_empno'   id='v_empno'  style="width:70px;" class='input01'  >
							<input type="text"  name='v_empnmk' id="v_empnmk" style="width:70px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelEmpPopup('<%=dirPath%>');" >
						</td>
					</tr>
				</table>
			</td>
		</tr>
</table>



<!-- body table -->
<table cellpadding="0" cellspacing="0" width=1030 height=550 bordercolor=black border="0">
		<tr> 
			<td style="width:250" align=left valign=top rowspan="2">
				<%=HDConstant.COMMENT_START%>		
				<OBJECT classid=<%=HDConstant.CT_GRID_CLSID%> id=gcgd_disp1  style="WIDTH: 250px; HEIGHT:560px;border:1 solid #777777;display:block;border-left-width:1px;" viewastext>
				<PARAM NAME="DataID"				VALUE="gcds_car">
				<PARAM NAME="BorderStyle"			VALUE="0">
				<PARAM NAME="Indwidth"				VALUE="0">
				<PARAM NAME="Fillarea"				VALUE="true">
				<PARAM NAME="Editable"				VALUE="false">
				<PARAM NAME="Colsizing"				VALUE="true">
				<PARAM NAME="viewsummary"		VALUE=1>
				<PARAM NAME="TitleHeight"			VALUE=20>
				<param name="sortview"					value=left>
				<PARAM NAME="Format"          		VALUE="  
					<FC>ID={CurRow}			Name=NO				Width=30,  				 	align=center  		editable=false </FC> 
					<FC>ID=CAR_NO,			Name=등록번호,		width=100px,				align=center,		edit=none  sort=true </FC>	
					<FC>ID=CAR_NM,		    Name=차종,	 			width=100px,				align=left,			edit=none  sort=true </FC>
					">
					</OBJECT>
					<%=HDConstant.COMMENT_END%>
					<fieldset id=ft_div1 style="width:252px;height:20px;background-color:#FFFFFF;border:0 solid #708090;border-top-width:0px;text-align:LEFT;">
						<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
					</fieldset>
			</td>



			<td><!-- 테이블 시작 -->
				<table cellpadding=0 cellspacing=1 style="width:780px;" bgcolor="#708090" border =0>
					<tr height="20">
					  <td bgcolor="#eeeeee" width="50" align="center">일자</td>
					  <td bgcolor="#FFFFFF" width="170">
							  <%=HDConstant.COMMENT_START%>
				              <OBJECT id=gcem_str_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
				              <param name=Alignment			value=0>
				              <param name=Border	      		value=true>
				              <param name=Format	      		value="YYYY/MM/DD">
				              <param name=PromptChar	  	value="_">
				              </OBJECT>
							  <%=HDConstant.COMMENT_END%>
							  &nbsp;&nbsp;~
							  <%=HDConstant.COMMENT_START%>
				              <OBJECT id=gcem_end_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;" >
				              <param name=Alignment			value=0>
				              <param name=Border	      		value=true>
				              <param name=Format	      		value="YYYY/MM/DD">
				              <param name=PromptChar	  	value="_">
				              </OBJECT>
							  <%=HDConstant.COMMENT_END%>
						</td>    
					  	<td bgcolor="#eeeeee" width="60" align="center">주행전거리</td>
					  	<td bgcolor="#FFFFFF" width="60">
							  <%=HDConstant.COMMENT_START%>
				              <OBJECT id=gcem_str_km classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
				              <param name=Alignment			value=0>
							  <param name=Numeric			value=true>				              
				              <param name=Border	      		value=true>
				              </OBJECT>
							  <%=HDConstant.COMMENT_END%>
						</td>
					  	<td bgcolor="#eeeeee" width="60" align="center">주행후거리</td>
					  	<td bgcolor="#FFFFFF" width="60">
							  <%=HDConstant.COMMENT_START%>
				              <OBJECT id=gcem_end_km classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:8px;top:0px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
				              <param name=Alignment			value=0>
							  <param name=Numeric			value=true>				              
				              <param name=Border	      		value=true>
				              </OBJECT>
							  <%=HDConstant.COMMENT_END%>
						</td> 
						   						    
					  	<td bgcolor="#eeeeee" width="40" align="center">제외</td>
					  	<td bgcolor="#FFFFFF" width="60">
                  			<input type=checkbox  id=chkbox_sat style="width:15px;position:relative;left:0px;top:-3px;color=#CCFFCC" value="0"><font color=blue>토</font>
                  			<input type=checkbox  id=chkbox_sun style="width:15px;position:relative;left:0px;top:-3px;color=#CCFFCC" value="0"><font color=red>일</font>	
						</td> 
											  	
					  	<td bgcolor="#FFFFFF" width="70">						
						<img src="../../Common/img/btn/BatchCreateOver.gif"	style="cursor:hand" onclick="ln_Settle()">
						</td>   
					</tr>		
				</table>
			</td>
		</tr>


		<tr>
			<td valign="top"><br>
				<table cellpadding=0 cellspacing=0 style="width:800px;height:550px;position:relative;top:-10px;" >
					<tr>
						<td align="left" >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=<%=HDConstant.CT_GRID_CLSID%> id=gcgd_disp2 style="width:780;height:530px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"				VALUE="gcds_data01">
							<PARAM NAME="BorderStyle" 			VALUE="0">
							<PARAM NAME="Indwidth"				VALUE="0">
							<PARAM NAME="Fillarea"				VALUE="true">
							<PARAM NAME="Colsizing"				VALUE="true">
							<PARAM NAME="editable"				VALUE="true">
							<PARAM NAME="TitleHeight"			VALUE=20>
							<param name="sortview"    			value=left>
							<param name="ViewSummary"  		value="1">
  							<PARAM NAME="Format"				VALUE="  
									<C> Name='No'						ID={CURROW}			Width=30	align=center	SumText=''		SumBgColor='#C3D0DB'</C>                      
		                            <C> name='사용일자'     				ID='DRIVE_DT'         	Width=75   Edit=none 	align=center Mask='XXXX-XX-XX' sort = true</C>
		                            <C> name='요일'     					ID='YOIL'         		Width=35    Edit=none 	align=center value={IF (YOIL='1','일',IF (YOIL='2','월', IF (YOIL='3','화', IF (YOIL='4','수', IF (YOIL='5','목', IF (YOIL='6','금', IF (YOIL='7','토', '' )))))))} color={IF (YOIL='1','red',IF (YOIL='7','blue','black'))}</C>		                            
		                            <G> name=사용자 
			                            <C> name='부서'             		ID='DPT_NM'         	Width=80   align=Left</C>
			                            <C> name='직책'        			ID=' '        				Width=80   align=center</C>      
			                            <C> name='성명'        			ID='ENO_NM'         	Width=60   align=center</C>  
		                            </G>
		                            <G> name=운행내역	 	                            
			                            <C> name='주행전거리'     		ID='DRIVE_BEFORE'       Width=80   align=right</C>
			                            <C> name='주행후거리'           ID='DRIVE_AFTER'        Width=80   align=right</C>
			                            <C> name='주행거리'             ID='MILEAGE'         		Width=80   align=right</C>
			                            <C> name='출퇴근용'        		ID='FOR_CMMT'        	Width=80   align=right</C>      
			                            <C> name='일반업무용'        	ID='FOR_BIZ'         		Width=80   align=right</C> 
		                            </G>	
							">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
								<fieldset id=ft_div2 style="width:782;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:1px;border-bottom-width:1px;border-right-width:1px;text-align:left;">
									&nbsp;
								<font id=ft_cnt2 style="position:relative;top:4px;"></font>
								</fieldset>

						</td>
					</tr>
				</table>
			</td> 
		</tr>


<!-- 기본탭 -->
	<%=HDConstant.COMMENT_START%>
	<OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 >
		<PARAM NAME="DataID"				VALUE="gcds_data00">
		<PARAM NAME="ActiveBind"			VALUE="true">
		<PARAM NAME="BindInfo"				VALUE="
			<C>Col=YOIL       		 				Ctrl=empno      			   					Param=Value</C>
			<C>Col=ENO_NM       				Ctrl=empnmk       								Param=Value</C>
			<C>Col=DEPT_CD   			 		Ctrl=txt_dept_cd     					  		Param=Value</C>
			<C>Col=T_PAY 							Ctrl=gcem_t_pay 								Param=Text</C>		
		">
	</OBJECT>
	<%=HDConstant.COMMENT_END%>
	</table>

<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


