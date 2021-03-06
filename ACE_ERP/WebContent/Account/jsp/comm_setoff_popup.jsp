<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 상계팝업
+ 프로그램 ID	:  Comm_Setoff_popup.html
+ 기 능 정 의	:  반제화면의 상계 팝업창
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2006.6.27
-----------------------------------------------------------------------------
+ 수 정 내 용 :	   
+ 수   정  자 :
+ 수 정 일 자 :
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>상계처리</title>

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
var parentGubun="";
var arg = new Array ();
get_cookdata();

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	arg=window.dialogArguments; 
	txt_custnm.value=arg.txt_custnm_fr.value;
    txt_custcd.value=arg.txt_custcd_fr.value;

	ln_Query('');
}

/******************************************************************************
	Description : 조회
***************************	***************************************************/
function ln_Query(p){

	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>setoff_popup_s1?v_str1="+arg.gclx_fdcode.bindcolval
	                                                             +"&v_str2="+arg.txt_custcd_fr.value
																															 +"&v_str3="+arg.txt_atcode_fr.value
																															 +"&v_str4="+arg.gcem_actdat_fr.text
																															 +"&v_str5="+arg.gcem_actdat_to.text;
	gcds_code01.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
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

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}


/******************************************************************************
	Description : 반제금액과 상계금액의 합계를 비교함.
******************************************************************************/
function ln_Amt_Chk(){
	var dblTempAmt=0;   //반제금액
	var dblTempAmt2=0;  //상계금액
	var dbltemp=0;
	var strChk="";

	for(var i=1;i<=gcds_code01.countrow;i++){
		if(gcds_code01.namevalue(i,"CHK")=="T"){
		  strChk="1";
		}
	}

	if(strChk=""){
		alert("데이타를 선택하십시요.");
	}

  //반제금액
	for(var i=1;i<=arg.gcds_data01.countrow;i++){
		if(arg.gcds_data01.namevalue(i,"CHK")=="T"){
			dblTempAmt+=arg.gcds_data01.namevalue(i,"BANJAEAMT");
		}
	}

	
	//상계금액 하나의 금액이 큰경우

	//상계금액 하나의 금액이 작은 경우

  //상계금액
  for(j=1;j<=gcds_code01.countrow;j++){
		if(gcds_code01.namevalue(j,"CHK")=="T"){
		  if(gcds_code01.namevalue(j,"CHAAMT")-gcds_code01.namevalue(j,"DAEAMT")>0){
				dbltemp = gcds_code01.namevalue(j,"CHAAMT")-gcds_code01.namevalue(j,"DAEAMT"); 
			}else if(gcds_code01.namevalue(j,"CHAAMT")-gcds_code01.namevalue(j,"DAEAMT")<0){
				dbltemp = gcds_code01.namevalue(j,"DAEAMT")-gcds_code01.namevalue(j,"CHAAMT"); 
			}
			dblTempAmt2+=dbltemp;
		}
	}

	if(Number(dblTempAmt)>Number(dblTempAmt2)){
		alert("상계금액이 더 작습니다. 금액을 확인해 주십시요.");
		return false;
	}
	return dblTempAmt;
}

/******************************************************************************
	Description : 클릭시 금액 체크해서 체크사항 확인.
	parameter   : 
	참       고 : 
	            : 
******************************************************************************/
function ln_Chk(row){
  var dblTempAmt=0; //반제금액
	var dblTempAmt2=0; //기존 체크된 상계금액
	for(var i=1;i<=arg.gcds_data01.countrow;i++){
		if(arg.gcds_data01.namevalue(i,"CHK")=="T"){
			dblTempAmt+=arg.gcds_data01.namevalue(i,"BANJAEAMT");
		}
	}

	for(j=1;j<=gcds_code01.countrow;j++){
		if(gcds_code01.namevalue(j,"CHK")=="T"){
		  if(gcds_code01.namevalue(j,"CHAAMT")-gcds_code01.namevalue(j,"DAEAMT")>0){
				dbltemp = gcds_code01.namevalue(j,"CHAAMT")-gcds_code01.namevalue(j,"DAEAMT"); 
			}else if(gcds_code01.namevalue(j,"CHAAMT")-gcds_code01.namevalue(j,"DAEAMT")<0){
				dbltemp = gcds_code01.namevalue(j,"DAEAMT")-gcds_code01.namevalue(j,"CHAAMT"); 
			}
			dblTempAmt2+=dbltemp;
		}
	}

	if(Number(dblTempAmt)<Number(dblTempAmt2)){
		alert("상계금액이 더 많습니다. 더이상 금액을 선택할 수 없습니다.");
		return false;
	}

	return true;


}

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
	참       고 : 전표 MST, 전표DTL, 반제원장, 반제연결에 데이타 넣음
	            : 종합 및 건별로 구분해야함.
******************************************************************************/
function ln_Close(p){
  var row = gcds_code01.rowposition;
	var icnt=0;
  var totamt=0; //반제합계금액 또는 false
	var strData="";

	if (p=="A") {
		
		totamt=ln_Amt_Chk();
   
    //alert("totamt::"+totamt);

		if(totamt==false) return; //반제금액합계와 상계금액합계를 비교함.
 
		for(var i=1;i<=gcds_code01.countrow;i++){
			if(gcds_code01.namevalue(i,"CHK")=="T"){
				strData+="02"+";";                                 //0  종합
				strData+="D"+";";                                  //1
				strData+=gcds_code01.namevalue(i,"CHK")+";";       //2
				strData+=gcds_code01.namevalue(i,"FDCODE")+";";    //3
				strData+=gcds_code01.namevalue(i,"FSDAT")+";";     //4 
				strData+=gcds_code01.namevalue(i,"FSNBR")+";";     //5 
				strData+=gcds_code01.namevalue(i,"FSSEQ")+";";		 //6 
				strData+=gcds_code01.namevalue(i,"ATCODE")+";";		 //7 
				strData+=gcds_code01.namevalue(i,"ATKORNAM")+";";  //8 
				strData+=gcds_code01.namevalue(i,"SSDAT")+";";		 //9 
				strData+=gcds_code01.namevalue(i,"SSNBR")+";";		 //10 
				strData+=gcds_code01.namevalue(i,"FSNUM")+";";     //11 
				strData+=gcds_code01.namevalue(i,"REMARK")+";";		 //12 
				strData+=gcds_code01.namevalue(i,"CHAAMT")+";";		 //13 
				strData+=gcds_code01.namevalue(i,"DAEAMT")+";";		 //14 
				strData+=gcds_code01.namevalue(i,"JANAMT")+";";		 //15 
				strData+=gcds_code01.namevalue(i,"DEPTCD")+";";		 //16 
				strData+=gcds_code01.namevalue(i,"DEPTNM")+";";		 //17 
				strData+=gcds_code01.namevalue(i,"VENDCD")+";";		 //18 
				strData+=gcds_code01.namevalue(i,"VENDNM")+";";		 //19 
				strData+=gcds_code01.namevalue(i,"FSREFCD")+";";   //20 
				strData+=gcds_code01.namevalue(i,"FSREFVAL")+";";  //21 
				strData+=gcds_code01.namevalue(i,"FSREFNM")+";"; 	 //22 
				strData+=gcds_code01.namevalue(i,"COCODE")+";"; 	 //23 
				strData+=gcds_code01.namevalue(i,"DIVCD")+";"; 		 //24 
				strData+=gcds_code01.namevalue(i,"SSNBR1")+";"; 	 //25 
				strData+=gcds_code01.namevalue(i,"ACTDAT")+";"; 	 //26 
				strData+=gcds_code01.namevalue(i,"FSSTAT")+";"; 	 //27 
				strData+=gcds_code01.namevalue(i,"FSREFCD2")+";";  //28 
				strData+=gcds_code01.namevalue(i,"FSREFVAL2")+";"; //29
				strData+=gcds_code01.namevalue(i,"FSREFNM2")+";";  //30
				strData+=totamt+";";                               //31

				//alert("DIVCD::"+gcds_code01.namevalue(i,"DIVCD"));
			}//if
		}//for
		window.returnValue = strData;
		window.close();
	} else {
		window.close();
	}
}

/************************************************************************************
	Description : 반제팝업 조회시 동일전표에서 반제한 금액이 존재할 경우 잔액에서 뺌
	              해당 fsseq의 전표를 수정할 경우 이 금액은 제외함.
	parameter   :
******************************************************************************/
function ln_Data_Research(){
  var i=0;
	var j=0;
	var tempbjdeamt=0;
	var tempbjcramt=0;
  
	//반제 연결
	for(i=1;i<=gcds_code01.countrow;i++){
	  tempbjdeamt=0;
    tempbjcramt=0;
		for(j=1;j<=arg.gcds_banjae.countrow;j++){
			if(gcds_code01.namevalue(i,"FDCODE")==arg.gcds_banjae.namevalue(j,"FDCODE")&&
				 gcds_code01.namevalue(i,"FSDAT")==arg.gcds_banjae.namevalue(j,"TSDAT")&&
				 gcds_code01.namevalue(i,"FSNBR")==arg.gcds_banjae.namevalue(j,"TSNBR")&&
				 gcds_code01.namevalue(i,"FSSEQ")==arg.gcds_banjae.namevalue(j,"TSSEQ")){
				 
				 if(gcds_code01.namevalue(i,"ATDECR")=="2"){
					 tempbjdeamt += arg.gcds_banjae.namevalue(j,"BJDEAMT");
				 }else if(gcds_code01.namevalue(i,"ATDECR")=="1"){
					 tempbjcramt += arg.gcds_banjae.namevalue(j,"BJCRAMT");
				 }
			}
		}//for j
    
		//alert("tempbjdeamt::"+tempbjdeamt+"tempbjcramt::"+tempbjcramt);
		if(gcds_code01.namevalue(i,"ATDECR")=="1"){
			gcds_code01.namevalue(i,"JANAMT")= gcds_code01.namevalue(i,"JANAMT") - tempbjcramt; 
    }else if(gcds_code01.namevalue(i,"ATDECR")=="2"){
      gcds_code01.namevalue(i,"JANAMT")= gcds_code01.namevalue(i,"JANAMT") - tempbjdeamt; 
		}else{
      gcds_code01.namevalue(i,"JANAMT")=0;
		}
	}//for i
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow <=0){
			alert("조회된 데이타가 없습니다.");
	}else{
		//기존에 적용된 금액은 잔액에서 뺌
		ln_Data_Research();
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	//ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp" event=OnClick(row,colid)>
	if(row>=1&&colid=="CHK"){
		if(gcds_code01.namevalue(row,"CHK")=="T"){
			gcds_code01.namevalue(row,"CHK")="F";
		}else{
		  if(!ln_Chk()) return;
			gcds_code01.namevalue(row,"CHK")="T";
      //전체 금액과 비교해서 크면 클릭 못하게 함.
		}
	}
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:710px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="80px;" bgcolor="#eeeeee">거래처</td>
		<td>	
			<input id="txt_custnm" type="text" class="txtbox"  style= "position:relative;top:3px;left:2px;width:250px; height:20px;ime-mode:active;" maxlength="36"  >
			<img src="../../Common/img/btn/com_b_find.gif"     BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:-1px;top:0px;" align=center >				
			<input id="txt_custcd" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:60px; height:20px;" maxlength="13"   >
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:710;height:250px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"    value="left">
				<param name="Editable"    VALUE="false">
			  <PARAM NAME="Format"			VALUE="  
					<C> Name='선택'		      ID=CHK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	 editstyle=checkbox</FC> 
					<C> Name='전표번호'		  ID=SSNBR1	   HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 edit=none </FC> 
					<C> Name='순번'		      ID=FSNUM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	 edit=none </FC> 
					<C> Name='계정과목'		  ID=ATKORNAM  HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft  	 edit=none </C> 
					<C> Name='차변'			    ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right	   edit=none  color=#0000FF </C> 
					<C> Name='대변'			    ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right    edit=none  color=#FF0000</C> 
					<C> Name='잔액'			    ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right    edit=none </C> 
					<C> Name='적요'		      ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=125	  align=reft     edit=none </C> 
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:712;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
