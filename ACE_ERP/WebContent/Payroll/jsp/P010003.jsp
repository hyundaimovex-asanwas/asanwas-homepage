
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	호봉표관리
+ 프로그램 ID	: p010003
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: p010003_s1, p010003_t1
------------------------------------------------------------------------------>
 
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>호봉표관리</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>


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
 gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7);


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Luxequery();								//공통코드

	gcem_stdym.enable = false;		//기준년월
	gclx_paygrd.enable = false;		//직위
	gclx_cddiv.enable = false;		//구분
	gcem_stdym1.Text=gs_date;

	//ln_EmeditEnable();					//호봉 ALL - Enable=False

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	var str1 = gcem_stdym1.text;
	var str2 = gclx_cddiv1.BindColVal;

	gcds_pay.DataID ="<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010003_s1?v_str1="+fn_trim(str1)+"&v_str2="+fn_trim(str2);
//prompt('',gcds_pay.DataID);
	gcds_pay.Reset();

	gcem_stdym.enable = false;		//기준년월
	gclx_paygrd.enable = false;		//직위
	gclx_cddiv.enable = false;		//구분

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

	if (gcds_pay.Countrow<=0) { return false; }

	gcds_pay.addrow();

	gcem_stdym.enable = true;			//기준년월
	gclx_paygrd.enable = true;		//직위
	gclx_cddiv.enable = true;			//구분

	gclx_paygrd.index = 0;
	gclx_cddiv.index = 0;

	ln_EmeditEnable2();						//호봉 ALL - Enable=true

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){  

	if (!ln_Valchk()) return;

	if (gcds_pay.sysStatus(gcds_pay.rowposition) == '1') {
				
		ln_DataSave();

		if (gcds_pay2.IsUpdated) {
				//prompt('pay2',gcds_pay2.text);
			if (confirm("입력하신 사항을 등록하시겠습니까?")){
				gctr_pay.KeyValue = "p010003_t1(I:USER=gcds_pay2)";
				gctr_pay.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010003_t1?v_str1=I";
				gctr_pay.post();
				ln_Query();
			}
		}
	}else {

		ln_DataSave3();

		if (gcds_pay3.IsUpdated) {	
			//prompt('pay3',gcds_pay3.text);
			if (confirm("입력하신 사항을 등록하시겠습니까?")){
				gctr_pay.KeyValue = "p010003_t1(I:USER=gcds_pay3)";
				gctr_pay.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010003_t1?v_str1=U";
				gctr_pay.post();
				ln_Query();
			}
		}
	}
}

/******************************************************************************
	Description : Data 저장
******************************************************************************/
function ln_DataSave(){  

	var THeader = "STDYM:String(6),CDDIV:String(1),PAYGRD:String(4),PAYSEQ:String(4),AMT:Decimal(9.0)";

	gcds_pay2.SetDataHeader(THeader);								//Header Set

	for(j=1;j<=gcds_pay.countrow;j++) {  //17
	
	var aa = gcds_pay.namevalue(j,"STDYM");
	var bb = gcds_pay.namevalue(j,"CDDIV");
	var cc = gcds_pay.namevalue(j,"PAYGRD");

		var j_row= 40*(j-1)+1;
		var i_40 = 0;

		for(i=j_row;i<=j_row+40;i++) {
			
			i_40 = i_40 + 1;

			if (i_40 < 41) {
			
			gcds_pay2.addrow();
			
			gcds_pay2.namevalue(i,"STDYM")	= aa;	//gcds_pay.namevalue(j,"STDYM");
			gcds_pay2.namevalue(i,"CDDIV")	= bb;	//gcds_pay.namevalue(j,"CDDIV");
			gcds_pay2.namevalue(i,"PAYGRD") = cc;	//gcds_pay.namevalue(j,"PAYGRD");
			gcds_pay2.namevalue(i,"PAYSEQ") = i_40;
			gcds_pay2.namevalue(i,"AMT")		= gcds_pay.namevalue(j,"PAYSEQ_"+i_40);
			}
		}
	}
}

/******************************************************************************
	Description : Data 수정사항 저장
******************************************************************************/
function ln_DataSave3(){

	var THeader = "STDYM:String(6),CDDIV:String(1),PAYGRD:String(4),PAYSEQ:String(4),AMT:Decimal(9.0)";

	gcds_pay3.SetDataHeader(THeader);								//Header Set

	for(j=1;j<=gcds_pay.countrow;j++) {  //17
	
	var v_stdym = gcds_pay.namevalue(j,"STDYM");
	var v_cddiv = gcds_pay.namevalue(j,"CDDIV");
	var v_paygrd = gcds_pay.namevalue(j,"PAYGRD");

		var j_row= 40*(j-1)+1;
		var i_40 = 0;

		for(i=j_row;i<=j_row+40;i++) {
			
			i_40 = i_40 + 1;

			if (i_40 < 41) {
			
			gcds_pay3.addrow();
			
			gcds_pay3.namevalue(i,"STDYM")	= v_stdym;	//gcds_pay.namevalue(j,"STDYM");
			gcds_pay3.namevalue(i,"CDDIV")	= v_cddiv;	//gcds_pay.namevalue(j,"CDDIV");
			gcds_pay3.namevalue(i,"PAYGRD") = v_paygrd;	//gcds_pay.namevalue(j,"PAYGRD");
			gcds_pay3.namevalue(i,"PAYSEQ") = i_40;
			gcds_pay3.namevalue(i,"AMT")		= gcds_pay.namevalue(j,"PAYSEQ_"+i_40);
			}
		}
	}	
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete() {

	if (confirm("선택한 정보를 삭제하시겠습니까?")){
//	prompt('',gcds_pay.text);
		gcds_pay.deleterow(gcds_pay.rowposition);
		gctr_pay.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p010003_t1";
		gctr_pay.post();
		ln_Query();
	}

}

/******************************************************************************
	Description : Data 삭제
******************************************************************************/
function ln_DataDel() {

	ln_DataSave();

	var Status = "";

	for(var i=1;i<=40;i++) {
		Status +=  "\n[" + i + "] " + "Row UserStatus = " + gcds_pay2.UserStatus(2);
		gcds_pay2.UserStatus(i) = 2;
	}

}

/******************************************************************************
	Description : Data 삭제 2
******************************************************************************/
function ln_DataDel2() {

	for (i=1;i<=40;i++) {
		gcds_pay2.namevalue(i,"STDYM")	= gcds_pay.namevalue(gcds_pay.rowposition,"STDYM");
		gcds_pay2.namevalue(i,"CDDIV")	= gcds_pay.namevalue(gcds_pay.rowposition,"CDDIV");
		gcds_pay2.namevalue(i,"PAYGRD") = gcds_pay.namevalue(gcds_pay.rowposition,"PAYGRD");
		gcds_pay2.namevalue(i,"PAYSEQ") = i;
		gcds_pay2.namevalue(i,"AMT")		= gcds_pay.namevalue(gcds_pay.rowposition,"PAYSEQ_"+i);

		gcds_pay2.deleterow(i);

	}
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
	Description : 파일열기
******************************************************************************/
function ln_File(){

	var str1=gcem_stdym.Text;	//기준년월
	
	gcif_file.Open();

	var str2=fn_trim(gcif_file.Value);										//open file
	var str3=str2.substr(str2.length-3,3).toLowerCase();	//확장자 추출

	if(str2=="") {
		alert("파일을 선택하세요");
	} else if(str3 !="csv")	{
	  gcif_file.Value="";
		alert("CSV확장자 파일을 선택하세요");
	//}	else if(str1.length != 6) {
	//	alert("기준년월을 6자리를 정확히 입력하세요");
	}else{
		ln_File_1();
	}
}

/******************************************************************************
	Description : 데이터 임포트
******************************************************************************/
function ln_File_1(){

	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";

	var THeader = "STDYM:String(6),"	
							+	"CDDIV1:String(30),"   
							+	"CDDIV:String(1),"   
							+	"PAYGRD1:String(30),"
							+	"PAYGRD:String(4),"   
							+	"PAYSEQ_1:Decimal(9.0),"
							+	"PAYSEQ_2:Decimal(9.0),"
							+	"PAYSEQ_3:Decimal(9.0),"
							+	"PAYSEQ_4:Decimal(9.0),"
							+	"PAYSEQ_5:Decimal(9.0),"
							+	"PAYSEQ_6:Decimal(9.0),"
							+	"PAYSEQ_7:Decimal(9.0),"
							+	"PAYSEQ_8:Decimal(9.0),"
							+	"PAYSEQ_9:Decimal(9.0),"
							+	"PAYSEQ_10:Decimal(9.0),"
							+	"PAYSEQ_11:Decimal(9.0),"
							+	"PAYSEQ_12:Decimal(9.0),"
							+	"PAYSEQ_13:Decimal(9.0),"
							+	"PAYSEQ_14:Decimal(9.0),"
							+	"PAYSEQ_15:Decimal(9.0),"
							+	"PAYSEQ_16:Decimal(9.0),"
							+	"PAYSEQ_17:Decimal(9.0),"
							+	"PAYSEQ_18:Decimal(9.0),"
							+	"PAYSEQ_19:Decimal(9.0),"
							+	"PAYSEQ_20:Decimal(9.0),"
							+	"PAYSEQ_21:Decimal(9.0),"
							+	"PAYSEQ_22:Decimal(9.0),"
							+	"PAYSEQ_23:Decimal(9.0),"
							+	"PAYSEQ_24:Decimal(9.0),"
							+	"PAYSEQ_25:Decimal(9.0),"
							+	"PAYSEQ_26:Decimal(9.0),"
							+	"PAYSEQ_27:Decimal(9.0),"
							+	"PAYSEQ_28:Decimal(9.0),"
							+	"PAYSEQ_29:Decimal(9.0),"
							+	"PAYSEQ_30:Decimal(9.0),"
							+	"PAYSEQ_31:Decimal(9.0),"
							+	"PAYSEQ_32:Decimal(9.0),"
							+	"PAYSEQ_33:Decimal(9.0),"
							+	"PAYSEQ_34:Decimal(9.0),"
							+	"PAYSEQ_35:Decimal(9.0),"
							+	"PAYSEQ_36:Decimal(9.0),"
							+	"PAYSEQ_37:Decimal(9.0),"
							+	"PAYSEQ_38:Decimal(9.0),"
							+	"PAYSEQ_39:Decimal(9.0),"
							+	"PAYSEQ_40:Decimal(9.0)";

	gcds_temp.DataID = gcif_file.Value;
	gcds_temp.Reset();

	gcds_pay.SyncLoad=true;
	gcds_pay.ClearAll();
	gcgd_pay.DataID = "";

	gcds_pay.SetDataHeader(THeader);								//Header Set

	var row = gcds_pay.rowposition;
	var ls_pd = gcem_stdym.Text;

	for(var j=1;j<=gcds_temp.countrow;j++) {
			
			gcds_pay.addrow();
	
			var ls_pos = gcds_pay.rowposition;

			for (var i=1; i<46; i++) {
				
				gcds_txt=fn_trim(gcds_temp.ColumnValue(j,i));

				gcds_txt=ln_Ltrim(gcds_txt,",");
				gcds_pay.ColumnValue(ls_pos,i) = gcds_txt;
			
			}
	}

	window.status="조회가 완료 되었습니다."; 
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "조회건수 : " + gcds_pay.countrow + " 건";
	if (gcds_pay.countrow <1) alert("검색된 데이터가 없습니다.");

	gcgd_pay.DataID = "gcds_pay";
	gcds_pay.SyncLoad=false;
	gcif_file.Value="";

}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Ltrim(src,arg) {
	if(src != undefined)
	{
	var li_chk = src.length/4+1;
	var ls_val = src;
	for (var i=1; i<=li_chk; i++)	ls_val = ls_val.replace(arg,"");
	return ls_val;
	}
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

	if (gcds_pay.countrow<1) { 
		alert("다운로드하실 자료가 없습니다."); 
	} else {
		gcgd_pay.RunExcel('호봉표관리');
	}
	
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Valchk(){

	if (gcem_stdym.text == "") {
		alert("정확한 기준년월를 입력해 주십시오.");
		gcem_stdym.Focus();
		return false;
	}
	
	return true;

}

/******************************************************************************
	Description : 호봉 비활성
******************************************************************************/
function ln_EmeditEnable() { 

	gcem_1ho.enable = false;
	gcem_2ho.enable = false;
	gcem_3ho.enable = false;
	gcem_4ho.enable = false;
	gcem_5ho.enable = false;
	gcem_6ho.enable = false;
	gcem_7ho.enable = false;
	gcem_8ho.enable = false;
	gcem_9ho.enable = false;
	gcem_10ho.enable = false;
	gcem_11ho.enable = false;
	gcem_12ho.enable = false;
	gcem_13ho.enable = false;
	gcem_14ho.enable = false;
	gcem_15ho.enable = false;
	gcem_16ho.enable = false;
	gcem_17ho.enable = false;
	gcem_18ho.enable = false;
	gcem_19ho.enable = false;
	gcem_20ho.enable = false;
	gcem_21ho.enable = false;
	gcem_22ho.enable = false;
	gcem_23ho.enable = false;
	gcem_24ho.enable = false;
	gcem_25ho.enable = false;
	gcem_26ho.enable = false;
	gcem_27ho.enable = false;
	gcem_28ho.enable = false;
	gcem_29ho.enable = false;
	gcem_30ho.enable = false;
	gcem_31ho.enable = false;
	gcem_32ho.enable = false;
	gcem_33ho.enable = false;
	gcem_34ho.enable = false;
	gcem_35ho.enable = false;
	gcem_36ho.enable = false;
	gcem_37ho.enable = false;
	gcem_38ho.enable = false;
	gcem_39ho.enable = false;
	gcem_40ho.enable = false;

}

/******************************************************************************
	Description : 호봉 비활성
******************************************************************************/
function ln_EmeditEnable2() { 

	gcem_1ho.enable = true;
	gcem_2ho.enable = true;
	gcem_3ho.enable = true;
	gcem_4ho.enable = true;
	gcem_5ho.enable = true;
	gcem_6ho.enable = true;
	gcem_7ho.enable = true;
	gcem_8ho.enable = true;
	gcem_9ho.enable = true;
	gcem_10ho.enable = true;
	gcem_11ho.enable = true;
	gcem_12ho.enable = true;
	gcem_13ho.enable = true;
	gcem_14ho.enable = true;
	gcem_15ho.enable = true;
	gcem_16ho.enable = true;
	gcem_17ho.enable = true;
	gcem_18ho.enable = true;
	gcem_19ho.enable = true;
	gcem_20ho.enable = true;
	gcem_21ho.enable = true;
	gcem_22ho.enable = true;
	gcem_23ho.enable = true;
	gcem_24ho.enable = true;
	gcem_25ho.enable = true;
	gcem_26ho.enable = true;
	gcem_27ho.enable = true;
	gcem_28ho.enable = true;
	gcem_29ho.enable = true;
	gcem_30ho.enable = true;
	gcem_31ho.enable = true;
	gcem_32ho.enable = true;
	gcem_33ho.enable = true;
	gcem_34ho.enable = true;
	gcem_35ho.enable = true;
	gcem_36ho.enable = true;
	gcem_37ho.enable = true;
	gcem_38ho.enable = true;
	gcem_39ho.enable = true;
	gcem_40ho.enable = true;

}

/******************************************************************************
	Description : 공통코드 조회
******************************************************************************/
function ln_Luxequery() { 

	//직위코드
	gcds_paycd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002"; 
	gcds_paycd1.Reset();

	//구분
	gcds_paycd2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2018"; 
	gcds_paycd2.Reset();

	//구분[검색]
	gcds_paycd3.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2018"; 
	gcds_paycd3.Reset();

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_pay" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+PAYGRD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_pay2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_pay3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_paycd1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--직위-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_paycd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--구분-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_paycd3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--구분[검색]-->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_temp" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pay classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p010003_t1(I:USER=gcds_pay)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pay" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_pay" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>
<script language="javascript" for="gcds_pay" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_pay" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_pay.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>
<script language="javascript" for="gcds_pay2" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_pay2" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_pay2.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</head>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/p010003_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_file.gif"	style="cursor:hand" onclick="ln_File()">
			<img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee" class="txtbox" >
						<nobr>&nbsp;구&nbsp;분&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;" ><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_cddiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=102 style="position:relative;top:3px;left:3" class="txtbox">
								<param name=ComboDataID			value=gcds_paycd3>
								<param name=SearchColumn		value="MINORCD^MINORNM">
								<param name=Sort            value="TRUE">
								<param name=SortColumn			value="MINORCD">
								<param name=ListExprFormat	value="MINORNM">
								<param name=BindColumn			value="MINORCD">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:23px;border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
							<nobr>&nbsp;기준년월&nbsp;</nobr></td>
								<td style="height:23px;border:0 solid #708090;border-bottom-width:0px" align=center><nobr>
									<comment id="__NSID__"><object id=gcem_stdym1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:50px; height:20px;" class="txtbox" validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment			value=0>
										<param name=Border	      value=True>
										<param name=ClipMode			value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=MaxLength     value=6>
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									
									<comment id="__NSID__"><object id=gcif_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
										<param name="Text"		value='찾아보기'>
										<param name="Enable"	value="True">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
						<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
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
							<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pay style="WIDTH:443px;HEIGHT:420px;border:1 solid #777777;display:block;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_pay">
								<PARAM NAME="Editable"		VALUE="FALSE">
								<PARAM NAME="BorderStyle" VALUE="0">
								<param name="Fillarea"		VALUE="true">
								<param name=Numeric       value=true>
								<param name=IsComma				value=true><!--기준년월 : Mask='XXXX/XX'   -->
								<PARAM NAME="Format"			VALUE="  
									<F> Name='기준년월'	ID=STDYM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	 align=CENTER		BgColor='#f5f5f5' </F>
									<F> Name='구분'			ID=CDDIV  		HeadAlign=Center HeadBgColor=#B9D4DC Width=86	 align=LEFT			BgColor='#f5f5f5' Data='gcds_paycd2:MINORCD:MINORNM' EditStyle=Lookup</F>
									<F> Name='구분코드'	ID=CDDIV  		HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=LEFT			BgColor='#f5f5f5' SHOW=FALSE</F>
									<F> Name='직위'			ID=PAYGRD  		HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=LEFT			BgColor='#f5f5f5' Data='gcds_paycd1:MINORCD:MINORNM' EditStyle=Lookup</F> 
									<F> Name='직위'			ID=PAYGRD  		HeadAlign=Center HeadBgColor=#B9D4DC Width=86  align=LEFT			BgColor='#f5f5f5' SHOW=FALSE</F> 
									<C> Name='1호봉'		ID=PAYSEQ_1		HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='2호봉'		ID=PAYSEQ_2  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='3호봉'		ID=PAYSEQ_3  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='4호봉'		ID=PAYSEQ_4  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='5호봉'		ID=PAYSEQ_5  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='6호봉'		ID=PAYSEQ_6  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='7호봉'		ID=PAYSEQ_7  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='8호봉'		ID=PAYSEQ_8  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='9호봉'		ID=PAYSEQ_9  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='10호봉'		ID=PAYSEQ_10 	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='11호봉'		ID=PAYSEQ_11 	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='12호봉'		ID=PAYSEQ_12 	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='13호봉'		ID=PAYSEQ_13	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='14호봉'		ID=PAYSEQ_14	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='15호봉'		ID=PAYSEQ_15	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='16호봉'		ID=PAYSEQ_16	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='17호봉'		ID=PAYSEQ_17	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='18호봉'		ID=PAYSEQ_18	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='19호봉'		ID=PAYSEQ_19	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='20호봉'		ID=PAYSEQ_20	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='21호봉'		ID=PAYSEQ_21	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='22호봉'		ID=PAYSEQ_22	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='23호봉'		ID=PAYSEQ_23	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='24호봉'		ID=PAYSEQ_24	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='25호봉'		ID=PAYSEQ_25	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='26호봉'		ID=PAYSEQ_26	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='27호봉'		ID=PAYSEQ_27	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='28호봉'		ID=PAYSEQ_28	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='29호봉'		ID=PAYSEQ_29	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='30호봉'		ID=PAYSEQ_30	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='31호봉'		ID=PAYSEQ_31	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='32호봉'		ID=PAYSEQ_32	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='33호봉'		ID=PAYSEQ_33	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='34호봉'		ID=PAYSEQ_34	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='35호봉'		ID=PAYSEQ_35	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='36호봉'		ID=PAYSEQ_36	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='37호봉'		ID=PAYSEQ_37	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='38호봉'		ID=PAYSEQ_38	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C> 
									<C> Name='39호봉'		ID=PAYSEQ_39	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C>
									<C> Name='40호봉'		ID=PAYSEQ_40	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C>
									">
				 </OBJECT></comment><script>__ws__(__NSID__);</script>
						
							<fieldset id=ft_div1 style="width:445px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
								<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
							</fieldset>
						
						</td>
						<td width=3></td>
						<td>

              <table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:375px;height:25px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
								<tr>
                  <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;기준년월</nobr></td>
									<td style="width:70px;height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff">
										<nobr>&nbsp;
										<comment id="__NSID__"><object id=gcem_stdym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:50px; height:20px;" class="txtbox" validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment			value=0>
											<param name=Border	      value=True>
											<param name=ClipMode			value=true>
											<param name=Numeric	      value=false>
											<param name=Format	      value="YYYY/MM">
											<param name=MaxLength     value=6>
											<param name=PromptChar	  value="_">
											<param name=IsComma	      value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td> 
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-bottom-width:0px"  bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;직&nbsp;위&nbsp;</nobr></td>
									<td style="width:90px;height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-bottom-width:0px"  align=center><nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=108 style="position:relative;top:3px;left:-5" class="txtbox">
											<param name=ComboDataID			value=gcds_paycd1>
											<param name=SearchColumn		value="MINORCD^MINORNM">
											<param name=Sort            value="TRUE">
											<param name=SortColumn			value="MINORCD">
											<param name=ListExprFormat	value="MINORNM">
											<param name=BindColumn			value="MINORCD">
										</object></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;구&nbsp;분&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:0px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gclx_cddiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=100 style="position:relative;top:3px;left:3" class="txtbox">
											<param name=ComboDataID			value=gcds_paycd2>
											<param name=SearchColumn		value="MINORCD^MINORNM">
											<param name=Sort            value="TRUE">
											<param name=SortColumn			value="MINORCD">
											<param name=ListExprFormat	value="MINORNM">
											<param name=BindColumn			value="MINORCD">
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td>
                </tr>
							</table>

							<table border=0><tr><td height=1></td></tr></table>

							<table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:363px;height:410px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>		
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >
										<nobr>1호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>&nbsp;
										<comment id="__NSID__"><object id=gcem_1ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px"  align=center bgcolor="#eeeeee" class="txtbox" >
										<nobr>&nbsp;&nbsp;2호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;
										<comment id="__NSID__"><object id=gcem_2ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px"  align=center bgcolor="#eeeeee" class="txtbox">
										<nobr>&nbsp;&nbsp;3호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;
										<comment id="__NSID__"><object id=gcem_3ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;top:1px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>&nbsp;
										</nobr>
									</td>
                </tr>
								<tr>
                  <td  style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox" align=center>
										<nobr>4호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_4ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox">
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox" align=center>
										<nobr>&nbsp;5호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_5ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;6호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_6ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;7호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_7ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;8호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_8ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;9호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_9ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>10호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_10ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;11호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_11ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;12호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_12ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>13호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_13ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;14호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_14ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</nobr>	
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;15호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_15ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</nobr>	
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>16호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_16ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;17호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_17ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;18호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_18ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>19호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_19ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</nobr>	
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;20호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_20ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
									</nobr>	
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;21호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_21ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>22호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_22ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;23호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_23ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;24호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_24ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>25호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_25ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;26호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_26ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;27호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_27ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>28호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_28ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;29호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_29ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;30호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_30ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>31호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_31ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;32호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_32ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;33호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_33ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>34호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_34ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;35호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_35ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;36호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_36ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>37호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_37ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;38호봉&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><object id=gcem_38ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:-6px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;39호봉&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>
										<comment id="__NSID__"><object id=gcem_39ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:0px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
                </tr>





								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>40호봉</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff">
										<nobr>
										<comment id="__NSID__"><object id=gcem_40ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:75px;position:relative;left:5px;" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</nobr>
										</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:0px" align=center>
										<nobr>&nbsp;&nbsp;
										</nobr>
									</td>
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px" align=center>
										<nobr>&nbsp;
										</nobr>
									</td>
                </tr>




				
				</table>
  					</td>
					</tr>
				</table>
			</td>
		</tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcbn_pyo classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_pay>
	<param name=BindInfo  value='
		<C>Col=STDYM				Ctrl=gcem_stdym       Param=text</C>
		<C>Col=PAYGRD				Ctrl=gclx_paygrd      Param=BindColVal</C>
		<C>Col=CDDIV				Ctrl=gclx_cddiv				Param=BindColVal</C>
		<C>Col=PAYSEQ_1			Ctrl=gcem_1ho					Param=text</C>
		<C>Col=PAYSEQ_2 		Ctrl=gcem_2ho					Param=text</C>
		<C>Col=PAYSEQ_3 		Ctrl=gcem_3ho					Param=text</C>
		<C>Col=PAYSEQ_4 		Ctrl=gcem_4ho					Param=text</C>
		<C>Col=PAYSEQ_5 		Ctrl=gcem_5ho					Param=text</C>
		<C>Col=PAYSEQ_6 		Ctrl=gcem_6ho					Param=text</C>
		<C>Col=PAYSEQ_7 		Ctrl=gcem_7ho					Param=text</C>
		<C>Col=PAYSEQ_8 		Ctrl=gcem_8ho					Param=text</C>
		<C>Col=PAYSEQ_9 		Ctrl=gcem_9ho					Param=text</C>
		<C>Col=PAYSEQ_10		Ctrl=gcem_10ho				Param=text</C>
		<C>Col=PAYSEQ_11		Ctrl=gcem_11ho				Param=text</C>
		<C>Col=PAYSEQ_12		Ctrl=gcem_12ho				Param=text</C>
		<C>Col=PAYSEQ_13		Ctrl=gcem_13ho				Param=text</C>
		<C>Col=PAYSEQ_14		Ctrl=gcem_14ho				Param=text</C>
		<C>Col=PAYSEQ_15		Ctrl=gcem_15ho				Param=text</C>
		<C>Col=PAYSEQ_16		Ctrl=gcem_16ho				Param=text</C>
		<C>Col=PAYSEQ_17		Ctrl=gcem_17ho				Param=text</C>
		<C>Col=PAYSEQ_18		Ctrl=gcem_18ho				Param=text</C>
		<C>Col=PAYSEQ_19		Ctrl=gcem_19ho				Param=text</C>
		<C>Col=PAYSEQ_20		Ctrl=gcem_20ho				Param=text</C>
		<C>Col=PAYSEQ_21		Ctrl=gcem_21ho				Param=text</C>
		<C>Col=PAYSEQ_22		Ctrl=gcem_22ho				Param=text</C>
		<C>Col=PAYSEQ_23		Ctrl=gcem_23ho				Param=text</C>
		<C>Col=PAYSEQ_24		Ctrl=gcem_24ho				Param=text</C>
		<C>Col=PAYSEQ_25		Ctrl=gcem_25ho				Param=text</C>
		<C>Col=PAYSEQ_26		Ctrl=gcem_26ho				Param=text</C>
		<C>Col=PAYSEQ_27		Ctrl=gcem_27ho				Param=text</C>
		<C>Col=PAYSEQ_28		Ctrl=gcem_28ho				Param=text</C>
		<C>Col=PAYSEQ_29		Ctrl=gcem_29ho				Param=text</C>
		<C>Col=PAYSEQ_30		Ctrl=gcem_30ho				Param=text</C>
		<C>Col=PAYSEQ_31		Ctrl=gcem_31ho				Param=text</C>
		<C>Col=PAYSEQ_32		Ctrl=gcem_32ho				Param=text</C>
		<C>Col=PAYSEQ_33		Ctrl=gcem_33ho				Param=text</C>
		<C>Col=PAYSEQ_34		Ctrl=gcem_34ho				Param=text</C>
		<C>Col=PAYSEQ_35		Ctrl=gcem_35ho				Param=text</C>
		<C>Col=PAYSEQ_36		Ctrl=gcem_36ho				Param=text</C>
		<C>Col=PAYSEQ_37		Ctrl=gcem_37ho				Param=text</C>
		<C>Col=PAYSEQ_38		Ctrl=gcem_38ho				Param=text</C>
		<C>Col=PAYSEQ_39		Ctrl=gcem_39ho				Param=text</C>
		<C>Col=PAYSEQ_40		Ctrl=gcem_40ho				Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



