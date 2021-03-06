<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사고과관리 - 고과점수 조정
+ 프로그램 ID	: H060005.html
+ 기 능 정 의	:   
+ 변 경 이 력	: 2007.06.13 정영식 - 년말평균, 평정, 최종판정 추가 
+ 서 블 릿 명	: h060005_s1, h060005_s2, hclcode_s1, h060005_t1
-------------------------------------------------------------------------------
+ 수 정 이 력 : 순위별 등급 적용 ( 2009.06 고과 부터 적용 ) 
+ 수 정 일 자 : 
+ 수   정  자 : 정 영 식 
-------------------------------------------------------------------------------
+ 수 정 이 력 : 부서장 관련 고과 추가 ( 2009.11 고과 부터 적용 ) 
+ 수 정 일 자 : 2009.11.06
+ 수   정  자 : 정 영 식 
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
get_cookdata();
lfn_init();
var gs_level;
var gs_treecd;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_yymm.text = gcurdate.substring(0,7); 
	ln_Luxecombo_load();

	//txt_empnoh.value = gusrid;
	//txt_empnmh.value = gusrnm;
	goga2.value = "선택";
	gcra_grsref.CodeValue = 1;

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

		if (gclx_paygrd.bindcolval != "" || gclx_paygrd2.bindcolval != "") {
			var v_paygrd1 = gcds_paygrd.namevalue(gcds_paygrd.rowposition,"SEQ");
			var v_paygrd2 = gcds_paygrd2.namevalue(gcds_paygrd2.rowposition,"SEQ");
		}else{
			var v_paygrd1 = "";
			var v_paygrd2 = ""; 
		}

		if(gcem_yymm.text==""){
			alert("고과년월을 확인하십시요.");
			return false;
		}

		if(gcem_yymm.text<='200811'){
			gcgd_col.ColumnProp("GOGAGB", "Show") = "true";
			gcgd_col.ColumnProp("GRADE", "Show") = "false";
			gcgd_col.ColumnProp("GRADE2", "Show") = "false";
			gcgd_col.ColumnProp("GRADE3", "Show") = "false";
		}else if(gcem_yymm.text=='200906'){
      gcgd_col.ColumnProp("GOGAGB", "Show") = "false";
			gcgd_col.ColumnProp("GRADE", "Show") = "true";
			gcgd_col.ColumnProp("GRADE2", "Show") = "false";
			gcgd_col.ColumnProp("GRADE3", "Show") = "false";
		}else if(gcem_yymm.text>'200906'){
			gcgd_col.ColumnProp("GOGAGB", "Show") = "false";
			gcgd_col.ColumnProp("GRADE", "Show") = "true";
			gcgd_col.ColumnProp("GRADE2", "Show") = "true";
			gcgd_col.ColumnProp("GRADE3", "Show") = "true";
		}

    //2008.11.11 jys 수정 : 평균 ( 5:5 => 6:4(2차고과) , 5:3:2(3차고과) 로 변경 ==> 4:3:3
		if(gcem_yymm.text<='200807'){
			gcds_data.DataID = "/servlet/Person.h060005_s1?v_str1="+gcem_yymm.text				//고과년월
																												 +"&v_str2="+txt_empnoh.value				//사번
																												 +"&v_str3="+gclx_deptcd.bindcolval	//소속코드
																												 +"&v_str4="+gs_level								//level
																												 +"&v_str5="+gs_treecd							//treecd
																												 +"&v_str6="+v_paygrd2							//직위 from
																												 +"&v_str7="+v_paygrd1							//직위 to
																												 +"&v_str8="+gclx_jobkind.bindcolval//직종
																												 +"&v_str9="+goga1.value						//고과평정
																												 +"&v_str10="+gcra_grsref.CodeValue //구분
																												 +"&v_str11=A";											//조회조건
      // prompt('1',gcds_data.DataID);
			 gcds_data.Reset(); 
		}else if(gcem_yymm.text>'200807'){
			 gcds_data.DataID = "/servlet/Person.h060005_s2?v_str1="+gcem_yymm.text				//고과년월
																												 +"&v_str2="+txt_empnoh.value				//사번
																												 +"&v_str3="+gclx_deptcd.bindcolval	//소속코드
																												 +"&v_str4="+gs_level								//level
																												 +"&v_str5="+gs_treecd							//treecd
																												 +"&v_str6="+v_paygrd2							//직위 from
																												 +"&v_str7="+v_paygrd1							//직위 to
																												 +"&v_str8="+gclx_jobkind.bindcolval//직종
																												 +"&v_str9="+goga1.value						//고과평정
																												 +"&v_str10="+gcra_grsref.CodeValue //구분
																												 +"&v_str11=A";											//조회조건
		   //prompt('2',gcds_data.DataID);
			 gcds_data.Reset(); 
		}
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

  if(gcem_yymm.text!="201106"){
		alert("2011년 06월만 저장 가능합니다.");
		return false;
	}

	if (gcds_data.countrow<1){
		alert ("저장할 정보가 없습니다.");
	}else {
		if (confirm("저장하시겠습니까?")) {
			//prompt("gcds_data2",  gcds_data.text );
			gctr_data.keyvalue = "h060005_t1(I:USER=gcds_data)";
			gctr_data.action = "/servlet/Person.h060005_t1";
			gctr_data.post();
			//ln_Query();
		}
	}
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
	alert("개발중입니다");
}

/******************************************************************************
	Description : 조회2
******************************************************************************/
function ln_Query2(){
  //2008.11.11 jys 수정 : 평균 ( 5:5 => 6:4(2차고과) , 5:3:2(3차고과) 로 변경  ==>4:3:3

  
	if(gcem_yymm.text!="201106"){
		alert("2011년 06월만 실행 가능합니다.");
		return false;
	}

  if(gcem_yymm.text<='200807'){
		gcds_data2.DataID = "/servlet/Person.h060005_s1?v_str1="+gcem_yymm.text			//고과년월
																											 +"&v_str2="+txt_empnoh.value				//사번
																											 +"&v_str3="+""											//소속코드
																											 +"&v_str4="+""											//level
																											 +"&v_str5="+""											//treecd
																											 +"&v_str6="+""											//직위
																											 +"&v_str7="+""											//직종
																											 +"&v_str8="+""											//고과평정
																											 +"&v_str9="+""											//고과평정
																											 +"&v_str10="+gcra_grsref.CodeValue;//구분
   // prompt('1111::',gcds_data2.DataID);
		gcds_data2.Reset(); 
	}else if(gcem_yymm.text>'200807'){
		gcds_data2.DataID = "/servlet/Person.h060005_s2?v_str1="+gcem_yymm.text			//고과년월
																											 +"&v_str2="+txt_empnoh.value				//사번
																											 +"&v_str3="+""											//소속코드
																											 +"&v_str4="+""											//level
																											 +"&v_str5="+""											//treecd
																											 +"&v_str6="+""											//직위
																											 +"&v_str7="+""											//직종
																											 +"&v_str8="+""											//고과평정
																											 +"&v_str9="+""											//고과평정
																											 +"&v_str10="+gcra_grsref.CodeValue;//구분
		//prompt("22",gcds_data2.DataID  );
		gcds_data2.Reset(); 
	}
}

/******************************************************************************
	Description : 실행
	            : 1. 보정 평균 ==> 최종조정 ( TOTAVG ) 에 UPDATE 함.
							: 2. 부서장 고과가 존재 하는 경우
							     보정평균 * 0.8 + DPTAVG ==> 최종조정 ( TOTAVG )에 UPDATE 함
******************************************************************************/
function ln_Execute(){

	if (gcds_data.countrow<1){
		alert ("저장할 정보가 없습니다.");
	}else {
    if(gcem_yymm.text==""){
			alert("고과년월을 확인하십시요.");
			return false;
		}

		ln_Query2();
	}

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	//gcgd_col.RunExcel('고과점수조정');
	gcgd_col.GridToExcel('고과점수조정','',8);
}

/******************************************************************************
	Description : 고과자 조회
******************************************************************************/
function ln_FindEmp(e, row){
  var result="";
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H060004_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:383px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

 	if (result != null) {
		arrResult = result.split(";");
		//eval(e).value  = arrResult[0];   
		if (e=="txt_empnmh") {
		  txt_empnmh.value = arrResult[0];
			txt_empnoh.value = arrResult[1];
		}else if(e=="EMPNMKH"){
		  gcds_data2.namevalue(row,"EMPNMKH")= arrResult[0];
      gcds_data2.namevalue(row,"EMPNOH") = arrResult[1];			
		}
	} else {
		if (e=="txt_empnmh") {
		  txt_empnmh.value="";
			txt_empnoh.value ="";
		}
	}
}

/******************************************************************************
	Description : Luxecombo load
******************************************************************************/
function ln_Luxecombo_load(){

	//직위 from
	gcds_paygrd.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";//&v_str3=SEQ"; 
	gcds_paygrd.Reset();

	//직위 to
	gcds_paygrd2.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";//&v_str3=SEQ"; 
	gcds_paygrd2.Reset();

	//직종
	gcds_jobkind.DataID = "/servlet/Person.hclcode_s1?v_str1=2034"; 
	gcds_jobkind.Reset();

	//소속
	gcds_deptcd.DataID = "/servlet/Person.hcdept_s1?";  
	gcds_deptcd.Reset();
}

/******************************************************************************
	Description : 등급생성 --> 등급은 항상 실행 후 totavg(최종조정)이 존재한 후에 적용해야함.
******************************************************************************/
function ln_Grade(){

  if(gcem_yymm.text==""){
		alert("고과년월이 존재하지 않습니다. 확인바랍니다.");
		return;
	}

	if(gcra_grsref.CodeValue==""){
		alert("구분이 존재하지 않습니다. 확인바랍니다.");
		return;
	}

	if(gcem_yymm.text!="201106"){
		alert("2011년 06월만 등급생성 가능합니다.");
		return false;
	}

	//직급별 등급 인원수
  gcds_grade1.DataID = "/servlet/Person.h060005_s3?v_str1="+gcem_yymm.text+"&v_str2="+gcra_grsref.CodeValue;
	//prompt('gcds_grade1',gcds_grade1.DataID);
	gcds_grade1.Reset();

	//직급별 rank  
	gcds_grade2.DataID = "/servlet/Person.h060005_s4?v_str1="+gcem_yymm.text+"&v_str2="+gcra_grsref.CodeValue;
	//prompt('gcds_grade2',gcds_grade2.DataID);
	gcds_grade2.Reset();

  if (confirm(gcem_yymm.text+" 등급생성을 하시겠습니까?")) {
		ln_Grade_Update();

		gctr_data.keyvalue = "h060005_t2(I:USER=gcds_grade2)";
		gctr_data.action = "/servlet/Person.h060005_t2";
		//prompt('',gcds_grade2.text);
		gctr_data.post();
	}
}


/******************************************************************************
	Description : 등급생성 --> 등급은 항상 실행 후 totavg(최종조정)이 존재한 후에 적용해야함.
******************************************************************************/
function ln_Grade_Update(){

	var intCnt=0;
	var intS=0;
	var intA=0;
	var intB=0;
	var intC=0;
	var intD=0;
	var intStart=1;

	//alert("gcds_grade1::"+gcds_grade1.countrow);
	//alert("gcds_grade2::"+gcds_grade2.countrow);

	for(i=1;i<=gcds_grade1.countrow;i++){     //직급별 row 
		intCnt=0;                               //직급별 명수 초기화
		intS=gcds_grade1.namevalue(i,"S");
		intA=gcds_grade1.namevalue(i,"S")+gcds_grade1.namevalue(i,"A");
		intB=gcds_grade1.namevalue(i,"S")+gcds_grade1.namevalue(i,"A")+gcds_grade1.namevalue(i,"B");
		intC=gcds_grade1.namevalue(i,"S")+gcds_grade1.namevalue(i,"A")+gcds_grade1.namevalue(i,"B")+gcds_grade1.namevalue(i,"C");
		intD=gcds_grade1.namevalue(i,"S")+gcds_grade1.namevalue(i,"A")+gcds_grade1.namevalue(i,"B")+gcds_grade1.namevalue(i,"C")+gcds_grade1.namevalue(i,"D");

    //alert(intS);
		//alert(intA);
		//alert(intB);
		//alert(intC);
		//alert(intD);

		_loop:
		for(j=intStart;j<=gcds_grade2.countrow;j++){   //전체 직급별 rank 순위..
			intCnt +=1;                           //순위

      if(gcds_grade1.namevalue(i,"PAYGRD2")==gcds_grade2.namevalue(j,"PAYGRD2")){ 
			  intStart+=1; 
				 
				if(intCnt<=intS){
					gcds_grade2.namevalue(j,"GRADE")="S";
				}else if(intCnt<=intA){
          gcds_grade2.namevalue(j,"GRADE")="A"; 
				}else if(intCnt<=intB){
          gcds_grade2.namevalue(j,"GRADE")="B"; 
        }else if(intCnt<=intC){
          gcds_grade2.namevalue(j,"GRADE")="C"; 
        }else if(intCnt<=intD){
          gcds_grade2.namevalue(j,"GRADE")="D"; 
				}
			}else{
				break _loop;
			}
		}//for j
  }//for i
}

/******************************************************************************
	Description : 지점의 고과 데이타 UPLOAD 할 때 사용함.
******************************************************************************/
function ln_Update(){
  	var s_temp = "TEMP:STRING";
		gcds_update.SetDataHeader(s_temp);

		gcds_update.addrow();
    gcds_update.namevalue(gcds_update.rowposition,"TEMP")="201106"; //고과년월

		gctr_data.keyvalue = "hupdate_t1(I:USER=gcds_update)";
		gctr_data.action = "/servlet/Person.hupdate_t1";
    //prompt('',gcds_update.text);
		gctr_data.post();
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	</OBJECT>

	<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	</OBJECT>

</comment><script>__ws__(__NSID__);</script>

<!--직위코드1-->
<comment id="__NSID__"><object id="gcds_paygrd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="SortExpr" value="+seq">
</object></comment><script>__ws__(__NSID__);</script>

<!--직위코드2-->
<comment id="__NSID__"><object id="gcds_paygrd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="SortExpr" value="+seq">
</object></comment><script>__ws__(__NSID__);</script>

<!--직종코드-->
<comment id="__NSID__"><object id="gcds_jobkind" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name="SortExpr" value="+MINORCD">
</object></comment><script>__ws__(__NSID__);</script>

<!--소속코드-->
<comment id="__NSID__"><object id=gcds_deptcd classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
	<param name="SortExpr" value="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
  <object id=gcds_update classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
</object>

<!-- 등급 : 직급별 등급 인원수  -->
 <object id=gcds_grade1 classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
</object>

<!-- 등급 : 직급별 rank  -->  
 <object id=gcds_grade2 classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("에러가 발생 했습니다.");
	window.status="조회가 완료 되었습니다.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	} 

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = " 조회가 완료 되었습니다.";
</script>

<script language="javascript" for="gcds_data2"	event="onLoadCompleted(row,colid)">
	if (gcds_data2.countrow<1){
	}else {
		for(var i=1;i<=row;i++) {
			//2009.11.06 추가 
			if(gcds_data2.namevalue(i,"DPTAVG")==0){
				gcds_data2.namevalue(i,"TOTAVG") = gcds_data2.namevalue(i,"CORAVG");
			}else{
				gcds_data2.namevalue(i,"TOTAVG") = gcds_data2.namevalue(i,"CORAVG")*0.8 + gcds_data2.namevalue(i,"DPTAVG") ;
			}
		}
		if (confirm("실행하신 정보를 저장하시겠습니까?")) {
			gctr_data.keyvalue = "h060005_t1(I:USER=gcds_data2)";
			gctr_data.action = "/servlet/Person.h060005_t1";
			//prompt(this,gcds_data2.text);
			gctr_data.post();
			ln_Query();
		}
	}
</script>

<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script>

<script language="javascript" for="gcds_paygrd" event="onloadCompleted(row,colid)">
	gcds_paygrd.insertrow(1);
	gcds_paygrd.namevalue(1,"MINORCD") = "";
	gcds_paygrd.namevalue(1,"MINORNM") = "전체";
	gclx_paygrd.index = 0;
</script>

<script language="javascript" for="gcds_paygrd2" event="onloadCompleted(row,colid)">
	gcds_paygrd2.insertrow(1);
	gcds_paygrd2.namevalue(1,"MINORCD") = "";
	gcds_paygrd2.namevalue(1,"MINORNM") = "전체";
	gclx_paygrd2.index = 0;
</script>

<script language="javascript" for="gcds_jobkind" event="onloadCompleted(row,colid)">
	gcds_jobkind.insertrow(1);
	gcds_jobkind.namevalue(1,"MINORCD") = "";
	gcds_jobkind.namevalue(1,"MINORNM") = "전체";
	gclx_jobkind.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_deptcd event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
	gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gctr_data event=OnSuccess()>
    alert("작업을 완료 하였습니다");
</script>

 
<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>


<table width="876" cellpadding="0" cellspacing="0" border="0">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/h060005_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
		 <!-- 임시막음. -->
<!-- <img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Update()">&nbsp;&nbsp; &nbsp; &nbsp;  
 -->				<img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Execute()">
        <img src="../../Common/img/btn/com_b_grade.gif" style="cursor:hand"   onclick="ln_Grade()">&nbsp;&nbsp;
				
				<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
				<img src="../../Common/img/btn/com_b_save.gif"	style="cursor:hand" onclick="ln_Save()">
				<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		<table  cellpadding="0" cellspacing="0" border="0"      
			 style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr> 
						<td class="tab11" width="10"  bgcolor="#eeeeee"><nobr>&nbsp;고과년월&nbsp;&nbsp;</nobr></td>
						<td class="tab19"><nobr>&nbsp
								<comment id="__NSID__"><object id=gcem_yymm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  	
										style="position:relative; left:3px;top:2px; width:50px; height:20px;" class=txtbox> 
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr>
							</td>
						<td class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;고과자&nbsp;&nbsp;&nbsp;</nobr></td>
						<td class="tab19" width="10" ><nobr>&nbsp;<input  id="txt_empnmh" name="txt_name" type="text" style="position:relative; left:0px;top:-2px; width:70px; size=20"  class="txt21" disabled>
							<img src="../../Common/img/btn/com_b_find.gif" alt="고과자를 검색합니다" style="position:relative;left:0px;top:2px;cursor:hand;" onclick="ln_FindEmp('txt_empnmh','')">
							<input type="hidden" width="0" id="txt_empnoh">&nbsp;</nobr>
						</td>  
						<td width="10" class="tab11" bgcolor="#eeeeee" align=center><nobr>&nbsp;소&nbsp;속&nbsp;</nobr></td>
						<td width="10" class="tab19"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=150  style="position:relative; top:2px;">
								<param name=ComboDataID           value=gcds_deptcd>
								<param name=SearchColumn          value="DEPTNM">
								<param name=Sort                  value=false>
								<param name=ListExprFormat        value="DEPTNM^0^150">       
								<param name=BindColumn            value="DEPTCD"> 
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td width="10" class="tab11" bgcolor="#eeeeee" align=center><nobr>&nbsp;구&nbsp;분&nbsp;</nobr></td>
						<td width="10" class="tab13"><nobr>&nbsp;
							<comment id="__NSID__"><object	id=gcra_grsref classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:-4px;top:2px;height:24;width:115;cursor:hand;" class="txtbox" >
								<PARAM NAME=Cols     VALUE="2">
								<PARAM NAME=Format   VALUE="1^정규직,2^계약직">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
<!-- 						<td width="100%" class="tab13"><nobr>&nbsp;  </nobr></td>
 -->			</tr>
					<tr>
						<td width="10" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;직&nbsp;종&nbsp;</nobr></td>
						<td width="10" class="tab12"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_jobkind classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=140 style="position:relative; top:2px;">
								<param name=ComboDataID           value="gcds_jobkind">
								<param name=SearchColumn          value="MINORNM">
								<param name=Sort                  value="false">
								<param name=ListExprFormat        value="MINORNM">
								<param name=BindColumn            value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td width="10" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;고과평정&nbsp;</nobr></td>
						<td width="10" class="tab12"><nobr>&nbsp;
							<input type="checkbox" id=goga1 value="" style="position:relative;left:-10px;cursor:hand;width:20px" onClick="if(this,this.checked) {goga1.value = 'T'}else{goga1.value = ''}">
							<input type="text"		 id=goga2 style="position:relative;left:-10px;width:40px;border-width:0px" >&nbsp;</nobr>
						</td>
						<td width="10" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;직&nbsp;위&nbsp;</nobr></td>
						<td width="10" class="tab12"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  style="position:relative; top:2px;">
								<param name=ComboDataID           value=gcds_paygrd>
								<param name=SearchColumn          value="MINORNM">
								<param name=Sort                  value=false>
								<param name=ListExprFormat        value="MINORNM">       
								<param name=BindColumn            value="MINORCD"> 
							</object></comment><script>__ws__(__NSID__);</script>
							&nbsp;~&nbsp;
							<comment id="__NSID__"><object id=gclx_paygrd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  style="position:relative; top:2px;">
								<param name=ComboDataID           value=gcds_paygrd2>
								<param name=SearchColumn          value="MINORNM">
								<param name=Sort                  value=false>
								<param name=ListExprFormat        value="MINORNM">       
								<param name=BindColumn            value="MINORCD"> 
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td width="100%" COLSPAN=2 ><nobr>&nbsp;  </nobr></td>    
					</tr>
				</table>		
			</td>
		</tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_col  
						style="WIDTH: 876px; HEIGHT: 404px;border:1 solid #777777;display:block;" viewastext>
								<param name="DataID"						value="gcds_data">
								<param name="Editable"					value="true">
								<param name="TitleHeight"       value="17">
								<param name="BorderStyle"				value="0">  
								<param name="Fillarea"					value="true">
                <param name="Sortview"					value="left">
								<param name=ColSelect						value="true">
								<param name=ColSizing						value="true">
								<param name="Format"						VALUE="  
									<FC> Name='사번'			  ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center  Edit=none BgColor='#f5f5f5' sort=true </FC> 
									<FC> Name='소속'			  ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left		Edit=none BgColor='#f5f5f5' sort=true</FC>
									<FC> Name='직위'			  ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		Edit=none BgColor='#f5f5f5' sort=true</FC>
									<FC> Name='피고과자'    ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=72		align=left		Edit=none BgColor='#f5f5f5' sort=true</FC> 
									<FC> Name='고과구분'	  ID=GRPNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=63		align=left		Edit=none	BgColor='#f5f5f5' sort=true  show=false</FC> 
											
									<C> Name='1차\\고과자'  ID=EMPNMH_1 HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		Edit=none sort=true</C>
									<C> Name='점수'				  ID=SCR1			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>
									<C> Name='보정'				  ID=AVG1			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>

									<C> Name='2차\\고과자'  ID=EMPNMH_2 HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		Edit=none sort=true</C>
									<C> Name='점수'				  ID=SCR2			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>
									<C> Name='보정'				  ID=AVG2			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>

									<C> Name='3차\\고과자'  ID=EMPNMH_3 HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		Edit=none sort=true</C>
									<C> Name='점수'				  ID=SCR3			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>
									<C> Name='보정'				  ID=AVG3			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true</C>

									<C> Name='④\\고과자'	  ID=EMPNMH_4 HeadAlign=Center HeadBgColor=#B9D4DC Width=72		align=left		Edit=none	sort=true show=false</C>
									<C> Name='점수'				  ID=SCR4			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true show=false</C>
									<C> Name='보정'				  ID=AVG4			HeadAlign=Center HeadBgColor=#B9D4DC Width=46		align=RIGHT		Edit=none sort=true show=false</C>

									<G> Name='평균' HeadAlign=Center HeadBgColor=#B9D4DC 
									<C> Name='고과'         ID=SCRAVG		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=RIGHT		Edit=none sort=true</C>
									<C> Name='보정'         ID=CORAVG		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=RIGHT		Edit=none sort=true</C>
									<C> Name='부서장'       ID=DPTAVG		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=RIGHT		Edit=none sort=true</C>
									</G>
									<C> Name='최종\\조정'   ID=TOTAVG		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=RIGHT		dec=2	    sort=true  bgcolor='#F5F6CE'</C>
									<C> Name='고과\\판정'   ID=GOGAGB		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=CENTER	Edit=none sort=true  show=true</C>
									<C> Name='고과\\등급'   ID=GRADE		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=CENTER	sort=true bgcolor='#F5D0A9' </C>

									<C> Name='년말\\평균'   ID=CORAVG_SUM		HeadAlign=Center HeadBgColor=#B9D4DC Width=48		align=RIGHT		Edit=none  sort=true  show=false</C>
									<C> Name='평정'		      ID=TOTAVG_SUM		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=RIGHT		Edit=none  dec=2	sort=true  show=false</C>
									<C> Name='최종\\판정'   ID=GOGAGB_SUM		HeadAlign=Center HeadBgColor=#B9D4DC Width=47		align=CENTER	Edit=none  sort=true  show=false</C>
								  <G> Name='최종등급조정' HeadAlign=Center HeadBgColor=#B9D4DC 
 										<C> Name='본부장'   ID=GRADE2		    HeadAlign=Center HeadBgColor=#B9D4DC Width=58		align=CENTER	sort=true  bgcolor='#F7BE81'</C>
									  <C> Name='대표이사' ID=GRADE3		    HeadAlign=Center HeadBgColor=#B9D4DC Width=74		align=CENTER	sort=true  bgcolor='#FAAC58'</C>
									</G>
								
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
        </tr>
      </table>
    </td>
  </tr>


 <tr>
		<td colspan=2 height="24">조회건수 : <label id="lbl_search"></label></td>
 </tr>	

 <tr>
		<td colspan=2 > <P>
		                 &nbsp;&nbsp;* 실&nbsp;&nbsp;&nbsp;&nbsp;행 : 보정평균 점수를 최종 조정에 업데이트함. ( 부서장 평균이 존재하면 보정평균(80%) + 부서장 평균 합산 점수를 적용함 ) <BR>
										 &nbsp;&nbsp;* 등급생성 : 최종점수 기준으로 고과 등급 생성함.(본부장 및 대표이사 최종등급조정도 최초 고과등급 적용함)<BR> 
		                 &nbsp;&nbsp;* 실행 및 등급 생성 버튼을 정규직, 계약직 각각 한 번만 적용하면 됩니다.<BR>
		                 &nbsp;&nbsp;* 고과등급, 본부장 및 대표이사 최종등급조정은 임의 변경 후에는 저장 버튼으로 저장하면 수정 됩니다.<BR>
										 &nbsp;&nbsp;* 단, 임의 변경한 경우 다시 실행 및 등급생성 버튼을 누르면 기존 임의 변경된 내용은 적용 안됩니다.
		</td>
 </tr>	

</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>