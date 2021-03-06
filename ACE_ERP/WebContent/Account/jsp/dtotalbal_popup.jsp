<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  경리회계 - 총계정원장(일별) Popup
+ 프로그램 ID	:  DTotalbal.html
+ 기 능 정 의	:  총계정원장(일별) 팝업창.
+ 작   성  자 :  이 순 미
+ 서 블 릿 명	:	 dtotalbal_popup_s1
------------------------------------------------------------------------------>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>총계정원장(일별) Popup</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

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
var p_fdcod="";		//지점코드
var p_atcod="";		//계정코드
var p_frdat="";		//검색일자 from
var p_todat="";		//검색일자 to
//get_cookdata();
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam = window.dialogArguments;

	ln_Before();
	ln_SetDataHeader();

	p_fdcod = strParam[0];
	p_atcod = strParam[1];
	p_frdat = strParam[2];
	p_todat = strParam[3];

	gclx_sfdcode.BindColVal = p_fdcod;
	gcem_staxdatfr.text = p_frdat;
	gcem_staxdatto.text = p_todat;
	ln_CurActcode(p_atcod);
	ln_PrtQuery();		//출력조회
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){
	var str1 = gclx_sfdcode.BindColVal;	
	var str2 = gcem_staxdatfr.text;			
	var str3 = gcem_staxdatto.text;
	var str4 = gcem_curatcode_fr01.text;
	var str5 = str2.substring(0,4);
	var str6 = str3.substring(6,8);
	var str7 = "";

	if (str2.substring(6,8) =="01") {
		str7 = Number(str2.substring(0,6)-1)+"31";
	}else{
		str7 = Number(str2-1);
	}

	if(str2 != "" && str3 != "" && str4 != "") {
		gcds_data1.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>totalbal_popup_s1?v_str1="+str1
																												 + "&v_str2="+str2
																												 + "&v_str3="+str3
																												 + "&v_str4="+str4
																												 + "&v_str5="+str5
																												 + "&v_str6="+str6
																												 + "&v_str7="+str7;
		gcds_data1.Reset();
	}
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

/******************************************************************************************
	Description : 조회 - 출력
******************************************************************************************/
function ln_PrtQuery(){
	gcds_print.ClearData();
	for (var i=1;i<=gcds_temp.countrow;i++) {
		var str1 = gclx_sfdcode.BindColVal;		//지점코드
		var str2 = gcem_staxdatfr.text;				//회계기간fr	
		var str3 = gcem_staxdatto.text;				//회계기간to
		var str4 = gcds_temp.namevalue(i,"ATCODE");
		var str5 = str2.substring(0,4);				//검색년도
		var str6 = str3.substring(6,8);				//검색일자
		var str7 = "";												//전기이월

		if (str2.substring(6,8) =="01") {	
			str7 = Number(str2.substring(0,6)-1)+"31";
		}else{
			str7 = Number(str2-1);
		}

		if(str2 != "" && str3 != "" && str4 != "") {
			gcds_data2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>totalbal_popup_s1?v_str1="+str1+"&v_str2="+str2
												+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6+"&v_str7="+str7;
			gcds_data2.Reset();
		}
	}
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
	ln_PrtQuery();	//출력조회
	if(gcds_print.countrow<1) {
		alert("출력할 정보가 없습니다.");
	}else{
		gcds_print.namevalue(1,"ATKORNAM") = txt_curatkornam_to01.value;
		gcds_print.namevalue(1,"FDCODENM") = gclx_sfdcode.text;
		gcds_print.namevalue(1,"CURDT")		 = gcem_staxdatfr.text + gcem_staxdatto.text;
		gcds_print.namevalue(1,"CURDT2")	 = gs_date;
		gcrp_print.preview(); 
	}
}

/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "ATDECR:STRING,ATCODE:STRING,ATKORNAM:STRING,ACTDAT:STRING,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,SLPVLA:DECIMAL,CUMULTAL:DECIMAL,"
						 + "REMARK:STRING,VENDER:STRING,LEVELS:STRING,FDCODE:STRING,"
						 + "FSDAT:STRING,FSNBR:STRING,FSNBRDT:STRING,FDCODENM:STRING,"
						 + "CURDT:STRING,CURDT2:STRING";
	gcds_print.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if (gcds_data1.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_disp01.RunExcel('계정원장');
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	//지점코드[검색]
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();
}

/***********************************************************************************************
	Description : 계정코드 찾기
	parameter   : p2===> fr, to- 계정코드 : apr- 충당금 : up - 상위계정 : down - 계정코드
**********************************************************************************************/
function ln_Popup(p2,p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./Actcode_popup.html";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(p=="01"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr01.text = arrParam[0];
					txt_atkornam_fr01.value = arrParam[1];
					ln_CurActcode();	//현재계정 조회
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
					ln_CurActcode();	//현재계정 조회
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr01.text = "";
				txt_atkornam_fr01.value ="";
			}else if(p2=="to"){
				gcem_atcode_to01.text = "";
				txt_atkornam_to01.value = "";
			}
		}
	}
}

/******************************************************************************
	Description : 현재계정 조회
******************************************************************************/
function ln_CurActcode(e){

	if(e==""){
		var str1 = gcem_atcode_fr01.text;	
		var str2 = gcem_atcode_to01.text;	
	}else{
		var str1 = p_atcod;	
		var str2 = p_atcod;	
	}
		gcds_temp.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030011_s0?v_str1="+str1+"&v_str2="+str2;
		gcds_temp.Reset();
}

/******************************************************************************
	Description : 누계
******************************************************************************/
function ln_Cumulative(){
	var row1 = gcds_data1.rowposition;
	var row  = gcds_data1.countrow;
	var l_33 = 0;
	var r_33 = 0;
	var t_33 = 0;
	for(var i=1;i<=row;i++) {
		/*잔액계산*/
		if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//차변:월계
		}else if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;  //차변:누계
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//대변:월계
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//대변:누계
		}

		/*월계-누계*/			
		if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "00") {
			gcds_data1.namevalue(i,"ACTDAT") = "전기이월";
		}else if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32" || gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			/*월계*/
			if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32"){
				gcds_data1.namevalue(i,"ACTDAT") = "월계";

			/*누계*/
			}else if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33"){
				gcds_data1.namevalue(i,"ACTDAT") = "누계";
				l_33 = l_33+gcds_data1.namevalue(i,"DETOT");	//차
				r_33 = r_33+gcds_data1.namevalue(i,"CRTOT");	//대
				gcds_data1.namevalue(i,"DETOT") = l_33;
				gcds_data1.namevalue(i,"CRTOT") = r_33;
				if(gcds_data1.namevalue(i,"ATDECR") == "1") {
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	//누계잔액
				}else{
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	//누계잔액
				}
				if(gcds_data1.namevalue(1,"ACTDAT") == "전기이월") {
					gcds_data1.namevalue(i,"DETOT") = gcds_data1.namevalue(1,"DETOT")+gcds_data1.namevalue(i,"DETOT");
					gcds_data1.namevalue(i,"CRTOT") = gcds_data1.namevalue(1,"CRTOT")+gcds_data1.namevalue(i,"CRTOT");
					if(gcds_data1.namevalue(i,"ATDECR") == "1") {
						gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	//누계잔액
					}else{
						gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	//누계잔액
					}
				}
			}
		}
	}

	/*전기이월*/	
	if (gcds_data1.namevalue(1,"ACTDAT") != "전기이월") {	//전기이월 0일때
		gcds_data1.InsertRow(1);
		gcds_data1.namevalue(1,"ACTDAT") = "전기이월";
		gcds_data1.namevalue(1,"ATCODE") = gcds_data1.namevalue(2,"ATCODE");
		gcds_data1.namevalue(1,"DETOT")  = 0;
		gcds_data1.namevalue(1,"CRTOT")  = 0;
		gcds_data1.namevalue(1,"SLPVLA") = 0;
	}
}

/******************************************************************************
	Description : 누계 - 출력
******************************************************************************/
function ln_Cumulative2(){
	var row1 = gcds_print.rowposition;
	var row  = gcds_print.countrow;
	var l_33 = 0;
	var r_33 = 0;
	var t_33 = 0;
	for(var i=1;i<=row;i++) {
		/*잔액계산*/
		if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//차변:월계
		}else if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;  //차변:누계
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//대변:월계
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//대변:누계
		}

		/*월계-누계*/			
		if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "00") {
			gcds_print.namevalue(i,"ACTDAT") = "전기이월";
		}else if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32" || gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			/*월계*/
			if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32"){
				gcds_print.namevalue(i,"ACTDAT") = "월계";

			/*누계*/
			}else if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33"){
				gcds_print.namevalue(i,"ACTDAT") = "누계";
				l_33 = l_33+gcds_print.namevalue(i,"DETOT");	//차
				r_33 = r_33+gcds_print.namevalue(i,"CRTOT");	//대
				gcds_print.namevalue(i,"DETOT") = l_33;
				gcds_print.namevalue(i,"CRTOT") = r_33;
				if(gcds_print.namevalue(i,"ATDECR") == "1") {
					gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	//누계잔액
				}else{
					gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	//누계잔액
				}
				if(gcds_print.namevalue(1,"ACTDAT") == "전기이월") {
					gcds_print.namevalue(i,"DETOT") = gcds_print.namevalue(1,"DETOT")+gcds_print.namevalue(i,"DETOT");
					gcds_print.namevalue(i,"CRTOT") = gcds_print.namevalue(1,"CRTOT")+gcds_print.namevalue(i,"CRTOT");
					if(gcds_print.namevalue(i,"ATDECR") == "1") {
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	//누계잔액
					}else{
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	//누계잔액
					}
				}
			}
		}
	}

	/*전기이월*/	
	if (gcds_print.namevalue(1,"ACTDAT") != "전기이월") {	//전기이월 0일때
		gcds_print.InsertRow(1);
		gcds_print.namevalue(1,"ACTDAT") = "전기이월";
		gcds_print.namevalue(1,"ATCODE") = gcds_print.namevalue(2,"ATCODE");
		gcds_print.namevalue(1,"DETOT")  = 0;
		gcds_print.namevalue(1,"CRTOT")  = 0;
		gcds_print.namevalue(1,"SLPVLA") = 0;
	}
}

/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		var row = gcds_data1.rowposition;
		window.returnValue = gcds_data1.namevalue(row,"ATCODE")  + ";" 
	                   	 + gcds_data1.namevalue(row,"ATKORNAM")+ ";" 
											 + gcds_data1.namevalue(row,"ATDECR")  + ";"
											 + gcds_data1.namevalue(row,"ATUPCODE");
		window.close();
	} else {
		window.close();
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
	<!-- <PARAM NAME="SubsumExpr"	VALUE="1:LEVELS,2:ACTDAT"> -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a030022_t1(I:USER=gcds_data1)"> 
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
	}else{
		ln_Cumulative();//누계
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row>0) {
		if (gcds_print.countrow<1) {
			for(i=1;i<=gcds_data2.countrow;i++){
				gcds_print.ImportData(gcds_data2.ExportData(i,1,false));
				gcds_print.namevalue(i,"FSNBRDT")  = gcds_data2.namevalue(i,"FSDAT")+gcds_data2.namevalue(i,"FSNBR");
			}
			ln_Cumulative2();//누계
		}else{
			gcds_print.ImportData(gcds_data2.ExportData(1,gcds_data2.CountRow,false));
			ln_Cumulative2();	//누계
		}
	}
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gclx_sfdcode.BindColVal = p_fdcod;
</script>

<script language="javascript" for="gcds_temp" event="onloadCompleted(row,colid)">
	ln_Query();
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnDblClick()">
	ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp01" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="전체";
	gclx_sfdcode.index=0;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data1 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data1 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()">
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030022_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
	<tr><td colspan="2" height="1px"></td></tr>
</table>

<table cellpadding="0" cellspacing="0" border="0">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">지점코드</td>
				<td class="tab21" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab22" width="220px">
					<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
				</td>
			</tr>
			
			<tr> 				
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">계정코드</td>
				<td class="tab23" colspan="5" width="490px"><nobr>
					<comment id="__NSID__"><object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:5px;cursor:hand">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=Enable				value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:8px;top:1px" align=center onclick="ln_Popup('fr','01');">
					<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;top:1px;left:8px;width:130px;height:20px;" maxlength="36"  disabled>&nbsp;&nbsp;~
				 <comment id="__NSID__"><object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:2px;top:5px;cursor:hand">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=Enable				value=false>
					</object></comment><script>__ws__(__NSID__);</script>         
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:8px;top:1px" align=center onclick="ln_Popup('to','01');">
					<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;top:1px;left:8px;width:130px;height:20px;" maxlength="36"  disabled><nobr>
				</td>
				<td class="tab12" width="60px" align=left>
					<img src="../../Common/img/btn/com_btn_left.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,-1)">
					<img src="../../Common/img/btn/com_btn_right.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,1)">
				</td>
				<td class="tab12" width="80px" bgcolor="#eeeeee">현재계정</td>
				<td width="170px">
					<comment id="__NSID__"><object  id=gcem_curatcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:3px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<input id="txt_curatkornam_to01" type="text" class="txtbox"  style= "position:relative;left:8px;top:-1px;width:105px;height:20px;" maxlength="36"  disabled>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
						style="position:relative;left:8px;width:864px;height:309px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data1">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="true">
						<!-- <PARAM NAME="ViewSummary"	VALUE="1"> -->
						<PARAM NAME="Format"			VALUE="  
						<C> Name='일자'	ID=ACTDAT  HeadAlign=Center HeadBgColor=#B9D4DC Width=158	align=center Edit=None SumText='합계' SumBgColor='#C3D0DB'</C> 
						<C> Name='차변'	ID=DETOT 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=230	align=right	 Edit=None SumText=@sum  SumBgColor='#C3D0DB'</C>
						<C> Name='대변'	ID=CRTOT 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=230	align=right	 Edit=None SumText=@sum	 SumBgColor='#C3D0DB'</C> 
						<C> Name='잔액'	ID=SLPVLA	 HeadAlign=Center HeadBgColor=#B9D4DC Width=230	align=right  Edit=None SumText=@sum	 SumBgColor='#C3D0DB'</C> 
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<!-- <img name="btn_select" border="0" src="../../common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')"> -->
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table> 

		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_temp>
	<param name=BindInfo  value='  
		<C>Col=ATCODE				Ctrl=gcem_curatcode_fr01				Param=text</C>
		<C>Col=ATKORNAM			Ctrl=txt_curatkornam_to01				Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATKORNAM;">
	<param name="Format"					value="
	<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=375 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1100 ,top=34 ,right=1938 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1091 ,top=22 ,right=1925 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=934, top=119, right=2078, bottom=166 ,mask='(  회계일자 : XXXX년 XX월 XX일  ~  XXXX년 XX월 XX일  )', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='계  정  원  장' ,left=1094 ,top=25 ,right=1919 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=241 ,top=284 ,right=2809 ,bottom=284 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='잔  액' ,left=2447 ,top=291 ,right=2803 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='대  변' ,left=2078 ,top=291 ,right=2434 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='차  변' ,left=1709 ,top=291 ,right=2066 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2809 ,top=284 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2441 ,top=284 ,right=2441 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2072 ,top=284 ,right=2072 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1703 ,top=284 ,right=1703 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=241 ,top=284 ,right=241 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=447 ,top=284 ,right=447 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=772 ,top=284 ,right=772 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=181, right=2806, bottom=228, align='right' ,mask='출력일자: XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2806 ,bottom=281 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=241, top=181, right=1088, bottom=228, align='left' ,mask='지      점: XXXXXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='전표번호' ,left=453 ,top=291 ,right=766 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1309 ,top=284 ,right=1309 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='거래처명' ,left=1316 ,top=291 ,right=1697 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='ATKORNAM', left=241, top=228, right=1088, bottom=281, align='left' ,mask='계정과목: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='일  자' ,left=244 ,top=291 ,right=441 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='적  요' ,left=778 ,top=291 ,right=1303 ,bottom=366 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=241 ,top=372 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 </L>
	<C>id='SLPVLA', left=2447, top=0, right=2803, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2441 ,top=0 ,right=2441 ,bottom=50 </L>
	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>
	<C>id='CRTOT', left=2078, top=0, right=2434, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETOT', left=1709, top=0, right=2066, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1703 ,top=0 ,right=1703 ,bottom=50 </L>
	<C>id='VENDER', left=1316, top=0, right=1697, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1309 ,top=0 ,right=1309 ,bottom=50 </L>
	<C>id='REMARK', left=778, top=0, right=1303, bottom=44, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=772 ,top=0 ,right=772 ,bottom=50 </L>
	<C>id='FSNBRDT', left=453, top=0, right=766, bottom=44, align='left' ,mask='XXXXXXXXX-XXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=447 ,top=0 ,right=447 ,bottom=50 </L>
	<C>id='ACTDAT', left=244, top=0, right=441, bottom=44, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=241 ,top=0 ,right=241 ,bottom=50 </L>
	<L> left=241 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=241 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2726 ,right=2869 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>
	<L> left=241 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>
<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 