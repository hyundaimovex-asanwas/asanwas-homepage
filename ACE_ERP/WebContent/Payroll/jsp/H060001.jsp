<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사고과관리 - 고과표입력
+ 프로그램 ID	:   h060001.html
+ 기 능 정 의	:   
+ 변 경 이 력	: 
+ 서 블 릿 명	:   h060001_s1, hclcode_s1, h060001_t1, 
                        h060001_s2: 기생성 고과표 확인
												h060001_t2 : 고과표 일괄생성
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>  
<title>고과표입력</title>

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
var strgcem_yyymm
get_cookdata();
//lfn_init();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_yymm.text = gcurdate.substring(0,7); 
	strgcem_yyymm= gcem_yymm.text;

	gcds_temp1.SetDataHeader("MINORCD:STRING(4),MINORNM:STRING(30)");
	gcds_temp2.SetDataHeader("MINORCD:STRING(4),MINORNM:STRING(30)");

	//공통코드
	ln_Luxecombo_load();  
	
	//ln_Find_item("1");
	//ln_Filter();
	ln_Enable("true");
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060001_s1?v_str1=" + gcem_yymm.text+"&v_str2="+gclx_grpcd.bindcolval; 
	//prompt("gcds_data", gcds_data.DataID);
	gcds_data.Reset(); 
	ln_Enable("false");
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	ln_Header_create("1");
	gcds_data.addrow();	
	ln_Enable("true");
	gcem_yymm2.text = strgcem_yyymm
	gcds_data.namevalue(gcds_data.RowPosition,"EVAYM")=gcem_yymm2.text;
	gcds_data.namevalue(gcds_data.RowPosition,"GRPCD")="1";
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
    if (gcds_data.countrow<1){
		alert ("저장할 정보가 없습니다.");
	}else {
		if(ln_Chk()){
			if (confirm("저장하시겠습니까?")) {
				
				//alert(gcem_escr.text+"gcem_escr");
				//prompt("gcds_data",  gcds_data.text );
				gctr_pyo.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060001_t1";
				gctr_pyo.post();
				ln_Query();
			}
		}//if ln_Chk
	}

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	if (gcds_data.countrow<1){
		alert ("저장할 정보가 없습니다.");
	}else {
		if (confirm("선택한 정보를 삭제하시겠습니까?")){
			gcds_data.deleterow(gcds_data.rowposition);
			gctr_pyo.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060001_t1";
			gctr_pyo.post();
			ln_Query()
		}
	}
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	//gcds_data.UndoAll()
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

   alert("start");
	gcrp_print.PreView();
	 alert("end");
	//alert("개발중입니다.");
	//var THeader="FRDATE:STRING(10),TODATE:STRING(10),CUDATE:STRING(10)";
	//gcds_print_param.SetDataHeader(THeader);
	//gcds_print_param.addrow();

	//gcds_print_param.namevalue(1,"FRDATE") = ADE_EMEdit_monthFr.text;
	//gcds_print_param.namevalue(1,"TODATE") = ADE_EMEdit_monthTo.text;
	//gcds_print_param.namevalue(1,"CUDATE") = "20040729";

	//gcpt_create.PreView();
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	gcgd_create.RunExcel('고과표');
}

function ln_Batch(){

	if (gcem_yymm3.text=="") {
		alert("생성할 고과표의 고과년월을 입력하십시요.");
    gcem_yymm3.focus();
		return ; 
	}else{
		gcds_batchchk.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060001_s3?v_str1=" + fn_trim(gcem_yymm3.text) ;
		//prompt("",gcds_batchchk.DataID);
		gcds_batchchk.reset(); 
	}

}

/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Chk(){
	if (gcds_data.IsUpdated) {
		if ( gcem_yymm.text ==""){
			alert("고과년월을 입력해 주십시요");
            gcem_yymm.Focus();
			return false;
		}else{
			if ( gclx_grpcd.BindColVal ==""){
				alert("직급을 입력해 주십시요");
				gclx_grpcd.Focus();
				return false;
			}else{
				if ( gclx_divcd.BindColVal ==""){
					alert("부문을 입력해 주십시요");
					gclx_divcd.Focus();
					return false;
				}else{
					if ( gclx_jobgrphcd.BindColVal ==""){
						 alert("직군을 입력해 주십시요");
						 gclx_jobgrphcd.Focus();
						 return false;
					}else{
						if ( gclx_jobgrphcd.BindColVal =="1"){
							if ( gclx_grpitemcd.BindColVal ==""){
								 alert("항목구분을 입력해 주십시요");
								 gclx_grpitemcd.Focus();
								 return false;
							}else{
								return true;
							}
						}else{
							if ( gcem_prtseq.text =="" || gcem_prtseq.text =="0"){
								alert("순번을 입력해 주십시요");
								gcem_prtseq.Focus();
								return false;
							}else{
								return true;
							}//seq
						}//item
					}//job
				}//div
			}//grp
		}//yyyymm
	}else{
		alert("변경된 사항이 없습니다");
		return false;
	}

}

/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Luxecombo_load(){
   
 //과장이상 - 대리이하
	gcds_grpcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2014"; 
	//prompt("gcds_grpcd", gcds_grpcd.DataID);
	gcds_grpcd.Reset();

	gcds_grpcd2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2014"; 
	//prompt("gcds_grpcd", gcds_grpcd.DataID);
	gcds_grpcd2.Reset();

  //능력- 업적
	gcds_divcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2015"; 
	gcds_divcd.Reset();

  //공통-사무-기술-영업직
	gcds_jobgrphcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2016"; 
	gcds_jobgrphcd.Reset();

  //평가요소
	gcds_grpitemcd_temp.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2019"; 
  gcds_grpitemcd_temp.Reset();

	gcds_grpitemcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2019"; 
	//prompt("",gcds_grpitemcd.Data);
	gcds_grpitemcd.Reset();

	gcds_samp.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2019"; 
	gcds_samp.Reset();

	}

/******************************************************************************
	Description : DataSet head
******************************************************************************/
function ln_Header_create(p){

	if (p=="1"){
		if (gcds_data.countrow<1){
			var Header1= "EVAYM:STRING,GRPCD:STRING, DIVCD:STRING,JOBGRPH:STRING,PRTSEQ:DECIMAL,GRPITEM:STRING,	        ASKITEM:STRING,	ESCR:DECIMAL,	GSCR:DECIMAL,	MSCR:DECIMAL,	LSCR:DECIMAL,	PSCR:DECIMAL";
			gcds_data.SetDataHeader(Header1);
		}
	}

	if (p=="2"){
		if (gcds_grpitemcd.countrow<1){
			var Header2= "MAJORCD:STRING,MINORCD:STRING,MINORNM:STRING,SEQ:DECIMAL";
			gcds_grpitemcd.SetDataHeader(Header2);
		}
	}
}

/******************************************************************************
	Description : 부문에 따른 항목구분 가져오기
******************************************************************************/
function ln_Find_item(p){
	gcds_grpitemcd.cleardata();
    ln_Header_create("2");
	var j=0
//	alert("p"+p);

	if (p=="all"){
		for (i=1;i<=gcds_grpitemcd_temp.countrow;i++){
			gcds_grpitemcd.AddRow();
			gcds_grpitemcd.namevalue(i,"MAJORCD") = gcds_grpitemcd_temp.namevalue(i,"MAJORCD");
			gcds_grpitemcd.namevalue(i,"MINORCD") = gcds_grpitemcd_temp.namevalue(i,"MINORCD");
			gcds_grpitemcd.namevalue(i,"MINORNM") = gcds_grpitemcd_temp.namevalue(i,"MINORNM");
			gcds_grpitemcd.namevalue(i,"SEQ") = gcds_grpitemcd_temp.namevalue(i,"SEQ");
		}
		return;
	}

	if (gclx_divcd.BindColVal=="1"){
		for (i=1;i<=gcds_grpitemcd_temp.countrow;i++){
			if (gcds_grpitemcd_temp.namevalue(i,"MINORCD")<=4){
			    j=j+1;
        gcds_grpitemcd.AddRow();
				gcds_grpitemcd.namevalue(j,"MAJORCD") = gcds_grpitemcd_temp.namevalue(i,"MAJORCD");
				gcds_grpitemcd.namevalue(j,"MINORCD") = gcds_grpitemcd_temp.namevalue(i,"MINORCD");
				gcds_grpitemcd.namevalue(j,"MINORNM") = gcds_grpitemcd_temp.namevalue(i,"MINORNM");
				gcds_grpitemcd.namevalue(j,"SEQ") = gcds_grpitemcd_temp.namevalue(i,"SEQ");
			}
		}
	}else if(gclx_divcd.BindColVal=="2") {
		for (i=1;i<=gcds_grpitemcd_temp.countrow;i++){
			if (gcds_grpitemcd_temp.namevalue(i,"MINORCD")>4){
				 j=j+1;
				gcds_grpitemcd.AddRow();
				gcds_grpitemcd.namevalue(j,"MAJORCD") = gcds_grpitemcd_temp.namevalue(i,"MAJORCD");
				gcds_grpitemcd.namevalue(j,"MINORCD") = gcds_grpitemcd_temp.namevalue(i,"MINORCD");
				gcds_grpitemcd.namevalue(j,"MINORNM") = gcds_grpitemcd_temp.namevalue(i,"MINORNM");
				gcds_grpitemcd.namevalue(j,"SEQ") = gcds_grpitemcd_temp.namevalue(i,"SEQ");
			}
		}
	}
}

/******************************************************************************
	Description : filter
******************************************************************************/
function ln_Filter(){

//    gcds_grpitemcd.Filter();
		gcbn_data.ActiveBind = "false";
		//divcd 1 - 능력고과  divcd 2 - 업적고과
		//gclx_grpitemcd - 의욕및태도, 업무능력  등의 구분
		if (gcds_data.namevalue(gcds_data.rowposition,"DIVCD")=="1"){
				//gclx_grpitemcd.ComboDataID="gcds_temp1";
		} else {
				//gclx_grpitemcd.ComboDataID="gcds_temp2";
		}
		gcbn_data.ActiveBind = "true";

   // gcds_grpitemcd.UseFilter = false;
}


/******************************************************************************
	Description : Enable or Disable
******************************************************************************/
function ln_Enable(p){
	
	if (p=="false"){
		gclx_grpcd2.Enable=false;
		gclx_divcd.Enable=false;
		gclx_jobgrphcd.Enable=false;
		gclx_grpitemcd.Enable=false;

	}else if(p=="true"){
		gclx_grpcd2.Enable=true;
		gclx_divcd.Enable=true;
		gclx_jobgrphcd.Enable=true;
		gclx_grpitemcd.Enable=true;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data  classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--일괄생성-->
<comment id="__NSID__"><OBJECT id=gcds_batch classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--일괄생성 체크-->
<comment id="__NSID__"><OBJECT id=gcds_batchchk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--직급코드-->
<comment id="__NSID__"><object id="gcds_grpcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grpcd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<!--고과부문-->
<comment id="__NSID__"><object id="gcds_divcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<!--직군-->
<comment id="__NSID__"><object id="gcds_jobgrphcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<!--항목구분-->
<comment id="__NSID__"><object id="gcds_grpitemcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
	<!-- <PARAM NAME="UseFilter" VALUE="true"> -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grpitemcd_temp" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_samp" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_temp1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_temp2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object id="gcds_param" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h060001_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--일괄생성-->
<comment id="__NSID__"><OBJECT id=gctr_batch classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h060001_t2(I:USER=gcds_batch)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
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

<script language=JavaScript for=gcds_grpitemcd event=onLoadCompleted(row,colid)>
	for (var i=1 ; i<=row; i++) {
		var temp = gcds_grpitemcd.namevalue(i,"MINORCD");
		
		if (temp=="1"||temp=="2"||temp=="3"||temp=="4") var obj = eval("gcds_temp1");
		else if (temp=="5"||temp=="6"||temp=="7"||temp=="8") var obj = eval("gcds_temp2");

		obj.addrow();
		var rows = obj.rowposition;
		obj.namevalue(rows,"MINORCD") = gcds_grpitemcd.namevalue(i,"MINORCD")
		obj.namevalue(rows,"MINORNM") = gcds_grpitemcd.namevalue(i,"MINORNM")
	}
</script>

<script language=JavaScript for=gcds_grpitemcd event=onFilter(row)>
	//alert("filter");
//	alert("gclx_divcd" +gclx_divcd.BindColVal);
	//alert("row" +row);
	//alert("MINORCD" +gcds_grpitemcd.namevalue(row,"MINORCD"));
	
	/*
		if(gcds_grpitemcd.namevalue(row,"MINORCD")=="5"){
			return false; 
		}else if (gcds_grpitemcd.namevalue(row,"MINORCD")=="6"){
			return false; 
		}else if (gcds_grpitemcd.namevalue(row,"MINORCD")=="7"){
			return false; 
		}else if (gcds_grpitemcd.namevalue(row,"MINORCD")=="8"){
			return false; 
		}
		return true;
		
    }else if (gclx_divcd.BindColVal=="2") {
		if(gcds_grpitemcd.namevalue(row,"MINORCD")=="1"){
			return false; 
		}else if (gcds_grpitemcd.namevalue(row,"MINORCD")=="2"){
			return false; 
		}else if (gcds_grpitemcd.namevalue(row,"MINORCD")=="3"){
			return false; 
		}else if (gcds_grpitemcd.namevalue(row,"MINORCD")=="4"){
			return false; 
		}
		return true;
    }
		*/
</script>

<script language=JavaScript  for=gcds_grpcd event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";

</script>

<script language=JavaScript  for=gcds_grpitemcd event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_batchchk event=OnLoadCompleted(rowcount)>

	if(rowcount>=1) {
			alert("생성할 고과년월의 고과표가 존재합니다.");
	}else{
			gcds_batch.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060001_s4?";
			//prompt("",gcds_batch.DataID);
			gcds_batch.reset(); 
	}
</script>

		
<script language=JavaScript  for=gcds_batch event=OnLoadCompleted(rowcount)>

	if(rowcount>=1) {
					
		if (confirm(gcem_yymm3.text+ "고과표를 생성하시겠습니까?")) {

			window.status="데이타 생성중입니다..잠시만 기다려 주십시오.";

			for(i=1;i<=rowcount;i++){
          gcds_batch.namevalue(i,"EVAYM") =  gcem_yymm3.text;
					gcds_batch.UserStatus(i)=1; //insert
			}
			
			gctr_batch.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060001_t2";
			//prompt("", gcds_batch.text);
			gctr_batch.post();

      window.status="데이타 생성을 완료했습니다.";
			alert("요청하신 작업을 완료하였습니다.")
			window.status="";
		}

	}else{
		alert("참조할 기생성된 고과표가 존재하지 않아서  고과표를 일괄적으로 생성할 수 없습니다.");
	}

</script>

		 
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_divcd event=OnSelChange2()>
	//ln_Find_item("1");
	//ln_Filter();
</script>

<script language=JavaScript for=gclx_grpitemcd event=OnSelChange2()>

	if (gcds_data.countrow<2||gcds_data.countrow==gcds_data.rowposition) {
		gcds_data.addrow();
		gcds_data.undo(gcds_data.rowposition);
	} else {
		gcds_data.rowposition = gcds_data.rowposition +1;
		gcds_data.rowposition = gcds_data.rowposition -1;
	}

</script>

<script language=JavaScript for=gclx_jobgrphcd event=OnSelChange2()>
	//공통
	if(gclx_jobgrphcd.BindColVal=="1"){
	  //  gclx_grpitemcd.enable= true;
		//ln_Find_item("1");
	}else{
		//gcds_grpitemcd.cleardata();
		//gclx_grpitemcd.enable= false;
	}
	
</script>

<script language="javascript"  for=gcgd_create event=OnClick(Row,Colid)>
	ln_Enable("false");
</script>

<script language="javascript"  for=gcds_data event=Onrowposchanged(Row)>

// ln_Filter();
/*	gcbn_data.ActiveBind = false;
	if (gclx_divcd.BindColVal=="1"){
		//ln_Find_item("1");	
	}else if (gclx_divcd.BindColVal=="2"){
		ln_Find_item("2");
	}
	gcbn_data.ActiveBind = true;
*/
  </script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/h060001_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick ="ln_Excel()">
			<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick = "ln_Print()" > -->
			<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand"  onclick ="ln_Add()">
			<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0"      
	   style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr > 
						<td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;고과년월&nbsp;&nbsp;</nobr></td>
            <td  style="border:0 solid #708090;border-right-width:1px;" ><nobr>&nbsp
							<comment id="__NSID__"><object id=gcem_yymm           
						   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:1px;top:3px; width:50px; height:20px; font-family:굴림; font-size:9pt; " class=objclsEme1
								validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr></TD>

					    <td width="10"   style="border:0 solid #708090;border-right-width:1px;"      
						    bgcolor="#eeeeee"><nobr>&nbsp;직급&nbsp;&nbsp;</nobr></td>
							<td width="10" style="border:0; solid #708090;border-right-width:1px;">
							<nobr>&nbsp;
								<comment id="__NSID__"><object id=gclx_grpcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120    style="position:relative;top:2px;">
									<param name=ComboDataID           value=gcds_grpcd>
									<param name=SearchColumn          value="MINORNM">
									<param name=Sort                         value=True>
									<param name=ListExprFormat          value="MINORNM">       
									<param name=BindColumn              value="MINORCD"> 
								</object></comment><script>__ws__(__NSID__);</script>						
            			    </nobr>
						</td>  
						<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr>
						</td>  
			</tr>
		</table>		
	</td>
  </tr>
  
  <tr> 
  <td height=3></td>
  </tr>  

  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
								<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  	style="WIDTH: 630px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
										<PARAM NAME="DataID"		  VALUE="gcds_data">
										<PARAM NAME="Editable"    VALUE="false">
										<PARAM NAME="BorderStyle" VALUE="0">
										<param name="Fillarea"		VALUE="true">
										<PARAM NAME="Format"		  VALUE="  
										<C> Name='고과년월' ID=EVAYM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60   align=left, show=false </C>
										<C> Name='부문' ID=DIVCD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60   align=left, EditStyle=Lookup, Data='gcds_divcd:MINORCD:MINORNM' </C> 
										<C> Name='직군' ID=JOBGRPH 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=left, EditStyle=Lookup, Data='gcds_jobgrphcd:MINORCD:MINORNM' </C> 
										<C> Name='항목구분' ID=GRPITEM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=left, EditStyle=Lookup, Data='gcds_samp:MINORCD:MINORNM' </C>  
										<C> Name='순번' ID=PRTSEQ HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=RIGHT Edit=Numeric   </C>
										<C> Name='평가요소' ID=ASKITEM HeadAlign=Center HeadBgColor=#B9D4DC Width=225 align=LEFT </C>
										<C> Name='탁월' ID=ESCR HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=RIGHT Edit=realNumeric  Dec=2 </C>
										<C> Name='우수' ID=GSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=RIGHT   Edit=Numeric  Dec=2 </C>
										<C> Name='보통' ID=MSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=RIGHT   Edit=Numeric  Dec=2</C>
										<C> Name='부족' ID=LSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=RIGHT   Edit=Numeric   Dec=2</C>
										<C> Name='문제' ID=PSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=RIGHT   Edit=Numeric   Dec=2</C>
										">
                </OBJECT></comment><script>__ws__(__NSID__);</script>
				</td>
		  <td width=3>
		  </td>
		  <td >
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0      
					style='width:243px;height:422px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>

					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" 	bgcolor="#B9D4DC"><nobr>&nbsp;일괄생성 </nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yymm3                
										classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
			         	    style=" position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt; "
										validFeatures="ignoreStatus=yes" validExp=""> 
										<param name=Text          value="">
										<param name=Alignment	  value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=PromptChar	  value="_">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>	&nbsp; </nobr> 
						<img src="../../Common/img/btn/com_b_total.gif" style="position:relative; top:1px; cursor:hand" onclick="ln_Batch()">
						</td>
					</tr>


					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" 	bgcolor="#eeeeee"><nobr>&nbsp;고과년월</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcem_yymm2                
										classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
			         	    style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt; " > 
										<param name=Text          value="">
										<param name=Alignment	    value=0>
										<param name=Border	      value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>	&nbsp;</nobr>
						</td>
					</tr>

					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;&nbsp;&nbsp;직급</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_grpcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
									<param name=ComboDataID           value=gcds_grpcd2>
									<param name=SearchColumn          value="MINORNM">
									<param name=Sort                         value=True>
									<param name=ListExprFormat          value="MINORNM">       
									<param name=BindColumn              value="MINORCD"> 
								</object></comment><script>__ws__(__NSID__);</script>		&nbsp;</nobr>
							</td>
             </tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;&nbsp;&nbsp;부문</nobr></td>
						<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_divcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
									<param name=ComboDataID           value=gcds_divcd>
									<param name=SearchColumn          value="MINORNM">
									<param name=Sort                         value=True>
									<param name=ListExprFormat          value="MINORNM">       
									<param name=BindColumn              value="MINORCD"> 
							</object></comment><script>__ws__(__NSID__);</script>	&nbsp;</nobr>
							</td>
            </tr>
						<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;&nbsp;&nbsp;직군</nobr></td>
								<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gclx_jobgrphcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=100 width=120>
									<param name=ComboDataID           value=gcds_jobgrphcd>
									<param name=SearchColumn          value="MINORNM">
									<param name=Sort                         value=True>
									<param name=ListExprFormat          value="MINORNM">       
									<param name=BindColumn              value="MINORCD"> 
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
							</td>
             </tr>
						<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;항목구분</td>
								<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gclx_grpitemcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=150 width=120>
		<!--									<param name=ComboDataID	value=gcds_grpitemcd>-->
                      <param name=ComboDataID	value=gcds_grpitemcd>
											<param name=SearchColumn          value="MINORNM">
											<param name=Sort                         value=True>
											<param name=ListExprFormat          value="MINORNM">       
											<param name=BindColumn              value="MINORCD"> 
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
               </tr>
						<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;&nbsp;&nbsp;순번</td>
								<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_prtseq   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:20px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=ClipMode	      value=true>
										<param name=Numeric	      value=true>
										<param name=Format	      value="">
										<param name=MaxLength     value=2>
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
						</tr>
						<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;평가요소</td>      
								<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<input id="txt_askitem" name="txt_askitem" type="text"  class="txt21" style="position:relative; left:-5px;width:150px;" maxlength=34 >&nbsp;</nobr>
								</td>
             </tr>
						<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;&nbsp;&nbsp;탁월</td>                        
								<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_escr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
																		<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td>
               </tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;&nbsp;&nbsp;우수</td>                    
								<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_gscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
              </tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;&nbsp;&nbsp;보통</td>                      
								<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_mscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
              </tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;&nbsp;&nbsp;부족</td>                        
								<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_lscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
              </tr>
						<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee">&nbsp;&nbsp;&nbsp;문제</td>                        
								<td  Style="height:30px;border:0 solid #708090;border-bottom-width:0px"><nobr>&nbsp;
									<comment id="__NSID__"><object id=gcem_pscr   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="border:0 solid #eeeeee; border-width:1px;position:relative; left:1px;top:1px; width:30px; height:18px; font-family:굴림;
										font-size:9pt; " 		validFeatures="ignoreStatus=yes" validExp=""  >
										<param name=Text          value="">
										<param name=Alignment	  value=2>
										<param name=Border	      value=false>
										<param name=Numeric	      value=true>
										<param name=MaxLength     value=2>
										<param name=MaxDecimalPlace   value=2>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
								</td>
             </tr>
				</table>
  		  </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
		<td height="24">조회건수 : <label id="lbl_search"></label></td>
  </tr>	

</table>

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=ActiveBind value=true>
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
    <C>Col=EVAYM           Ctrl=gcem_yymm2        Param=text</C>
    <C>Col=GRPCD          Ctrl=gclx_grpcd2           Param=BindColVal</C>
		<C>Col=DIVCD           Ctrl=gclx_divcd            Param=BindColVal</C>
		<C>Col=JOBGRPH       Ctrl=gclx_jobgrphcd      Param=BindColVal</C>
		<C>Col=PRTSEQ         Ctrl=gcem_prtseq         Param=text</C>
		<C>Col=GRPITEM       Ctrl=gclx_grpitemcd      Param=BindColVal</C>
		<C>Col=ASKITEM       Ctrl=txt_askitem           Param=value</C>
		<C>Col=ESCR            Ctrl=gcem_escr          Param=text</C>
		<C>Col=GSCR            Ctrl=gcem_gscr          Param=text</C>
		<C>Col=MSCR            Ctrl=gcem_mscr         Param=text</C>
		<C>Col=LSCR             Ctrl=gcem_lscr          Param=text</C>
		<C>Col=PSCR             Ctrl=gcem_pscr         Param=text</C>
	 '>
	</object></comment><script>__ws__(__NSID__);</script>

<!-- / ******************************************************************************
 	        Description : Report 
        ************************************************************************************-->

<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_param">
	<PARAM NAME="DetailDataID"			VALUE="gcds_data">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=144 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='인사고과 평가요소별 배점표' ,left=0 ,top=22 ,right=1975 ,bottom=137 ,face='HY견고딕' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2653 ,face='굴림' ,size=10 ,penwidth=1
	<T>id='1.능력고과' ,left=6 ,top=0 ,right=275 ,bottom=66 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='EVAYM', left=16, top=84, right=316, bottom=162</C>
</B>

	">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>



