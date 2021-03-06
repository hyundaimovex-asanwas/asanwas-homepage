<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: H020005.HTML
+ 기 능 정 의	: 조회,저장,삭제,엑셀
+ 변 경 이 력	: 
+ 서 블 릿 명	: h020005_s1, h020005_t1, h020004_s2, hclcode_s1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title>심사결과관리</title>
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

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	var ls_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcem_fr.text = gcurdate.substring(0,7) + "01";
	gcem_to.text = gcurdate;
	gcem_date.text = gcurdate;
	gcem_time.text = "1200";
	gclx_prosts.index = 0;

	//응시분야
	gcds_before.DataID = "/servlet/Person.h020004_s2?v_str1=" + ls_date;
	gcds_before.Reset();

	gcds_hclcode.DataID = "/servlet/Person.hclcode_s1?v_str1=2013";
	gcds_hclcode.Reset();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "/servlet/Person.h020005_s1?"
									 + "v_str1=" + fn_trim(gcem_fr.text) 
									 + "&v_str2=" + fn_trim(gcem_to.text)
									 + "&v_str3=" + fn_trim(gclx_info.bindcolval)
									 + "&v_str4=" + fn_trim(gcem_wrno1.text)
									 + "&v_str5=" + fn_trim(gcem_wrno2.text)
									 + "&v_str6=" + fn_trim(txt_nmk.value)
									 + "&v_str7=" + fn_trim(gclx_prosts.bindcolval);
	gcds_data.Reset();
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
var pronm = "";

	if (gcds_data.countrow <1) {
		alert("저장하실 정보가 없습니다.");
	} else {
		if (gcds_data.IsUpdated) {
			var rot = "1";
			for (var k=1; k<=gcds_data.countrow;k++) {
				if (gcds_data.namevalue(k,"BCHK")=="T")	{
					if (rot==1) rot = k;
				}
			}

			if (gcds_data.namevalue(rot,"PROSTS")=="1") {
				if (gcds_data.namevalue(rot,"BCHK")=="T") {
					pronm = "해당 접수자를 면접자로 등록하겠습니까 ?";
				} else if (gcds_data.namevalue(rot,"INTATTYN")=="1"||gcds_data.namevalue(rot,"INTATTYN")=="2"||gcds_data.namevalue(rot,"INTATTYN")=="3"){
					pronm = "해당 접수자를 불합격 처리하겠습니까 ?";
				}
			}	else if (gcds_data.namevalue(rot,"PROSTS")=="2") {
				if (gcds_data.namevalue(rot,"BCHK")=="T") {
					pronm = "해당 면접자를 합격자로 등록하겠습니까 ?";
				} else if (gcds_data.namevalue(rot,"INTATTYN")!="0"){
					pronm = "해당 면접자를 불합격 처리하겠습니까 ?";
				}			
			}	else if (gcds_data.namevalue(rot,"PROSTS")=="3") {
				if (gcds_data.namevalue(rot,"INTATTYN")!="0"){
					pronm = "해당 합격자를 불합격 처리하겠습니까 ?";
				}
			}	else if (gcds_data.namevalue(rot,"PROSTS")=="4") {
				if (gcds_data.namevalue(rot,"INTATTYN")!="0"){
					pronm = "해당 불합격자 사유를 변경하겠습니까 ?";
				} else {
					pronm = "해당 불합격자를 접수자로 변경하겠습니까 ?";
				}
			}
			
			if (confirm(pronm))	gctr_data.post();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	if (gcds_data.countrow <1) {
		alert("삭제하실 정보가 없습니다.");
	} else {
		if (gcds_data.namevalue(1,"PROSTS")=="3") pronm = "해당 합격자를 취소하겠습니까 ?";
		else pronm = "해당 면접자를 취소하겠습니까 ?";

		if (confirm(pronm)) {
			gcds_data.deleterow(gcds_data.rowposition);
			gctr_data.post();
		}
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
	if (gcds_data.countrow<1) alert("다운로드 하실 자료가 없습니다");
	else gcgd_disp.RunExcel("심사현황관리");
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Select(){
	var pam = "T";
	if (gcds_data.namevalue(1,"BChk")=="F") pam = "T";
	else pam = "F";

	for (var i=1;i<=gcds_data.countrow;i++){
		gcds_data.namevalue(i,"BChk") = pam;
	}
}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Execute(){
	if (confirm("합격자를 제외한 전체 접수자에 대하여 불합격 처리 하시겠습니까 ?")){
		gcds_execute.DataID = "/servlet/Person.h020005_s2?v_str1=" + gclx_info.BindColVal;
		gcds_execute.Reset();
	} 
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
	ls_ahtml += ",OADDRNM:STRING(70),CZIPCD:STRING(6),CADDRNM:STRING(70)  ";
	ls_ahtml += ",TELNO:STRING(15),HPNO:STRING(15),EMAIL:STRING(30),EYEL:DECIMAL(2.1),EYER:DECIMAL(2.1)  ";
	ls_ahtml += ",HEIGHT:DECIMAL(3.0),WEIGHT:DECIMAL(3.0),BLOOD:STRING(2),RGHANDYN:STRING(1),MILIDIV:STRING(4)  ";
	ls_ahtml += ",MILIKND:STRING(4),MILIGRD:STRING(4),MILINO:STRING(15),MILIPLC:STRING(30),MILIFRDT:STRING(8)  ";
	ls_ahtml += ",MILITODT:STRING(8),NMREASON:STRING(40),MRYDT:STRING(8),DISDIV:STRING(4),DISGRD:STRING(4)  ";
	ls_ahtml += ",MILITYPE:STRING(4),MRTDIV:STRING(2),MRTNO:STRING(20),REFCD:STRING(4),MILISPEC:STRING(4)  ";
	ls_ahtml += ",ENGLVL:STRING(1),TOESCR:DECIMAL(4.0),JPTSCR:DECIMAL(4.0),DELFSCR:DECIMAL(4.0),TOFSCR:DECIMAL(4.0)  ";
	ls_ahtml += ",DALFSCR:DECIMAL(4.0),TEPSSCR:DECIMAL(4.0),ETCLNG:STRING(50),HWGRDCD:STRING(1),EXGRDCD:STRING(1)  ";
	ls_ahtml += ",PWGRDCD:STRING(1),ACGRDCD:STRING(1),INTDT:STRING(8),INTTM:STRING(4),INTATTYN:STRING(1)  ";
	ls_ahtml += ",PASSDT:STRING(8),AMDT:STRING(8),EMPNO:STRING(6),AMKIND:STRING(2),LCSTYPE:STRING(4)  ";
	ls_ahtml += ",LCSCD:STRING(4),PROSTS:STRING(1),CARYEAR:DECIMAL(2.0),PICFILE:URL,HSKSCR:DECIMAL(4.0) ";
	ls_ahtml += ",MILIDIVNM:STRING(30),MILIKNDNM:STRING(30),MILIGRDNM:STRING(30),BIRCITYNM:STRING(30),RILIGNM:STRING(30)";

	gcds_basis.SetDataHeader(ls_ahtml);
	gcds_basis.Addrow();

	//////////////////////////////////////////////////////////////////////////////////////////////
	//	학력
	//////////////////////////////////////////////////////////////////////////////////////////////
	var ls_ehtml = "";

	ls_ehtml += "INFODIV:STRING(6),RESINO:STRING(13),SEQ:DECIMAL(2.0),EDCCD:STRING(4),GRAYY:STRING(4)";
	ls_ehtml += ",SCHNM:STRING(60),CITY:STRING(40),PGCCD:STRING(4),EDCDIV:STRING(4),AVRUNI:DECIMAL(2.1) ";
	ls_ehtml += ",PERFECT:DECIMAL(2.1) ";
	
	gcds_educ.SetDataHeader(ls_ehtml);

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


	//////////////////////////////////////////////////////////////////////////////////////////////
	//	자격/면허
	//////////////////////////////////////////////////////////////////////////////////////////////
	var ls_lhtml = "";

	ls_lhtml += "INFODIV:STRING(6),RESINO:STRING(13),SEQ:DECIMAL(2.0),LCSTYPE:STRING(4),LCSCD:STRING(4)";
	ls_lhtml += ",LCSNO:STRING(20),GETDT:STRING(8),CHGDT:STRING(8),ISSPART:STRING(30) ";
	
	gcds_license.SetDataHeader(ls_lhtml);



	//////////////////////////////////////////////////////////////////////////////////////////////
	//	자기소개서
	//////////////////////////////////////////////////////////////////////////////////////////////
	var ls_ihtml = "";

	ls_ihtml += "INFODIV:STRING(6),RESINO:STRING(13),GROWTH:STRING(1000),SCHOOL:STRING(1000),CAREER:STRING(1000),";
	ls_ihtml += "AMBITION:STRING(1000)";
	
	gcds_hrself.SetDataHeader(ls_ihtml);
	gcds_hrself.addrow();

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){
	if(gcds_data.countrow > 0)
	{
		gcrp_print.Format="";
		ln_SetHeader();
        gcds_report09.ClearData();
		var ls_ihtml2 = "";
		for(var i=1; i<=gcds_data.countrow; i++)
		{
			ls_ihtml2 +="GROWTH_"+i+":STRING,SCHOOL_"+i+":STRING,CAREER_"+i+":STRING,AMBITION_"+i+":STRING,";
			if(i == gcds_data.countrow)
			ls_ihtml2 +="GROWTH_"+i+":STRING,SCHOOL_"+i+":STRING,CAREER_"+i+":STRING,AMBITION_"+i+":STRING";
		}
		gcds_report09.SetDataHeader(ls_ihtml2); //소개서보고서 헤더정의

		for(var i=1; i<=gcds_data.countrow; i++)
		{
		gcds_data.rowposition=i;

        //기본입사지원
		gcds_basis.ClearData();
		gcds_basis.DataID = "/servlet/Person.h020002_s3?"
										 + "v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"RESINO")
										 + "&v_str2=" + gcds_data.namevalue(gcds_data.rowposition,"INFODIV");
		gcds_basis.Reset();

        
        //학력
		gcds_educ.ClearData();
		gcds_educ.DataID = "/servlet/Person.h020002_s4?"
										 + "v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"RESINO");
		gcds_educ.Reset();

        //경력
		gcds_career.ClearData();
		gcds_career.DataID = "/servlet/Person.h020002_s5?"
										 + "v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"RESINO");
		gcds_career.Reset();

        //가족
		gcds_family.ClearData();
		gcds_family.DataID = "/servlet/Person.h020002_s6?"
										 + "v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"RESINO");
		gcds_family.Reset();

        //자격/면허
		gcds_license.ClearData();
		gcds_license.DataID = "/servlet/Person.h020002_s7?"
										 + "v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"RESINO");
		gcds_license.Reset();

        //소개서
		gcds_hrself.ClearData();
		gcds_hrself.DataID = "/servlet/Person.h020002_s0?"
										 + "v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"INFODIV")
										 + "&v_str2=" + gcds_data.namevalue(gcds_data.rowposition,"RESINO");
		gcds_hrself.Reset();


		gcds_report09.AddROW();
		if(gcds_hrself.countrow >0)
		{
			gcds_report09.namevalue(1,("GROWTH_"+i)) =ln_Multiline_Text(fn_trim(gcds_hrself.namevalue(1,"GROWTH")),139);
			gcds_report09.namevalue(1,("SCHOOL_"+i))  =ln_Multiline_Text(fn_trim(gcds_hrself.namevalue(1,"SCHOOL")),139);
			gcds_report09.namevalue(1,("CAREER_"+i))  =ln_Multiline_Text(fn_trim(gcds_hrself.namevalue(1,"CAREER")),139);
			gcds_report09.namevalue(1,("AMBITION_"+i))=ln_Multiline_Text(fn_trim(gcds_hrself.namevalue(1,"AMBITION")),139)
		}

        ln_RptFor(i-1);
   window.status= gcds_data.countrow+"중의 "+ i+"를 완료햇습니다. ";

         }

      //  alert(555);
	var ls_for = "";


		ls_for += "		<B>id=Footer ,left=0 ,top=2539 ,right=2000 ,bottom=2860 ,face='굴림' ,size=10 ,penwidth=1 "; 
		ls_for += "	<I>id='../../Common/img/icon.jpg' ,left=1593 ,top=230 ,right=1974 ,bottom=331</I> "; 
		ls_for += "	<L> left=0 ,top=220 ,right=1974 ,bottom=220 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> "; 
		ls_for += "	<T>id='#p/#t' ,left=0 ,top=230 ,right=1974 ,bottom=310</T> "; 
		ls_for += " </B> "; 
	gcrp_print.format = gcrp_print.format + ls_for;
//test_txt.value=gcrp_print.format;
   window.status= "";
			gcrp_print.preview();

	}
}

/******************************************************************************
	Description : 출력물 포멧 작성 gcrp_print.format
******************************************************************************/
function ln_RptFor(e){

	var Area_num=9*e+1;
	var ls_for = "";

ls_for += "<A>id=Area"+Area_num+" ,left=0,top=0 ,right=2000 ,bottom=129                                                                                                                                                            ";
	ls_for += "<R>id='basis"+Area_num+".sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_basis'                                                                                                                         ";
		ls_for +="<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=569 ,face='새굴림' ,size=9 ,penwidth=1                                                                                                                    ";

			if (gcds_basis.namevalue(1,"photo")=="") {
				 var photo="../../Person/html/photo/00000.jpg";

				ls_for +="	<I>id='"+photo+"' ,left=17 ,top=225 ,right=348 ,bottom=545 ,border=false ,penstyle=solid ,penwidth=1 ,pencolor=#000000</I> ";

			} else {
				var str1 = gcds_basis.namevalue(1,"infodiv");
				var str2 = gcds_basis.namevalue(1,"resino");

				ls_for +="	<I>id='"+rDOMAIN+"/servlet/Person.h020002_s9?v_str1="+str1+"&v_str2="+str2+"' ,left=17 ,top=225 ,right=348 ,bottom=545</I> ";
			}

		ls_for +="	<T>id='입사응시원서 (입사양식 A)' ,left=495 ,top=0 ,right=1505 ,bottom=95 ,face='굴림' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                    ";
		ls_for +="	<X>left=1357 ,top=103 ,right=1569 ,bottom=185 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=5</X>                                                                                                              ";
		ls_for +="	<T>id='응시구분' ,left=1371 ,top=111 ,right=1556 ,bottom=177 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                                                                                                        ";
		ls_for +="	<X>left=1566 ,top=103 ,right=1974 ,bottom=185 ,border=true ,penstyle=solid ,penwidth=5</X>                                                                                                            ";
		ls_for +="	<T>id='"+gcds_basis.namevalue(1,"INFO")+"', left=1580, top=119, right=1953, bottom=167, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>        "; 

		
		ls_for +="	<T>id='1.기본인적사항' ,left=0 ,top=138 ,right=503 ,bottom=198 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>              ";
		ls_for +="	<L> left=3 ,top=206 ,right=1971 ,bottom=206 </L>                                                                                                                                                       ";
		ls_for +="	<T>id='"+gcds_basis.namevalue(1,"SPECIAL")+"', left=1074, top=333, right=1320, bottom=381, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>        ";    
		ls_for +="	<T>id='"+gcds_basis.namevalue(1,"CARYEAR")+"', left=1828, top=333, right=1916, bottom=381, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";
		ls_for +="	<T>id='년' ,left=1918 ,top=333 ,right=1963 ,bottom=381</T> ";



		ls_for +="	<X>left=1667 ,top=325 ,right=1820 ,bottom=386 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                       ";

		ls_for +="	<T>id='경력' ,left=1680 ,top=333 ,right=1807 ,bottom=381 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>		";

         var strRESINO=gcds_basis.namevalue(1,"RESINO");
        if(fn_trim(strRESINO)!="")
		ls_for +="	<T>id='"+strRESINO.substr(0,6)+"-"+ strRESINO.substr(6,7)+"', left=593, top=275, right=844, bottom=323, align='left' ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>           "; 

		ls_for +="	<T>id='"+gcds_basis.namevalue(1,"HOBBY")+"', left=593, top=333, right=844, bottom=381, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>            ";
		ls_for +="	<T>id='"+gcds_basis.namevalue(1,"TELNO")+"', left=593, top=394, right=844, bottom=442, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>            ";
         var strOZIPCD=gcds_basis.namevalue(1,"OZIPCD");
		ls_for +="	<T>id='"+strOZIPCD.substr(0,3)+"-"+ strOZIPCD.substr(3,3)+"', left=593, top=452, right=725, bottom=500, align='left' ,mask='XXX-XXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>          "; 
		
         var strCZIPCD=gcds_basis.namevalue(1,"CZIPCD");
		ls_for +="	<T>id='"+strCZIPCD.substr(0,3)+"-"+ strCZIPCD.substr(3,3)+"', left=593, top=511, right=725, bottom=558, align='left' ,mask='XXX-XXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>           "; 
		ls_for +="	<T>id='"+gcds_basis.namevalue(1,"CADDRNM")+"', left=728, top=511, right=1550, bottom=558, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>          ";  
		ls_for +="	<L> left=0 ,top=566 ,right=1971 ,bottom=566 </L>                                                                                                                                                       ";

		var ls_MIDP = "";	//출신도

		ls_MIDP = gcds_basis.namevalue(1,"BIRCITYNM");
		ls_for += " <T>id='" + ls_MIDP + "',left=1484 ,top=275 ,right=1953 ,bottom=323 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='left'</T>";

		//ls_for +="	<T>id='BIRCITY', left=1495, top=275, right=1963, bottom=323, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=false</T>        ";   
		
		ls_for +=" <T>id='"+gcds_basis.namevalue(1,"EMAIL")+"', left=1484, top=394, right=1953, bottom=442, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";  

	var strTEMP=fn_trim(gcds_basis.namevalue(gcds_basis.rowposition,"BIRDT"));
	var strBIRDT="";

	if(strTEMP.substr(0,4)!="") strBIRDT+=strTEMP.substr(0,4);
	if(strTEMP.substr(4,2)!="") strBIRDT+="/"+strTEMP.substr(4,2);
	if(strTEMP.substr(6,2)!="") strBIRDT+="/"+strTEMP.substr(6,2);
		ls_for +=" <T>id='"+strBIRDT+"', left=1074, top=273, right=1334, bottom=320, align='left' ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";  
		ls_for +=" <T>id='"+gcds_basis.namevalue(1,"HPNO")+"', left=1074, top=394, right=1334, bottom=442, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";  
		//ls_for +=" <T>id='"+gcds_basis.namevalue(1,"OADDR2")+"', left=1553, top=452, right=1963, bottom=500, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";  
		//ls_for +=" <T>id='"+gcds_basis.namevalue(1,"CADDR2")+"', left=1553, top=511, right=1963, bottom=558, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>          ";  

		var ls_MIDP2 = "";	
			//종교

		ls_MIDP2 = gcds_basis.namevalue(1,"RILIGNM");
		ls_for += " <T>id='" + ls_MIDP2 + "',left=1484 ,top=333 ,right=1664 ,bottom=381 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, align='left'</T> ";

		ls_for +="	<L> left=0 ,top=206 ,right=0 ,bottom=566 </L> ";
		ls_for += " <L> left=1974 ,top=206 ,right=1974 ,bottom=566 </L> ";
		ls_for += " <T>id='"+gcds_basis.namevalue(1,"OADDRNM")+"', left=728, top=452, right=1550, bottom=500, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";
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
		ls_for += " <T>id='"+gcds_basis.namevalue(1,"NME")+"', left=1484, top=214, right=1953, bottom=262, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";
		ls_for += " <T>id='"+gcds_basis.namevalue(1,"NMK")+"', left=593, top=214, right=844, bottom=262, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";
		ls_for += " <T>id='"+gcds_basis.namevalue(1,"NMC")+"', left=1074, top=214, right=1320, bottom=262, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T> ";
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

        Area_num++;

ls_for +=" <A>id=Area"+Area_num+" ,left=0,top=0 ,right=2000 ,bottom=127                                                                                                                                                               ";
ls_for +=" 	<R>id='education"+Area_num+".sbt' ,left=0 ,top=0 ,right=2000 ,bottom=127  MasterDataID ='gcds_basis'                                                                                                                   ";
ls_for +=" <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom="+(183+(48*gcds_educ.countrow))+" ,face='굴림' ,size=10 ,penwidth=1                                                                                                                           ";
ls_for +=" 	<T>id='2. 학 력 사 항' ,left=0 ,top=0 ,right=1691 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                       ";
ls_for +=" 	<X>left=0 ,top=61 ,right=106 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                        ";
ls_for +=" 	<T>id='졸업' ,left=5 ,top=64 ,right=101 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                   ";
ls_for +=" 	<T>id='(예정)' ,left=5 ,top=101 ,right=101 ,bottom=151 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                ";
ls_for +=" 	<T>id='년도' ,left=5 ,top=138 ,right=101 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                  ";
ls_for +=" 	<X>left=103 ,top=61 ,right=524 ,bottom=127 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                      ";
ls_for +=" 	<T>id='출신학교' ,left=161 ,top=66 ,right=466 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                             ";
ls_for +=" 	<X>left=1781 ,top=61 ,right=1974 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 	<X>left=968 ,top=61 ,right=1222 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
ls_for +=" 	<T>id='전공' ,left=997 ,top=66 ,right=1212 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                ";
ls_for +=" 	<X>left=521 ,top=61 ,right=979 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                      ";
ls_for +=" 	<T>id='비율' ,left=1791 ,top=66 ,right=1963 ,bottom=177 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                               ";
ls_for +=" 	<T>id='소재지' ,left=524 ,top=66 ,right=968 ,bottom=175 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                               ";
ls_for +=" 	<X>left=1595 ,top=61 ,right=1786 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 	<T>id='만점' ,left=1598 ,top=66 ,right=1781 ,bottom=177 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                               ";
ls_for +=" 	<X>left=1416 ,top=61 ,right=1598 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 	<T>id='평점' ,left=1423 ,top=66 ,right=1588 ,bottom=177 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                               ";
ls_for +=" 	<X>left=1220 ,top=61 ,right=1418 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 	<T>id='구분' ,left=1230 ,top=69 ,right=1405 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                               ";
ls_for +=" 	<X>left=103 ,top=124 ,right=339 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
ls_for +=" 	<X>left=336 ,top=124 ,right=521 ,bottom=183 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
ls_for +=" 	<T>id='학교' ,left=344 ,top=130 ,right=513 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                ";
ls_for +=" 	<T>id='학교명' ,left=132 ,top=130 ,right=307 ,bottom=180 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                              ";


for(var i=1; i<=gcds_educ.countrow; i++)
{
gcds_educ.rowposition=i;
	ls_for +=" 	<L> left=0 ,top="+(183+(50*(i-1)))+" ,right=0 ,bottom="+(183+(50*i))+" </L>                                                                                                                                                                      ";
	ls_for +=" 	<L> left=103 ,top="+(183+(50*(i-1)))+" ,right=103 ,bottom="+(183+(50*i))+" </L>                                                                                                                                                                  ";
	ls_for +=" 	<L> left=336 ,top="+(183+(50*(i-1)))+" ,right=336 ,bottom="+(183+(50*i))+" </L>                                                                                                                                                                  ";
	ls_for +=" 	<L> left=521 ,top="+(183+(50*(i-1)))+" ,right=521 ,bottom="+(183+(50*i))+" </L>                                                                                                                                                                  ";
	ls_for +=" 	<L> left=979 ,top="+(183+(50*(i-1)))+" ,right=979 ,bottom="+(183+(50*i))+" </L>                                                                                                                                                                  ";
	ls_for +=" 	<L> left=1220 ,top="+(183+(50*(i-1)))+" ,right=1220 ,bottom="+(183+(50*i))+" </L>                                                                                                                                                                ";
	ls_for +=" 	<L> left=1418 ,top="+(183+(50*(i-1)))+" ,right=1418 ,bottom="+(183+(50*i))+" </L>                                                                                                                                                                ";
	ls_for +=" 	<L> left=1597 ,top="+(183+(50*(i-1)))+" ,right=1597 ,bottom="+(183+(50*i))+" </L>                                                                                                                                                                ";
	ls_for +=" 	<L> left=1786 ,top="+(183+(50*(i-1)))+" ,right=1786 ,bottom="+(183+(50*i))+" </L>                                                                                                                                                                ";
	ls_for +=" 	<L> left=1974 ,top="+(183+(50*(i-1)))+" ,right=1974 ,bottom="+(183+(50*i))+" </L>                                                                                           ";
	ls_for +=" 	<T>id='"+gcds_educ.namevalue(gcds_educ.rowposition,"GRAYY")+"', left=5, top="+(183+(48*(i-1)))+", right=101, bottom="+(183+(48*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                      ";
	ls_for +=" 	<T>id='"+gcds_educ.namevalue(gcds_educ.rowposition,"EDCCDNM")+"', left=344, top="+(183+(48*(i-1)))+", right=519, bottom="+(183+(48*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                                 ";
	ls_for +=" 	<T>id='"+gcds_educ.namevalue(gcds_educ.rowposition,"CITY")+"', left=524, top="+(183+(48*(i-1)))+", right=974, bottom="+(183+(48*i))+", align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                    ";
	ls_for +=" 	<T>id='"+gcds_educ.namevalue(gcds_educ.rowposition,"SCHNM")+"', left=108, top="+(183+(48*(i-1)))+", right=331, bottom="+(183+(48*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                                 ";
	ls_for +=" 	<T>id='"+gcds_educ.namevalue(gcds_educ.rowposition,"PGCCDNM")+"', left=982, top="+(183+(48*(i-1)))+", right=1214, bottom="+(183+(48*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                                ";
	ls_for +=" 	<T>id='"+gcds_educ.namevalue(gcds_educ.rowposition,"AVRUNI")+"', left=1429, top="+(183+(48*(i-1)))+", right=1590, bottom="+(183+(48*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                              ";
	ls_for +=" 	<T>id='"+gcds_educ.namevalue(gcds_educ.rowposition,"PERFECT")+"', left=1606, top="+(183+(48*(i-1)))+", right=1778, bottom="+(183+(48*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                             ";
		var intTOT_1= parseFloat(gcds_educ.namevalue(gcds_educ.rowposition,"AVRUNI")); //비율계산시작
		var intTOT_2=parseFloat(gcds_educ.namevalue(gcds_educ.rowposition,"PERFECT"));
		if ( parseInt(intTOT_2)==0)
		{
			var intTOT_3="";
		}else
		{
			var intTOT_3=parseFloat((intTOT_1/intTOT_2)*100)+"";
		}
		if(intTOT_3.length >=6) intTOT_3= intTOT_3.substr(0,6);                           //비율계산끝

	ls_for +=" 	<T>id='"+intTOT_3+"', left=1797, top="+(183+(48*(i-1)))+", right=1969, bottom="+(183+(48*i))+" , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                ";
	ls_for +=" 	<T>id='"+gcds_educ.namevalue(gcds_educ.rowposition,"EDCDIVNM")+"', left=1225, top="+(183+(48*(i-1)))+", right=1410, bottom="+(183+(48*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                              ";
	ls_for +=" 	<L> left=0 ,top="+(183+(50*i))+" ,right=1974 ,bottom="+(183+(50*i))+" </L>  ";
}
ls_for +=" 		</B> ";
ls_for +=" 	</R>  ";
ls_for +=" </A> ";


        Area_num++;

ls_for +=" <A>id=Area"+Area_num+" ,left=0,top=0 ,right=2000 ,bottom=164                                                                                                                                                                ";
ls_for +=" 	<R>id='career"+Area_num+".sbt' ,left=0 ,top=0 ,right=2000 ,bottom=161 ,MasterDataID='gcds_career'                                                                                                                           ";
ls_for +=" 		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom="+(172+(53*gcds_career.countrow))+" ,face='굴림' ,size=10 ,penwidth=1                                                                                             ";
ls_for +=" 			<T>id='3. 경 력 사 항' ,left=0 ,top=0 ,right=1691 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                   ";
ls_for +=" 			<X>left=0 ,top=58 ,right=106 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 			<X>left=103 ,top=58 ,right=471 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                  ";
ls_for +=" 			<X>left=103 ,top=119 ,right=288 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
ls_for +=" 			<X>left=286 ,top=119 ,right=471 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
ls_for +=" 			<X>left=468 ,top=58 ,right=945 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                  ";
ls_for +=" 			<T>id='근무기간' ,left=108 ,top=64 ,right=466 ,bottom=119 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                         ";
ls_for +=" 			<T>id='퇴사일' ,left=291 ,top=127 ,right=466 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                          ";
ls_for +=" 			<T>id='입사일' ,left=108 ,top=127 ,right=283 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                          ";
ls_for +=" 			<T>id='No' ,left=5 ,top=64 ,right=101 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                 ";
ls_for +=" 			<T>id='직장명' ,left=474 ,top=64 ,right=939 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
ls_for +=" 			<X>left=1172 ,top=58 ,right=1974 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                ";
ls_for +=" 			<X>left=942 ,top=58 ,right=1177 ,bottom=172 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
ls_for +=" 			<T>id='담당업무' ,left=1400 ,top=64 ,right=1744 ,bottom=172 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                       ";
ls_for +=" 			<T>id='직위명' ,left=958 ,top=64 ,right=1151 ,bottom=169 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                          ";

for(var i=1; i<=gcds_career.countrow; i++)
{
	gcds_career.rowposition=i;

	ls_for +=" 			<L> left=1974 ,top="+(172+(53*(i-1)))+" ,right=1974 ,bottom="+(172+(53*i))+" </L>                                                                                                                                                            ";
	ls_for +=" 			<L> left=1177 ,top="+(172+(53*(i-1)))+" ,right=1177 ,bottom="+(172+(53*i))+" </L>                                                                                                                                                            ";
	ls_for +=" 			<L> left=942 ,top="+(172+(53*(i-1)))+" ,right=942 ,bottom="+(172+(53*i))+" </L>                                                                                                                                                              ";
	ls_for +=" 			<L> left=468 ,top="+(172+(53*(i-1)))+" ,right=468 ,bottom="+(172+(53*i))+" </L>                                                                                                                                                              ";
	ls_for +=" 			<L> left=286 ,top="+(172+(53*(i-1)))+" ,right=286 ,bottom="+(172+(53*i))+" </L>                                                                                                                                                              ";
	ls_for +=" 			<L> left=103 ,top="+(172+(53*(i-1)))+" ,right=103 ,bottom="+(172+(53*i))+" </L>                                                                                                                                                              ";
	ls_for +=" 			<L> left=0 ,top="+(172+(53*(i-1)))+" ,right=0 ,bottom="+(172+(53*i))+" </L>                                                                                                                                                                  ";
	ls_for +=" 			<L> left=0 ,top="+(172+(53*i))+" ,right=1974 ,bottom="+(172+(53*i))+" </L>                                                                                                                                                              ";
	ls_for +=" 			<T>id='"+gcds_career.namevalue(gcds_career.rowposition,"COMNM")+"', left=474, top="+(172+(53*(i-1)))+", right=939, bottom="+(172+(53*i))+", align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                               ";

	var strTEMP=fn_trim(gcds_career.namevalue(gcds_career.rowposition,"ENDDT"));
	var strENDDT="";

	if(strTEMP.substr(0,4)!="") strENDDT+=strTEMP.substr(0,4);
	if(strTEMP.substr(4,2)!="") strENDDT+="/"+strTEMP.substr(4,2);
	if(strTEMP.substr(6,2)!="") strENDDT+="/"+strTEMP.substr(6,2);
	ls_for +=" 			<T>id='"+strENDDT+"', left=291, top="+(172+(53*(i-1)))+", right=466, bottom="+(172+(53*i))+" ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                          ";

	var strTEMP=fn_trim(gcds_career.namevalue(gcds_career.rowposition,"FRDT"));
	var strFRDT="";

	if(strTEMP.substr(0,4)!="") strFRDT+=strTEMP.substr(0,4);
	if(strTEMP.substr(4,2)!="") strFRDT+="/"+strTEMP.substr(4,2);
	if(strTEMP.substr(6,2)!="") strFRDT+="/"+strTEMP.substr(6,2);

	ls_for +=" 			<T>id='"+strFRDT+"', left=108, top="+(172+(53*(i-1)))+", right=283, bottom="+(172+(53*i))+" ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                           ";

	ls_for +=" 			<T>id='"+i+"', left=5, top="+(172+(53*(i-1)))+", right=101, bottom="+(172+(53*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                            ";

	ls_for +=" 			<T>id='"+gcds_career.namevalue(gcds_career.rowposition,"DUTYNM")+"', left=1180, top="+(172+(53*(i-1)))+", right=1958, bottom="+(172+(53*i))+", align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                            ";

	ls_for +=" 			<T>id='"+gcds_career.namevalue(gcds_career.rowposition,"POSINM")+"', left=947, top="+(172+(53*(i-1)))+", right=1167, bottom="+(172+(53*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                           ";

}

ls_for +=" 		</B> ";
ls_for +=" 	</R>  ";
ls_for +=" </A> ";

        Area_num++;

ls_for +=" <A>id=Area"+Area_num+" ,left=0,top=0 ,right=2000 ,bottom=130                                                                                                                                                                ";
ls_for +=" 	<R>id='sinche"+Area_num+".sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_basis'                                                                                                                             ";
ls_for +=" 		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=135 ,face='새굴림' ,size=9 ,penwidth=1                                                                                                                        ";
ls_for +=" 			<L> left=3 ,top=66 ,right=1974 ,bottom=66 </L>                                                                                                                                                              ";
ls_for +=" 			<T>id='좌:' ,left=233 ,top=77 ,right=294 ,bottom=124 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                ";
ls_for +=" 			<T>id='우:' ,left=442 ,top=77 ,right=500 ,bottom=124 ,align='left' ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                ";
ls_for +=" 			<X>left=1093 ,top=66 ,right=1246 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                ";
ls_for +=" 			<T>id='체중' ,left=1106 ,top=74 ,right=1233 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
ls_for +=" 			<X>left=1553 ,top=66 ,right=1707 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                ";
ls_for +=" 			<T>id='혈액형' ,left=1566 ,top=74 ,right=1693 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                         ";
ls_for +=" 			<L> left=1974 ,top=66 ,right=1974 ,bottom=135 </L>                                                                                                                                                          ";
ls_for +=" 			<T>id='"+gcds_basis.namevalue(1,"EYEL")+"', left=296, top=77, right=426, bottom=124, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                               ";
ls_for +=" 			<T>id='"+gcds_basis.namevalue(1,"WEIGHT")+" Kg', left=1259, top=77, right=1482, bottom=124, align='center' ,mask='XXX Kg', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>           ";
ls_for +=" 			<T>id='"+gcds_basis.namevalue(1,"HEIGHT")+" Cm', left=812, top=77, right=1035, bottom=124, align='center' ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>            ";
ls_for +=" 			<T>id='"+gcds_basis.namevalue(1,"BLOOD")+"', left=1712, top=77, right=1924, bottom=124, align='center', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                            ";
ls_for +=" 			<T>id='4. 신 체 사 항' ,left=0 ,top=3 ,right=503 ,bottom=64 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                    ";
ls_for +=" 			<X>left=654 ,top=66 ,right=807 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                  ";
ls_for +=" 			<T>id='신장' ,left=664 ,top=77 ,right=791 ,bottom=124 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                             ";
ls_for +=" 			<X>left=0 ,top=66 ,right=222 ,bottom=135 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 			<T>id='시력' ,left=53 ,top=74 ,right=180 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                              ";
ls_for +=" 			<L> left=0 ,top=66 ,right=0 ,bottom=132 </L>                                                                                                                                                                ";
ls_for +=" 			<L> left=0 ,top=135 ,right=1974 ,bottom=135 </L>                                                                                                                                                            ";
ls_for +=" 			<T>id='"+gcds_basis.namevalue(1,"EYER")+"', left=500, top=77, right=550, bottom=124, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF,align='left'</T>                               ";
ls_for +=" 		</B> ";
ls_for +=" 	</R>  ";
ls_for +=" </A> ";

        Area_num++;

ls_for +=" <A>id=Area"+Area_num+" ,left=0,top=0 ,right=2000 ,bottom=130                                                                                                                                                                ";
ls_for +=" 	<R>id='miligrd"+Area_num+".sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_basis'                                                                                                                            ";
ls_for +=" 		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=201 ,face='새굴림' ,size=9 ,penwidth=1                                                                                                                        ";
ls_for +=" 			<L> left=0 ,top=64 ,right=1974 ,bottom=64 </L>                                                                                                                                                              ";
ls_for +=" 			<L> left=1974 ,top=64 ,right=1974 ,bottom=201 </L>                                                                                                                                                          ";
ls_for +=" 			<T>id='"+gcds_basis.namevalue(1,"MILIDIVNM")+"', left=230, top=74, right=640, bottom=122, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                                          ";
ls_for +=" 			<T>id='"+gcds_basis.namevalue(1,"MILIKNDNM")+"', left=921, top=74, right=1416, bottom=122 ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                          ";
ls_for +=" 			<T>id='"+gcds_basis.namevalue(1,"MILIGRDNM")+"', left=1585, top=74, right=1950, bottom=122 ,mask='XXX Kg', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                         ";
ls_for +=" 			<T>id='~' ,left=466 ,top=140 ,right=516 ,bottom=188 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                               ";

	var strTEMP=fn_trim(gcds_basis.namevalue(gcds_basis.rowposition,"MILITODT"));
	var strMILITODT="";

	if(strTEMP.substr(0,4)!="") strMILITODT+=strTEMP.substr(0,4);
	if(strTEMP.substr(4,2)!="") strMILITODT+="/"+strTEMP.substr(4,2);
	if(strTEMP.substr(6,2)!="") strMILITODT+="/"+strTEMP.substr(6,2);
ls_for +=" 			<T>id='"+strMILITODT+"', left=516, top=140, right=751, bottom=188 ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                 ";

	var strTEMP=fn_trim(gcds_basis.namevalue(gcds_basis.rowposition,"MILIFRDT"));
	var strMILIFRDT="";

	if(strTEMP.substr(0,4)!="") strMILIFRDT+=strTEMP.substr(0,4);
	if(strTEMP.substr(4,2)!="") strMILIFRDT+="/"+strTEMP.substr(4,2);
	if(strTEMP.substr(6,2)!="") strMILIFRDT+="/"+strTEMP.substr(6,2);
ls_for +=" 			<T>id='"+strMILIFRDT+"', left=230, top=140, right=466, bottom=188 ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                 ";
ls_for +=" 			<T>id='"+gcds_basis.namevalue(1,"NMREASON")+"', left=921, top=140, right=1945, bottom=188 ,mask='XXX Cm', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                        ";
ls_for +=" 			<L> left=0 ,top=64 ,right=0 ,bottom=201 </L>                                                                                                                                                                ";
ls_for +=" 			<T>id='5. 병 역 사 항' ,left=0 ,top=3 ,right=503 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                    ";
ls_for +=" 			<X>left=1426 ,top=64 ,right=1580 ,bottom=132 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                ";
ls_for +=" 			<T>id='계급' ,left=1439 ,top=77 ,right=1566 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
ls_for +=" 			<X>left=762 ,top=64 ,right=915 ,bottom=201 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                  ";
ls_for +=" 			<T>id='면제사유' ,left=773 ,top=143 ,right=900 ,bottom=191 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                        ";
ls_for +=" 			<T>id='군별' ,left=773 ,top=74 ,right=900 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                             ";
ls_for +=" 			<X>left=0 ,top=64 ,right=222 ,bottom=201 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 			<T>id='병무기간' ,left=53 ,top=140 ,right=180 ,bottom=188 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                         ";
ls_for +=" 			<T>id='병역구분' ,left=53 ,top=71 ,right=180 ,bottom=119 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                          ";
ls_for +=" 			<L> left=0 ,top=132 ,right=1974 ,bottom=132 </L>                                                                                                                                                            ";
ls_for +=" 			<L> left=0 ,top=201 ,right=1974 ,bottom=201 </L>                                                                                                                                                            ";
ls_for +=" 		</B> ";
ls_for +=" 	</R>  ";
ls_for +=" </A> ";

        Area_num++;

ls_for +=" <A>id=Area"+Area_num+" ,left=0,top=0 ,right=2000 ,bottom=69                                                                                                                                                                 ";
ls_for +=" 	<R>id='family"+Area_num+".sbt' ,left=0 ,top=0 ,right=2000 ,bottom=69 ,DetailDataID='gcds_family'                                                                                                                          ";
ls_for +=" 		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom="+(119+(59*gcds_family.countrow))+" ,face='굴림' ,size=10 ,penwidth=1                                                                                                                        ";
ls_for +=" 			<X>left=0 ,top=58 ,right=106 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 			<L> left=0 ,top=61 ,right=0 ,bottom=119 </L>                                                                                                                                                                ";
ls_for +=" 			<X>left=1162 ,top=58 ,right=1527 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                ";
ls_for +=" 			<T>id='최 종 학 력' ,left=1175 ,top=61 ,right=1511 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                    ";
ls_for +=" 			<X>left=804 ,top=58 ,right=1164 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
ls_for +=" 			<T>id='주민번호' ,left=905 ,top=61 ,right=1077 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                        ";
ls_for +=" 			<T>id='No' ,left=3 ,top=61 ,right=98 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                  ";
ls_for +=" 			<T>id='6. 가 족 사 항' ,left=0 ,top=0 ,right=1691 ,bottom=58 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                   ";
ls_for +=" 			<X>left=1524 ,top=58 ,right=1974 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                ";
ls_for +=" 			<T>id='현 직 업' ,left=1537 ,top=64 ,right=1945 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                       ";
ls_for +=" 			<X>left=447 ,top=58 ,right=807 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                  ";
ls_for +=" 			<X>left=101 ,top=58 ,right=450 ,bottom=119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                  ";
ls_for +=" 			<T>id='성  명' ,left=532 ,top=64 ,right=733 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
ls_for +=" 			<T>id='가족관계' ,left=156 ,top=61 ,right=394 ,bottom=114 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                         ";

for(var i=1; i<=gcds_family.countrow; i++)
{
	gcds_family.rowposition=i;
ls_for +=" 			<L> left=1974 ,top="+(114+(59*(i-1)))+" ,right=1974 ,bottom="+(114+(59*i))+" </L>                                                                                                                                                            ";
ls_for +=" 			<L> left=1524 ,top="+(114+(59*(i-1)))+" ,right=1524 ,bottom="+(114+(59*i))+" </L>                                                                                                                                                            ";
ls_for +=" 			<L> left=1163 ,top="+(114+(59*(i-1)))+" ,right=1163 ,bottom="+(114+(59*i))+" </L>                                                                                                                                                            ";
ls_for +=" 			<L> left=807 ,top="+(114+(59*(i-1)))+" ,right=807 ,bottom="+(114+(59*i))+" </L>                                                                                                                                                              ";
ls_for +=" 			<L> left=447 ,top="+(114+(59*(i-1)))+" ,right=447 ,bottom="+(114+(59*i))+" </L>                                                                                                                                                              ";
ls_for +=" 			<L> left=101 ,top="+(114+(59*(i-1)))+" ,right=101 ,bottom="+(114+(59*i))+" </L>                                                                                                                                                              ";
ls_for +=" 			<L> left=0 ,top="+(114+(59*(i-1)))+" ,right=0 ,bottom="+(114+(59*i))+" </L>                                                                                                                                                                  ";
ls_for +=" 			<L> left=0 ,top="+(114+(59*i))+" ,right=1974 ,bottom="+(114+(59*i))+" </L>                                                                                                                                                              ";
ls_for +=" 			<T>id='"+i+"', left=3, top="+(114+(59*(i-1)))+", right=98, bottom="+(114+(59*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                             ";
ls_for +=" 			<T>id='"+gcds_family.namevalue(gcds_family.rowposition,"LSTEDCNM")+"', left=1169, top="+(114+(59*(i-1)))+", right=1519, bottom="+(114+(59*i))+", align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                            ";
ls_for +=" 			<T>id='"+gcds_family.namevalue(gcds_family.rowposition,"CMPNM")+"', left=1529, top="+(114+(59*(i-1)))+", right=1966, bottom="+(114+(59*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                           ";
	var strTEMP=fn_trim(gcds_family.namevalue(gcds_family.rowposition,"RESINOF"));
	var strRESINOF="";

	if(strTEMP.substr(0,6)!="") strRESINOF+=strTEMP.substr(0,4);
	if(strTEMP.substr(6,7)!="") strRESINOF+="-"+strTEMP.substr(4,2);

ls_for +=" 			<T>id='"+strRESINOF+"', left=812, top="+(114+(59*(i-1)))+", right=1156, bottom="+(114+(59*i))+" ,mask='XXXXXX-XXXXXXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                   ";
ls_for +=" 			<T>id='"+gcds_family.namevalue(gcds_family.rowposition,"FAMNM")+"', left=450, top="+(114+(59*(i-1)))+", right=799, bottom="+(114+(59*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                             ";
ls_for +=" 			<T>id='"+gcds_family.namevalue(gcds_family.rowposition,"REFCDNM")+"', left=108, top="+(114+(59*(i-1)))+", right=439, bottom="+(114+(59*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                             ";
}
ls_for +=" 		</B> ";
ls_for +=" 	</R>  ";
ls_for +=" </A> ";

        Area_num++;

ls_for +=" <A>id=Area"+Area_num+" ,left=0,top=0 ,right=2000 ,bottom=66                                                                                                                                                                 ";
ls_for +=" 	<R>id='license"+Area_num+".sbt' ,left=0 ,top=0 ,right=2000 ,bottom=66 ,DetailDataID='gcds_license'                                                                                                                         ";
ls_for +=" <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom="+(111+(66*gcds_license.countrow))+" ,face='굴림' ,size=10 ,penwidth=1                                                                                                                           ";
ls_for +=" 	<X>left=0 ,top=58 ,right=106 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                        ";
ls_for +=" 	<T>id='No' ,left=8 ,top=64 ,right=95 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                      ";
ls_for +=" 	<X>left=1228 ,top=58 ,right=1495 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 	<T>id='변경일' ,left=1254 ,top=64 ,right=1461 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                             ";
ls_for +=" 	<T>id='7. 자 격 면 허' ,left=0 ,top=0 ,right=1691 ,bottom=58 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                       ";
ls_for +=" 	<X>left=619 ,top=58 ,right=987 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                      ";
ls_for +=" 	<T>id='자격/면허번호' ,left=624 ,top=64 ,right=982 ,bottom=111 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                        ";
ls_for +=" 	<X>left=984 ,top=58 ,right=1233 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
ls_for +=" 	<T>id='취득일' ,left=1003 ,top=64 ,right=1209 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                             ";
ls_for +=" 	<X>left=1492 ,top=58 ,right=1974 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 	<T>id='발급기관' ,left=1569 ,top=64 ,right=1889 ,bottom=111 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
ls_for +=" 	<X>left=103 ,top=58 ,right=421 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                      ";
ls_for +=" 	<X>left=418 ,top=58 ,right=622 ,bottom=111 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                      ";
ls_for +=" 	<T>id='등급' ,left=434 ,top=64 ,right=614 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                 ";
ls_for +=" 	<T>id='종류' ,left=119 ,top=64 ,right=402 ,bottom=108 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                 ";

for(var i=1; i<=gcds_license.countrow; i++)
{
	gcds_license.rowposition=i;

ls_for +=" 	<L> left=0 ,top="+(111+(66*(i-1)))+" ,right=0 ,bottom="+(111+(66*i))+" </L>                                                                                                                                                                      ";
ls_for +=" 	<L> left=103 ,top="+(111+(66*(i-1)))+" ,right=103 ,bottom="+(111+(66*i))+" </L>                                                                                                                                                                  ";
ls_for +=" 	<L> left=418 ,top="+(111+(66*(i-1)))+" ,right=418 ,bottom="+(111+(66*i))+" </L>                                                                                                                                                                  ";
ls_for +=" 	<L> left=621 ,top="+(111+(66*(i-1)))+" ,right=621 ,bottom="+(111+(66*i))+" </L>                                                                                                                                                                  ";
ls_for +=" 	<L> left=984 ,top="+(111+(66*(i-1)))+" ,right=984 ,bottom="+(111+(66*i))+" </L>                                                                                                                                                                  ";
ls_for +=" 	<L> left=1232 ,top="+(111+(66*(i-1)))+" ,right=1232 ,bottom="+(111+(66*i))+" </L>                                                                                                                                                                ";
ls_for +=" 	<L> left=1492 ,top="+(111+(66*(i-1)))+" ,right=1492 ,bottom="+(111+(66*i))+" </L>                                                                                                                                                                ";
ls_for +=" 	<L> left=1974 ,top="+(111+(66*(i-1)))+" ,right=1974 ,bottom="+(111+(66*i))+" </L>                                                                                                                                                                ";
ls_for +=" 	<L> left=0 ,top="+(111+(66*i))+" ,right=1974 ,bottom="+(111+(66*i))+" </L>                                                                                                                                                                  ";
ls_for +=" 	<T>id='"+gcds_license.namevalue(gcds_license.rowposition,"ISSPART")+"', left=1498, top="+(111+(66*(i-1)))+", right=1966, bottom="+(111+(66*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                             ";
	var strTEMP=fn_trim(gcds_license.namevalue(gcds_license.rowposition,"CHGDT"));
	var strCHGDT="";

	if(strTEMP.substr(0,4)!="") strCHGDT+=strTEMP.substr(0,4);
	if(strTEMP.substr(4,2)!="") strCHGDT+="/"+strTEMP.substr(4,2);
	if(strTEMP.substr(6,2)!="") strCHGDT+="/"+strTEMP.substr(6,2);

ls_for +=" 	<T>id='"+strCHGDT+"', left=1236, top="+(111+(66*(i-1)))+", right=1490, bottom="+(111+(66*i))+" ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                            ";


	var strTEMP=fn_trim(gcds_license.namevalue(gcds_license.rowposition,"GETDT"));
	var strGETDT="";

	if(strTEMP.substr(0,4)!="") strGETDT+=strTEMP.substr(0,4);
	if(strTEMP.substr(4,2)!="") strGETDT+="/"+strTEMP.substr(4,2);
	if(strTEMP.substr(6,2)!="") strGETDT+="/"+strTEMP.substr(6,2);

ls_for +=" 	<T>id='"+strGETDT+"', left=990, top="+(111+(66*(i-1)))+", right=1225, bottom="+(111+(66*i))+" ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                             ";
ls_for +=" 	<T>id='"+gcds_license.namevalue(gcds_license.rowposition,"LCSNO")+"', left=624, top="+(111+(66*(i-1)))+", right=982, bottom="+(111+(66*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                                 ";
ls_for +=" 	<T>id='"+i+"', left=5, top="+(111+(66*(i-1)))+", right=101, bottom="+(111+(66*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                                ";
ls_for +=" 	<T>id='"+gcds_license.namevalue(gcds_license.rowposition,"LCSTYPENM")+"', left=108, top="+(111+(66*(i-1)))+", right=413, bottom="+(111+(66*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                               ";
ls_for +=" 	<T>id='"+gcds_license.namevalue(gcds_license.rowposition,"LCSCDNM")+"', left=429, top="+(111+(66*(i-1)))+", right=614, bottom="+(111+(66*i))+", face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</T>                                                 ";
}
ls_for +=" 		</B> ";
ls_for +=" 	</R>  ";
ls_for +=" </A> ";

        Area_num++;

ls_for +=" <A>id=Area"+Area_num+" ,left=0,top=0 ,right=2000 ,bottom=129                                                                                                                                                                ";
ls_for +=" 	<R>id='english"+Area_num+".sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_basis'                                                                                                                            ";
ls_for +=" <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=273 ,face='새굴림' ,size=9 ,penwidth=1                                                                                                                           ";
ls_for +=" 	<T>id='"+gcds_basis.namevalue(1,"JPTSCR")+"', left=439, top=146, right=770, bottom=193 , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                               ";
ls_for +=" 	<T>id='"+gcds_basis.namevalue(1,"HSKSCR")+"', left=1167, top=146, right=1498, bottom=193 , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                             ";
ls_for +=" 	<T>id='"+gcds_basis.namevalue(1,"TOFSCR")+"', left=1167, top=82, right=1498, bottom=130 , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                              ";
ls_for +=" 	<T>id='"+gcds_basis.namevalue(1,"TOESCR")+"', left=439, top=82, right=770, bottom=130 , face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                                ";
ls_for +=" 	<T>id='"+gcds_basis.namevalue(1,"ETCLNG")+"', left=273, top=212, right=1950, bottom=259, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, align='left'</T>                                             ";
ls_for +=" 	<L> left=1 ,top=66 ,right=1974 ,bottom=66 </L>                                                                                                                                                                  ";
ls_for +=" 	<T>id='8. 외 국 어' ,left=0 ,top=3 ,right=505 ,bottom=64 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                           ";
ls_for +=" 	<X>left=1003 ,top=66 ,right=1156 ,bottom=204 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 	<T>id='HSK' ,left=1013 ,top=143 ,right=1140 ,bottom=191 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                               ";
ls_for +=" 	<T>id='토플' ,left=1013 ,top=79 ,right=1140 ,bottom=127 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                               ";
ls_for +=" 	<X>left=0 ,top=66 ,right=260 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                        ";
ls_for +=" 	<T>id='제1외국어' ,left=16 ,top=77 ,right=198 ,bottom=124 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                             ";
ls_for +=" 	<T>id='기타 가능 외국어' ,left=8 ,top=212 ,right=254 ,bottom=259 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                      ";
ls_for +=" 	<T>id='제2외국어' ,left=16 ,top=146 ,right=196 ,bottom=193 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                            ";
ls_for +=" 	<L> left=259 ,top=273 ,right=1974 ,bottom=273 </L>                                                                                                                                                              ";
ls_for +=" 	<L> left=1 ,top=204 ,right=262 ,bottom=204 </L>                                                                                                                                                                 ";
ls_for +=" 	<X>left=259 ,top=66 ,right=413 ,bottom=204 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                      ";
ls_for +=" 	<L> left=407 ,top=204 ,right=1974 ,bottom=204 </L>                                                                                                                                                              ";
ls_for +=" 	<T>id='JPT' ,left=273 ,top=143 ,right=400 ,bottom=193 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                 ";
ls_for +=" 	<T>id='토익' ,left=273 ,top=79 ,right=400 ,bottom=127 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                                 ";
ls_for +=" 	<L> left=1 ,top=138 ,right=1974 ,bottom=138 </L>                                                                                                                                                                ";
ls_for +=" 	<L> left=1974 ,top=66 ,right=1974 ,bottom=273 </L>                                                                                                                                                              ";
ls_for +=" 		</B> ";
ls_for +=" 	</R>  ";
ls_for +=" </A> ";

        Area_num++;

ls_for +=" <A>id=Area"+Area_num+" ,left=0,top=0 ,right=2000 ,bottom=129                                                                                                                                                                ";
ls_for +=" 	<R>id='hrself"+Area_num+".sbt' ,left=0 ,top=0 ,right=2000 ,bottom=130 ,MasterDataID='gcds_report09'                                                                                                                         ";
ls_for +=" 		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2479 ,face='굴림' ,size=10 ,penwidth=1                                                                                                                       ";
ls_for +=" 			<X>left=0 ,top=762 ,right=1971 ,bottom=1275 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                    ";
ls_for +=" 			<X>left=0 ,top=153 ,right=1971 ,bottom=667 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                     ";
ls_for +=" 			<T>id='9. 자 기 소 개 서' ,left=0 ,top=0 ,right=503 ,bottom=61 ,align='left' ,face='HY견고딕' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                  ";
ls_for +=" 			<X>left=0 ,top=87 ,right=212 ,bottom=156 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                    ";
ls_for +=" 			<X>left=0 ,top=696 ,right=212 ,bottom=762 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                   ";
ls_for +=" 			<T>id='학창생활' ,left=3 ,top=699 ,right=209 ,bottom=759 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                          ";
ls_for +=" 			<T>id='성장배경' ,left=5 ,top=93 ,right=206 ,bottom=151 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                           ";
ls_for +=" 			<X>left=0 ,top=1902 ,right=492 ,bottom=1969 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
ls_for +=" 			<T>id='지원동기 및 입사후포부' ,left=5 ,top=1905 ,right=413 ,bottom=1963 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                          ";
ls_for +=" 			<X>left=0 ,top=1299 ,right=212 ,bottom=1365 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                 ";
ls_for +=" 			<T>id='경력사항' ,left=19 ,top=1302 ,right=198 ,bottom=1363 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>                                       ";
ls_for +=" 			<C>id='GROWTH_"+(e+1)+"', left=16, top=172, right=1953, bottom=648, align='left', Multiline=true</C>                                                                                                                  ";
ls_for +=" 			<C>id='SCHOOL_"+(e+1)+"', left=16, top=781, right=1953, bottom=1257, align='left', Multiline=true</C>                                                                                                                 ";
ls_for +=" 			<X>left=0 ,top=1363 ,right=1971 ,bottom=1876 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                   ";
ls_for +=" 			<C>id='CAREER_"+(e+1)+"', left=16, top=1381, right=1953, bottom=1857, align='left', Multiline=true</C>                                                                                                                ";
ls_for +=" 			<X>left=0 ,top=1966 ,right=1971 ,bottom=2479 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                                   ";
ls_for +=" 			<C>id='AMBITION_"+(e+1)+"', left=16, top=1984, right=1953, bottom=2461, align='left', Multiline=true</C>                                                                                                              ";
ls_for +=" 		</B> ";
ls_for +=" 	</R>  ";
ls_for +=" </A> ";





	gcrp_print.format = gcrp_print.format + ls_for;

}	



/******************************************************************************
	Description : 보고서 멀티라인 자동개행
	-- ln_Multiline_Text(문자열,자동개행할 가로 문자열길이(첫문자가 0임))
******************************************************************************/
function ln_Multiline_Text(str_text,Maxlen)
{      
		var num_s=new Array("0","1","2","3","4","5","6","7","8","9","");  //숫자 길이체크 배열
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
				if (j==10) seq_1 += 2;
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

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_before classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hclcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_execute classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!--레포트 데이타셋-->
<comment id="__NSID__"><OBJECT id=gcds_basis classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_educ classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_career classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_family classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_license classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_hrself classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_report09 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"		value="toinb_dataid4">
	<param name="KeyValue"	value="Person.h020005_t1(I:USER=gcds_data)">
	<param name="Action"		value="/servlet/Person.h020005_t1">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_before" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (row <1) alert("검색된 데이터가 없습니다.");
	else {
		if (gcds_data.namevalue(1,"PASSDT")!="") gcgd_disp.columnprop("BCHK","edit") = "none";
		else gcgd_disp.columnprop("BCHK","edit") = "";

		if (gcds_data.namevalue(row,"PROSTS")=="4") gcgd_disp.columnProp("BCHK","Edit") = "none";
		else gcgd_disp.columnProp("BCHK","Edit") = "";
	}
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_hclcode" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_execute" event="onloadcompleted(row,colid)">
	gcds_data.reset();
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="onClick(row,colid)">
	if (row <1) return;
	if (colid == "BCHK") {
		if (gcds_data.namevalue(row,"PROSTS")=="4") gcgd_disp.columnProp("BCHK","Edit") = "none";
		else {
			gcgd_disp.columnProp("BCHK","Edit") = "";

			if (gcds_data.namevalue(row,colid)=="T") {
				if (gcds_data.namevalue(row,"PROSTS")=="1"){
					gcds_data.namevalue(row,"INTDT") = gcem_date.text;
					gcds_data.namevalue(row,"INTTM") = gcem_time.text;
				} else if (gcds_data.namevalue(row,"PROSTS")=="2"){
					gcds_data.namevalue(row,"PASSDT") = gcem_date.text;
				}
				gcds_data.namevalue(row,"INTATTYN") = "0";
			} else {
				if (gcds_data.namevalue(row,"PROSTS")=="1"){
					gcds_data.namevalue(row,"INTDT") = "";
					gcds_data.namevalue(row,"INTTM") = "";
				} else if (gcds_data.namevalue(row,"PROSTS")=="2"){
					gcds_data.namevalue(row,"PASSDT") = "";
				}
			}
		}
	}
</script>

<script language="javascript" for="gcds_data" event="OnColumnChanged(row,colid)">
	if (colid == "INTATTYN") {
		if (gcds_data.namevalue(row,colid) != "0") gcds_data.namevalue(row,"BCHK") = "F";
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	gcds_data.Reset();
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/h020005_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:3px">
			<img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Execute()">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">  
			<img src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onclick="ln_Select()">
			<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			&nbsp;
		</td>
  </tr>
  <tr> 
    <td colspan=2>
			<table width="875" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td align=center>
						<table  cellpadding="0" cellspacing="0" border="0" style="width:877px;height:20px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
				      <tr>
								<td width="80" class="tab11" bgcolor="#eeeeee">검색일자</td>
								<td width="215" class="tab21">
									<table cellpadding=0 cellspacing=0 border="0">
										<tr>
											<td height="30px">&nbsp;
												<comment id="__NSID__"><object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
												<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
											</td>
											<td align=center>&nbsp;~&nbsp;</td>
											<td>
												<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
												<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;
											</td>
										</TR>
									</TABLE>
								</TD>
								<td width="80" class="tab11" bgcolor="#eeeeee">응시분야</td>
								<td class="tab21" width="210px">
 									<comment id="__NSID__"><object id=gclx_info classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
 										style="position:relative;left:8px;top:1px;font-size:12px;width:200px;">
											<param name=ComboDataID			value="gcds_before">
											<param name=CBDataColumns		value="INFODIV, DSPNM">
											<param name=SearchColumn		value=DSPNM>
	  									<param name=Sort						value=false>
  										<param name=ListExprFormat	value="DSPNM^0^200">
	 										<param name=BindColumn			value=INFODIV>
			 						</object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td width="80" class="tab11" bgcolor="#eeeeee">진행일자</td>
								<td class="tab22">
									<table cellpadding=0 cellspacing=0 border=0>
										<TR>
											<TD>&nbsp;
												<comment id="__NSID__"><object id=gcem_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
												<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_date', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
											</td>
											<td>&nbsp;</td>
											<td style="height:30px;border:0 solid #708090;border-right-width:0px;"> 
												<comment id="__NSID__"><object id=gcem_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:1px;top:0px; width:35px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="00:00">
														<param name=PromptChar	  value="_">
										    </object></comment><script>__ws__(__NSID__);</script>
											</td>
										</TR>
									</TABLE>
								</td>
							</tr>
              <tr height="30px;">
                <td class="tab12" bgcolor="#eeeeee">접수번호</td>
								<td class="tab23">&nbsp;
									<comment id="__NSID__"><object id=gcem_wrno1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:3px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="00000">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									&nbsp;-&nbsp;
									<comment id="__NSID__"><object id=gcem_wrno2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:3px; width:40px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="00000">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
								</td>
                <td class="tab12" bgcolor="#eeeeee">성명</td>
                <td class="tab23"><input type=text id="txt_nmk" class="txt11" style="width:150px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
                <td class="tab12" bgcolor="#eeeeee">진행상태</td>
                <td width="180px">
 									<comment id="__NSID__"><object id=gclx_prosts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
 										style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_hclcode">
											<param name=CBDataColumns		value="MINORCD, MINORNM">
											<param name=SearchColumn		value=MINORNM>
	  									<param name=Sort						value=false>
  										<param name=ListExprFormat	value="MINORNM^0^100">
	 										<param name=BindColumn			value=MINORCD>
			 						</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
            </table>
					</td>
				</tr>
			</table>
			</div>

		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="875" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:875" align=center>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp  
							style="WIDTH: 875px; HEIGHT: 399px;border:1 solid #777777;display:block;z-index:2" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="true">
              <PARAM NAME="AllShowEdit"	VALUE="true">
              <PARAM NAME="BorderStyle" VALUE="0">
              <PARAM NAME="Indwidth"		VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
                <C> NAME='선택'				ID=BCHK			HeadAlign=Center HeadBgColor=#B9D4DC width=30		align=center, EditStyle=CheckBox</C>
								<C> Name='접수번호'		ID=WRNO			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right,	Edit=none</C>
								<C> Name='성명'				ID=NMK			HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center, Edit=none</C>
								<C> Name='주민번호'		ID=RESINO		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=center, Edit=none, Mask='XXXXXX-XXXXXXX'</C>
								<C> Name='주소'				ID=OADDR		HeadAlign=Center HeadBgColor=#B9D4DC Width=323	align=left,		Edit=none</C>
								<C> Name='면접일자'		ID=INTDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=center, Edit=none, Mask='XXXX/XX/XX'</C>
								<C> Name='합격일자'		ID=PASSDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=center, Edit=none, Mask='XXXX/XX/XX'</C>
                <C> NAME='불합격사유'	ID=INTATTYN	HeadAlign=Center HeadBgColor=#B9D4DC width=88		align=Center, EditStyle=Combo, Data='0:,1:불참,2:서류,3:면접,4:심사탈락,5:합격후불합격'</C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:877px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<!--textarea cols=30 rows=30 id=test_txt style="visibility:visible;">
</textarea-->


<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 



<!------------------------------------------------------------------------
레포트
-------------------------------------------------------------------------->
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_basis">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
