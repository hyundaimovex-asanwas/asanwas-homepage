<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: H020002.HTML
+ 기 능 정 의	: 조회,저장
+ 변 경 이 력	: 
+ 서 블 릿 명	: hclcode_s1, h020002_s3, h020002_s4, h020002_s5, h020002_s6,
								h020002_s7, h020002_s8, h020002_s9, h020002_t1
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Sales/Common/include/head.jsp"/>
<title>입사지원서접수</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/Common.css">

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
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

var report_format=""
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_SetHeader();

	ln_Before();
    ln_SerEdu(); 

	ln_SerMil();
	ln_SerFam();
    ln_SerLic(); 

	ln_SerEng();

	report_format=gcrp_print.format;
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	if (fn_trim(gcem_resino.text).length<13) {
		alert("정확한 주민번호를 입력해 주십시오");
	} else {
		gcds_data.DataID = "/servlet/Person.h020002_s3?"
										 + "v_str1=" + gcem_resino.text
										 + "&v_str2="+ gclx_info.BindColVal;
		//prompt("",gcds_data.DataID); 
		gcds_data.Reset();
	}
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(Obj,arg1){
	tmpObj=eval("document.all.gcgd"+Obj.id.toString().substring(4,Obj.id.toString().length));
	if(tmpObj.style.display=='none') ln_Disp(tmpObj);
	else Obj.AddRow();
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	gcds_hrself.namevalue(1,"INFODIV") = gclx_info.BindColVal;
	gcds_hrself.namevalue(1,"RESINO") = gcem_resino2.text;

	var ls_msg = "";
	var tfile = "";
	var tfilename = ""; 
	if (gcds_data.sysStatus(1)=="1") ls_msg = "입사지원서를 접수 하겠습니까 ?";
	else ls_msg = "입사지원서를 수정 하겠습니까 ?";

	if (gcds_data.IsUpdated || gcds_educ.IsUpdated || gcds_career.IsUpdated || gcds_family.IsUpdated || gcds_license.IsUpdated || gcds_hrself.IsUpdated) {
		if (!ln_Vchk()) return;
		if (confirm(ls_msg)){

	   /* gcds_hrself.namevalue(1,"GROWTH") =ln_Multiline_Text(fn_trim(txt_growth.value),139);
        gcds_hrself.namevalue(1,"SCHOOL")  =ln_Multiline_Text(fn_trim(txt_school.value),139);
        gcds_hrself.namevalue(1,"CAREER")  =ln_Multiline_Text(fn_trim(txt_career.value),139);
        gcds_hrself.namevalue(1,"AMBITION")=ln_Multiline_Text(fn_trim(txt_ambition.value),139)*/

			 
			if (gcds_data.sysStatus(1)=="1") {
				tfile = txt_file.value;
				tfilename = ln_Divide(txt_file.value, "\\");
				gcds_data.namevalue(1,"INFODIV") = gclx_info.BindColVal;
				gcds_data.namevalue(1,"PROSTS") = "1";
				gcds_data.namevalue(1,"WRDT") = gs_date;
				gcds_data.namevalue(1,"PHOTO") = tfilename;
				gcds_data.namevalue(1,"PICFILE") = tfile;
			} else {
				if (fn_trim(txt_file.value)!="") {
					tfile = txt_file.value;
					tfilename = ln_Divide(txt_file.value, "\\");
					gcds_data.namevalue(1,"PHOTO") = tfilename;
					gcds_data.namevalue(1,"PICFILE") = tfile;
				}
			}

			var strNm = new Array("gcds_educ","gcds_career","gcds_family","gcds_license");
			for (var k=0;k<strNm.length;k++) {
				for (var j=1;j<=eval(strNm[k]).countrow;j++){
					if (eval(strNm[k]).sysStatus(j)=="1") {
						var ls_seq1 = eval(strNm[k]).Max(3,0,eval(strNm[k]).countrow);
						var ls_seq2 = parseInt(ls_seq1)+1;

						eval(strNm[k]).namevalue(j,"INFODIV") = gclx_info.BindColVal;
						eval(strNm[k]).namevalue(j,"RESINO") = gcds_data.namevalue(1,"RESINO");
						eval(strNm[k]).namevalue(j,"SEQ") = ls_seq2;
					}
				}
			}

			gctr_data.Parameters = "v_str1=" + gclx_info.BindColVal;

			//prompt("",gcds_data.text);
			gctr_data.post();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(Obj){
	tmpObj=eval("document.all.gcgd"+Obj.id.toString().substring(4,Obj.id.toString().length));
	if(tmpObj.style.display=="none") ln_Disp(tmpObj);
	else	{
		if(Obj.sysStatus(Obj.RowPosition)=="1") Obj.undo(Obj.RowPosition);
		else if(confirm("선택한 데이타를 삭제하시겠습니까?"))	Obj.DeleteRow(Obj.RowPosition);
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
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 포멧 셋팅
******************************************************************************/
function ln_SetHeader(){
	//////////////////////////////////////////////////////////////////////////////////////////////
	//	채용기본
	//////////////////////////////////////////////////////////////////////////////////////////////
	var ls_ahtml = "";

	ls_ahtml += "INFODIV:STRING(6),RESINO:STRING(13),WRDT:STRING(8),WRNO:DECIMAL(5.0),NMK:STRING(30)  ";
	ls_ahtml += ",PHOTO:STRING(30),BIRDT:STRING(8),GLDIV:STRING(1),HOBBY:STRING(40),NMC:STRING(20)  ";
	ls_ahtml += ",RILIGN:STRING(4),NME:STRING(40),BIRCITY:STRING(4),SPECIAL:STRING(40),OZIPCD:STRING(6)  ";
	ls_ahtml += ",OADDR1:STRING(70),OADDR2:STRING(70),CZIPCD:STRING(6),CADDR1:STRING(70),CADDR2:STRING(70)  ";
	ls_ahtml += ",TELNO:STRING(15),HPNO:STRING(15),EMAIL:STRING(30),EYEL:DECIMAL(2.1),EYER:DECIMAL(2.1)  ";
	ls_ahtml += ",HEIGHT:DECIMAL(3.0),WEIGHT:DECIMAL(3.0),BLOOD:STRING(2),RGHANDYN:STRING(1),MILIDIV:STRING(4)  ";
	ls_ahtml += ",MILIKND:STRING(4),MILIGRD:STRING(4),MILINO:STRING(15),MILIPLC:STRING(30),MILIFRDT:STRING(8)  ";
	ls_ahtml += ",MILITODT:STRING(8),NMREASON:STRING(40),MRYDT:STRING(8),DISDIV:STRING(4),DISGRD:STRING(4)  ";
	ls_ahtml += ",MILITYPE:STRING(4),MRTDIV:STRING(2),MRTNO:STRING(20),REFCD:STRING(4),MILISPEC:STRING(4)  ";
	ls_ahtml += ",ENGLVL:STRING(1),TOESCR:DECIMAL(4.0),JPTSCR:DECIMAL(4.0),DELFSCR:DECIMAL(4.0),TOFSCR:DECIMAL(4.0)  ";
	ls_ahtml += ",DALFSCR:DECIMAL(4.0),TEPSSCR:DECIMAL(4.0),ETCLNG:STRING(50),HWGRDCD:STRING(1),EXGRDCD:STRING(1)  ";
	ls_ahtml += ",PWGRDCD:STRING(1),ACGRDCD:STRING(1),INTDT:STRING(8),INTTM:STRING(4),INTATTYN:STRING(1)  ";
	ls_ahtml += ",PASSDT:STRING(8),AMDT:STRING(8),EMPNO:STRING(6),AMKIND:STRING(2),LCSTYPE:STRING(4)  ";
	ls_ahtml += ",LCSCD:STRING(4),PROSTS:STRING(1),CARYEAR:DECIMAL(2.0),PICFILE:URL,HSKSCR:DECIMAL(4.0)";

	gcds_data.SetDataHeader(ls_ahtml);
	gcds_data.Addrow();

	//////////////////////////////////////////////////////////////////////////////////////////////
	//	학력
	//////////////////////////////////////////////////////////////////////////////////////////////
	var ls_ehtml = "";

	ls_ehtml += "INFODIV:STRING(6),RESINO:STRING(13),SEQ:DECIMAL(2.0),EDCCD:STRING(4),GRAYY:STRING(4)";
	ls_ehtml += ",SCHNM:STRING(60),CITY:STRING(40),PGCCD:STRING(4),EDCDIV:STRING(4),AVRUNI:DECIMAL(2.1) ";
	ls_ehtml += ",PERFECT:DECIMAL(2.1) ";
	
	gcds_educ.SetDataHeader(ls_ehtml);

	var ls_ehtml2 = "GRAYY:STRING(4),,SCHNM:STRING(60),EDCCD:STRING(30)";
	ls_ehtml2 += ",CITY:STRING(40),PGCCD:STRING(30),EDCDIV:STRING(30),AVRUNI:DECIMAL(2.1) ";
	ls_ehtml2 += ",PERFECT:DECIMAL(2.1) ";
	gcds_report01.SetDataHeader(ls_ehtml2); //학력보고서
	//////////////////////////////////////////////////////////////////////////////////////////////
	//	경력
	//////////////////////////////////////////////////////////////////////////////////////////////
	var ls_chtml = "";

	ls_chtml += "INFODIV:STRING(6),RESINO:STRING(13),SEQ:DECIMAL(2.0),FRDT:STRING(8),ENDDT:STRING(8)";
	ls_chtml += ",COMNM:STRING(50),POSINM:STRING(30),DUTYNM:STRING(60) ";
	
	gcds_career.SetDataHeader(ls_chtml);

	//////////////////////////////////////////////////////////////////////////////////////////////
	//	가족
	//////////////////////////////////////////////////////////////////////////////////////////////
	var ls_fhtml = "";

	ls_fhtml += "INFODIV:STRING(6),RESINO:STRING(13),SEQ:DECIMAL(2.0),REFCD:STRING(4),FAMNM:STRING(20)";
	ls_fhtml += ",RESINOF:STRING(13),SCHNM:STRING(40),CMPNM:STRING(100),LSTEDC:STRING(4) ";
	
	gcds_family.SetDataHeader(ls_fhtml);
	var ls_fhtml2 = "REFCD:STRING(30),FAMNM:STRING(20)";
	ls_fhtml2 += ",RESINOF:STRING(13),LSTEDC:STRING(30),CMPNM:STRING(100) ";
	gcds_report06.SetDataHeader(ls_fhtml2); //가족사항보고서


	//////////////////////////////////////////////////////////////////////////////////////////////
	//	자격/면허
	//////////////////////////////////////////////////////////////////////////////////////////////
	var ls_lhtml = "";

	ls_lhtml += "INFODIV:STRING(6),RESINO:STRING(13),SEQ:DECIMAL(2.0),LCSTYPE:STRING(4),LCSCD:STRING(4)";
	ls_lhtml += ",LCSNO:STRING(20),GETDT:STRING(8),CHGDT:STRING(8),ISSPART:STRING(30) ";
	
	gcds_license.SetDataHeader(ls_lhtml);

	var ls_lhtml2 = "LCSTYPE:STRING(30),LCSCD:STRING(30)";
	ls_lhtml2 += ",LCSNO:STRING(20),GETDT:STRING(8),CHGDT:STRING(8),ISSPART:STRING(30) ";
	gcds_report07.SetDataHeader(ls_lhtml2); //자격/면허보고서


	//////////////////////////////////////////////////////////////////////////////////////////////
	//	자기소개서
	//////////////////////////////////////////////////////////////////////////////////////////////
	var ls_ihtml = "";

	ls_ihtml += "INFODIV:STRING(6),RESINO:STRING(13),GROWTH:STRING(1000),SCHOOL:STRING(1000),CAREER:STRING(1000),";
	ls_ihtml += "AMBITION:STRING(1000)";
	
	gcds_hrself.SetDataHeader(ls_ihtml);

	gcds_hrself.addrow();

	var ls_ihtml2 = "GROWTH:STRING,SCHOOL:STRING,CAREER:STRING,AMBITION:STRING";
	gcds_report09.SetDataHeader(ls_ihtml2); //소개서보고서

}

/******************************************************************************
	Description : 기본 조회
******************************************************************************/
function ln_Before(){
	//응시분야
	gcds_before.DataID = "/servlet/Person.h020002_s8?v_str1=" + gs_date;
	gcds_before.Reset();

	//출신도
	gcds_bircity.DataID = "/servlet/Person.hclcode_s1?v_str1=2011";
	gcds_bircity.Reset();

	//종교
	gcds_rilign.DataID = "/servlet/Person.hclcode_s1?v_str1=1117";
	gcds_rilign.Reset();

}

/******************************************************************************
	Description : 학력관련 조회
******************************************************************************/
function ln_SerEdu(){
	gcds_educ.Deleteall();
	ln_SetVisbile();

	//학력
	gcds_hreduc.DataID = "/servlet/Person.hclcode_s1?v_str1=1115";
	gcds_hreduc.Reset();

	//전공
	gcds_preduc.DataID = "/servlet/Person.hclcode_s1?v_str1=1129";
	gcds_preduc.Reset();

	//졸업구분
	gcds_greduc.DataID = "/servlet/Person.hclcode_s1?v_str1=1118";
	gcds_greduc.Reset();
}

/******************************************************************************
	Description : 병역관련 조회
******************************************************************************/
function ln_SerMil(){
	//병역구분
	gcds_milidiv.DataID = "/servlet/Person.hclcode_s1?v_str1=1168";
	gcds_milidiv.Reset();

	//군별
	gcds_miliknd.DataID = "/servlet/Person.hclcode_s1?v_str1=1116";
	gcds_miliknd.Reset();

	//계급
	gcds_miligrd.DataID = "/servlet/Person.hclcode_s1?v_str1=1134";
	gcds_miligrd.Reset();
}

/******************************************************************************
	Description : 가족관계
******************************************************************************/
function ln_SerFam(){
	gcds_family.Deleteall();
	ln_SetVisbile();

	//학력/대졸/중졸
	gcds_fameduc.DataID = "/servlet/Person.hclcode_s1?v_str1=1115";
	gcds_fameduc.Reset();

	//가족관계
	gcds_famre.DataID = "/servlet/Person.hclcode_s1?v_str1=1132";
	gcds_famre.Reset();

}

/******************************************************************************
	Description : 자격증관련 조회
******************************************************************************/
function ln_SerLic(){
	gcds_license.Deleteall();
	ln_SetVisbile();

	//자격증등급
	gcds_lcscd.DataID = "/servlet/Person.hclcode_s1?v_str1=1128";
	gcds_lcscd.Reset();

	//자격증종류
	gcds_lcstype.DataID = "/servlet/Person.hclcode_s1?v_str1=1127";
	gcds_lcstype.Reset();
}

/******************************************************************************
	Description : 어학관련 조회
******************************************************************************/
function ln_SerEng(){
	//영어수준
	gcds_englvl.DataID = "/servlet/Person.hclcode_s1?v_str1=1149";
	gcds_englvl.Reset();
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Vchk() {
	
	if (fn_trim(txt_nmk.value)=="") {
		alert("한글 성명을 입력해 주십시오");
		txt_nmk.focus();
		return false;
	}

	if (fn_trim(txt_nmc.value)=="") {
		alert("한자 성명을 입력해 주십시오");
		txt_nmc.focus();
		return false;
	}

	if (fn_trim(txt_nme.value)=="") {
		alert("영문 성명을 입력해 주십시오");
		txt_nme.focus();
		return false;
	}

	if (fn_trim(gcem_resino2.text)=="") {
		alert("주민번호를 입력해 주십시오");
		gcem_resino2.focus();
		return false;
	}

	if (fn_trim(gcem_birdt.text)=="") {
		alert("생년월일을 입력해 주십시오");
		gcem_birdt.focus();
		return false;
	}

	if (fn_trim(gclx_bircity.BindColVal)=="") {
		alert("출신도를 선택해 주십시오");
		gclx_bircity.focus();
		return false;
	}

	if (fn_trim(txt_hobby.value)=="") {
		alert("취미를 입력해 주십시오");
		txt_hobby.focus();
		return false;
	}
	
	if (fn_trim(txt_special.value)=="") {
		alert("특기를 입력해 주십시오");
		txt_special.focus();
		return false;
	}
	
	if (fn_trim(gclx_rilign.BindColVal)=="") {
		alert("종교를 선택해 주십시오");
		gclx_rilign.focus();
		return false;
	}

	if (fn_trim(gcem_caryear.text)=="") {
		alert("경력을 입력해 주십시오");
		gcem_caryear.focus();
		return false;
	}

	if (fn_trim(txt_telno.value)=="") {
		alert("연락처를 입력해 주십시오");
		txt_telno.focus();
		return false;
	}

	if (fn_trim(txt_hpno.value)=="") {
		alert("휴대폰 번호를 입력해 주십시오");
		txt_hpno.focus();
		return false;
	}

	if (fn_trim(txt_email.value)=="") {
		alert("이메일 주소를 입력해 주십시오");
		txt_email.focus();
		return false;
	}

	if (fn_trim(gcem_ozipcd.text)=="") {
		alert("본적주소 우편번호를 입력해 주십시오");
		return false;
	}

	if (fn_trim(txt_oaddr2.value)=="") {
		alert("나머지 본적 주소를 입력해 주십시오");
		txt_oaddr2.focus();
		return false;
	}

	if (fn_trim(gcem_czipcd.text)=="") {
		alert("현주소 우편번호를 입력해 주십시오");
		return false;
	}

	if (fn_trim(txt_caddr2.value)=="") {
		alert("나머지 현주소를 입력해 주십시오");
		txt_caddr2.focus();
		return false;
	}

	if (gcds_educ.countrow<1) {
		alert("학력사항을 입력해 주십시오");
		return false;
	}

	return true;
}

/******************************************************************************
	Description : 입력항목 표시유무
******************************************************************************/
function ln_Disp(Obj,e){
	if (e=="gcds_educ" && gcds_hreduc.countrow<1) ln_SerEdu();
//	else if (e=="gcds_mili" && gcds_milidiv.countrow<1) ln_SerMil();
	else if (e=="gcds_eng" && gcds_englvl.countrow<1) ln_SerEng();
	else if (e=="gcds_license" && gcds_lcstype.countrow<1) ln_SerLic();
	else if (e=="gcds_family" && gcds_famre.countrow<1) ln_SerFam();

	if(Obj.style.display=="none") Obj.style.display="block";
	else Obj.style.display="none";
}

/******************************************************************************
	Description : 주소 조회
******************************************************************************/
function ln_Popup(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/Common/html/com_zipcd.html";
	strPos = "dialogWidth:640px;dialogHeight:410px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval("gcem_"+e+"zipcd").text = arrParam[0];
		var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
		eval("txt_"+e+"addr1").value = val;
		eval("txt_"+e+"addr2").focus();
	}
}

/******************************************************************************
	Description : 채용안내정보
******************************************************************************/
function ln_Popup2(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]	= gclx_info.bindColVal;

	strURL = "./H020002_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:353px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/******************************************************************************
	Description : 화일명 체크
******************************************************************************/
function ln_Divide(str, delim){
	var strArr=str.split(delim);
	var rtn="";
	var a=strArr.length;

	if(a>0){rtn=strArr[a-1];}
	strArr=null;
	return rtn;
}

/******************************************************************************
	Description : 로딩 체크
******************************************************************************/
function ln_SetVisbile(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
}

/******************************************************************************
	Description : 로딩 체크
******************************************************************************/
function ln_SetHidden(){
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
}


/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
	if(gcds_data.countrow > 0)
	{

	   ln_RptFor('3');
		gcds_report01.ClearData();
		for(var i=1;i <= gcds_educ.countrow; i++)
		{
			gcds_report01.AddROW();
			for(var j=1;j <= gcds_report01.CountColumn; j++)
			{
				if(fn_trim(gcgd_educ.VirtualString(i, gcds_report01.ColumnID(j)))=="")
					gcds_report01.namevalue(i,gcds_report01.ColumnID(j))=gcds_educ.namevalue(i, gcds_report01.ColumnID(j));
				else
					gcds_report01.namevalue(i,gcds_report01.ColumnID(j))=gcgd_educ.VirtualString(i, gcds_report01.ColumnID(j));
			}

		}


		gcds_report06.ClearData();
		for(var i=1;i <= gcds_family.countrow; i++)
		{
			gcds_report06.AddROW();
			for(var j=1;j <= gcds_report06.CountColumn; j++)
			{
				if(fn_trim(gcgd_family.VirtualString(i, gcds_report06.ColumnID(j)))=="")
					gcds_report06.namevalue(i,gcds_report06.ColumnID(j))=gcds_family.namevalue(i, gcds_report06.ColumnID(j));
				else
					gcds_report06.namevalue(i,gcds_report06.ColumnID(j))=gcgd_family.VirtualString(i, gcds_report06.ColumnID(j));
			}

		}


		gcds_report07.ClearData();
		for(var i=1;i <= gcds_license.countrow; i++)
		{
			gcds_report07.AddROW();
			for(var j=1;j <= gcds_report07.CountColumn; j++)
			{
				if(fn_trim(gcgd_license.VirtualString(i, gcds_report07.ColumnID(j)))=="")
					gcds_report07.namevalue(i,gcds_report07.ColumnID(j))=fn_trim(gcds_license.namevalue(i, gcds_report07.ColumnID(j)));
				else
					gcds_report07.namevalue(i,gcds_report07.ColumnID(j))=fn_trim(gcgd_license.VirtualString(i, gcds_report07.ColumnID(j)));
			}

		}

       gcds_report09.ClearData();
		gcds_report09.AddROW();
		 gcds_report09.namevalue(1,"GROWTH") =ln_Multiline_Text(fn_trim(txt_growth.value),139);
        gcds_report09.namevalue(1,"SCHOOL")  =ln_Multiline_Text(fn_trim(txt_school.value),139);
        gcds_report09.namevalue(1,"CAREER")  =ln_Multiline_Text(fn_trim(txt_career.value),139);
        gcds_report09.namevalue(1,"AMBITION")=ln_Multiline_Text(fn_trim(txt_ambition.value),139)
//test_txt.value=gcrp_print.format;

			gcrp_print.preview();
	}
}


/******************************************************************************
	Description : 보고서 멀티라인 자동개행
	-- ln_Multiline_Text(문자열,자동개행할 가로 문자열길이(첫문자가 0임))
******************************************************************************/
function ln_Multiline_Text(str_text,Maxlen)
{      
		var num_s=new Array("0","1","2","3","4","5","6","7","8","9");  //숫자 길이체크 배열
		var str1 =str_text;  //문자열
		var seq_1=0;   //문자-2길이,숫자-1길이 
		var Rseq_1=0;  //실제 substr에서 쓰이는 index
		var Maxseq =Maxlen; //가로문자길이 최대
		var seq_2=1;     //현재 몇배수
		var Tlength=str1.length;
		var Rstr_value="";

		 for(var i=0; i<Tlength; i++)
		 {
			for(var j=0; j < num_s.length; j++)
			{
				if (str1.substr(i,1)==num_s[j])
				{
					seq_1++;
					break;
				}
				if (j==9) seq_1 += 2;
			}
			if(i == (Tlength-1))
			{ 
					if(str1.substring(Rseq_1,Tlength).indexOf(unescape("%0D"))!=-1)
					{
						 Rstr_value+=str1.substring(Rseq_1,Tlength);
					}
					else
					{
						 Rstr_value+=str1.substring(Rseq_1,Tlength)+unescape("%0D%0A");
					}

					break;

			}
            else
			{
				if(seq_1 > (Maxseq*seq_2)  )
				{   
					if(str1.substring(Rseq_1,i).indexOf(unescape("%0D"))!=-1)
					{
						 Rstr_value+=str1.substring(Rseq_1,i);
					}
					else
					{
						 Rstr_value+=str1.substring(Rseq_1,i)+unescape("%0D%0A");
					}

					seq_2++;
					Rseq_1=(i);
				}
			}
		}

        return Rstr_value;
}



/******************************************************************************
	Description : 출력물 포멧 작성
******************************************************************************/
function ln_RptFor(e){
	var ls_for = "";


ls_for += "<A>id=Area1 ,left=0,top=0 ,right=2000 ,bottom=129                                                                                                                                                            ";
	ls_for += "<R>id='basis.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_data'                                                                                                                         ";
		ls_for +="<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=569 ,face='새굴림' ,size=9 ,penwidth=1                                                                                                                    ";

			if (gcds_data.namevalue(1,"photo")=="") {
				 var photo="../../Person/html/photo/00000.jpg";
				if(txt_file.value!="")
				 { 

					 var photo=txt_file.value;
				 }

				ls_for +="	<I>id='"+photo+"' ,left=21 ,top=225 ,right=352 ,bottom=545</I> ";

			} else {
				if(txt_file.value!="")
				 { 
 					 var photo=txt_file.value;
				ls_for +="	<I>id='"+photo+"' ,left=21 ,top=225 ,right=352 ,bottom=545</I> ";
				 }else{
				var str1 = gcds_data.namevalue(1,"infodiv");
				var str2 = gcds_data.namevalue(1,"resino");

				ls_for +="	<I>id='"+rDOMAIN+"/servlet/Person.h020002_s9?v_str1="+str1+"&v_str2="+str2+"' ,left=21 ,top=225 ,right=352 ,bottom=545</I> ";

			}
		}



		ls_for +="	<T>id='입사응시원서 (입사양식 A)' ,left=495 ,top=0 ,right=1505 ,bottom=95 ,face='Arial' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                    ";
		ls_for +="	<X>left=1357 ,top=103 ,right=1569 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=5</X>                                                                                                              ";
		ls_for +="	<T>id='응시구분' ,left=1371 ,top=111 ,right=1556 ,bottom=177 ,face='Arial' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                                                                                                        ";
		ls_for +="	<X>left=1566 ,top=103 ,right=1974 ,bottom=185 ,border=true ,penstyle=solid ,penwidth=5</X>                                                                                                            ";
		ls_for +="	<T>id='" + gclx_info.Text + "', left=1580, top=119, right=1953, bottom=167, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>        "; 

		
		ls_for +="	<T>id='1.기본인적사항' ,left=0 ,top=138 ,right=503 ,bottom=198 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>              ";
		ls_for +="	<L> left=3 ,top=206 ,right=1971 ,bottom=206 </L>                                                                                                                                                       ";
		ls_for +="	<C>id='SPECIAL', left=1074, top=333, right=1318, bottom=381, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>      ";    
		ls_for +="	<C>id='CARYEAR', left=1828, top=333, right=1900, bottom=381, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
		ls_for +="	<T>id='년' ,left=1918 ,top=333 ,right=1963 ,bottom=381</T> ";


		ls_for +="	<X>left=1667 ,top=325 ,right=1820 ,bottom=386 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                       ";

		ls_for +="	<T>id='경력' ,left=1680 ,top=333 ,right=1807 ,bottom=381 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                      ";
		ls_for +="	<C>id='RESINO', left=593, top=275, right=844, bottom=323, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           "; 
		ls_for +="	<C>id='HOBBY', left=593, top=333, right=844, bottom=381, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            ";
		ls_for +="	<<C>id='TELNO', left=593, top=394, right=844, bottom=442, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>            ";
		ls_for +="	<C>id='OZIPCD', left=593, top=452, right=725, bottom=500, align='left' ,mask='XXX-XXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          "; 
		ls_for +="	<C>id='CZIPCD', left=593, top=511, right=725, bottom=558, align='left' ,mask='XXX-XXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           "; 
		ls_for +="	<C>id='CADDR1', left=728, top=511, right=1550, bottom=558, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          ";  
		ls_for +="	<L> left=0 ,top=566 ,right=1971 ,bottom=566 </L>                                                                                                                                                       ";

		var ls_MIDP = "";	//출신도

		ls_MIDP = gclx_bircity.ValueByColumn("MINORCD", gclx_bircity.ValueOfIndex("MINORCD", gclx_bircity.Index), "MINORNM");
		ls_for += " <T>id='" + ls_MIDP + "',left=1484 ,top=275 ,right=1953 ,bottom=323 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";

		//ls_for +="	<C>id='BIRCITY', left=1495, top=275, right=1963, bottom=323, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=false</C>        ";   
		
		ls_for +=" <C>id='EMAIL', left=1484, top=394, right=1953, bottom=442, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";  
		ls_for +=" <C>id='BIRDT', left=1074, top=273, right=1334, bottom=320, align='left' ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";  
		ls_for +=" <C>id='HPNO', left=1074, top=394, right=1334, bottom=442, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";  
		ls_for +=" <C>id='OADDR2', left=1553, top=452, right=1963, bottom=500, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";  
		ls_for +=" <C>id='CADDR2', left=1553, top=511, right=1963, bottom=558, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          ";  

		var ls_MIDP2 = "";	
			//종교

		ls_MIDP2 = gclx_rilign.ValueByColumn("MINORCD", gclx_rilign.ValueOfIndex("MINORCD", gclx_rilign.Index), "MINORNM");
		ls_for += " <T>id='" + ls_MIDP2 + "',left=1484 ,top=333 ,right=1664 ,bottom=381 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T> ";

		ls_for +="	<L> left=0 ,top=206 ,right=0 ,bottom=566 </L> ";
		ls_for += " <L> left=1974 ,top=206 ,right=1974 ,bottom=566 </L> ";
		ls_for += " <C>id='OADDR1', left=728, top=452, right=1550, bottom=500, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
		ls_for += " <X>left=365 ,top=206 ,right=587 ,bottom=566 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
		ls_for += " <T>id='현재 주소' ,left=397 ,top=511 ,right=558 ,bottom=558 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='본적 주소' ,left=397 ,top=452 ,right=556 ,bottom=500 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='집전화' ,left=413 ,top=394 ,right=540 ,bottom=442 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='취미' ,left=413 ,top=333 ,right=540 ,bottom=381 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='주민등록번호' ,left=378 ,top=275 ,right=577 ,bottom=323 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='성명' ,left=413 ,top=217 ,right=540 ,bottom=265 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <X>left=849 ,top=206 ,right=1072 ,bottom=447 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
		ls_for += " <T>id='휴대폰' ,left=894 ,top=394 ,right=1021 ,bottom=442 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='특기' ,left=894 ,top=333 ,right=1021 ,bottom=381 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='생년월일' ,left=894 ,top=275 ,right=1021 ,bottom=323 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='한자명' ,left=894 ,top=217 ,right=1021 ,bottom=265 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <L> left=368 ,top=267 ,right=1974 ,bottom=267 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <L> left=368 ,top=325 ,right=1974 ,bottom=325 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <L> left=368 ,top=386 ,right=1974 ,bottom=386 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <L> left=368 ,top=447 ,right=1974 ,bottom=447 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <L> left=368 ,top=505 ,right=1974 ,bottom=505 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <C>id='NME', left=1484, top=214, right=1953, bottom=262, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
		ls_for += " <C>id='NMK', left=593, top=214, right=844, bottom=262, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
		ls_for += " <C>id='NMC', left=1074, top=214, right=1320, bottom=262, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
		ls_for += " <X>left=1326 ,top=206 ,right=1479 ,bottom=447 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
		ls_for += " <X>left=1326 ,top=206 ,right=1479 ,bottom=447 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X> ";
		ls_for += " <L> left=368 ,top=267 ,right=1974 ,bottom=267 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <L> left=368 ,top=325 ,right=1974 ,bottom=325 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <L> left=368 ,top=386 ,right=1974 ,bottom=386 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <L> left=368 ,top=447 ,right=1974 ,bottom=447 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <L> left=368 ,top=505 ,right=1974 ,bottom=505 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L> ";
		ls_for += " <T>id='이메일' ,left=1339 ,top=394 ,right=1466 ,bottom=442 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='종교' ,left=1339 ,top=331 ,right=1466 ,bottom=378 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='출신도' ,left=1339 ,top=273 ,right=1466 ,bottom=320 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " <T>id='영문명' ,left=1339 ,top=214 ,right=1466 ,bottom=262 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T> ";
		ls_for += " </B> ";
		ls_for += " </R> ";
		ls_for += " </A> ";

	gcrp_print.format = ls_for + report_format;

}	
</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 기본 사항 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 학력사항 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_educ classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 학력사항 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_career classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 경력사항 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_family classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 가족사항 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_report06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 가족사항보고서 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_license classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 자격 및 면허 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_report07 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 자격 및 면허보고서 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_before classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 응시분야 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_bircity classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 출신도 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rilign classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 종교 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_milidiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 계급 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_miliknd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 군별 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_miligrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 병역구분 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_englvl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 영어수준 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hreduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 학력 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_preduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 전공 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_greduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 졸업구분 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_famre classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 가족관계 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_fameduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 가족학력/대졸/중졸 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_lcstype classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 자격증종류 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_lcscd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 자격증등급 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hrself classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 자기소개서 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_report09 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"> <!-- 자격 및 면허보고서 -->
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"		value="toinb_dataid4">
	<param name="KeyValue"	value="Person.h020002_t1(I:USER=gcds_data,I:EDUC=gcds_educ,I:CARR=gcds_career,I:FAMI=gcds_family,I:LICE=gcds_license,I:SELF=gcds_hrself)">
	<param name="Action"		value="/servlet/Person.h020002_t1">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_milidiv" event="OnLoadStarted()">
	ln_SetVisbile();
</script>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ln_SetVisbile();
</script>

<script language="javascript" for="gcds_data" event="onLoadCompleted(row,colid)">
	if (row>0){
		if (gcds_data.namevalue(1,"photo")=="") {
			photo.src="photo/00000.gif";
		} else {
			var str1 = gcds_data.namevalue(1,"infodiv");
			var str2 = gcds_data.namevalue(1,"resino");
			photo.src="/servlet/Person.h020002_s9?v_str1="+str1+"&v_str2="+str2
		}

		gcds_educ.DataID = "/servlet/Person.h020002_s4?"
										 + "v_str1=" + gcds_data.namevalue(1,"RESINO");
		gcds_educ.Reset();
	} else {
		photo.src="photo/00000.gif";
		ln_SetHeader();
		gcds_educ.ClearData();
		gcds_career.ClearData();
		gcds_family.ClearData();
		gcds_license.ClearData();
		ln_SetHidden();
		alert("검색된 데이터가 없습니다.");
	}

</script>

<script language="javascript" for="gcds_educ" event="onloadCompleted(row,colid)">
	gcds_career.DataID = "/servlet/Person.h020002_s5?"
									 + "v_str1=" + gcds_data.namevalue(1,"RESINO");
	gcds_career.Reset();
</script>

<script language="javascript" for="gcds_career" event="onloadCompleted(row,colid)">
	gcds_family.DataID = "/servlet/Person.h020002_s6?"
									 + "v_str1=" + gcds_data.namevalue(1,"RESINO");
	gcds_family.Reset();
</script>

<script language="javascript" for="gcds_family" event="onloadCompleted(row,colid)">
	gcds_license.DataID = "/servlet/Person.h020002_s7?"
									 + "v_str1=" + gcds_data.namevalue(1,"RESINO");
	gcds_license.Reset();
</script>

<script language="javascript" for="gcds_license" event="onloadCompleted(row,colid)">
	gcds_hrself.DataID = "/servlet/Person.h020002_s0?"
									 + "v_str1=" + gcds_data.namevalue(1,"INFODIV")
									 + "&v_str2=" + gcds_data.namevalue(1,"RESINO");
	gcds_hrself.Reset();

	ln_SetHidden();
</script>

<script language="javascript" for="gcds_hrself" event="onloadCompleted(row,colid)">
    if(gcds_hrself.countrow <1) gcds_hrself.addrow();
</script>


<script language="javascript" for="gcds_data" event="onloadError()">
	ln_SetHidden();
</script>

<script language="javascript" for="gcds_rilign" event="onloadCompleted(row,colid)">
	ln_SetHidden();
</script>

<script language="javascript" for="gcds_rilign" event="onloadError()">
	ln_SetHidden();
</script>

<script language="javascript" for="gcds_lcstype" event="onloadCompleted(row,colid)">
	ln_SetHidden();
	gcds_license.undoall();
</script>

<script language="javascript" for="gcds_greduc" event="onloadCompleted(row,colid)">
	ln_SetHidden();
	gcds_educ.undoall();
</script>

<script language="javascript" for="gcds_famre" event="onloadCompleted(row,colid)">
	ln_SetHidden();
	gcds_family.undoall();
</script>

<script language="javascript" for="gcds_miliknd" event="onloadCompleted(row,colid)">
	gcds_miliknd.InsertRow(1);
  gcds_miliknd.Index=0;
</script>

<script language="javascript" for="gcds_miligrd" event="onloadCompleted(row,colid)">
	gcds_miligrd.InsertRow(1);
  gcds_miligrd.Index=0;
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value) != "") {
		txt_file.value = gcip_file.value;
		photo.src = gcip_file.value;
		var tfile = txt_file.value;
		var tfilename = ln_Divide(txt_file.value, "\\");
		gcds_data.namevalue(gcds_data.rowposition,"photo") = tfilename;
	}
</script>

<script language="javascript" for="gcem_resino2" event="OnKillFocus()">
	var ls_ck = gcem_resino2.text.substring(6,7);
	if (ls_ck<3) gcem_birdt.text = "19"+gcem_resino2.text.substring(0,6);
	else gcem_birdt.text = "20"+gcem_resino2.text.substring(0,6);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	gcem_resino.text = gcem_resino2.text;
	ln_Query();
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/h020002_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
			<img src="../../Common/img/btn/com_b_save.gif"	style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
	<tr>
		<td colspan=2> 
			<table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
        <tr> 
					<td style="width:100px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" align=center><nobr>주민번호</td>
					<td width="200">
						<comment id="__NSID__"><object id=gcem_resino classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:3px; width:95px; height:17px; font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="000000-0000000">
								<param name=PromptChar	  value="_">
					  </object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td style="width:100px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;" align="center" bgcolor="#eeeeee">응시분야</td>
					<td>
 						<comment id="__NSID__"><object id=gclx_info classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
 							style="position:relative;left:8px;top:0px;font-size:12px;width:250px;">
								<param name=ComboDataID			value="gcds_before">
								<param name=CBDataColumns		value="INFODIV, DSPNM">
  							<param name=SearchColumn		value="DSPNM">
  							<param name=Sort						value="false">
  							<param name=ListExprFormat	value="DSPNM^0^250">
	 							<param name=BindColumn			value="INFODIV">
 						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td align="right"><img src="../../Common/img/btn/com_b_information.gif" style="cursor:hand" onclick="ln_Popup2();" ></td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>  
	<tr><td colspan=2 height=3></td></tr>  	
	<tr>
		<td colspan=2> 
			<table width=100% border=0 cellspacing=0 cellpadding=0 >
				<tr><td height=31  background="../../Common/img/com_cont_subtxt_bg.gif"><b>기본인적사항</b></td></tr>
			</table>
			<table cellpadding=0 cellspacing=0  border=0 style="width:876px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;">
				<tr>
					<td class="tab11" style="width:100px;" rowspan=5 valign=middle>
						<input type=image id="photo" NAME="photo" style="height:110;width:85;border:0px;" src="photo/00000.gif">
					</td>
					<td class="tab11" style="width:100px;height:25px;" bgcolor="#eeeeee">성명</td>
					<td class="tab21"><input id="txt_nmk" name="txt_nmk" type="text" class="txt11" style="width:120px;" maxlength="30" onBlur="bytelength(this,this.value,30);"></td>
					<td class="tab11" style="width:100px;height:25px;" bgcolor="#eeeeee">한자명</td>
					<td class="tab21"><input id="txt_nmc" name="txt_nmc" type="text" class="txt11" style="width:120px;" maxlength="20" onBlur="bytelength(this,this.value,20);"></td>
					<td class="tab11" style="height:25px;" bgcolor="#eeeeee">영문명</td>
					<td class="tab22"><input id="txt_nme" name="txt_nme" type="text" class="txt11" style="width:150px;" maxlength="40" onBlur="bytelength(this,this.value,40);"></td>
				</tr>
				<tr>
					<td class="tab11" style="width:100px;" bgcolor="#eeeeee">주민등록번호</td>
					<td class="tab21">
						<comment id="__NSID__"><object id=gcem_resino2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:4px; width:100px; height:17px; font-family:굴림; font-size:9pt; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="000000-0000000">
								<param name=PromptChar	  value="_">
					  </object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" bgcolor="#eeeeee">생년월일</td>
					<td class="tab21">
						<comment id="__NSID__"><object id=gcem_birdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:4px; width:100px; height:17px; font-family:굴림; font-size:9pt;z-index:2; ">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY년MM월DD일">
								<param name=PromptChar	  value="_">
								<param name=Enable				value="false">
					  </object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" bgcolor="#eeeeee">출신도</td>
					<td class="tab22">
						<comment id="__NSID__"><object id=gclx_bircity classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:8px;top:1px;font-size:12px;width:120px;">
								<param name=ComboDataID			value="gcds_bircity">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value=MINORCD>
 						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				<tr>
					<td class="tab11" bgcolor="#eeeeee">취미</td>
					<td class="tab21"><input id="txt_hobby" name="txt_hobby" type="text" class="txt11" style="width:120px;" maxlength="40" onBlur="bytelength(this,this.value,40);"></td>
					<td class="tab11" bgcolor="#eeeeee">특기</td>
					<td class="tab21"><input id="txt_special" name="txt_special" type="text" class="txt11" style="width:120px;" maxlength="40" onBlur="bytelength(this,this.value,40);"></td>
					<td colspan="2">
						<table cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td class="tab11" width="55px;" bgcolor="#eeeeee">종교</td>
								<td class="tab21" width="100px;">
									<comment id="__NSID__"><object id=gclx_rilign classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
											<param name=ComboDataID			value="gcds_rilign">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^100">
											<param name=BindColumn			value=MINORCD>
			 						</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" width="60px;" bgcolor="#eeeeee">경력</td>
								<td class="tab22" width="25px;">
									<comment id="__NSID__"><object id=gcem_caryear classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										style="position:relative; left:8px;top:4px; width:15px; height:17px; font-family:굴림; font-size:9pt; " >
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Numeric				value=true>
											<param name=MaxLength			value=2>
											<param name=PromptChar	  value="_">
								  </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab22"><span style="position:relative;top:2px;">년</span></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tab11" bgcolor="#eeeeee">집전화</td>
					<td class="tab21"><input id="txt_telno" name="txt_telno" type="text" class="txt11" style="width:120px;" maxlength="15" onBlur="bytelength(this,this.value,15);"></td>
					<td class="tab11" bgcolor="#eeeeee">휴대폰</td>
					<td class="tab21"><input id="txt_hpno" name="txt_hpno" type="text" class="txt11" style="width:120px;" maxlength="15" onBlur="bytelength(this,this.value,15);"></td>
					<td class="tab11" bgcolor="#eeeeee">이메일</td>
					<td class="tab22"><input id="txt_email" name="txt_email" type="text" class="txt11" style="width:150px;" maxlength="30" onBlur="bytelength(this,this.value,30);"></td>
				</tr>
				<tr>
					<td class="tab11" bgcolor="#eeeeee">본적 주소</td>
					<td class="tab22" colspan=5>
						<table cellspacing=0 cellpadding=0 border=0>
							<tr>
								<td>
									<comment id="__NSID__"><object id=gcem_ozipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:3px; width:50px; height:17px; font-family:굴림; font-size:9pt; " >
											<param name=Alignment				value=0>
											<param name=Border					value=false>
											<param name=Enable					value=false>
											<param name=Format					value="000-000">
											<param name=MaxDecimalPlace value=1>
											<param name=PromptChar			value="_">
								  </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td>&nbsp;&nbsp;</td>
								<td><img alt=우편번호조회  id='img_search1' name='img_search1' style="cursor:hand" src='../../Common/img/btn/com_b_search.gif'  onclick="ln_Popup('o')"></td>
								<td>
									&nbsp;<input id="txt_oaddr1" name="txt_oaddr1" type="text" class="txt11" style= "width:300px;" disabled>
									<input id="txt_oaddr2" name="txt_oaddr2" type="text" class="txt11" style= "width:230px;" maxlength="70" onBlur="bytelength(this,this.value,70);">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tab12" bgcolor="#eeeeee">
						<input type="hidden" id=txt_file name="txt_file" readonly style="position:relative;left:6px;width:100px">
					  <comment id="__NSID__"><object id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
			        style="position:relative;left:0px;top:0px;width:80; height:20;">
					      <param name="Text"		value="찾아보기">
                <param name="Enable"  value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" bgcolor="#eeeeee">현재 주소</td>
					<td colspan=5 >
						<table cellspacing=0 cellpadding=0 border=0>
							<tr>
								<td>
									<comment id="__NSID__"><object id=gcem_czipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:3px; width:50px; height:17px; font-family:굴림; font-size:9pt; " >
											<param name=Alignment				value=0>
											<param name=Border					value=false>
											<param name=Enable					value=false>
											<param name=Format					value="000-000">
											<param name=MaxDecimalPlace value=1>
											<param name=PromptChar			value="_">
								  </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td>&nbsp;&nbsp;</td>
								<td><IMG alt=우편번호조회  id='img_search2' 	name='img_search2' style="cursor:hand" 	src='../../Common/img/btn/com_b_search.gif'  onclick="ln_Popup('c')"></td>
								<td>
									&nbsp;<input id="txt_caddr1" name="txt_caddr1" type="text" class="txt11" style= "width:300px;" disabled>
									<input id="txt_caddr2" name="txt_caddr2" type="text" class="txt11" style= "width:230px;" maxlength="70" onBlur="bytelength(this,this.value,70);">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>  	
	<tr><td colspan=2 height=12></td></tr>
	<tr>
		<td colspan="2">
			<table width="100%" border=0 cellspacing=0 cellpadding=0 background="../../Common/img/com_cont_subtxt_bg.gif">
				<tr>
					<td onclick="ln_Disp(gcgd_educ,'gcds_educ');" style="cursor:hand;" height=31><b>학력사항(*)</b></td>
					<td align=right>
						<table  border=0 cellspacing=0 cellpadding=0 background="../../Common/img/com_cont_subtxt_bg.gif" style="cursor:hand;" height=31>
							<tr>
								<td width=100% onclick="ln_Disp(gcgd_educ,'gcds_educ');"></td>
								<td align=right width=40><img src="../../Common/img/btn/com_b_insert.gif" width=40 height=21 style="cursor:hand" onclick="ln_Add(gcds_educ,'gcds_educ')"></td>
								<td>&nbsp;</td>
								<td width=0 align=right width=40><img src="../../Common/img/btn/com_b_delete.gif" width=40 height=21 style="cursor:hand" onclick="ln_Delete(gcds_educ)"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_educ style="width:875;height:159px;border:1 solid #777777;display:none" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_educ">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
		          <PARAM NAME="Editable"		VALUE="true">
						  <param name="AllShowEdit" VALUE="true">
						  <PARAM NAME="Format"			VALUE="  
								<C> Name='졸업(예정)년도' ID=GRAYY HeadAlign=Center HeadBgColor=#B9D4DC Width=100 Mask='XXXX' align=center</C>
								<G> Name='출신학교'  	HeadAlign=Center HeadBgColor=#B9D4DC align=CENTER 
									<C> Name='학교명' ID=SCHNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=160  align=left </C> 
									<C> Name='학교'		ID=EDCCD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90  align=left, editstyle=LookUp data='gcds_hreduc:minorcd:minornm'</C> 
								</G>
								<C> Name='소재지' ID=CITY		HeadAlign=Center HeadBgColor=#B9D4DC Width=180 align=left </C>
								<C> Name='전공'		ID=PGCCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left, editstyle=LookUp data='gcds_preduc:minorcd:minornm'</C>
								<C> Name='구분'		ID=EDCDIV HeadAlign=Center HeadBgColor=#B9D4DC Width=73  align=left, editstyle=LookUp data='gcds_greduc:minorcd:minornm' </C> 
								<C> Name='평점'		ID=AVRUNI HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right</C> 
								<C> Name='만점'		ID=PERFECT HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right</C> 
								<C> Name='비율'		ID={(AVRUNI/PERFECT)*100} HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=center, mask='XX %' edit=none</C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="100%" border=0 cellspacing=0 cellpadding=0 background="../../Common/img/com_cont_subtxt_bg.gif" style="cursor:hand;" height=31>
				<tr>
					<td onclick="ln_Disp(gcgd_career,'gcds_career');" style="cursor:hand;"><b>경력사항(*)</b></td>
					<td align=right>
						<table  border=0 cellspacing=0 cellpadding=0 background="../../Common/img/com_cont_subtxt_bg.gif" style="cursor:hand;" height=31>
							<tr>
								<td width="100%" onclick="ln_Disp(gcgd_career,'gcds_career');"></td>
								<td align=right width=40><img src="../../Common/img/btn/com_b_insert.gif" width=40 height=21  style="cursor:hand" onclick="ln_Add(gcds_career,'gcds_career')"></td>
								<td>&nbsp;</td>
								<td width=0 align=right width=40><img src="../../Common/img/btn/com_b_delete.gif" width=40 height=21 style="cursor:hand" onclick="ln_Delete(gcds_career)"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_career style="WIDTH: 875; HEIGHT: 159px;border:1 solid #777777;display:none" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_career">교
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
		          <PARAM NAME="Editable"		VALUE="true">
						  <param name="AllShowEdit" VALUE="true">
						  <PARAM NAME="Format"			VALUE=" 
								<G> Name='근무기간 ex) 20000101'  	HeadAlign=Center HeadBgColor=#B9D4DC 
									<C> Name='FROM'		ID=FRDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 Mask='XXXX/XX/XX' align=center</C> 
									<C> Name='TO'			ID=ENDDT  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 Mask='XXXX/XX/XX' align=center</C> 
								</G>
								<C> Name='직장명'		ID=COMNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=left </C>
								<C> Name='직위'			ID=POSINM HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left </C>
								<C> Name='담당업무' ID=DUTYNM HeadAlign=Center HeadBgColor=#B9D4DC Width=323	align=left </C> 
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="100%" border=0 cellspacing=0 cellpadding=0  background="../../Common/img/com_cont_subtxt_bg.gif" style="background-color:#ffffff;" height=31>
				<tr>
					<td height=31 style="cursor:hand" onclick="ln_Disp(gcgd_sinche,'gcds_sinche');"><b>신체사항</b></td>
				</tr>
				<tr>
					<td>
						<div id=gcgd_sinche style="position:relative;display:none">
						<table border= "0" cellpadding=0 cellspacing=0  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
						<tr>
							<td>
							<table border= "0" cellpadding=0 cellspacing=0  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:0 solid #708090'>
							<tr>
								<td class="tab12" width="70px" bgcolor="#eeeeee">시력</td>
								<td class="tab23" width="150px;" align=center><nobr><input type="text" value="좌:" style="position:relative;top:-1px;border-width:0px;width:20px;">
									<comment id="__NSID__"><object id=gcem_eyel classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:5px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
										<param name=Alignment				value=0>
										<param name=Border					value=false>
										<param name=PromptChar			value="_">
										<param name=MaxLength       value=2>
										<param name=MaxDecimalPlace value=1>
									</object></comment><script>__ws__(__NSID__);</script>
									&nbsp;&nbsp;<input type="text" value="우:" style="position:relative;top:-1px;border-width:0px;width:20px;">
									<comment id="__NSID__"><object id=gcem_eyer classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:5px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
										<param name=Alignment				value=0>
										<param name=Border					value=false>
										<param name=PromptChar			value="_">
										<param name=MaxLength       value=2>
										<param name=MaxDecimalPlace value=1>
								  </object></comment><script>__ws__(__NSID__);</script></nobr>
								</td>
								<td class="tab12" width="70px;" bgcolor="#eeeeee">신장</td>
								<td class="tab23" width="110px;" align=right>
									<comment id="__NSID__"><object id=gcem_height classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:5px; width:22px; height:17px; font-family:굴림; font-size:9pt;">
										<param name=Alignment				value=0>
										<param name=Border					value=false>
										<param name=Numeric					value="true">
										<param name=Maxlength				value="3">
								  </object></comment><script>__ws__(__NSID__);</script>
									&nbsp;&nbsp;<span style="position:relative;top:-2px;">Cm</span>&nbsp;&nbsp;&nbsp;
								</td>
								<td class="tab12" width="70px;" bgcolor="#eeeeee">체중</td>
								<td class="tab23" width="130px;" align=right>
									<comment id="__NSID__"><object id=gcem_weight classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:5px; width:22px; height:17px; font-family:굴림; font-size:9pt; " >
										<param name=Alignment				value=0>
										<param name=Border					value=false>
										<param name=Numeric					value="true">
										<param name=Maxlength				value="3">
								  </object></comment><script>__ws__(__NSID__);</script>
									&nbsp;&nbsp;<span style="position:relative;top:-2px;">Kg</span>&nbsp;&nbsp;&nbsp;
								</td>
								<td class="tab12" width="70px;" bgcolor="#eeeeee">혈액형</td>
								<td width="100px;" align=center>
									<comment id="__NSID__"><object id=gcem_blood classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										style="position:relative; left:8px;top:5px; width:22px; height:17px; font-family:굴림; font-size:9pt; " >
										<param name=Alignment				value=0>
										<param name=Border					value=false>
										<param name=Format					value="AA">
										<param name=PromptChar			value="_">
								  </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;&nbsp;
								</td>
								<!--
								<td class="tab12" width="40px;" bgcolor="#eeeeee">손잡이</td>
								<td>
       						<comment id="__NSID__"><object id=gclx_rghandyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
       							style="position:relative;left:8px;top:0px;font-size:12px;width:130px;height:200px;">
       								<param name=CBData					value="1^오른손잡이,2^왼손잡이">
       								<param name=CBDataColumns		value="Code, Parm">
      								<param name=SearchColumn		value="Parm">
      								<param name=Sort						value="false">
      								<param name=ListExprFormat	value="Parm^0^130">
      								<param name=BindColumn			value="Code">
       						</object></comment><script>__ws__(__NSID__);</script>
								</td>
								-->
									</tr>
								</table>
							</tr>
						</table>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<table width="100%" border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_mili,'gcds_mili');" background="../../Common/img/com_cont_subtxt_bg.gif"  height=31><b>병역사항</b></td>
				</tr>
				<tr>
					<td>
						<div id=gcgd_mili style="position:relative;display:none">
            <table border="0" class=itemdisp cellpadding=0 cellspacing=0 style='width:876px;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
							<tr>
								<td>
							<table border="0" class=itemdisp cellpadding=0 cellspacing=0 style='width:876px;height:40px;font-size:9pt;background-color:#ffffff;border:0 solid #708090'>
							<tr>
								<td class="tab11" width="80px" bgcolor="#eeeeee">병역구분</td>
								<td class="tab21"><nobr>
									<comment id="__NSID__"><object id=gclx_milidiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
											<param name=ComboDataID			value="gcds_milidiv">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^100">
											<param name=BindColumn			value=MINORCD>
			 						</object></comment><script>__ws__(__NSID__);</script></nobr>
								</td>
								<td class="tab11" width="80px" bgcolor="#eeeeee">군별</td>
								<td class="tab21"><nobr>
									<comment id="__NSID__"><object id=gclx_miliknd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_miliknd">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^100">
											<param name=BindColumn			value=MINORCD>
			 						</object></comment><script>__ws__(__NSID__);</script></nobr>
								</td>
								<td class="tab11" width="80px" bgcolor="#eeeeee">계급</td>
								<td class="tab22"><nobr>
									<comment id="__NSID__"><object id=gclx_miligrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_miligrd">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="MINORNM^0^100">
											<param name=BindColumn			value=MINORCD>
			 						</object></comment><script>__ws__(__NSID__);</script></nobr>
								</td>
								<!--
								<td class="tab11" width="60px" bgcolor="#eeeeee">군번</td>
								<td class="tab22">
									<comment id="__NSID__"><object id=gcem_milino classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:5px; width:105px; height:17px; font-family:굴림; font-size:9pt; " >
											<param name=Alignment				value=0>
											<param name=Border					value=false>
											<param name=Format					value="000000000000000">
											<param name=PromptChar			value="_">
								  </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;&nbsp;
								</td>
								-->
							</tr>
							<tr>
								<!--
								<td class="tab12" bgcolor="#eeeeee">근무지</td>
								<td class="tab23"><input id="txt_miliplc" name="txt_miliplc" type="text" class="txt11" style="width:78px;"></td>
								-->
								<td class="tab12" bgcolor="#eeeeee">병무기간</td>
								<td class="tab23"><nobr>
									<comment id="__NSID__"><object id=gcem_milifrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:6px; width:90px; height:17px; font-family:굴림; font-size:9pt;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="YYYY년MM월DD일">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									&nbsp;&nbsp;~&nbsp;
									<comment id="__NSID__"><object id=gcem_militodt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:6px; width:90px; height:17px; font-family:굴림; font-size:9pt;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="YYYY년MM월DD일">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script></nobr>
								</td>
								<td class="tab12" bgcolor="#eeeeee">면제사유</td>
								<td COLSPAN=3><input id="txt_nmreason" name="txt_nmreason" type="text" class="txt11" style="width:450px;" maxlength="40" onBlur="bytelength(this,this.value,40);"></td>
									
									</tr>
								</table>

								</td>
							</tr>
						</table>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<table width=100% border=0 cellspacing=0 cellpadding=0 background="../../Common/img/com_cont_subtxt_bg.gif" style="cursor:hand;" height=31>
				<tr>
					<td onclick="ln_Disp(gcgd_family,'gcds_family');" style="cursor:hand;"><b>가족사항</b></td>
					<td align=right>
						<table  border=0 cellspacing=0 cellpadding=0 background="../../Common/img/com_cont_subtxt_bg.gif" style="cursor:hand;" height=31 style="cursor:hand;">
							<tr>
								<td width=100% onclick="ln_Disp(gcgd_family,'gcds_family');"></td>
								<td align=right width=40><img src="../../Common/img/btn/com_b_insert.gif" width=40 height=21  style="cursor:hand" onclick="ln_Add(gcds_family,'gcds_family')"></td>
								<td>&nbsp;</td>
								<td width=0 align=right width=40><img src="../../Common/img/btn/com_b_delete.gif" width=40 height=21 style="cursor:hand" onclick="ln_Delete(gcds_family)"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_family style="WIDTH: 875; HEIGHT: 139px;border:1 solid #777777;display:none" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_family">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
		          <PARAM NAME="Editable"		VALUE="true">
						  <param name="AllShowEdit" VALUE="true">
						  <PARAM NAME="Format"			VALUE=" 
								<C> Name='가족관계'		ID=REFCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=150  align=center, EditStyle='Lookup', Data='gcds_famre:minorcd:minornm' </C> 
								<C> Name='성명'				ID=FAMNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center </C> 
								<C> Name='주민번호'		ID=RESINOF	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center Mask='XXXXXX-XXXXXXX'</C> 
								<C> Name='최종학력'		ID=LSTEDC		HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=center, EditStyle='Lookup', Data='gcds_fameduc:minorcd:minornm'</C>
								<C> Name='현직업'			ID=CMPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=223	align=left </C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<!--
								<C> Name='최종학교명' ID=SCHNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=left </C>
						-->
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<table width=100% border=0 cellspacing=0 cellpadding=0 background="../../Common/img/com_cont_subtxt_bg.gif" style="cursor:hand;" height=31>
				<tr>
					<td onclick="ln_Disp(gcgd_license,'gcds_license');" style="cursor:hand;"><b>자격 및 면허</b></td>
					<td align=right>
						<table  border=0 cellspacing=0 cellpadding=0 background="../../Common/img/com_cont_subtxt_bg.gif" style="cursor:hand;" height=31 style="cursor:hand;">
							<tr>
								<td width=100% onclick="ln_Disp(gcgd_license,'gcds_license');"></td>
								<td align=right width=40><img src="../../Common/img/btn/com_b_insert.gif" id=img_lic style="cursor:hand" onclick="ln_Add(gcds_license,'gcds_license')"></td>
								<td>&nbsp;</td>
								<td width=0 align=right width=40><img src="../../Common/img/btn/com_b_delete.gif" width=40 height=21 style="cursor:hand" onclick="ln_Delete(gcds_license)"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_license style="WIDTH: 875; HEIGHT: 139px;border:1 solid #777777;display:none" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_license">
              <PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
		          <PARAM NAME="Editable"		VALUE="true">
						  <param name="AllShowEdit" VALUE="true">
						  <PARAM NAME="Format"			VALUE=" 
								<C> Name='종류'			ID=LCSTYPE	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left, Editstyle=lookup data='gcds_lcstype:minorcd:minornm' </C>
								<C> Name='등급'			ID=LCSCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=103	align=left, Editstyle=lookup data='gcds_lcscd:minorcd:minornm' </C>
								<C> Name='자격/면허번호' ID=LCSNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left </C>
								<C> Name='취득일'		ID=GETDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center Mask='XXXX/XX/XX'</C> 
								<C> Name='변경일'		ID=CHGDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center Mask='XXXX/XX/XX'</C> 
								<C> Name='발급기관'	ID=ISSPART	HeadAlign=Center HeadBgColor=#B9D4DC Width=260	align=left</C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_eng,'gcds_eng');" background="../../Common/img/com_cont_subtxt_bg.gif" style="cursor:hand;" height=31><b>외국어</b></td>
				</tr>
				<tr>
					<td>
						<div id=gcgd_eng style="position:relative;display:none">
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:876px;height:40px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
							<tr>
								<td>
							<table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:876px;height:40px;font-size:9pt;background-color:#ffffff;border:0 solid #708090'>
							<tr>
								<td class="tab11" width="200px" bgcolor="#eeeeee">제 1 외국어</td>
								<td class="tab11" width="100px" bgcolor="#eeeeee">토익</td>
								<td class="tab21" width="80px;">
									<comment id="__NSID__"><object id=gcem_toescr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Numeric	      value="true">
											<param name=Maxlength     value="4">
							    </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" width="100px" bgcolor="#eeeeee">토플</td>
								<td class="tab22" width="350px;">
									<comment id="__NSID__"><object id=gcem_tofscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Numeric	      value="true">
											<param name=Maxlength     value="4">
							    </object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" bgcolor="#eeeeee">제 2 외국어</td>
								<td class="tab11" width="100px" bgcolor="#eeeeee">JPT</td>
								<td class="tab21" width="80px;">
									<comment id="__NSID__"><object id=gcem_jptscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Numeric	      value="true">
											<param name=Maxlength     value="4">
							    </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab11" width="100px" bgcolor="#eeeeee">HSK</td>
								<td class="tab22" width="350px;">
									<comment id="__NSID__"><object id=gcem_hskscr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:3px; width:30px; height:17px; font-family:굴림; font-size:9pt;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Numeric	      value="true">
											<param name=Maxlength     value="4">
							    </object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab12" bgcolor="#eeeeee">기타 가능 외국어</td>
								<td colspan=5><input id="txt_etclng" name="txt_etclng" type="text" class="txt11" style="width:650px;" maxlength="50" onBlur="bytelength(this,this.value,50);"></td>
											</tr>
										</table>

									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!--tr>
		<td colspan="2">
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_oa,'gcds_oa');" background="../../Common/img/com_cont_subtxt_bg.gif"   style="cursor:hand;" height=31><b>전산</b></td>
				</tr>
				<tr>
					<td>
						<div id=gcgd_oa style="position:relative;display:none">
						<table cellpadding=0 cellspacing=0  border=0 width=876 style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090'>
							<tr>
								<td class="tab12" width="80px;" bgcolor="#eeeeee">한글</td>
								<td class="tab23" width="100px;">
       						<comment id="__NSID__"><object id=gclx_hwgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
       							style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
       								<param name=CBData					value="1^상,2^중,3^하">
       								<param name=CBDataColumns		value="Code, Parm">
      								<param name=SearchColumn		value="Parm">
      								<param name=Sort						value="false">
      								<param name=ListExprFormat	value="Parm^0^80">
      								<param name=BindColumn			value="Code">
       						</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab12" width="80px;" bgcolor="#eeeeee">엑셀</td>
								<td class="tab23" width="100px;">
       						<comment id="__NSID__"><object id=gclx_exgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
       							style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
       								<param name=CBData					value="1^상,2^중,3^하">
       								<param name=CBDataColumns		value="Code, Parm">
      								<param name=SearchColumn		value="Parm">
      								<param name=Sort						value="false">
      								<param name=ListExprFormat	value="Parm^0^80">
      								<param name=BindColumn			value="Code">
       						</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab12" width="80px;" bgcolor="#eeeeee">파워포인트</td>
								<td class="tab23" width="100px;">
       						<comment id="__NSID__"><object id=gclx_pwgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
       							style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
       								<param name=CBData					value="1^상,2^중,3^하">
       								<param name=CBDataColumns		value="Code, Parm">
      								<param name=SearchColumn		value="Parm">
      								<param name=Sort						value="false">
      								<param name=ListExprFormat	value="Parm^0^80">
      								<param name=BindColumn			value="Code">
       						</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td class="tab12" width="80px;" bgcolor="#eeeeee">엑세스</td>
								<td width="100px;">
       						<comment id="__NSID__"><object id=gclx_acgrdcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
       							style="position:relative;left:8px;top:0px;font-size:12px;width:80px;height:200px;">
       								<param name=CBData					value="1^상,2^중,3^하">
       								<param name=CBDataColumns		value="Code, Parm">
      								<param name=SearchColumn		value="Parm">
      								<param name=Sort						value="false">
      								<param name=ListExprFormat	value="Parm^0^80">
      								<param name=BindColumn			value="Code">
       						</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
						</table>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr-->
	<tr>
		<td colspan="2">
			<table width=100% border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td style="cursor:hand" onclick="ln_Disp(gcgd_wr,'gcds_hrself');" background="../../Common/img/com_cont_subtxt_bg.gif"   style="cursor:hand;" height=31><b>자기소개서</b></td>
				</tr>
				<tr>
					<td>
						<div id=gcgd_wr style="position:relative;display:none">
						<table cellpadding=0 cellspacing=0  border=0 width=876 style='width:876px;height:560px;font-size:9pt;background-color:#ffffff;'>
							<tr><td style="height:135px;border:1 solid #708090">
								<img src="../../Common/img/new_img2/tab_01.gif" style="position:relative;top:5px;left:8px">
								<textarea class="txt21" id="txt_growth" name="txt_growth" style="width:860px;height:100px; overflow-x:hidden;padding:0; " maxlength="500" onBlur="bytelength(this,this.value,500);" WRAP=physical></textarea>
							</td></tr>
							<tr><td height="7px;"></td></tr>
							<tr><td style="height:135px;border:1 solid #708090">
								<img src="../../Common/img/new_img2/tab_02.gif" style="position:relative;top:5px;left:8px">
								<textarea class="txt21" id="txt_school" name="txt_school" style="width:860px;height:100px;" maxlength="500" onBlur="bytelength(this,this.value,500);"></textarea>
							</td></tr>
							<tr><td height="7px;"></td></tr>
							<tr><td style="height:135px;border:1 solid #708090">
								<img src="../../Common/img/new_img2/tab_03.gif" style="position:relative;top:5px;left:8px">
								<textarea class="txt21" id="txt_career" name="txt_career" style="width:860px;height:100px;" maxlength="500" onBlur="bytelength(this,this.value,500);"></textarea>
							</td></tr>
							<tr><td height="7px;"></td></tr>
							<tr><td style="height:135px;border:1 solid #708090">
								<img src="../../Common/img/new_img2/tab_04.gif" style="position:relative;top:5px;left:8px">
								<textarea class="txt21" id="txt_ambition" name="txt_ambition" style="width:860px;height:100px;" maxlength="500" onBlur="bytelength(this,this.value,500);"></textarea>
							</td></tr>
						</table>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td colspan="2" height="60px;"></td></tr>
</table>
<!--textarea cols=30 rows=30 id=test_txt style="visibility:hidden;">
</textarea-->

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT> 
	<param name=DataID    value=gcds_data>
	<PARAM NAME="ActiveBind"		VALUE="true">
	<param name=BindInfo  value='
		<C>Col=NMK        Ctrl=txt_nmk         Param=value</C>
		<C>Col=NMC        Ctrl=txt_nmc         Param=value</C>
		<C>Col=NME        Ctrl=txt_nme         Param=value</C>
		<C>Col=RESINO     Ctrl=gcem_resino2    Param=text</C>
		<C>Col=BIRDT      Ctrl=gcem_birdt      Param=text</C>
		<C>Col=BIRCITY    Ctrl=gclx_bircity    Param=BindColVal</C>
		<C>Col=HOBBY      Ctrl=txt_hobby       Param=value</C>
		<C>Col=SPECIAL    Ctrl=txt_special     Param=value</C>
		<C>Col=RILIGN     Ctrl=gclx_rilign     Param=BindColVal</C>
		<C>Col=CARYEAR    Ctrl=gcem_caryear    Param=Text</C>
		<C>Col=TELNO      Ctrl=txt_telno       Param=value</C>
		<C>Col=HPNO       Ctrl=txt_hpno        Param=value</C>
		<C>Col=EMAIL      Ctrl=txt_email       Param=value</C>
		<C>Col=OZIPCD     Ctrl=gcem_ozipcd     Param=text</C>
		<C>Col=OADDR1     Ctrl=txt_oaddr1      Param=value</C>
		<C>Col=OADDR2     Ctrl=txt_oaddr2      Param=value</C>
		<C>Col=CZIPCD     Ctrl=gcem_czipcd     Param=text</C>
		<C>Col=CADDR1     Ctrl=txt_caddr1      Param=value</C>
		<C>Col=CADDR2     Ctrl=txt_caddr2      Param=value</C>

		<C>Col=EYEL		    Ctrl=gcem_eyel			 Param=Text</C>
		<C>Col=EYER		    Ctrl=gcem_eyer			 Param=Text</C>
		<C>Col=HEIGHT	    Ctrl=gcem_height		 Param=Text</C>
		<C>Col=WEIGHT	    Ctrl=gcem_weight		 Param=Text</C>
		<C>Col=BLOOD	    Ctrl=gcem_blood			 Param=Text</C>
		<C>Col=RGHANDYN   Ctrl=gclx_rghandyn	 Param=BindColVal</C>

		<C>Col=MILIDIV    Ctrl=gclx_milidiv		 Param=BindColVal</C>
		<C>Col=MILIKND    Ctrl=gclx_miliknd		 Param=BindColVal</C>
		<C>Col=MILIGRD    Ctrl=gclx_miligrd		 Param=BindColVal</C>
		<C>Col=MILINO     Ctrl=gcem_milino		 Param=Text</C>
		<C>Col=MILIPLC    Ctrl=txt_miliplc		 Param=Value</C>
		<C>Col=MILIFRDT   Ctrl=gcem_milifrdt	 Param=Text</C>
		<C>Col=MILITODT   Ctrl=gcem_militodt	 Param=Text</C>
		<C>Col=NMREASON   Ctrl=txt_nmreason		 Param=Value</C>

		<C>Col=ENGLVL			Ctrl=gclx_englvl		 Param=BindColVal</C>
		<C>Col=TOESCR			Ctrl=gcem_toescr		 Param=Text</C>
		<C>Col=JPTSCR			Ctrl=gcem_JPTSCR		 Param=Text</C>
		<C>Col=DELFSCR		Ctrl=gcem_delfscr		 Param=Text</C>
		<C>Col=TOFSCR			Ctrl=gcem_tofscr		 Param=Text</C>
		<C>Col=DALFSCR		Ctrl=gcem_dalfscr		 Param=Text</C>
		<C>Col=TEPSSCR		Ctrl=gcem_tepsscr		 Param=Text</C>
		<C>Col=HSKSCR			Ctrl=gcem_hskscr		 Param=Text</C>
		<C>Col=ETCLNG			Ctrl=txt_etclng			 Param=Value</C>

		<C>Col=HWGRDCD		Ctrl=gclx_hwgrdcd		 Param=BindColVal</C>
		<C>Col=EXGRDCD		Ctrl=gclx_exgrdcd		 Param=BindColVal</C>
		<C>Col=PWGRDCD		Ctrl=gclx_pwgrdcd		 Param=BindColVal</C>
		<C>Col=ACGRDCD		Ctrl=gclx_acgrdcd		 Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object id=gcbn_hrself classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT> 
	<param name=DataID    value=gcds_hrself>
	<PARAM NAME="ActiveBind"		VALUE="true">
	<param name=BindInfo  value='
		<C>Col=GROWTH     Ctrl=txt_growth      Param=value</C>
		<C>Col=SCHOOL     Ctrl=txt_school      Param=value</C>
		<C>Col=CAREER     Ctrl=txt_career      Param=value</C>
		<C>Col=AMBITION   Ctrl=txt_ambition    Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>


<!------------------------------------------------------------------------
레포트
-------------------------------------------------------------------------->
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_data">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="

<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=127
	<R>id='education.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=127 ,DetailDataID='gcds_report01'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=183 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='2. 학 력 사 항' ,left=0 ,top=0 ,right=1691 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=0 ,top=61 ,right=106 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='졸업' ,left=5 ,top=64 ,right=101 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='(예정)' ,left=5 ,top=101 ,right=101 ,bottom=151 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='년도' ,left=5 ,top=138 ,right=101 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=103 ,top=61 ,right=524 ,bottom=127 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='출신학교' ,left=161 ,top=66 ,right=466 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1781 ,top=61 ,right=1974 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=968 ,top=61 ,right=1222 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='전공' ,left=997 ,top=66 ,right=1212 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=521 ,top=61 ,right=979 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='비율' ,left=1791 ,top=66 ,right=1963 ,bottom=177 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='소재지' ,left=524 ,top=66 ,right=968 ,bottom=175 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1595 ,top=61 ,right=1786 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='만점' ,left=1598 ,top=66 ,right=1781 ,bottom=177 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1416 ,top=61 ,right=1598 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='평점' ,left=1423 ,top=66 ,right=1588 ,bottom=177 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1220 ,top=61 ,right=1418 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='구분' ,left=1230 ,top=69 ,right=1405 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=103 ,top=124 ,right=339 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=336 ,top=124 ,right=521 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='학교' ,left=344 ,top=130 ,right=513 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='학교명' ,left=132 ,top=130 ,right=307 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=48 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=0 ,top=0 ,right=0 ,bottom=48 </L>
	<L> left=103 ,top=0 ,right=103 ,bottom=48 </L>
	<L> left=336 ,top=0 ,right=336 ,bottom=48 </L>
	<L> left=521 ,top=0 ,right=521 ,bottom=48 </L>
	<L> left=979 ,top=0 ,right=979 ,bottom=48 </L>
	<L> left=1220 ,top=0 ,right=1220 ,bottom=48 </L>
	<L> left=1418 ,top=0 ,right=1418 ,bottom=48 </L>
	<L> left=1597 ,top=0 ,right=1597 ,bottom=48 </L>
	<L> left=1786 ,top=0 ,right=1786 ,bottom=48 </L>
	<L> left=1974 ,top=0 ,right=1974 ,bottom=48 </L>
	<C>id='GRAYY', left=5, top=3, right=101, bottom=48 ,mask='XXXX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EDCCD', left=344, top=3, right=519, bottom=48, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CITY', left=524, top=3, right=974, bottom=48, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCHNM', left=108, top=3, right=331, bottom=48, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PGCCD', left=982, top=3, right=1214, bottom=48, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AVRUNI', left=1429, top=3, right=1590, bottom=48, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERFECT', left=1606, top=3, right=1778, bottom=48, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{(AVRUNI/PERFECT)*100}', left=1797, top=3, right=1969, bottom=48 ,mask='XXX %', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EDCDIV', left=1225, top=3, right=1410, bottom=48, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=0 ,top=50 ,right=1974 ,bottom=50 </L>
</B>


	</R>
</A>
<A>id=Area3 ,left=0,top=0 ,right=2000 ,bottom=164
	<R>id='career.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=161 ,DetailDataID='gcds_career'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=172 ,face='Arial' ,size=10 ,penwidth=1
			<T>id='3. 경 력 사 항' ,left=0 ,top=0 ,right=1691 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=0 ,top=58 ,right=106 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103 ,top=58 ,right=471 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=103 ,top=119 ,right=288 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=286 ,top=119 ,right=471 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=468 ,top=58 ,right=945 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='근무기간' ,left=108 ,top=64 ,right=466 ,bottom=119 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='퇴사일' ,left=291 ,top=127 ,right=466 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='입사일' ,left=108 ,top=127 ,right=283 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='No' ,left=5 ,top=64 ,right=101 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='직장명' ,left=474 ,top=64 ,right=939 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1172 ,top=58 ,right=1974 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=942 ,top=58 ,right=1177 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='담당업무' ,left=1400 ,top=64 ,right=1744 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='직위명' ,left=958 ,top=64 ,right=1151 ,bottom=169 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=52 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=1974 ,top=0 ,right=1974 ,bottom=53 </L>
			<L> left=1177 ,top=0 ,right=1177 ,bottom=53 </L>
			<L> left=942 ,top=0 ,right=942 ,bottom=53 </L>
			<L> left=468 ,top=0 ,right=468 ,bottom=53 </L>
			<L> left=286 ,top=0 ,right=286 ,bottom=53 </L>
			<L> left=103 ,top=0 ,right=103 ,bottom=53 </L>
			<L> left=0 ,top=0 ,right=0 ,bottom=53 </L>
			<L> left=0 ,top=52 ,right=1974 ,bottom=53 </L>
			<C>id='COMNM', left=474, top=3, right=939, bottom=53, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ENDDT', left=291, top=3, right=466, bottom=53 ,mask='XXXX/XX/XX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='FRDT', left=108, top=3, right=283, bottom=53 ,mask='XXXX/XX/XX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{CURROW}', left=5, top=3, right=101, bottom=53, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DUTYNM', left=1180, top=3, right=1958, bottom=53, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='POSINM', left=947, top=3, right=1167, bottom=50, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>
<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=130
	<R>id='sinche.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_data'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=135 ,face='새굴림' ,size=9 ,penwidth=1
			<L> left=3 ,top=66 ,right=1974 ,bottom=66 </L>
			<T>id='좌:' ,left=233 ,top=77 ,right=294 ,bottom=124 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='EYER', left=508, top=77, right=648, bottom=124, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='우:' ,left=442 ,top=77 ,right=500 ,bottom=124 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=1093 ,top=66 ,right=1246 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='체중' ,left=1106 ,top=74 ,right=1233 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1553 ,top=66 ,right=1707 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='혈액형' ,left=1566 ,top=74 ,right=1693 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<L> left=1974 ,top=66 ,right=1974 ,bottom=135 </L>
			<C>id='EYEL', left=296, top=77, right=426, bottom=124, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='WEIGHT', left=1259, top=77, right=1482, bottom=124 ,mask='XXX Kg', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='HEIGHT', left=812, top=77, right=1035, bottom=124 ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='BLOOD', left=1712, top=77, right=1924, bottom=124, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='4. 신 체 사 항' ,left=0 ,top=3 ,right=503 ,bottom=64 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=654 ,top=66 ,right=807 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='신장' ,left=664 ,top=77 ,right=791 ,bottom=124 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=0 ,top=66 ,right=222 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='시력' ,left=53 ,top=74 ,right=180 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<L> left=0 ,top=66 ,right=0 ,bottom=132 </L>
			<L> left=0 ,top=135 ,right=1974 ,bottom=135 </L>
		</B>

	</R>
</A>
<A>id=Area5 ,left=0,top=0 ,right=2000 ,bottom=130
	<R>id='miligrd.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_data'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=201 ,face='새굴림' ,size=9 ,penwidth=1
			<L> left=0 ,top=64 ,right=1974 ,bottom=64 </L>
			<L> left=1974 ,top=64 ,right=1974 ,bottom=201 </L>
			<C>id='MILIDIV', left=230, top=74, right=640, bottom=122, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MILIKND', left=921, top=74, right=1416, bottom=122, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MILIGRD', left=1585, top=74, right=1950, bottom=122, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='~' ,left=466 ,top=140 ,right=516 ,bottom=188 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='MILITODT', left=516, top=140, right=751, bottom=188 ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MILIFRDT', left=230, top=140, right=466, bottom=188 ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='NMREASON', left=921, top=140, right=1945, bottom=188, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=0 ,top=64 ,right=0 ,bottom=201 </L>
			<T>id='5. 병 역 사 항' ,left=0 ,top=3 ,right=503 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=1426 ,top=64 ,right=1580 ,bottom=132 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='계급' ,left=1439 ,top=77 ,right=1566 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=762 ,top=64 ,right=915 ,bottom=201 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='면제사유' ,left=773 ,top=143 ,right=900 ,bottom=191 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='군별' ,left=773 ,top=74 ,right=900 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=0 ,top=64 ,right=222 ,bottom=201 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='병무기간' ,left=53 ,top=140 ,right=180 ,bottom=188 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='병역구분' ,left=53 ,top=71 ,right=180 ,bottom=119 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<L> left=0 ,top=132 ,right=1974 ,bottom=132 </L>
			<L> left=0 ,top=201 ,right=1974 ,bottom=201 </L>
		</B>
	</R>
</A>
<A>id=Area6 ,left=0,top=0 ,right=2000 ,bottom=69
	<R>id='family.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=69 ,DetailDataID='gcds_report06'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=119 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=0 ,top=58 ,right=106 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=0 ,top=61 ,right=0 ,bottom=119 </L>
			<X>left=1162 ,top=58 ,right=1527 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='최 종 학 력' ,left=1175 ,top=61 ,right=1511 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=804 ,top=58 ,right=1164 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='주민번호' ,left=905 ,top=61 ,right=1077 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='No' ,left=3 ,top=61 ,right=98 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='6. 가 족 사 항' ,left=0 ,top=0 ,right=1691 ,bottom=58 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=1524 ,top=58 ,right=1974 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='현 직 업' ,left=1537 ,top=64 ,right=1945 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=447 ,top=58 ,right=807 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=101 ,top=58 ,right=450 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='성  명' ,left=532 ,top=64 ,right=733 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='가족관계' ,left=156 ,top=61 ,right=394 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=58 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=1974 ,top=0 ,right=1974 ,bottom=59 </L>
			<L> left=1524 ,top=0 ,right=1524 ,bottom=59 </L>
			<L> left=1163 ,top=0 ,right=1163 ,bottom=59 </L>
			<L> left=807 ,top=0 ,right=807 ,bottom=59 </L>
			<L> left=447 ,top=0 ,right=447 ,bottom=59 </L>
			<L> left=101 ,top=0 ,right=101 ,bottom=59 </L>
			<L> left=0 ,top=0 ,right=0 ,bottom=58 </L>
			<L> left=0 ,top=58 ,right=1974 ,bottom=59 </L>
			<C>id='{CURROW}', left=3, top=3, right=98, bottom=56, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LSTEDC', left=1169, top=3, right=1519, bottom=56, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CMPNM', left=1529, top=3, right=1966, bottom=56, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RESINOF', left=812, top=3, right=1156, bottom=56 ,mask='XXXXXX-XXXXXXX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='FAMNM', left=450, top=3, right=799, bottom=56, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REFCD', left=108, top=3, right=439, bottom=56, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>
<A>id=Area7 ,left=0,top=0 ,right=2000 ,bottom=66
	<R>id='license.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=66 ,DetailDataID='gcds_report07'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=111 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=0 ,top=58 ,right=106 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='No' ,left=8 ,top=64 ,right=95 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1228 ,top=58 ,right=1495 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='변경일' ,left=1254 ,top=64 ,right=1461 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='7. 자 격 면 허' ,left=0 ,top=0 ,right=1691 ,bottom=58 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=619 ,top=58 ,right=987 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='자격/면허번호' ,left=624 ,top=64 ,right=982 ,bottom=111 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=984 ,top=58 ,right=1233 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='취득일' ,left=1003 ,top=64 ,right=1209 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1492 ,top=58 ,right=1974 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='발급기관' ,left=1569 ,top=64 ,right=1889 ,bottom=111 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=103 ,top=58 ,right=421 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=418 ,top=58 ,right=622 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='등급' ,left=434 ,top=64 ,right=614 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='종류' ,left=119 ,top=64 ,right=402 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=0 ,top=0 ,right=0 ,bottom=66 </L>
	<L> left=103 ,top=0 ,right=103 ,bottom=66 </L>
	<L> left=418 ,top=0 ,right=418 ,bottom=66 </L>
	<L> left=621 ,top=0 ,right=621 ,bottom=66 </L>
	<L> left=984 ,top=0 ,right=984 ,bottom=66 </L>
	<L> left=1232 ,top=0 ,right=1232 ,bottom=66 </L>
	<L> left=1492 ,top=0 ,right=1492 ,bottom=66 </L>
	<L> left=1974 ,top=0 ,right=1974 ,bottom=66 </L>
	<L> left=0 ,top=66 ,right=1974 ,bottom=66 </L>
	<C>id='ISSPART', left=1498, top=5, right=1966, bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHGDT', left=1236, top=5, right=1490, bottom=64 ,mask='XXXX/XX/XX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GETDT', left=990, top=5, right=1225, bottom=64 ,mask='XXXX/XX/XX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LCSNO', left=624, top=5, right=982, bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=5, top=5, right=101, bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LCSTYPE', left=108, top=5, right=413, bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LCSCD', left=429, top=5, right=614, bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	</R>
</A>
<A>id=Area8 ,left=0,top=0 ,right=2000 ,bottom=129
	<R>id='english.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_data'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=273 ,face='새굴림' ,size=9 ,penwidth=1
	<C>id='JPTSCR', left=439, top=146, right=770, bottom=193 , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HSKSCR', left=1167, top=146, right=1498, bottom=193 , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOFSCR', left=1167, top=82, right=1498, bottom=130 , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOESCR', left=439, top=82, right=770, bottom=130 , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETCLNG', left=273, top=212, right=1950, bottom=259, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1 ,top=66 ,right=1974 ,bottom=66 </L>
	<T>id='8. 외 국 어' ,left=0 ,top=3 ,right=505 ,bottom=64 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1003 ,top=66 ,right=1156 ,bottom=204 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='HSK' ,left=1013 ,top=143 ,right=1140 ,bottom=191 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='토플' ,left=1013 ,top=79 ,right=1140 ,bottom=127 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=0 ,top=66 ,right=260 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='제1외국어' ,left=16 ,top=77 ,right=198 ,bottom=124 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='기타 가능 외국어' ,left=8 ,top=212 ,right=254 ,bottom=259 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='제2외국어' ,left=16 ,top=146 ,right=196 ,bottom=193 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=259 ,top=273 ,right=1974 ,bottom=273 </L>
	<L> left=1 ,top=204 ,right=262 ,bottom=204 </L>
	<X>left=259 ,top=66 ,right=413 ,bottom=204 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=407 ,top=204 ,right=1974 ,bottom=204 </L>
	<T>id='JPT' ,left=273 ,top=143 ,right=400 ,bottom=193 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='토익' ,left=273 ,top=79 ,right=400 ,bottom=127 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=1 ,top=138 ,right=1974 ,bottom=138 </L>
	<L> left=1974 ,top=66 ,right=1974 ,bottom=273 </L>
</B>
	</R>
</A>
<A>id=Area9 ,left=0,top=0 ,right=2000 ,bottom=129
	<R>id='hrself.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_report09'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2479 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=0 ,top=762 ,right=1971 ,bottom=1275 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=0 ,top=153 ,right=1971 ,bottom=667 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='9. 자 기 소 개 서' ,left=0 ,top=0 ,right=503 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=0 ,top=87 ,right=212 ,bottom=156 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=0 ,top=696 ,right=212 ,bottom=762 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='학창생활' ,left=3 ,top=699 ,right=209 ,bottom=759 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='성장배경' ,left=5 ,top=93 ,right=206 ,bottom=151 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=0 ,top=1902 ,right=492 ,bottom=1969 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='지원동기 및 입사후포부' ,left=5 ,top=1905 ,right=413 ,bottom=1963 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=0 ,top=1299 ,right=212 ,bottom=1365 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='경력사항' ,left=19 ,top=1302 ,right=198 ,bottom=1363 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<C>id='GROWTH', left=16, top=172, right=1953, bottom=648, align='left', Multiline=true</C>
			<C>id='SCHOOL', left=16, top=781, right=1953, bottom=1257, align='left', Multiline=true</C>
			<X>left=0 ,top=1363 ,right=1971 ,bottom=1876 ,border=true ,penstyle=solid ,penwidth=1</X>
			<C>id='CAREER', left=16, top=1381, right=1953, bottom=1857, align='left', Multiline=true</C>
			<X>left=0 ,top=1966 ,right=1971 ,bottom=2479 ,border=true ,penstyle=solid ,penwidth=1</X>
			<C>id='AMBITION', left=16, top=1984, right=1953, bottom=2461, align='left', Multiline=true</C>
		</B>
	</R>
</A>
<B>id=Footer ,left=0 ,top=2539 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1593 ,top=230 ,right=1974 ,bottom=331</I>
	<L> left=0 ,top=220 ,right=1974 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=0 ,top=230 ,right=1974 ,bottom=310</T>
</B>




">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>

<!--
<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=127
	<R>id='education.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=127 ,DetailDataID='gcds_report01'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=185 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='2. 학 력 사 항' ,left=11 ,top=0 ,right=1701 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=11 ,top=61 ,right=116 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='졸업' ,left=16 ,top=64 ,right=111 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='(예정)' ,left=16 ,top=101 ,right=111 ,bottom=151 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='년도' ,left=16 ,top=138 ,right=111 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=114 ,top=61 ,right=534 ,bottom=127 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='출신학교' ,left=172 ,top=66 ,right=476 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1791 ,top=61 ,right=1984 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=979 ,top=61 ,right=1233 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='전공' ,left=1008 ,top=66 ,right=1222 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=532 ,top=61 ,right=990 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='비율' ,left=1802 ,top=66 ,right=1974 ,bottom=177 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='소재지' ,left=534 ,top=66 ,right=979 ,bottom=175 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1606 ,top=61 ,right=1797 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='만점' ,left=1609 ,top=66 ,right=1791 ,bottom=177 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1426 ,top=61 ,right=1609 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='평점' ,left=1434 ,top=66 ,right=1598 ,bottom=177 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1230 ,top=61 ,right=1429 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='구분' ,left=1241 ,top=69 ,right=1416 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=114 ,top=124 ,right=349 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=347 ,top=124 ,right=534 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='학교' ,left=355 ,top=130 ,right=524 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='학교명' ,left=143 ,top=130 ,right=318 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=11 ,top=0 ,right=11 ,bottom=50 </L>
	<L> left=114 ,top=0 ,right=114 ,bottom=50 </L>
	<L> left=347 ,top=0 ,right=347 ,bottom=50 </L>
	<L> left=532 ,top=0 ,right=532 ,bottom=50 </L>
	<L> left=1230 ,top=0 ,right=1230 ,bottom=50 </L>
	<L> left=1795 ,top=0 ,right=1795 ,bottom=50 </L>
	<L> left=1982 ,top=0 ,right=1982 ,bottom=50 </L>
	<C>id='GRAYY', left=16, top=3, right=111, bottom=50 ,mask='XXXX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EDCCD', left=355, top=3, right=529, bottom=50, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CITY', left=534, top=3, right=984, bottom=50, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCHNM', left=119, top=3, right=341, bottom=50, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=989 ,top=0 ,right=989 ,bottom=50 </L>
	<C>id='PGCCD', left=992, top=3, right=1225, bottom=50, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1606 ,top=0 ,right=1606 ,bottom=50 </L>
	<C>id='AVRUNI', left=1439, top=3, right=1601, bottom=50, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERFECT', left=1617, top=3, right=1789, bottom=50, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{(AVRUNI/PERFECT)*100}', left=1807, top=3, right=1979, bottom=50, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, mask='XXX %'</C>
	<L> left=1982 ,top=50 ,right=11 ,bottom=50 </L>
	<L> left=1428 ,top=0 ,right=1428 ,bottom=50 </L>
	<C>id='EDCDIV', left=1236, top=3, right=1421, bottom=50, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


	</R>
</A>
<A>id=Area3 ,left=0,top=0 ,right=2000 ,bottom=164
	<R>id='career.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=161 ,DetailDataID='gcds_career'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=175 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='3. 경 력 사 항' ,left=11 ,top=0 ,right=1701 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=11 ,top=58 ,right=116 ,bottom=175 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=114 ,top=58 ,right=482 ,bottom=120 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=114 ,top=119 ,right=299 ,bottom=175 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=296 ,top=119 ,right=482 ,bottom=175 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=479 ,top=58 ,right=955 ,bottom=175 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='근무기간' ,left=119 ,top=64 ,right=476 ,bottom=119 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='퇴사일' ,left=302 ,top=127 ,right=476 ,bottom=175 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='입사일' ,left=119 ,top=127 ,right=294 ,bottom=175 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='No' ,left=16 ,top=64 ,right=111 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='직장명' ,left=484 ,top=64 ,right=950 ,bottom=175 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1183 ,top=58 ,right=1984 ,bottom=175 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=953 ,top=58 ,right=1188 ,bottom=175 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='담당업무' ,left=1410 ,top=64 ,right=1754 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='직위명' ,left=968 ,top=64 ,right=1161 ,bottom=169 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='COMNM', left=484, top=3, right=950, bottom=53, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENDDT', left=302, top=3, right=476, bottom=53 ,mask='XXXX/XX/XX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRDT', left=119, top=3, right=294, bottom=53 ,mask='XXXX/XX/XX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=16, top=3, right=111, bottom=53, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1982 ,top=0 ,right=1982 ,bottom=53 </L>
	<L> left=1187 ,top=0 ,right=1187 ,bottom=53 </L>
	<L> left=953 ,top=0 ,right=953 ,bottom=53 </L>
	<L> left=479 ,top=0 ,right=479 ,bottom=53 </L>
	<L> left=296 ,top=0 ,right=296 ,bottom=53 </L>
	<L> left=114 ,top=0 ,right=114 ,bottom=53 </L>
	<C>id='DUTYNM', left=1191, top=3, right=1969, bottom=53, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=11 ,top=0 ,right=11 ,bottom=53 </L>
	<L> left=11 ,top=51 ,right=1984 ,bottom=51 </L>
	<C>id='POSINM', left=958, top=3, right=1177, bottom=50, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	</R>
</A>
<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=130
	<R>id='sinche.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_data'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=135 ,face='새굴림' ,size=9 ,penwidth=1
	<L> left=13 ,top=66 ,right=1982 ,bottom=66 </L>
	<T>id='좌:' ,left=243 ,top=77 ,right=304 ,bottom=124 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EYER', left=519, top=77, right=659, bottom=124, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='우:' ,left=452 ,top=77 ,right=511 ,bottom=124 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1103 ,top=66 ,right=1257 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='체중' ,left=1117 ,top=74 ,right=1244 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1564 ,top=66 ,right=1717 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='혈액형' ,left=1577 ,top=74 ,right=1704 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=1982 ,top=66 ,right=1982 ,bottom=135 </L>
	<C>id='EYEL', left=307, top=77, right=437, bottom=124, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WEIGHT', left=1270, top=77, right=1492, bottom=124, align='right' ,mask='XXX Kg', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HEIGHT', left=823, top=77, right=1045, bottom=124, align='right' ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BLOOD', left=1722, top=77, right=1934, bottom=124, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='4. 신 체 사 항' ,left=11 ,top=3 ,right=513 ,bottom=64 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=664 ,top=66 ,right=818 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='신장' ,left=675 ,top=77 ,right=802 ,bottom=124 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=11 ,top=66 ,right=233 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='시력' ,left=64 ,top=74 ,right=191 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=11 ,top=66 ,right=11 ,bottom=132 </L>
	<L> left=11 ,top=134 ,right=1982 ,bottom=134 </L>
</B>

	</R>
</A>
<A>id=Area5 ,left=0,top=0 ,right=2000 ,bottom=130
	<R>id='miligrd.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_data'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=201 ,face='새굴림' ,size=9 ,penwidth=1
	<L> left=11 ,top=64 ,right=1979 ,bottom=64 </L>
	<L> left=1979 ,top=64 ,right=1979 ,bottom=198 </L>
	<C>id='MILIDIV', left=241, top=74, right=651, bottom=122, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MILIKND', left=931, top=74, right=1426, bottom=122 ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MILIGRD', left=1595, top=74, right=1961, bottom=122 ,mask='XXX Kg', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='~' ,left=476 ,top=140 ,right=527 ,bottom=188 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MILITODT', left=527, top=140, right=762, bottom=188 ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MILIFRDT', left=241, top=140, right=476, bottom=188 ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NMREASON', left=931, top=140, right=1955, bottom=188 ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=11 ,top=64 ,right=11 ,bottom=193 </L>
	<T>id='5. 병 역 사 항' ,left=11 ,top=3 ,right=513 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1437 ,top=64 ,right=1590 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='계급' ,left=1450 ,top=77 ,right=1577 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=773 ,top=64 ,right=926 ,bottom=201 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='면제사유' ,left=783 ,top=143 ,right=910 ,bottom=191 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='군별' ,left=783 ,top=74 ,right=910 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=11 ,top=64 ,right=233 ,bottom=201 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='병무기간' ,left=64 ,top=140 ,right=191 ,bottom=188 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='병역구분' ,left=64 ,top=71 ,right=191 ,bottom=119 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=11 ,top=132 ,right=1982 ,bottom=132 </L>
	<L> left=11 ,top=200 ,right=1979 ,bottom=200 </L>
</B>


	</R>
</A>
<A>id=Area6 ,left=0,top=0 ,right=2000 ,bottom=69
	<R>id='family.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=69 ,DetailDataID='gcds_report06'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=119 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=8 ,top=58 ,right=114 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=8 ,top=61 ,right=8 ,bottom=119 </L>
	<X>left=1172 ,top=58 ,right=1537 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='최 종 학 력' ,left=1185 ,top=61 ,right=1521 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=815 ,top=58 ,right=1175 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='주민번호' ,left=915 ,top=61 ,right=1087 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='No' ,left=13 ,top=61 ,right=108 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='6. 가 족 사 항' ,left=8 ,top=0 ,right=1699 ,bottom=58 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1535 ,top=58 ,right=1984 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='현 직 업' ,left=1548 ,top=64 ,right=1955 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=458 ,top=58 ,right=818 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=111 ,top=58 ,right=460 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='성  명' ,left=542 ,top=64 ,right=743 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='가족관계' ,left=167 ,top=61 ,right=405 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=58 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{CURROW}', left=13, top=3, right=108, bottom=56, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LSTEDC', left=1180, top=3, right=1529, bottom=56, align='left', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1172 ,top=0 ,right=1172 ,bottom=58 </L>
	<L> left=1982 ,top=0 ,right=1982 ,bottom=58 </L>
	<C>id='CMPNM', left=1540, top=3, right=1976, bottom=56, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1535 ,top=0 ,right=1535 ,bottom=58 </L>
	<C>id='RESINOF', left=823, top=3, right=1167, bottom=56,mask='XXXXXX-XXXXXXX', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=817 ,top=0 ,right=817 ,bottom=58 </L>
	<L> left=460 ,top=0 ,right=460 ,bottom=58 </L>
	<C>id='FAMNM', left=460, top=3, right=810, bottom=56, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REFCD', left=119, top=3, right=450, bottom=56 , face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=112 ,top=0 ,right=112 ,bottom=58 </L>
	<L> left=8 ,top=0 ,right=8 ,bottom=58 </L>
	<L> left=11 ,top=58 ,right=1984 ,bottom=58 </L>
</B>


	</R>
</A>
<A>id=Area7 ,left=0,top=0 ,right=2000 ,bottom=66
	<R>id='license.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=66 ,DetailDataID='gcds_report07'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=114 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=11 ,top=58 ,right=116 ,bottom=114 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=114 ,top=58 ,right=376 ,bottom=114 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='No' ,left=19 ,top=64 ,right=106 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='종류' ,left=119 ,top=64 ,right=370 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=373 ,top=58 ,right=632 ,bottom=114 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='등급' ,left=378 ,top=64 ,right=622 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1238 ,top=58 ,right=1505 ,bottom=114 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='변경일' ,left=1265 ,top=64 ,right=1471 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='7. 자 격 면 허' ,left=11 ,top=0 ,right=1701 ,bottom=58 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=630 ,top=58 ,right=997 ,bottom=114 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='자격/면허번호' ,left=635 ,top=64 ,right=992 ,bottom=111 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=995 ,top=58 ,right=1244 ,bottom=114 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='취득일' ,left=1013 ,top=64 ,right=1220 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1503 ,top=58 ,right=1984 ,bottom=114 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='발급기관' ,left=1580 ,top=64 ,right=1900 ,bottom=111 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=69 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=11 ,top=0 ,right=11 ,bottom=69 </L>
	<L> left=114 ,top=0 ,right=114 ,bottom=69 </L>
	<L> left=373 ,top=0 ,right=373 ,bottom=69 </L>
	<L> left=630 ,top=0 ,right=630 ,bottom=69 </L>
	<L> left=995 ,top=0 ,right=995 ,bottom=69 </L>
	<L> left=1243 ,top=0 ,right=1243 ,bottom=69 </L>
	<L> left=1503 ,top=0 ,right=1503 ,bottom=69 </L>
	<L> left=1982 ,top=0 ,right=1982 ,bottom=69 </L>
	<L> left=11 ,top=69 ,right=1984 ,bottom=69 </L>
	<C>id='ISSPART', left=1508, top=5, right=1976, bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHGDT', left=1246, top=5, right=1500,mask='XXXX/XX/XX', bottom=64, align='center', face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GETDT', left=1000, top=5, right=1236,mask='XXXX/XX/XX', bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LCSCD', left=378, top=5, right=624, bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LCSNO', left=635, top=5, right=992, bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{CURROW}', left=16, top=5, right=111, bottom=64, face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LCSTYPE', left=119, top=5, right=370, bottom=64 , face='Arial', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	</R>
</A>
<A>id=Area8 ,left=0,top=0 ,right=2000 ,bottom=129
	<R>id='english.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_data'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=355 ,face='새굴림' ,size=9 ,penwidth=1
	<C>id='JPTSCR', left=450, top=146, right=781, bottom=193 ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HSKSCR', left=1177, top=146, right=1508, bottom=193 ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOFSCR', left=1177, top=82, right=1508, bottom=130 ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOESCR', left=450, top=82, right=781, bottom=130 ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ETCLNG', left=283, top=212, right=1961, bottom=259 , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=13 ,top=66 ,right=1982 ,bottom=66 </L>
	<T>id='8. 외 국 어' ,left=13 ,top=3 ,right=516 ,bottom=64 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=1013 ,top=66 ,right=1167 ,bottom=204 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='HSK' ,left=1024 ,top=143 ,right=1151 ,bottom=191 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='토플' ,left=1024 ,top=79 ,right=1151 ,bottom=127 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=13 ,top=66 ,right=273 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='제1외국어' ,left=26 ,top=77 ,right=209 ,bottom=124 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='기타 가능 외국어' ,left=19 ,top=212 ,right=265 ,bottom=259 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='제2외국어' ,left=26 ,top=146 ,right=206 ,bottom=193 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=270 ,top=270 ,right=1982 ,bottom=270 </L>
	<L> left=1982 ,top=64 ,right=1982 ,bottom=270 </L>
	<L> left=13 ,top=203 ,right=273 ,bottom=203 </L>
	<X>left=270 ,top=66 ,right=423 ,bottom=204 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=418 ,top=203 ,right=1982 ,bottom=203 </L>
	<T>id='JPT' ,left=282 ,top=143 ,right=409 ,bottom=191 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='토익' ,left=282 ,top=79 ,right=409 ,bottom=127 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=13 ,top=135 ,right=1982 ,bottom=135 </L>
</B>



	</R>
</A>

<A>id=Area9 ,left=0,top=0 ,right=2000 ,bottom=129
	<R>id='hrself.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_hrself'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2492 ,face='Arial' ,size=10 ,penwidth=1
			<T>id='9. 자 기 소 개 서' ,left=13 ,top=0 ,right=516 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=13 ,top=87 ,right=225 ,bottom=156 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=13 ,top=696 ,right=225 ,bottom=762 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='학창생활' ,left=16 ,top=699 ,right=222 ,bottom=759 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='성장배경' ,left=19 ,top=93 ,right=220 ,bottom=151 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=13 ,top=1902 ,right=505 ,bottom=1969 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='지원동기 및 입사후포부' ,left=19 ,top=1905 ,right=426 ,bottom=1963 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=13 ,top=1299 ,right=225 ,bottom=1365 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='경력사항' ,left=32 ,top=1302 ,right=212 ,bottom=1363 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<C>id='AMBITION CAREER', left=13, top=1966, right=1984, bottom=2479, align='left', border=true, penstyle=solid, penwidth=1, pencolor=#000000, Multiline=true</C>
			<C>id='CAREER', left=13, top=1363, right=1984, bottom=1876, align='left', border=true, penstyle=solid, penwidth=1, pencolor=#000000, Multiline=true</C>
			<C>id='SCHOOL', left=13, top=759, right=1984, bottom=1273, align='left', border=true, penstyle=solid, penwidth=1, pencolor=#000000, Multiline=true</C>
			<C>id='GROWTH', left=13, top=153, right=1984, bottom=667, align='left', border=true, penstyle=solid, penwidth=1, pencolor=#000000, Multiline=true</C>
		</B>
	</R>
</A>


-->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		