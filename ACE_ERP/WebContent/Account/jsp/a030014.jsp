
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  원가관리 - 월별 비용명세서
+ 프로그램 ID	:  A030014.html
+ 기 능 정 의	:  
+ 작   성  자 :  YS.JEONG
+ 수 정 일 자 :  2006.09.19
-----------------------------------------------------------------------------
+ 수 정 내 용  :	 개선사항 수정 및 출력물 작성  
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2006.10
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>월별판관비명세서</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
//get_cookdata();
var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7); //년월
var gs_date3 = gcurdate.substring(0,4); //년
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var g_date,g_time;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
	gclx_fdcode.bindcolval = gs_fdcode;
	
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){

	gcds_data01.clearall();
	gcds_temp01.clearall();

	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030014_s1?v_str1="+gclx_fdcode.bindcolval
		   +"&v_str2="+gcem_datefr.text;
		 //  +"&v_str3="+//gcem_atcode_fr01.text
		 //  +"&v_str4="+;//gcem_atcode_to01.text;
																								  																										
	//prompt("",gcds_data01.DataID );																							
	gcds_data01.Reset();									
	
}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
 
  //alert("개발중");
	//return;

	var time = new Date();

	gcds_temp01.clearall();
	ln_PrintHeader();
	gcds_temp01.addrow();
	
	if(time.getMonth()+1<10)
		g_date = time.getFullYear()+"/0"+(time.getMonth()+1)+"/"+time.getDate();
	else
		g_date = time.getFullYear()+"/"+(time.getMonth()+1)+"/"+time.getDate();
	if(time.getHours()<10) {
		if(time.getMinutes()<10)
			g_time = "0"+time.getHours()+":0"+time.getMinutes()+" AM";
		else
			g_time = "0"+time.getHours()+":"+time.getMinutes()+" AM";
	} else if(time.getHours()>=10&&time.getHours()<12) {
		if(time.getMinutes()<10)
			g_time = ""+time.getHours()+":0"+time.getMinutes()+" AM";
		else
			g_time = ""+time.getHours()+":"+time.getMinutes()+" AM";
	} else if(time.getHours()==12) {
		if(time.getMinutes()<10)
			g_time = "12:0"+time.getMinutes()+" PM";
		else
			g_time = "12:"+time.getMinutes()+" PM";
	} else if(time.getHours()>12&&time.getHours()<22) {
		if(time.getMinutes()<10)
			g_time = "0"+(time.getHours()-12)+":0"+time.getMinutes()+" PM";
		else
			g_time = "0"+(time.getHours()-12)+":"+time.getMinutes()+" PM";
	} else {
		if(time.getMinutes()<10)
			g_time = ""+(time.getHours()-12)+":0"+time.getMinutes()+" PM";
		else
			g_time = ""+(time.getHours()-12)+":"+time.getMinutes()+" PM";
	}

	if(gcds_data01.countrow<1)
			alert("출력할 정보가 없습니다.");
	else {
		var fdcodenm;
		if(gclx_fdcode.BindColVal=="")
			fdcodenm = "현대아산주식회사";
		else
			fdcodenm = gclx_fdcode.text;
		gcds_temp01.namevalue(1,"TITLE") = "월별 " + fdcodenm + " 판관비명세서";
//		gcds_temp01.namevalue(1,"FDCODENM") = "사업장명 : " + fdcodenm + "  " +txt_costnm_fr.value;

		gcds_temp01.namevalue(1,"CURDT") = "출력일자 : " + g_date;
		gcds_temp01.namevalue(1,"CURTM") = "출력시간 : " + g_time;
		gcds_temp01.namevalue(1,"KISU1") = "( "+gcem_datefr.text+"년도 )";//기수
		gcrp_print1.preview();
	}

}

/******************************************************************************
	Description : 출력 - Header Set
******************************************************************************/
function ln_PrintHeader() {
		if(gcds_temp01.countrow<1){
	   var s_temp = "TITLE:STRING,KISU1:STRING,FDCODENM:STRING,CURDT:STRING,CURTM:STRING,ATKORNAM:STRING";
		 gcds_temp01.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	
	//gcgd_disp01.runexcel("월별판관비명세서");
     gcgd_disp01.GridToExcel("월별판관비명세서","",2);
	
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
  
	//년도
	gcem_datefr.text = gs_date3; //년도
	
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	//사업장
	//gcds_place.DataID = "/services/servlet/Account.commdtil_s1?v_str1=2159"; 
	//prompt("", gcds_place.DataID);
	//gcds_place.Reset();

	//기수
	//gcds_staxdatki.DataID = "/services/servlet/Account.commdtil_s1?v_str1=2137"; 
	//gcds_staxdatki.Reset(); 

	/* 
	//관리/지점코드
	gcds_sfdcode2.DataID = "/services/servlet/Account.a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	gcds_staxdatki.DataID = "/services/servlet/Account.commdtil_s1?v_str1=2137"; 
	gcds_staxdatki.Reset(); //기수
	*/
}

/******************************************************************************
	Description : 원가팝업
  parameter   : 
******************************************************************************/
function ln_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  arrParam[0]="0030";//원가코드

	if(gclx_place.bindcolval!=""){
		arrParam[1]=gclx_place.bindcolval;//사업장코드
  }else{
    arrParam[1]="";
	}

	if(txt_costnm_fr.value==""){
		 arrParam[2]="";
	}else{
     arrParam[2]=txt_costnm_fr.value;
	}

	if(txt_costcd_fr.value==""){
     arrParam[3]="";
	}else{
     arrParam[3]=txt_costcd_fr.value;
	}

	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_costcd_fr.value =arrResult[0];
		txt_costnm_fr.value = arrResult[1];
	}else{
    txt_costcd_fr.value="";
		txt_costnm_fr.value="";
	}
}

/******************************************************************************
	Description : 날짜계산
	prameter    : 
******************************************************************************/

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String
 */
function toTimeObject(time) { //parseTime(time)
    var year  = time.substr(0,4);
    var month = time.substr(4,2) - 1; // 1월=0,12월=11
    var day   = time.substr(6,2);
    return new Date(year,month,day);
}

/**
 * 자바스크립트 Date 객체를 Time 스트링으로 변환
 * parameter date: JavaScript Date Object
 */
function toTimeString(date) { //formatTime(date)
    var year  = date.getFullYear();
    var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }

    return ("" + year + month + day);
}

/**
 * 주어진 Time 과 y년 m월 d일 차이나는 Time을 리턴
 *
 * ex) var time = form.time.value; //'20000101'
 *     alert(shiftTime(time,0,0,-100));
 *     => 2000/01/01 으로부터 100일 전 Time
 *
 * http://www.oramaster.net
 */
function shiftTime(time,y,m,d) { //moveTime(time,y,m,d)
    var date = toTimeObject(time);

    date.setFullYear(date.getFullYear() + y); //y년을 더함
    date.setMonth(date.getMonth() + m);       //m월을 더함
    date.setDate(date.getDate() + d);         //d일을 더함

    return toTimeString(date);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--(총)원가명세서 조회  -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--지점  -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--사업장  -->
<!--comment id="__NSID__"><object  id=gcds_place classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script--> 

<!-- 기수 -->
<!--comment id="__NSID__"><object  id=gcds_staxdatki classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script--> 

<!--(총)원가명세서 조회 복사  -->
<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
    //ln_Data_Reset(); //데이타 재설정
		ft_cnt03.innerText = "조회건수 : " + row + " 건";
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_staxdatki" event="onloadCompleted(row,colid)">

</script>

<script language="javascript" for="gcds_place" event="onloadCompleted(row,colid)">
	//gcds_place.InsertRow(1);
	//gcds_place.NameValue(1,"CDCODE")="";
	//gcds_place.NameValue(1,"CDNAM")="전체";
	//gclx_place.index=0;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030014_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" width="685" align="right">&nbsp;
			<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
			<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------ ----------------------->
<table cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:3px;width:877px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>지점코드</td>
				<td class="tab18" style="width:120px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>년&nbsp;&nbsp;&nbsp;도</td>
				<td class="tab18" style="height:30px;width:597px;">&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_datefr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:35px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>
			
<!-- 
			<tr>
				<td class="tab17" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>사 업 장</td>
        <td class="tab19" width="690px" colspan=3>
				  <nobr>
					<input id="txt_vendnm_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd('fr');">
					<input id="txt_vendcd_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_vendnm_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd('to');">
					<input id="txt_vendcd_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:3px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>

				<td class="tab19" style="width:797px" colspan="3"><nobr>
					<object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:5px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 

					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:8px;top:1px" align=center onclick="ln_Popup('fr','01');">
					<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;top:1px;left:8px;width:130px;height:20px;" maxlength="36"  disabled>
					&nbsp;&nbsp;~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:5px">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>         
					<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:8px;top:1px" align=center onclick="ln_Popup('to','01');">
					<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;top:1px;left:8px;width:130px;height:20px;" maxlength="36"  disabled>
				</td>
			</tr> -->
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>  

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:877px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:3px;width:875px; height:430px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data01">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<param name="colsizing"     value="true">
							<param name=viewsummary   value=1>
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<FC> Name='계정코드'	ID=ATCODE HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center SumBgColor=#C3D0DB SumText='계' sort=false show=false</FC> 
								<FC> Name='계정과목'	ID=ATKORNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left SumBgColor=#C3D0DB SumText='계' sort=false</FC> 
								<C> Name='1월'    	ID=A01    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='2월'	    ID=A02    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='3월'    	ID=A03    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='4월'	    ID=A04    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='5월'    	ID=A05    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='6월'	    ID=A06    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='7월'    	ID=A07    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='8월'	    ID=A08    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='9월'    	ID=A09    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='10월'	    ID=A10    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C> 
								<C> Name='11월'	    ID=A11    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
								<C> Name='12월'	    ID=A12    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 align=right  SumBgColor=#C3D0DB SumText=@sum</C>
                <C> Name='계'	      ID=TSUM   HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=right SumBgColor=#C3D0DB SumText=@sum</C>
								   
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">조회건수 : </font>
					</fieldset>
			</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_temp01">
	<param name="DetailDataID"			value="gcds_data01">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"					value="true">
  <param name="PrintSetupDlgFlag" value="true">
	<param name="Format"						value="
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=450 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=960 ,top=108 ,right=1960 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=950 ,top=98 ,right=1950 ,bottom=176 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='KISU1', left=1013, top=190, right=1893, bottom=241, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=70 ,top=370 ,right=2808 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계' ,left=2645 ,top=389 ,right=2780 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='12월' ,left=2460 ,top=389 ,right=2595 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='11월' ,left=2275 ,top=389 ,right=2410 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10월' ,left=2090 ,top=389 ,right=2225 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='9월' ,left=1905 ,top=389 ,right=2040 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='8월' ,left=1720 ,top=389 ,right=1855 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='7월' ,left=1535 ,top=389 ,right=1670 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4월' ,left=975 ,top=389 ,right=1110 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5월' ,left=1165 ,top=389 ,right=1300 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6월' ,left=1348 ,top=389 ,right=1483 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3월' ,left=795 ,top=389 ,right=930 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2월' ,left=610 ,top=389 ,right=743 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구 분' ,left=105 ,top=389 ,right=373 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1월' ,left=423 ,top=389 ,right=558 ,bottom=434 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=70 ,top=450 ,right=2808 ,bottom=450 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TITLE', left=955, top=103, right=1945, bottom=169, face='HY중고딕', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='FDCODENM', left=80, top=314, right=1008, bottom=361, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2870 ,bottom=63 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='TSUM', left=2620, top=7, right=2808, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A12', left=2433, top=7, right=2623, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A11', left=2245, top=7, right=2438, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A10', left=2060, top=7, right=2253, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A09', left=1875, top=7, right=2065, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A08', left=1690, top=7, right=1880, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A07', left=1505, top=7, right=1700, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A06', left=1320, top=7, right=1510, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A05', left=1135, top=7, right=1325, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A04', left=950, top=7, right=1140, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A03', left=763, top=7, right=953, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A02', left=575, top=7, right=765, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='A01', left=385, top=7, right=578, bottom=49, align='right', face='굴림', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=80, top=7, right=390, bottom=49, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2870 ,bottom=63 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=70 ,top=0 ,right=2808 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=70 ,top=63 ,right=2808 ,bottom=63 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<S>id='{Sum(TSUM)}' ,left=2620 ,top=12 ,right=2808 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A12)}' ,left=2435 ,top=12 ,right=2623 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A10)}' ,left=2065 ,top=12 ,right=2253 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A11)}' ,left=2250 ,top=12 ,right=2438 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A08)}' ,left=1693 ,top=12 ,right=1880 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A09)}' ,left=1880 ,top=12 ,right=2065 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A07)}' ,left=1508 ,top=12 ,right=1695 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A06)}' ,left=1323 ,top=12 ,right=1510 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A04)}' ,left=950 ,top=12 ,right=1140 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A05)}' ,left=1138 ,top=12 ,right=1325 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A02)}' ,left=575 ,top=12 ,right=765 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A03)}' ,left=763 ,top=12 ,right=953 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(A01)}' ,left=385 ,top=12 ,right=578 ,bottom=54 ,align='right' ,face='돋움체' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<T>id='계' ,left=80 ,top=12 ,right=390 ,bottom=54 ,face='굴림' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2870 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2418 ,top=2 ,right=2798 ,bottom=84</I>
	<L> left=70 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p / #t' ,left=1245 ,top=54 ,right=1668 ,bottom=96 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=80, top=14, right=480, bottom=59, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURTM', left=475, top=14, right=820, bottom=59, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
